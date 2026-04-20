package org.example.pj_thuexe_vinfast.filter;

import org.example.pj_thuexe_vinfast.modal.User;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

// Chặn các request gửi đến các Controller quản trị
@WebFilter(urlPatterns = {"/product", "/admin-orders", "/user", "/dashboard"})
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // 1. Kiểm tra đăng nhập
        User currUser = (session != null) ? (User) session.getAttribute("currUser") : null;

        if (currUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        if (currUser.getRole() == 1 || currUser.getRole() == 2) {
            chain.doFilter(request, response);
        } else {

            session.setAttribute("message", "Bạn không có quyền truy cập khu vực này!");
            session.setAttribute("msgType", "danger");
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}