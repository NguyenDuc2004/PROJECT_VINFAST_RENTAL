package org.example.pj_thuexe_vinfast.controller.admin;

import org.example.pj_thuexe_vinfast.modal.Car;
import org.example.pj_thuexe_vinfast.modal.Location;
import org.example.pj_thuexe_vinfast.service.CarService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CarServlet", value = "/product")
public class CarServlet extends HttpServlet {

    private final CarService carService = new CarService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        HttpSession session = req.getSession();

        // Luôn lấy listLocations để dùng cho cả Filter và Modal
        List<Location> listLocations = carService.getAllLocations();
        req.setAttribute("listLocations", listLocations);

        try {
            if ("delete".equals(action)) {
                deletedcar(req, resp, session);
                return;
            }

            if ("view-car".equals(action) || "edit-car".equals(action)) {
                String idRaw = req.getParameter("id");
                if (idRaw != null && !idRaw.isEmpty()) {
                    int id = Integer.parseInt(idRaw);
                    Car car = carService.getCarById(id);
                    System.out.println(car.toString());

                    if (car != null) {
                        req.setAttribute("car", car);
                        req.setAttribute("view", action);
                        req.getRequestDispatcher("admin/layout.jsp").forward(req, resp);
                        return;
                    } else {
                        session.setAttribute("toastMsg", "Không tìm thấy sản phẩm có ID: " + id);
                        session.setAttribute("toastType", "warning");
                    }
                }
            }

            // HIỂN THỊ DANH SÁCH
            int page = 1;
            int pageSize = 5; // Số xe trên 1 trang
            String pageRaw = req.getParameter("page");
            if (pageRaw != null && !pageRaw.isEmpty()) {
                try {
                    page = Integer.parseInt(pageRaw);
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            String keyword = req.getParameter("keyword");
            String status = req.getParameter("status");
            String category = req.getParameter("category");
            String locationId = req.getParameter("locationId");

            int totalRecords = carService.countAllCars(keyword, status, category, locationId);
            List<Car> list = carService.getAllCars(keyword, status, category, locationId, page, pageSize);


            int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

            req.setAttribute("listProduct", list);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("totalRecords", totalRecords);

            req.setAttribute("keyword", keyword);
            req.setAttribute("status", status);
            req.setAttribute("category", category);
            req.setAttribute("locationId", locationId);

            req.setAttribute("view", "products");
            req.getRequestDispatcher("admin/layout.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/product");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        HttpSession session = req.getSession();

        try {
            if ("create".equals(action)) {
                handleCreate(req, resp, session);
            } else if ("update".equals(action)) {
                handleUpdate(req, resp, session);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/product");
        }
    }

    private void handleCreate(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws Exception {
        try {
            Car c = mapRequestToCar(req);
            carService.addProduct(c);
            session.setAttribute("toastMsg", "Thêm xe thành công!");
            session.setAttribute("toastType", "success");
        } catch (Exception e) {
            session.setAttribute("toastMsg", "Lỗi: " + e.getMessage());
            session.setAttribute("toastType", "danger");
        }
        resp.sendRedirect(req.getContextPath() + "/product");
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws Exception {
        try {
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.isEmpty()) throw new Exception("Thiếu ID!");

            int id = Integer.parseInt(idParam);
            Car c = mapRequestToCar(req);
            c.setId(id);

            // Xử lý logic biển số trống cho update
            if (c.getLicensePlate() == null || c.getLicensePlate().trim().isEmpty()) {
                Car existingCar = carService.getCarById(id);
                if (existingCar != null) {
                    c.setLicensePlate(existingCar.getLicensePlate());
                }
            }

            carService.updateProduct(c);
            session.setAttribute("toastMsg", "Cập nhật thành công!");
            session.setAttribute("toastType", "success");
        } catch (Exception e) {
            session.setAttribute("toastMsg", e.getMessage());
            session.setAttribute("toastType", "warning");
        }
        resp.sendRedirect(req.getContextPath() + "/product");
    }

    private void deletedcar(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            carService.removeProduct(id);
            session.setAttribute("toastMsg", "Xóa thành công!");
            session.setAttribute("toastType", "success");
        } catch (Exception e) {
            session.setAttribute("toastMsg", e.getMessage());
            session.setAttribute("toastType", "danger");
        }
        resp.sendRedirect(req.getContextPath() + "/product");
    }

    private Car mapRequestToCar(HttpServletRequest req) {
        Car c = new Car();
        c.setModelName(req.getParameter("name"));

        String plate = req.getParameter("licensePlate");
        c.setLicensePlate(plate != null ? plate.trim() : "");

        String priceStr = req.getParameter("price");
        if (priceStr != null) {
            String cleanPrice = priceStr.replaceAll("[^0-9]", "");
            c.setPricePerDay(cleanPrice.isEmpty() ? 0 : Double.parseDouble(cleanPrice));
        }

        String catId = req.getParameter("categoryId");
        c.setCategoryId(catId != null ? Integer.parseInt(catId) : 1);

        // FIX: ĐÃ XÓA DÒNG GÁN CỨNG ID = 1
        String locId = req.getParameter("locationId");
        c.setLocationId(locId != null ? Integer.parseInt(locId) : 1);

        c.setStatus(req.getParameter("status"));
        c.setImageUrl(req.getParameter("imageUrl"));
        c.setDescription(req.getParameter("description"));

        return c;
    }
}