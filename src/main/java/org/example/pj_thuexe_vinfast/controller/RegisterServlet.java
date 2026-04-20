package org.example.pj_thuexe_vinfast.controller;

import org.example.pj_thuexe_vinfast.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "RegisterServlet", value = "/register")
public class RegisterServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Hiển thị giao diện trang đăng ký
        req.getRequestDispatcher("page/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(); // Khởi tạo session

        String fullname = req.getParameter("fullname");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");

        try {
            // Gọi nghiệp vụ đăng ký
            userService.register(fullname, email, password, phone);

            // --- ĐĂNG KÝ THÀNH CÔNG ---
            // Gán đúng tên biến "toastMsg" và "toastType" mà JSP của anh đang chờ
            session.setAttribute("toastMsg", "Chúc mừng " + fullname + "! Đăng ký tài khoản VinFast thành công.");
            session.setAttribute("toastType", "success");

            // Chuyển hướng sang trang Login
            resp.sendRedirect(req.getContextPath() + "/login");

        } catch (RuntimeException e) {
            // --- THẤT BẠI (Lỗi nghiệp vụ) ---
            // Với lỗi ở chính trang Register, anh có thể dùng setAttribute (Request)
            // hoặc Session tùy ý, nhưng dùng Request cho nhanh:
            req.setAttribute("error", e.getMessage());
            req.setAttribute("oldFullname", fullname);
            req.setAttribute("oldEmail", email);
            req.setAttribute("oldPhone", phone);

            req.getRequestDispatcher("page/register.jsp").forward(req, resp);
        }
    }
}
