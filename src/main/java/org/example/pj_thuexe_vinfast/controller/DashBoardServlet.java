package org.example.pj_thuexe_vinfast.controller;

import org.example.pj_thuexe_vinfast.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "DashBoardServlet", value = "/dashboard")
public class DashBoardServlet extends HttpServlet {
    UserService userService = new UserService();

    @Override

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (req.getSession().getAttribute("currUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        int TotalUser = userService.getTotalUser(0);
        req.setAttribute("TotalUser",TotalUser);
        req.setAttribute("view","dashboard");
        req.getRequestDispatcher("/admin/layout.jsp").forward(req, resp);
    }
}
