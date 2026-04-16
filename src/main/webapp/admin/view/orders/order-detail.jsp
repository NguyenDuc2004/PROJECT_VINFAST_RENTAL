<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid px-4">
    <h1 class="mt-4">Chi tiết đơn hàng</h1>
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item"><a href="dashboard">Dashboard</a></li>
        <li class="breadcrumb-item"><a href="admin-orders">Quản lý đơn hàng</a></li>
        <li class="breadcrumb-item active">Mã đơn #${order.id}</li>
    </ol>

    <div class="row">
        <div class="col-xl-8">
            <div class="card mb-4 shadow-sm border-0">
                <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">
                    <span><i class="bi bi-info-circle me-1"></i> Thông tin thuê xe</span>
                    <span class="badge ${order.status == 1 ? 'bg-success' : (order.status == 0 ? 'bg-warning text-dark' : 'bg-secondary')}">
                        <c:choose>
                            <c:when test="${order.status == 0}">Chờ duyệt</c:when>
                            <c:when test="${order.status == 1}">Đang thuê</c:when>
                            <c:when test="${order.status == 2}">Đã trả xe</c:when>
                            <c:otherwise>Đã hủy</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="card-body">
                    <div class="row mb-4">
                        <div class="col-sm-6">
                            <h6 class="text-muted text-uppercase small fw-bold">Khách hàng</h6>
                            <p class="fs-5">${order.customerName}</p>
                        </div>
                        <div class="col-sm-6">
                            <h6 class="text-muted text-uppercase small fw-bold">Dòng xe đặt thuê</h6>
                            <p class="fs-5 text-primary fw-bold">${order.carModel}</p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <h6 class="text-muted text-uppercase small fw-bold">Ngày tạo đơn</h6>
                            <p><i class="bi bi-calendar3 me-2"></i>${order.orderDate}</p>
                        </div>
                        <div class="col-sm-6">
                            <h6 class="text-muted text-uppercase small fw-bold">Tổng thanh toán</h6>
                            <p class="fs-4 text-danger fw-bold">
                                <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="đ"/>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-4">
            <div class="card mb-4 shadow-sm border-0">
                <div class="card-header bg-light fw-bold">
                    <i class="bi bi-gear me-1"></i> Thao tác nhanh
                </div>
                <div class="card-body d-grid gap-2">
                    <a href="admin-orders?action=edit&id=${order.id}" class="btn btn-warning">
                        <i class="bi bi-pencil-square me-2"></i>Thay đổi trạng thái
                    </a>
                    <a href="admin-orders" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-left me-2"></i>Quay lại danh sách
                    </a>
                    <hr>
                    <button class="btn btn-outline-dark" onclick="window.print()">
                        <i class="bi bi-printer me-2"></i>In hóa đơn đơn hàng
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>