package org.example.pj_thuexe_vinfast.controller.admin;

import org.example.pj_thuexe_vinfast.modal.Car;
import org.example.pj_thuexe_vinfast.modal.Order;
import org.example.pj_thuexe_vinfast.service.OrderService;
import org.example.pj_thuexe_vinfast.service.CarService; // Nên thêm cái này

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "OrderController", value = "/admin-orders")
public class OrderServlet extends HttpServlet {
    private OrderService orderService;
    private CarService carService; // Khai báo thêm để xử lý trạng thái xe

    public void init() {
        orderService = new OrderService();
        carService = new CarService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "export":
                exportToExcel(request, response);
                break;
            case "view":
                showOrderDetail(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteOrder(request, response);
                break;
            default:
                listOrders(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        switch (action) {
            case "insert":
                insertOrder(request, response);
                break;
            case "updateStatus":
                updateOrderStatus(request, response);
                break;
        }
    }

    private void listOrders(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int page = 1;
        int pageSize = 10; // Đơn hàng nên để 10 dòng cho dễ quản lý
        String p = req.getParameter("page");
        if (p != null && !p.isEmpty()) page = Integer.parseInt(p);
        List<Order> listOrder = orderService.getAllOrders(page,pageSize);
        int totalRecords = orderService.countAllOrders();
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
        req.setAttribute("listOrders", listOrder);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalRecords", totalRecords);

        req.setAttribute("view", "orders");
        req.getRequestDispatcher("admin/layout.jsp").forward(req, resp);
    }

    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Order order = orderService.getOrderById(id);
        request.setAttribute("order", order);
        request.setAttribute("view", "order-view");
        request.getRequestDispatcher("admin/layout.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Order order = orderService.getOrderById(id);
        request.setAttribute("order", order);
        request.setAttribute("view", "order-edit");
        request.getRequestDispatcher("admin/layout.jsp").forward(request, response);
    }

    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession();
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            int status = Integer.parseInt(request.getParameter("status"));

            orderService.updateStatus(id, status);

            Order order = orderService.getOrderById(id);

            if (status == 1) carService.updateCarStatus(order.getCarId(), "UNAVAILABLE");
            else if (status == 2 || status == 3) carService.updateCarStatus(order.getCarId(), "AVAILABLE");

            session.setAttribute("toastMsg", "Cập nhật trạng thái đơn hàng thành công!");
            session.setAttribute("msgType", "success");

        } catch (NumberFormatException e) {
            session.setAttribute("toastMsg", "Dữ liệu ID hoặc Trạng thái không hợp lệ!");
            session.setAttribute("msgType", "danger");
        } catch (Exception e) {
            // BẮT MỌI LỖI TỪ SERVICE NÉM RA (Ví dụ: "Đơn hàng đã hoàn thành...")
            session.setAttribute("toastMsg", e.getMessage());
            session.setAttribute("msgType", "warning");
        }

        response.sendRedirect("admin-orders");
    }

    private void deleteOrder(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            Order order = orderService.getOrderById(id);

            if (order == null) {
                session.setAttribute("toastMsg", "Đơn hàng không tồn tại!");
                session.setAttribute("msgType", "danger");
                response.sendRedirect("admin-orders");
                return;
            }

            String result = orderService.deleteOrder(id);

            if ("SUCCESS".equals(result)) {
                // 3. Giải phóng xe về trạng thái AVAILABLE
                carService.updateCarStatus(order.getCarId(), "AVAILABLE");

                session.setAttribute("toastMsg", "Xóa đơn hàng thành công và đã giải phóng xe!");
                session.setAttribute("msgType", "success");
            } else {
                session.setAttribute("toastMsg", result);
                session.setAttribute("msgType", "warning");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("toastMsg", "ID đơn hàng không hợp lệ!");
            session.setAttribute("msgType", "danger");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("toastMsg", "Lỗi hệ thống: " + e.getMessage());
            session.setAttribute("msgType", "danger");
        }

        response.sendRedirect("admin-orders");
    }

    private void insertOrder(HttpServletRequest request, HttpServletResponse response)throws IOException {
        try {
            Order newOrder = new Order();
            newOrder.setUserId(Integer.parseInt(request.getParameter("userId")));
            newOrder.setCarId(Integer.parseInt(request.getParameter("carId")));
            newOrder.setCustomerName(request.getParameter("customerName"));
            newOrder.setPhone(request.getParameter("phone"));
            newOrder.setEmail(request.getParameter("email"));
            newOrder.setStartDate(Date.valueOf(request.getParameter("startDate")));
            newOrder.setEndDate(Date.valueOf(request.getParameter("endDate")));
            newOrder.setTotalPrice(Double.parseDouble(request.getParameter("totalPrice")));
            newOrder.setNote(request.getParameter("note"));
            newOrder.setStatus(0);

            orderService.addOrder(newOrder);
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("admin-orders");
    }

    private void exportToExcel(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=danh_sach_don_hang.xlsx");

        List<Order> listOrder = orderService.getAllOrders(1,5);
        try {
            orderService.exportOrdersToExcel(listOrder, response.getOutputStream());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}