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
                // Lấy ID và check null/rỗng trước khi parse
                String idRaw = req.getParameter("id");
                if (idRaw != null && !idRaw.isEmpty()) {
                    int id = Integer.parseInt(idRaw);
                    Car car = carService.getCarById(id);

                    if (car != null) {
                        req.setAttribute("car", car);
                        req.setAttribute("view", action);
                        req.getRequestDispatcher("admin/layout.jsp").forward(req, resp);
                        return;
                    } else {
                        // NẾU KHÔNG TÌM THẤY XE: Set thông báo lỗi rồi để nó chạy xuống dưới
                        session.setAttribute("toastMsg", "Không tìm thấy sản phẩm có ID: " + id);
                        session.setAttribute("toastType", "warning");
                    }
                } else {
                    session.setAttribute("toastMsg", "ID sản phẩm không hợp lệ!");
                    session.setAttribute("toastType", "danger");
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
            // Nếu có lỗi hệ thống (như parse sai định dạng số), báo lỗi rồi về trang chính
            session.setAttribute("toastMsg", "Lỗi: " + e.getMessage());
            session.setAttribute("toastType", "danger");
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
            // 4. Hứng mọi lỗi từ Service
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

        //Xử lý lỗi từ handleCreate/Update
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
            if (idParam == null || idParam.isEmpty()) {
                throw new Exception("Yêu cầu không hợp lệ: Thiếu ID sản phẩm!");
            }
            int id = Integer.parseInt(idParam);

            // 1. Map dữ liệu từ Form trước
            Car c = mapRequestToCar(req);
            c.setId(id);

            // 2. Kiểm tra biển số: Nếu form không gửi lên (null/rỗng), lúc đó mới lấy biển số cũ
            if (c.getLicensePlate() == null || c.getLicensePlate().trim().isEmpty()) {
                Car existingCar = carService.getCarById(id);
                if (existingCar != null) {
                    c.setLicensePlate(existingCar.getLicensePlate());
                }
            }

            // 3. Thực hiện update
            carService.updateProduct(c);

            session.setAttribute("toastMsg", "Cập nhật thành công xe: " + c.getModelName());
            session.setAttribute("toastType", "success");

        } catch (Exception e) {
            e.printStackTrace(); // In ra console để ông debug cho dễ
            session.setAttribute("toastMsg", e.getMessage());
            session.setAttribute("toastType", "warning");
        }
        resp.sendRedirect(req.getContextPath() + "/product");
    }

    private Car mapRequestToCar(HttpServletRequest req) throws Exception {
        Car c = new Car();

        // 1. Lấy tên xe
        c.setModelName(req.getParameter("name"));

        // 2. XỬ LÝ BIỂN SỐ (RANDOM NẾU TRỐNG)
        String plate = req.getParameter("licensePlate");
        if (plate == null || plate.trim().isEmpty()) {
            // Tự chế biển số: 30H - [3 số ngẫu nhiên].[2 số ngẫu nhiên]
            int r1 = (int) (Math.random() * 899) + 100;
            int r2 = (int) (Math.random() * 89) + 10;
            plate = "30H-" + r1 + "." + r2;
        }
        c.setLicensePlate(plate.trim());

        // 3. XỬ LÝ GIÁ TIỀN (Sửa lỗi format có dấu chấm)
        String priceStr = req.getParameter("price");
        if (priceStr != null && !priceStr.trim().isEmpty()) {
            // Xóa sạch mọi thứ không phải là số (dấu chấm, dấu phẩy, chữ...)
            String cleanPrice = priceStr.replaceAll("[^0-9]", "");
            try {
                c.setPricePerDay(cleanPrice.isEmpty() ? 0 : Double.parseDouble(cleanPrice));
            } catch (Exception e) {
                c.setPricePerDay(0);
            }
        } else {
            c.setPricePerDay(0);
        }

        try {
            String catId = req.getParameter("categoryId");
            c.setCategoryId(catId != null ? Integer.parseInt(catId) : 1);
        } catch (Exception e) {
            c.setCategoryId(1);
        }

        c.setStatus(req.getParameter("status"));
        c.setImageUrl(req.getParameter("imageUrl"));
        c.setLocationId(1);

        return c;
    }
}