package org.example.pj_thuexe_vinfast.controller;

import org.example.pj_thuexe_vinfast.modal.Order;
import org.example.pj_thuexe_vinfast.modal.User;
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
                resp.sendRedirect("login"); // Chưa login thì đá ra trang login
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
        HttpSession session = req.getSession();
        User currUser = (User) session.getAttribute("currUser");

        if (currUser == null) {
            resp.sendRedirect("login");
            return;
        }
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String fullname = req.getParameter("fullname");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String address = req.getParameter("address");

            // Lấy thông tin cũ để giữ Role/Status
            User oldUser = userService.getDetailUser(id);
            User userUpdate = new User(id, fullname, email, phone, address, oldUser.getRole(), oldUser.getStatus());

            if (userService.editedUser(userUpdate, id)) {
                User userChuan = userService.getDetailUser(id);
                req.getSession().setAttribute("currUser", userChuan);

                req.getSession().setAttribute("toastMsg", "Cập nhật thành công!");
                req.getSession().setAttribute("toastType", "success");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("toastMsg", "Lỗi: " + e.getMessage());
            req.getSession().setAttribute("toastType", "danger");
        }
        resp.sendRedirect("home?page=profile");
    }
}
