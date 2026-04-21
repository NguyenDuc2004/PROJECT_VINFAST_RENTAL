package org.example.pj_thuexe_vinfast.controller.client;

import org.example.pj_thuexe_vinfast.modal.Car;
import org.example.pj_thuexe_vinfast.modal.Location;
import org.example.pj_thuexe_vinfast.service.CarService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CarClientServlet", value = "/cars")
public class CarClientServlet extends HttpServlet {
    CarService carService = new CarService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "detail":
                showDetail(req, resp);
                break;
            case "checkout":
                showCheckout(req, resp);
                break;
            default:
                showList(req, resp);
                break;
        }
    }

    private void showList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        int pageSize = 6;
        String pageRaw = req.getParameter("page");
        if (pageRaw != null && !pageRaw.isEmpty()) {
            try {
                page = Integer.parseInt(pageRaw);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        String keyword = req.getParameter("keyword");
        String category = req.getParameter("category");
        String locationId = req.getParameter("locationId");

        List<Car> list = carService.getAllCars(keyword, null, category, locationId, page, pageSize);

        int totalRecords = carService.countAllCars(keyword, null, category, locationId);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        List<Location> listLocations = carService.getAllLocations();

        req.setAttribute("listCars", list);
        req.setAttribute("listLocations", listLocations);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalRecords", totalRecords);

        req.setAttribute("keyword", keyword);
        req.setAttribute("category", category);
        req.setAttribute("locationId", locationId);

        req.setAttribute("view", "cars");
        req.getRequestDispatcher("client/layout.jsp").forward(req, resp);
    }

    private void showDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Car car = carService.getCarById(id);
            if (car != null) {
                req.setAttribute("view", "car-detail");
                req.setAttribute("title", "Chi tiết xe - " + car.getModelName());
                req.setAttribute("car", car);
                req.getRequestDispatcher("client/layout.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/cars");
            }
        } catch (Exception e) {
            resp.sendRedirect(req.getContextPath() + "/cars");
        }
    }

    private void showCheckout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("currUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            int id = Integer.parseInt(req.getParameter("id"));
            Car car = carService.getCarById(id);

            if (car != null) {
                req.setAttribute("car", car);
                req.setAttribute("view", "checkout");
                req.setAttribute("title", "Xác nhận đặt xe");
                req.getRequestDispatcher("client/layout.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/cars");
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/cars");
        }
    }
}