<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid">
    <div class="bg-white px-4 py-2 border-bottom d-flex align-items-center">
        <a href="${pageContext.request.contextPath}/user" class="btn btn-sm btn-outline-secondary border-0 me-3">
            <i class="bi bi-arrow-left me-2"></i>Quay lại
        </a>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="user">Người dùng</a></li>
                <li class="breadcrumb-item active">Xem chi tiết</li>
            </ol>
        </nav>
    </div>

    <div class="row g-4">
        <div class="col-md-4">
            <div class="card border-0 shadow-sm pt-4 overflow-hidden">
                <div class="text-center px-3">
                    <img src="https://ui-avatars.com/api/?name=${user.fullname}&size=128&background=random&color=fff"
                         class="rounded-circle mb-3 shadow-sm border border-3 border-white" width="120">
                    <h4 class="fw-bold mb-1">${not empty user.fullname ? user.fullname : ""}</h4>
                    <p class="text-muted small mb-3">ID tài khoản: #${user.id}</p>

                    <c:choose>
                        <c:when test="${user.role== 1}">
                            <span class="badge bg-danger-subtle text-danger border border-danger-subtle px-3 py-2">QUẢN TRỊ VIÊN</span>
                        </c:when>
                        <c:when test="${user.role == 2}">
                            <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-2">NHÂN VIÊN</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle px-3 py-2">KHÁCH HÀNG</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="list-group list-group-flush mt-4">
                    <div class="list-group-item d-flex justify-content-between align-items-center py-3 px-4">
                        <span class="text-muted small fw-bold text-uppercase">Trạng thái</span>
                        <c:choose>
                            <c:when test="${user.status == 1}">
                                <span class="text-success fw-bold small"><i class="bi bi-patch-check-fill me-1"></i>Đang hoạt động</span>
                            </c:when>
                            <c:otherwise>
                                <span class="text-danger fw-bold small"><i class="bi bi-x-octagon-fill me-1"></i>Đã khóa</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="list-group-item d-flex justify-content-between align-items-center py-3 px-4">
                        <span class="text-muted small fw-bold text-uppercase">Ngày tham gia</span>
                        <span class="fw-medium small text-dark">${user.createdAt}</span>
                    </div>
                </div>

                <div class="card-footer bg-light border-0 p-3 text-center">
                    <a href="?action=edit&id=${user.id}" class="btn btn-primary w-100">
                        <i class="bi bi-pencil-square me-2"></i>Chỉnh sửa hồ sơ
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-white py-3 border-bottom">
                    <h5 class="mb-0 fw-bold text-dark"><i class="bi bi-person-badge me-2 text-primary"></i>Thông tin chi tiết</h5>
                </div>
                <div class="card-body p-4">
                    <div class="row mb-4">
                        <div class="col-sm-4">
                            <p class="text-muted small fw-bold text-uppercase mb-1">Họ và tên</p>
                            <p class="fw-semibold text-dark mb-0">${user.fullname}</p>
                        </div>
                        <div class="col-sm-8">
                            <p class="text-muted small fw-bold text-uppercase mb-1">Địa chỉ Email</p>
                            <p class="fw-semibold text-dark mb-0">${user.email}</p>
                        </div>
                    </div>

                    <div class="row mb-4">
                        <div class="col-sm-4">
                            <p class="text-muted small fw-bold text-uppercase mb-1">Số điện thoại</p>
                            <p class="fw-semibold text-primary mb-0">
                                ${not empty user.phone ? user.phone : '<span class="text-muted fw-normal italic">Chưa cập nhật</span>'}
                            </p>
                        </div>
                        <div class="col-sm-8">
                            <p class="text-muted small fw-bold text-uppercase mb-1">Địa chỉ nhận hàng</p>
                            <p class="fw-semibold text-dark mb-0">
                                ${not empty user.address ? user.address : '<span class="text-muted fw-normal italic">Chưa có thông tin địa chỉ</span>'}
                            </p>
                        </div>
                    </div>

                    <hr class="my-4 opacity-25">

                    <h5 class="fw-bold text-dark mb-3"><i class="bi bi-shield-lock me-2 text-warning"></i>Bảo mật & Hệ thống</h5>
                    <div class="bg-light p-3 rounded-3">
                        <div class="row">
                            <div class="col-sm-6">
                                <p class="text-muted small mb-1">Mật khẩu</p>
                                <p class="mb-0 text-dark">•••••••••••• (Đã mã hóa)</p>
                            </div>
                            <div class="col-sm-6">
                                <p class="text-muted small mb-1">Quyền hạn truy cập</p>
                                <p class="mb-0 fw-bold text-dark">${user.role == 1 ? "ADMIN" : (user.role == 2 ? "NHÂN VIÊN" : "KHÁCH HÀNG")}</p>
                            </div>
                        </div>
                    </div>

                    <div class="mt-4">
                        <h6 class="fw-bold mb-2 small text-muted text-uppercase">Ghi chú quản trị</h6>
                        <p class="text-muted small mb-0">Tài khoản này được khởi tạo tự động từ hệ thống quản lý thương mại điện tử.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    /* Sửa lỗi font chữ và hiển thị */
    body { font-family: 'Inter', 'Roboto', sans-serif; }
    .text-uppercase { letter-spacing: 0.05rem; font-size: 0.7rem !important; }
    .card { border-radius: 12px; }
    .badge { font-weight: 700; letter-spacing: 0.5px; }
    .italic { font-style: italic; }
</style>