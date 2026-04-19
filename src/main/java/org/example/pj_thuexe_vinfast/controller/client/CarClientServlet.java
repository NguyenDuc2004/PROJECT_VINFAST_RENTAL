package org.example.pj_thuexe_vinfast.controller.client;

import org.example.pj_thuexe_vinfast.dao.car.CarDAO; // Giả định tên DAO của bạn
import org.example.pj_thuexe_vinfast.modal.Car;
import org.example.pj_thuexe_vinfast.service.CarService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CarClientServlet", value = "/cars")
public class CarClientServlet extends HttpServlet {
    CarService carService = new CarService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "detail":
                showDetail(req, resp);
                break;
            default:
                showList(req, resp);
                break;
        }
    }

    private void showList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        String category = req.getParameter("categoryId");

        // Client mặc định không truyền status thì hàm  tự lấy 'AVAILABLE'
        List<Car> list = carService.getAllCars(keyword, null, category,null);

        req.setAttribute("listCars", list);
        req.setAttribute("view", "cars");
        req.getRequestDispatcher("client/layout.jsp").forward(req, resp);
    }

    private void showDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Car car = carService.getCarById(id);
        req.setAttribute("view", "car-detail");
        req.setAttribute("title", "Chi tiết xe");
        req.setAttribute("car", car);
        req.getRequestDispatcher("client/layout.jsp").forward(req, resp);
    }
}