package org.example.pj_thuexe_vinfast.controller;

import org.example.pj_thuexe_vinfast.modal.Car;
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

        try {
            // 1. XỬ LÝ XÓA
            if ("delete".equals(action)) {
                deletedcar(req, resp, session);
                return;
            }

            // 2. XỬ LÝ XEM CHI TIẾT HOẶC DI CHUYỂN ĐẾN TRANG SỬA
            if ("view".equals(action) || "edit".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Car car = carService.getCarById(id);
                if (car != null) {
                    req.setAttribute("car", car);
                    req.setAttribute("view", action); // Truyền "view" hoặc "edit"
                    req.getRequestDispatcher("admin/layout.jsp").forward(req, resp);
                    return;
                }
            }

            // 3. HIỂN THỊ DANH SÁCH (MẶC ĐỊNH)
            String keyword = req.getParameter("keyword");
            String status = req.getParameter("status");
            String category = req.getParameter("category");
            List<Car> list = carService.getAllCars(keyword, status, category);

            req.setAttribute("listProduct", list);
            req.setAttribute("view", "products");
            req.getRequestDispatcher("admin/layout.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/product");
        }
    }

    private void deletedcar(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException {
        try {
            // 1. Lấy ID từ tham số
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                throw new Exception("Yêu cầu không hợp lệ: Thiếu ID sản phẩm!");
            }

            int id = Integer.parseInt(idParam);

            // 2. Gọi nghiệp vụ xóa (đã có check ID, check tồn tại, check status bên trong)
            carService.removeProduct(id);

            // 3. Nếu không có lỗi xảy ra, báo thành công
            session.setAttribute("toastMsg", "Xóa sản phẩm thành công!");
            session.setAttribute("toastType", "success");

        } catch (NumberFormatException e) {
            session.setAttribute("toastMsg", "ID phải là con số!");
            session.setAttribute("toastType", "danger");
        } catch (Exception e) {
            // 4. Hứng mọi lỗi từ Service (e.getMessage() sẽ lấy đúng câu ông viết ở throw new Exception)
            session.setAttribute("toastMsg", e.getMessage());
            session.setAttribute("toastType", "warning");
        }

        // 5. Quay về trang danh sách
        resp.sendRedirect(req.getContextPath() + "/product");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        HttpSession session = req.getSession();

        if ("create".equals(action)) {
            handleCreate(req, resp, session);
        } else if ("update".equals(action)) {
            handleUpdate(req, resp, session);
        }
    }

    private void handleCreate(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException {
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

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException {
        try {
            // 1. Kiểm tra ID đầu vào
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                throw new Exception("Yêu cầu không hợp lệ: Thiếu ID sản phẩm!");
            }

            int id = Integer.parseInt(idParam);
            if (id <= 0) {
                throw new Exception("ID sản phẩm phải lớn hơn 0!");
            }

            // 2. Map dữ liệu từ Form vào đối tượng Car
            Car c = mapRequestToCar(req);
            c.setId(id);

            // 3. Gọi Service
            // Nếu Service của ông trả về String (SUCCESS hoặc lỗi)
            String result = carService.updateProduct(c);

            if ("SUCCESS".equals(result)) {
                session.setAttribute("toastMsg", "Cập nhật sản phẩm thành công!");
                session.setAttribute("toastType", "success");
            } else {
                // Trường hợp Service trả về thông báo lỗi cụ thể (ví dụ: "Tên không được trống")
                session.setAttribute("toastMsg", result);
                session.setAttribute("toastType", "warning");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("toastMsg", "ID hoặc giá trị số không hợp lệ!");
            session.setAttribute("toastType", "danger");
        } catch (Exception e) {
            // Hứng mọi lỗi từ "throw new Exception" ở Service
            session.setAttribute("toastMsg", e.getMessage());
            session.setAttribute("toastType", "warning");
        }

        // 4. Redirect về trang danh sách (chỉ dùng 1 lần duy nhất ở cuối)
        resp.sendRedirect(req.getContextPath() + "/product");
    }

    private Car mapRequestToCar(HttpServletRequest req) {
        Car c = new Car();
        c.setModelName(req.getParameter("name"));
        String priceStr = req.getParameter("price");
        c.setPricePerDay((priceStr != null && !priceStr.isEmpty()) ? Double.parseDouble(priceStr) : 0);
        c.setImageUrl(req.getParameter("imageUrl"));
        c.setStatus(req.getParameter("status"));
        c.setCategoryId(Integer.parseInt(req.getParameter("categoryId") != null ? req.getParameter("categoryId") : "1"));
        c.setLocationId(1);
        c.setLicensePlate("VIN-" + System.currentTimeMillis() % 10000);
        return c;
    }
}