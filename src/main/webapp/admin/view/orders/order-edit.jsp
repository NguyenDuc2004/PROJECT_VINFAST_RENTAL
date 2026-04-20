<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid px-4 py-4">
    <h1 class="fw-bold">Cập nhật đơn hàng</h1>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item"><a href="dashboard" class="text-decoration-none">Dashboard</a></li>
            <li class="breadcrumb-item"><a href="admin-orders" class="text-decoration-none">Quản lý đơn hàng</a></li>
            <li class="breadcrumb-item active">Chỉnh sửa #${order.id}</li>
        </ol>
    </nav>

    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="card mb-4 shadow-sm border-0 rounded-4">
                <div class="card-header bg-dark text-white py-3 rounded-top-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="fw-bold"><i class="bi bi-pencil-square me-2"></i>Thay đổi trạng thái đơn hàng #${order.id}</span>
                        <span class="small opacity-75">Ngày đặt: <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                    </div>
                </div>
                <div class="card-body p-4">
                    <form action="admin-orders" method="post">
                        <input type="hidden" name="action" value="updateStatus">
                        <input type="hidden" name="id" value="${order.id}">

                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label class="form-label text-muted small fw-bold">KHÁCH HÀNG</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-0"><i class="bi bi-person"></i></span>
                                    <input type="text" class="form-control bg-light border-0 fw-bold" value="${order.customerName}" readonly>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label text-muted small fw-bold">MÃ SỐ XE (CAR ID)</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-0"><i class="bi bi-car-front"></i></span>
                                    <input type="text" class="form-control bg-light border-0 fw-bold text-primary" value="${order.carId}" readonly>
                                </div>
                            </div>
                        </div>

                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label class="form-label text-muted small fw-bold">LỊCH TRÌNH THUÊ</label>
                                <div class="p-3 bg-light rounded-3 border">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span class="small">Ngày nhận:</span>
                                        <span class="fw-bold text-success"><fmt:formatDate value="${order.startDate}" pattern="dd/MM/yyyy"/></span>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <span class="small">Ngày trả:</span>
                                        <span class="fw-bold text-danger"><fmt:formatDate value="${order.endDate}" pattern="dd/MM/yyyy"/></span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label text-muted small fw-bold">TỔNG THANH TOÁN (VNĐ)</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light border-0"><i class="bi bi-cash-stack"></i></span>
                                    <input type="text" class="form-control bg-light border-0 fw-bold text-danger fs-5"
                                           value="<fmt:formatNumber value='${order.totalPrice}' pattern='#,###'/> đ" readonly>
                                </div>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="status" class="form-label text-primary fw-bold"><i class="bi bi-arrow-repeat me-2"></i>TRẠNG THÁI ĐƠN HÀNG</label>
                            <select class="form-select form-select-lg border-2 border-primary shadow-sm" id="status" name="status">
                                <option value="0" ${order.status == 0 ? 'selected' : ''}>⏳ Chờ duyệt (Khách mới đặt)</option>
                                <option value="1" ${order.status == 1 ? 'selected' : ''}>🚗 Đang thuê (Đã giao xe)</option>
                                <option value="2" ${order.status == 2 ? 'selected' : ''}>✅ Đã trả xe (Hoàn thành đơn)</option>
                                <option value="3" ${order.status == 3 ? 'selected' : ''}>❌ Hủy đơn (Khách hủy/Sự cố)</option>
                            </select>
                            <div class="form-text text-info mt-2">
                                <i class="bi bi-info-circle-fill me-1"></i> Lưu ý: Chuyển sang "Đang thuê" sẽ tự động cập nhật xe thành <b>UNAVAILABLE</b>.
                            </div>
                        </div>

                        <div class="mt-4 border-top pt-4 text-end">
                            <a href="admin-orders" class="btn btn-light px-4 me-2">
                                <i class="bi bi-x-circle me-1"></i> Hủy bỏ
                            </a>
                            <button type="submit" class="btn btn-primary px-5 fw-bold shadow-sm">
                                <i class="bi bi-check-circle me-1"></i> Cập nhật ngay
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .form-select-lg { font-weight: 700; cursor: pointer; }
    .bg-light { background-color: #f8fafc !important; }
</style>