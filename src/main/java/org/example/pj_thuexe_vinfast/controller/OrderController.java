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

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            orderService.deleteOrder(id);
            response.sendRedirect("admin-orders");
            return;
        }

        List<Order> listOrder = orderService.getAllOrders();
        request.setAttribute("listOrder", listOrder);

        request.setAttribute("view", "orders");
        request.getRequestDispatcher("/admin/layout.jsp").forward(request, response);
    }
}
