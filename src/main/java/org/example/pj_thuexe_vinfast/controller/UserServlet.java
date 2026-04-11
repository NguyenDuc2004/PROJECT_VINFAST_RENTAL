package org.example.pj_thuexe_vinfast.controller;


import org.example.pj_thuexe_vinfast.modal.User;
import org.example.pj_thuexe_vinfast.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
            case "delete":
                break;
            default:
                filterSearchListUser(req, resp);
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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}
