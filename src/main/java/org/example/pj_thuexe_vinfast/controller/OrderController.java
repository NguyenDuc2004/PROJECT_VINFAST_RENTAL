package org.example.pj_thuexe_vinfast.controller;

import org.example.pj_thuexe_vinfast.modal.Order;
import org.example.pj_thuexe_vinfast.service.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "OrderController", value = "/admin-orders")
public class OrderController extends HttpServlet {
    private OrderService orderService;

    public void init() {
        orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "add":
                request.setAttribute("view", "order-add");
                request.getRequestDispatcher("admin/layout.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8"); // Thêm dòng này để không lỗi font tiếng Việt
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

        request.setAttribute("view", "order-view"); // Khớp với layout.jsp mới
        request.getRequestDispatcher("admin/layout.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Order order = orderService.getOrderById(id);
        request.setAttribute("order", order);

        request.setAttribute("view", "order-edit"); // Khớp với layout.jsp mới
        request.getRequestDispatcher("admin/layout.jsp").forward(request, response);
    }

    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int status = Integer.parseInt(request.getParameter("status"));
        orderService.updateStatus(id, status);
        response.sendRedirect("admin-orders"); // Quay về danh sách sau khi sửa
    }

    private void deleteOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        orderService.deleteOrder(id);
        response.sendRedirect("admin-orders"); // Quay về danh sách sau khi xóa
    }

    private void insertOrder(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String customerName = request.getParameter("customerName");
        String carModel = request.getParameter("carModel");
        String priceStr = request.getParameter("totalPrice");

        double totalPrice = 0;
        if (priceStr != null) {
            totalPrice = Double.parseDouble(priceStr);
        }
        Order newOrder = new Order();
        newOrder.setCustomerName(customerName);
        newOrder.setCarModel(carModel);
        newOrder.setTotalPrice(totalPrice);
        newOrder.setStatus(0); // Mặc định: Chờ duyệt

        orderService.addOrder(newOrder);

        response.sendRedirect("admin-orders");
    }
}