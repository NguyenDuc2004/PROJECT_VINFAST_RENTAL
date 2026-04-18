package org.example.pj_thuexe_vinfast.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "HomeServlet", value = {"/home", ""})
public class HomeServlet extends HttpServlet {
        @Override
        protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String page = req.getParameter("page");

            String view = "home";
            String title = "VinFast Rental - Trang chủ"; //

            if ("cars".equals(page)) {
                view = "cars";
                title = "VinFast Rental - Danh sách xe";
            }

            req.setAttribute("view", view);
            req.setAttribute("title", title);
            req.getRequestDispatcher("client/layout.jsp").forward(req, resp);
        }
}
