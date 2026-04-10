package org.example.pj_thuexe_vinfast.controller;


import org.example.pj_thuexe_vinfast.modal.User;
import org.example.pj_thuexe_vinfast.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    UserService userService = new UserService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("logout".equals(action)) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            HttpSession newSession = req.getSession();
            newSession.setAttribute("toastMsg", "Đăng xuất thành công!");
            newSession.setAttribute("toastType", "success");

            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.getRequestDispatcher("page/login.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = userService.checkLogin(email, password);

        if (user != null) {
            // Lấy session, đảm bảo dùng true để tạo mới nếu chưa có
            HttpSession session = req.getSession(true);
            session.setAttribute("currUser", user);

            if (user.isAdmin()) {
                // Dùng session để lưu thông báo vì redirect sẽ làm mất request
                session.setAttribute("toastMsg", "Chào mừng Admin " + user.getFullname());
                session.setAttribute("toastType", "success");
                resp.sendRedirect(req.getContextPath() + "/dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/index.jsp");
            }
        } else {
            req.setAttribute("toastMsg", "Tài khoản hoặc mật khẩu không chính xác!");
            req.setAttribute("toastType", "danger");
            req.getRequestDispatcher("page/login.jsp").forward(req, resp);
        }
    }
}
