<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid px-4">
    <h1 class="mt-4">Cập nhật đơn hàng</h1>
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item"><a href="dashboard">Dashboard</a></li>
        <li class="breadcrumb-item"><a href="admin-orders">Quản lý đơn hàng</a></li>
        <li class="breadcrumb-item active">Chỉnh sửa #${order.id}</li>
    </ol>

    <div class="card mb-4 shadow-sm">
        <div class="card-header bg-primary text-white">
            <i class="bi bi-pencil-square me-1"></i>
            Thông tin chỉnh sửa đơn hàng #${order.id}
        </div>
        <div class="card-body">
            <form action="admin-orders" method="post">
                <input type="hidden" name="action" value="updateStatus">
                <input type="hidden" name="id" value="${order.id}">

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Khách hàng</label>
                        <input type="text" class="form-control bg-light" value="${order.customerName}" readonly>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Dòng xe</label>
                        <input type="text" class="form-control bg-light" value="${order.carModel}" readonly>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Tổng tiền (VNĐ)</label>
                        <input type="text" class="form-control bg-light"
                               value="<fmt:formatNumber value='${order.totalPrice}' type='number'/>" readonly>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="status" class="form-label fw-bold">Trạng thái đơn hàng</label>
                        <select class="form-select border-primary" id="status" name="status">
                            <option value="0" ${order.status == 0 ? 'selected' : ''}>Chờ duyệt</option>
                            <option value="1" ${order.status == 1 ? 'selected' : ''}>Đã thuê (Đang sử dụng)</option>
                            <option value="2" ${order.status == 2 ? 'selected' : ''}>Đã trả xe</option>
                            <option value="3" ${order.status == 3 ? 'selected' : ''}>Hủy đơn</option>
                        </select>
                        <div class="form-text">Thay đổi trạng thái để cập nhật tiến độ thuê xe.</div>
                    </div>
                </div>

                <div class="mt-4 border-top pt-3 text-end">
                    <a href="admin-orders" class="btn btn-secondary me-2">
                        <i class="bi bi-x-circle"></i> Hủy bỏ
                    </a>
                    <button type="submit" class="btn btn-primary px-4">
                        <i class="bi bi-save"></i> Cập nhật trạng thái
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>