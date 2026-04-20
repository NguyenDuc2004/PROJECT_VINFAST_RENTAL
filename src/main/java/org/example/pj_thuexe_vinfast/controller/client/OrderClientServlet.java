package org.example.pj_thuexe_vinfast.controller.client;

import org.example.pj_thuexe_vinfast.modal.Order;
import org.example.pj_thuexe_vinfast.modal.User;
import org.example.pj_thuexe_vinfast.service.CarService;
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
    private CarService carService = new CarService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("title", "Đặt xe thành công");
        req.setAttribute("view", "order-success");
        req.getRequestDispatcher("client/layout.jsp").forward(req, resp);
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

        // Lấy carId ngay từ đầu để dùng cho việc Redirect khi lỗi
        String carIdStr = req.getParameter("carId");
        int carId = Integer.parseInt(carIdStr);

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


            orderService.createOrder(newOrder);

            carService.updateCarStatus(carId, "UNAVAILABLE");

            session.setAttribute("message", "Đặt xe thành công!");
            session.setAttribute("msgType", "success");

            resp.sendRedirect(req.getContextPath() + "/order");
            return;

        } catch (Exception e) {
            // BẮT MỌI LỖI: Từ lỗi trống SĐT, lỗi định dạng ngày, đến lỗi ép kiểu giá tiền
            e.printStackTrace();

            // Lấy đúng cái tin nhắn "Số điện thoại không được để trống" từ Service ném về
            session.setAttribute("message", e.getMessage());
            session.setAttribute("msgType", "danger");

            // Đẩy khách quay lại trang Checkout để họ thấy cái Toast trượt ra báo lỗi
            resp.sendRedirect(req.getContextPath() + "/cars?action=checkout&id=" + carId);
        }
    }
}