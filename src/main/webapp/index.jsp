<%-- webapp/index.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Tự động đẩy người dùng về HomeController để được lắp ghép Layout
    response.sendRedirect(request.getContextPath() + "/home");
%>