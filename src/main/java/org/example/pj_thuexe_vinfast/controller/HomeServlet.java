package org.example.pj_thuexe_vinfast.controller;

import org.example.pj_thuexe_vinfast.modal.Location;
import org.example.pj_thuexe_vinfast.modal.Order;
import org.example.pj_thuexe_vinfast.modal.User;
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

@WebServlet(name = "HomeServlet", value = {"/home", ""})
public class HomeServlet extends HttpServlet {
    private UserService userService = new UserService();
    private OrderService orderService = new OrderService();
    private CarService carService = new CarService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        String page = req.getParameter("page");
        HttpSession session = req.getSession();
        User currUser = (User) session.getAttribute("currUser");

        if ("profile".equals(page)) {
            if (currUser == null) {
                resp.sendRedirect("login");
                return;
            }
            try {
                User user = userService.getDetailUser(currUser.getId());
                req.setAttribute("user", user);
                req.setAttribute("view", "user-profile");
                req.setAttribute("title", "Thông tin cá nhân");
            } catch (Exception e) {
                e.printStackTrace();
                req.getSession().setAttribute("toastMsg", "Không thể lấy thông tin: " + e.getMessage());
                req.getSession().setAttribute("toastType", "danger");
                resp.sendRedirect("home");
                return;
            }
        }
        else if ("history".equals(page)) {
            if (currUser == null) {
                resp.sendRedirect("login");
                return;
            }
            List<Order> history = orderService.getAllOrdersByUserId(currUser.getId());
            req.setAttribute("history", history);
            req.setAttribute("view", "user-history");
            req.setAttribute("title", "Lịch sử thuê xe");
        }
        else if ("cars".equals(page)) {
            resp.sendRedirect(req.getContextPath() + "/cars");
            return;
        }
        else {
            req.setAttribute("view", "home");
            req.setAttribute("title", "VinFast Rental - Trang chủ");
        }

        req.getRequestDispatcher("client/layout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8"); // Giúp đọc dữ liệu tiếng Việt từ Form gửi lên
        resp.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("updateProfile".equals(action)) {
            updateUserProfile(req, resp);
        }
    }

    private void updateUserProfile(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // Sửa lỗi font tiếng Việt cho request
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User currUser = (User) session.getAttribute("currUser");
        System.out.println("status" + currUser.getStatus());
        if (currUser == null) {
            resp.sendRedirect("login");
            return;
        }

        try {
            int idFromForm = Integer.parseInt(req.getParameter("id"));
            System.out.println("id: " +idFromForm);
            if (idFromForm != currUser.getId()) {
                session.setAttribute("toastMsg", "Thao tác không hợp lệ!");
                session.setAttribute("toastType", "danger");
                resp.sendRedirect("home?page=profile");
                return;
            }

            String fullname = req.getParameter("fullname");
            String phone = req.getParameter("phone");
            String address = req.getParameter("address");

            User userUpdate = new User();
            userUpdate.setId(currUser.getId());
            userUpdate.setFullname(fullname);
            userUpdate.setEmail(currUser.getEmail());
            userUpdate.setPhone(phone);
            userUpdate.setAddress(address);
            userUpdate.setRole(currUser.getRole());
            userUpdate.setStatus(currUser.getStatus());

            if (userService.editedUser(userUpdate, idFromForm)) {
                User updatedUser = userService.getDetailUser(idFromForm);
                session.setAttribute("currUser", updatedUser);

                session.setAttribute("toastMsg", "Cập nhật hồ sơ thành công!");
                session.setAttribute("toastType", "success");
            }
        } catch (Exception e) {
            e.printStackTrace();
            String errorMsg = e.getMessage();
            if(errorMsg.contains("kha")) errorMsg = "Bạn không thể tự thay đổi trạng thái của mình!";

            session.setAttribute("toastMsg", "Lỗi: " + errorMsg);
            session.setAttribute("toastType", "danger");
        }

        resp.sendRedirect("home?page=profile");
    }
}
