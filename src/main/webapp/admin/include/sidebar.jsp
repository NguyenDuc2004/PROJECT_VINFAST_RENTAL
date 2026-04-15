<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="sidebar" id="sidebar">
  <div class="sidebar-brand text-uppercase">
    <i class="bi bi-rocket-takeoff-fill me-2 text-primary"></i> VINFAST RENTAL ADMIN
  </div>

  <div class="nav flex-column mt-4">
    <%-- 1. DASHBOARD: Active khi view trống hoặc bằng dashboard --%>
    <a class="nav-link ${view == 'dashboard' ? 'active' : ''}"
       href="${pageContext.request.contextPath}/dashboard">
      <i class="bi bi-grid-1x2-fill"></i> Dashboard
    </a>

    <%-- 2. QUẢN LÝ USER: Active khi view là users --%>
    <a class="nav-link ${view == 'users' ? 'active' : ''}"
       href="${pageContext.request.contextPath}/user">
      <i class="bi bi-people-fill"></i> Quản lý người dùng
    </a>

    <%-- 3. SẢN PHẨM: Active khi view là products --%>
    <a class="nav-link ${view == 'products' ? 'active' : ''}"
       href="${pageContext.request.contextPath}/product">
      <i class="bi bi-box-seam-fill"></i> Quản lý sản phẩm
    </a>
      <%-- 3. ĐƠN ĐẶT XE: Active khi view là bookings --%>
        <a class="nav-link ${view == 'orders' ? 'active' : ''}"
           href="${pageContext.request.contextPath}/admin-orders">
            <i class="bi bi-cart-fill"></i> Quản lý đơn hàng
        </a>

    <%-- 4. NHẬT KÝ HỆ THỐNG: Active khi view là history --%>
    <a class="nav-link ${param.view == 'history' ? 'active' : ''}"
       href="${pageContext.request.contextPath}/admin?view=history">
      <i class="bi bi-shield-lock-fill"></i> Nhật ký hệ thống
    </a>
  </div>
</div>