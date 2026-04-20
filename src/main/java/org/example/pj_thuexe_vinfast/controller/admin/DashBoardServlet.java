package org.example.pj_thuexe_vinfast.controller.admin;

import org.example.pj_thuexe_vinfast.service.CarService;
import org.example.pj_thuexe_vinfast.service.OrderService;
import org.example.pj_thuexe_vinfast.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "DashBoardServlet", value = "/dashboard")
public class DashBoardServlet extends HttpServlet {
    private final UserService userService = new UserService();
    private final CarService carService = new CarService();
    private final OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("currUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int totalUser = userService.getTotalUser(0);
        int totalCar = carService.getTotalCarsCount("AVAILABLE", "UNAVAILABLE");
        int available = carService.getTotalCarsCount("AVAILABLE");
        int unavailable = carService.getTotalCarsCount("UNAVAILABLE");


        int newOrders = orderService.countOrdersByStatus(0);         // Đơn chờ duyệt
        int processingOrders = orderService.countOrdersByStatus(1);    // Đơn đang thuê
        double totalRevenue = orderService.getTotalRevenue();          // Tổng doanh thu thực tế


        List<Double> revenueList = orderService.getRevenueLast6Months();
        String revenueData;

        if (revenueList == null || revenueList.isEmpty()) {
            revenueData = "0, 0, 0, 0, 0, 0";
        } else {
            revenueData = revenueList.stream()
                    .map(Object::toString)
                    .collect(Collectors.joining(", "));
        }


        req.setAttribute("TotalUser", totalUser);
        req.setAttribute("TotalCar", totalCar);
        req.setAttribute("TotalCarAvailable", available);
        req.setAttribute("TotalCarUnavailable", unavailable);

        req.setAttribute("NewOrders", newOrders);
        req.setAttribute("ProcessingOrders", processingOrders);
        req.setAttribute("TotalRevenue", totalRevenue);
        req.setAttribute("RevenueData", revenueData);

        req.setAttribute("view", "dashboard");
        req.getRequestDispatcher("/admin/layout.jsp").forward(req, resp);
    }
}