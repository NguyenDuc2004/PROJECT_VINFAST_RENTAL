<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid px-4 py-4">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="dashboard" class="text-decoration-none">Dashboard</a></li>
            <li class="breadcrumb-item"><a href="admin-orders" class="text-decoration-none">Quản lý đơn hàng</a></li>
            <li class="breadcrumb-item active">Mã đơn #${order.id}</li>
        </ol>
    </nav>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold m-0">Chi tiết đơn hàng <span class="text-muted">#${order.id}</span></h2>
        <div>
            <c:choose>
                <c:when test="${order.status == 0}"><span class="badge bg-warning text-dark px-3 py-2 rounded-pill">Chờ duyệt</span></c:when>
                <c:when test="${order.status == 1}"><span class="badge bg-success px-3 py-2 rounded-pill">Đang thuê</span></c:when>
                <c:when test="${order.status == 2}"><span class="badge bg-primary px-3 py-2 rounded-pill">Đã trả xe</span></c:when>
                <c:otherwise><span class="badge bg-secondary px-3 py-2 rounded-pill">Đã hủy</span></c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-xl-8">
            <div class="card border-0 shadow-sm rounded-4 mb-4">
                <div class="card-header bg-white py-3 border-bottom">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-person-badge me-2 text-primary"></i>Thông tin đơn hàng</h5>
                </div>
                <div class="card-body">
                    <div class="row mb-4">
                        <div class="col-md-6 mb-3">
                            <label class="text-muted small text-uppercase fw-bold d-block">Khách hàng</label>
                            <span class="fs-5 fw-bold text-dark">${order.customerName}</span>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="text-muted small text-uppercase fw-bold d-block">Mã số xe (Car ID)</label>
                            <span class="badge bg-info-subtle text-info fs-6 px-3 border border-info-subtle">${order.carId}</span>
                        </div>
                    </div>

                    <div class="row mb-4">
                        <div class="col-md-6 mb-3">
                            <label class="text-muted small text-uppercase fw-bold d-block">Số điện thoại</label>
                            <span class="fs-6"><i class="bi bi-telephone me-2 text-muted"></i>${order.phone}</span>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="text-muted small text-uppercase fw-bold d-block">Email</label>
                            <span class="fs-6"><i class="bi bi-envelope me-2 text-muted"></i>${order.email}</span>
                        </div>
                    </div>

                    <hr class="my-4 opacity-25">

                    <div class="row mb-4">
                        <div class="col-md-6">
                            <div class="p-3 bg-light rounded-3 border-start border-success border-4">
                                <label class="text-muted small text-uppercase fw-bold d-block">Ngày nhận xe</label>
                                <span class="fs-5 fw-bold text-success"><i class="bi bi-calendar-check me-2"></i><fmt:formatDate value="${order.startDate}" pattern="dd/MM/yyyy"/></span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="p-3 bg-light rounded-3 border-start border-danger border-4">
                                <label class="text-muted small text-uppercase fw-bold d-block">Ngày trả xe</label>
                                <span class="fs-5 fw-bold text-danger"><i class="bi bi-calendar-x me-2"></i><fmt:formatDate value="${order.endDate}" pattern="dd/MM/yyyy"/></span>
                            </div>
                        </div>
                    </div>

                    <div class="mb-0">
                        <label class="text-muted small text-uppercase fw-bold d-block">Ghi chú của khách</label>
                        <div class="p-3 bg-light rounded-3 italic text-muted">
                            ${not empty order.note ? order.note : "Không có ghi chú nào."}
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-xl-4">
            <div class="card border-0 shadow-sm rounded-4 mb-4 overflow-hidden">
                <div class="card-body p-0">
                    <div class="bg-primary p-4 text-white">
                        <label class="small text-uppercase opacity-75 d-block">Tổng cộng thanh toán</label>
                        <h2 class="fw-900 mb-0"><fmt:formatNumber value="${order.totalPrice}" pattern="#,###"/> đ</h2>
                    </div>
                    <div class="p-4">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Ngày đặt đơn:</span>
                            <span class="fw-bold"><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span class="text-muted">Phương thức:</span>
                            <span class="badge bg-light text-dark border">Thanh toán tại quầy</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card border-0 shadow-sm rounded-4 mb-4">
                <div class="card-header bg-white py-3 border-bottom">
                    <h6 class="mb-0 fw-bold">Xử lý đơn hàng</h6>
                </div>
                <div class="card-body d-grid gap-2">
                    <a href="admin-orders?action=edit&id=${order.id}" class="btn btn-warning py-2 fw-bold">
                        <i class="bi bi-pencil-square me-2"></i>Cập nhật trạng thái
                    </a>
                    <button class="btn btn-dark py-2 fw-bold" onclick="window.print()">
                        <i class="bi bi-printer me-2"></i>In phiếu thuê xe
                    </button>
                    <hr>
                    <a href="admin-orders" class="btn btn-outline-secondary py-2">
                        <i class="bi bi-arrow-left me-2"></i>Quay lại danh sách
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .fw-900 { font-weight: 900; }
    .bg-info-subtle { background-color: #e0f2fe; }
    .text-info { color: #0369a1 !important; }
</style>