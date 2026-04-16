package org.example.pj_thuexe_vinfast.controller.admin;


import org.example.pj_thuexe_vinfast.modal.User;
import org.example.pj_thuexe_vinfast.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name="UserServlet",value="/user")
public class UserServlet extends HttpServlet {
    UserService userService = new UserService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if(action == null) action = "";
        switch (action){
            case "create":
                break;
            case "view":
                detailUser(req, resp);
                break;
            case "edit":
                showViewEdit(req, resp);
                break;
            case "delete":
                deletedUser(req,resp);
                break;
            default:
                filterSearchListUser(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action =  req.getParameter("action");
        if(action == null) action = "";
        switch (action){
            case "edit":
                updateUser(req,resp);
                break;
            case "create":
                addUser(req,resp);
                break;
            default:
                resp.sendRedirect("user");
                break;
        }
    }

    private void addUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String fullname = req.getParameter("fullname");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String phone = req.getParameter("phone");
            String address = req.getParameter("address");
            int roleId = Integer.parseInt(req.getParameter("roleId"));
            User newUser = new User();
            newUser.setFullname(fullname);
            newUser.setEmail(email);
            newUser.setPassword(password);
            newUser.setPhone(phone);
            newUser.setAddress(address);
            newUser.setRole(roleId);
            userService.insertUser(newUser);
            req.getSession().setAttribute("toastMsg", "Thêm mới thành viên thành công!");
            req.getSession().setAttribute("toastType", "success");
            resp.sendRedirect("user");

        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("toastMsg", "Lỗi: " + e.getMessage());
            req.getSession().setAttribute("toastType", "danger");
            resp.sendRedirect("user?openModal=true");
        }
    }
    private void updateUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        User currAdmin = (User) req.getSession().getAttribute("currUser");
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String fullname = req.getParameter("fullname");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String address = req.getParameter("address");
            int roleId = Integer.parseInt(req.getParameter("role"));

            int status = (req.getParameter("status") != null) ? 1 : 0;

            User userUpdate = new User(id, fullname, email, phone, address, roleId, status);

            userService.editedUser(userUpdate, currAdmin.getId());
            req.getSession().setAttribute("toastMsg", "Cập nhật thông tin thành công!");
            req.getSession().setAttribute("toastType", "success");
            resp.sendRedirect("user?action=view&id=" + req.getParameter("id"));
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("toastMsg", e.getMessage());
            req.getSession().setAttribute("toastType", "danger");
            resp.sendRedirect("user?action=edit&id=" + req.getParameter("id"));
        }
    }
    private void showViewEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User currUser = (User) req.getSession().getAttribute("currUser");
        if (currUser == null || currUser.getRole() != 1) {
            req.getSession().setAttribute("toastMsg", "Bạn không có quyền thực hiện hành động này!");
            req.getSession().setAttribute("toastType", "danger");
            resp.sendRedirect("user");
            return;
        }
        try {
            int id = Integer.parseInt(req.getParameter("id"));

            User userEdit = userService.getDetailUser(id);

            req.setAttribute("user", userEdit);
            req.setAttribute("view", "edit-user");
            req.getRequestDispatcher("admin/layout.jsp").forward(req, resp);

        } catch (Exception e) {
            req.getSession().setAttribute("toastMsg", e.getMessage());
            req.getSession().setAttribute("toastType", "danger");
            resp.sendRedirect("user");
        }
    }

    private void deletedUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                throw new Exception("Không tìm thấy ID để xóa!");
            }

            int id = Integer.parseInt(idParam);
            userService.deleteUserById(id);
            HttpSession session = req.getSession();
            session.setAttribute("toastMsg", "Đã xóa người dùng thành công!");
            session.setAttribute("toastType", "success");

        } catch (NumberFormatException e) {
            HttpSession session = req.getSession();
            session.setAttribute("toastMsg", "ID người dùng phải là con số!");
            session.setAttribute("toastType", "danger");

        } catch (Exception e) {
            HttpSession session = req.getSession();
            session.setAttribute("toastMsg", e.getMessage());
            session.setAttribute("toastType", "danger");
        }

        resp.sendRedirect("user");
    }

    private void detailUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                throw new Exception("Không tìm thấy ID người dùng!");
            }
            int id = Integer.parseInt(idParam);
            User user = userService.getDetailUser(id);
            req.setAttribute("user", user);
            req.setAttribute("view", "view-user");
            req.getRequestDispatcher("admin/layout.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            HttpSession session = req.getSession();
            session.setAttribute("toastMsg", e.getMessage());
            session.setAttribute("toastType", "danger");
            resp.sendRedirect("user");
        } catch (Exception e) {
            HttpSession session = req.getSession();
            session.setAttribute("toastMsg", e.getMessage());
            session.setAttribute("toastType", "danger");
            resp.sendRedirect("user");
        }
    }

    private void filterSearchListUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        String role = req.getParameter("role");
        String status = req.getParameter("status");
        List<User> users = userService.filterSearchListUser(keyword,role,status);
        req.setAttribute("listUser",users);
        req.setAttribute("view","users");
        req.getRequestDispatcher("admin/layout.jsp").forward(req, resp);
    }
}
