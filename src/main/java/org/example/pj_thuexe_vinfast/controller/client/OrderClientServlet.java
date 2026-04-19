package org.example.pj_thuexe_vinfast.controller.client;

import org.example.pj_thuexe_vinfast.modal.Order;
import org.example.pj_thuexe_vinfast.modal.User;
import org.example.pj_thuexe_vinfast.service.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "OrderClientServlet", value = "/order")
public class OrderClientServlet extends HttpServlet {

    private OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Không dùng trang success riêng nữa nên có thể để trống hoặc xóa
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("create".equals(action)) {
            processCreateOrder(req, resp);
        }
    }

    private void processCreateOrder(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currUser = (User) session.getAttribute("currUser");

        if (currUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int carId = Integer.parseInt(req.getParameter("carId"));

        try {
            Order newOrder = new Order();
            newOrder.setUserId(currUser.getId());
            newOrder.setCarId(carId);
            newOrder.setCustomerName(req.getParameter("customerName"));
            newOrder.setPhone(req.getParameter("phone"));
            newOrder.setEmail(req.getParameter("email"));
            newOrder.setStartDate(Date.valueOf(req.getParameter("startDate")));
            newOrder.setEndDate(Date.valueOf(req.getParameter("endDate")));
            newOrder.setTotalPrice(Double.parseDouble(req.getParameter("totalPrice")));
            newOrder.setNote(req.getParameter("note"));
            newOrder.setStatus(0);

            boolean isSaved = orderService.createOrder(newOrder);

            if (isSaved) {
                // ĐẶT THÔNG BÁO VÀO SESSION
                session.setAttribute("orderStatus", "success");
            } else {
                session.setAttribute("orderStatus", "fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("orderStatus", "error");
        }

        // LUÔN QUAY VỀ TRANG CHECKOUT (Đứng im tại trang này)
        resp.sendRedirect(req.getContextPath() + "/cars?action=checkout&id=" + carId);
    }
}