package org.example.pj_thuexe_vinfast.controller.admin;

import org.example.pj_thuexe_vinfast.modal.Order;
import org.example.pj_thuexe_vinfast.service.OrderService;
import org.example.pj_thuexe_vinfast.service.CarService; // Nên thêm cái này

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
//                updateOrderStatus(request, response);
                break;
        }
    }

    private void listOrders(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Order> listOrder = orderService.getAllOrders();
        request.setAttribute("listOrder", listOrder);
        request.setAttribute("view", "orders");
        request.getRequestDispatcher("admin/layout.jsp").forward(request, response);
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
        int id = Integer.parseInt(request.getParameter("id"));
        int status = Integer.parseInt(request.getParameter("status"));

        // Lấy thông tin đơn hàng trước khi update để biết carId
        Order order = orderService.getOrderById(id);

        if (order != null) {
            orderService.updateStatus(id, status);

            // LOGIC QUAN TRỌNG: Đồng bộ trạng thái xe trong Database
            if (status == 1) {
                // Nếu Admin bấm "Duyệt/Đang thuê" -> Chuyển xe thành UNAVAILABLE
                carService.updateCarStatus(order.getCarId(), "UNAVAILABLE");
            } else if (status == 2 || status == 3) {
                // Nếu "Hoàn thành" hoặc "Hủy" -> Trả xe về AVAILABLE để người khác thuê
                carService.updateCarStatus(order.getCarId(), "AVAILABLE");
            }
        }

        response.sendRedirect("admin-orders");
    }


    private void deleteOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        orderService.deleteOrder(id);
        response.sendRedirect("admin-orders");
    }

    private void insertOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
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

        List<Order> listOrder = orderService.getAllOrders();
        try {
            orderService.exportOrdersToExcel(listOrder, response.getOutputStream());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}