<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="top-navbar d-flex justify-content-between align-items-center">
    <div class="d-flex align-items-center">
        <button id="sidebarCollapse" type="button">
            <i class="bi bi-list fs-4"></i>
        </button>

        <h5 class="mb-0 fw-bold text-dark">
            <c:choose>
<%--                user--%>
                <c:when test="${view == 'users'}">Quản lý người dùng</c:when>
                <c:when test="${view == 'view'}">Thông tin người dùng</c:when>
                <c:when test="${view == 'edit'}">Cập nhật thông tin</c:when>
<%--                sản phẩm--%>
                <c:when test="${view == 'products'}">Danh sách sản phẩm</c:when>
                <c:when test="${view == 'view-car'}">Thông tin xe</c:when>
                <c:when test="${view == 'edit-car'}">Cập nhật thông tin</c:when>
<%--                đơn hàng--%>
                <c:when test="${view == 'orders'}">Quản lý đơn hàng</c:when>
                <c:when test="${view == 'orders-view'}">Chi tiết đơn hàng</c:when>
                <c:when test="${view == 'orders-edit'}">Cập nhật đơn hàng</c:when>
<%--                lịch sử đăng nhập--%>
                <c:when test="${view == 'history'}">Nhật ký hệ thống</c:when>
                <c:otherwise>Tổng quan Dashboard</c:otherwise>
            </c:choose>
        </h5>
    </div>

    <div class="user-profile d-flex align-items-center">
        <div class="text-end me-3 d-none d-sm-block">
            <p class="mb-0 fw-bold small text-dark">${sessionScope.currUser.fullname}</p>
            <span class="text-success fw-medium" style="font-size: 0.7rem;">
                <i class="bi bi-circle-fill me-1" style="font-size: 0.5rem;"></i> Trực tuyến
            </span>
        </div>
        <div class="dropdown">
            <a href="#" data-bs-toggle="dropdown" aria-expanded="false">
                <img src="https://ui-avatars.com/api/?name=${sessionScope.currUser.fullname}&background=random"
                     class="rounded-circle border" width="40" height="40">
            </a>
            <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i> Hồ sơ</a></li>
                <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-2"></i> Cài đặt</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/login?action=logout">
                    <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
                </a></li>
            </ul>
        </div>
    </div>
</header>
