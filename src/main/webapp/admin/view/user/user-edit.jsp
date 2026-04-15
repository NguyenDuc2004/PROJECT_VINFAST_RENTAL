<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="isUser" value="${user.role == 0}" />

<style>
    /* Làm cho container bao ngoài chiếm toàn bộ chiều cao */
    .main-edit-wrapper {
        height: calc(100vh - 80px); /* Trừ đi chiều cao của Navbar nếu có */
        display: flex;
        flex-direction: column;
        padding: 0 !important; /* Xóa padding để sát mép */
    }

    .edit-card {
        border: none;
        border-radius: 0; /* Bo góc bằng 0 nếu muốn sát khít hoàn toàn */
        display: flex;
        flex-direction: column;
        flex-grow: 1; /* Tự giãn ra chiếm hết khoảng trống */
        box-shadow: none;
    }

    .header-dark { background: #1a1d20; color: white; padding: 15px 25px; }

    /* Cuộn nội dung bên trong nếu quá dài */
    .scroll-content {
        flex-grow: 1;
        overflow-y: auto;
        padding: 25px;
        background: #f4f6f9;
    }

    .sys-panel {
        background: white;
        border-radius: 12px;
        padding: 25px;
        border: 1px solid #dee2e6;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }

    /* Switch giữ nguyên như cũ của ông vì nó đang đẹp */
    .status-toggle-box {
        display: flex; justify-content: space-between; align-items: center;
        background: #f8f9fa; padding: 12px 15px; border: 1px solid #ddd;
        border-radius: 8px; margin-top: 8px;
    }
    .t-switch { position: relative; display: inline-block; width: 50px; height: 24px; }
    .t-switch input { opacity: 0; width: 0; height: 0; }
    .t-slider { position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0; background-color: #ccc; transition: .4s; border-radius: 24px; }
    .t-slider:before { position: absolute; content: ""; height: 18px; width: 18px; left: 3px; bottom: 3px; background-color: white; transition: .4s; border-radius: 50%; }
    input:checked + .t-slider { background-color: #38a41c; } /* Dùng màu xanh thương hiệu của ông */
    input:checked + .t-slider:before { transform: translateX(26px); }

    .footer-actions {
        background: white;
        padding: 15px 25px;
        border-top: 1px solid #dee2e6;
    }
</style>

<div class="main-edit-wrapper">
    <div class="bg-white px-4 py-2 border-bottom d-flex align-items-center">
        <a href="user" class="btn btn-sm btn-outline-secondary border-0 me-3">
            <i class="bi bi-arrow-left"></i> Quay lại
        </a>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item"><a href="user">Người dùng</a></li>
                <li class="breadcrumb-item active">Chỉnh sửa</li>
            </ol>
        </nav>
    </div>

    <div class="card edit-card">
        <div class="header-dark d-flex justify-content-between align-items-center">
            <h5 class="mb-0 fw-bold"><i class="bi bi-person-gear me-2 text-warning"></i>Cấu hình tài khoản: ${user.fullname}</h5>
            <span class="badge ${isUser ? 'bg-secondary' : 'bg-primary'} px-3">${isUser ? 'CHẾ ĐỘ XEM' : 'ADMIN'}</span>
        </div>

        <form action="user?action=edit" method="POST" class="h-100 d-flex flex-column" autocomplete="off">
            <input type="hidden" name="id" value="${user.id}">
            <div class="scroll-content">
                <div class="row g-4">
                    <div class="col-lg-8">
                        <div class="bg-white p-4 rounded-3 border shadow-sm h-100">
                            <h6 class="fw-bold text-primary text-uppercase mb-4">
                                <i class="bi bi-info-circle-fill me-2"></i>Thông tin cơ bản
                            </h6>

                            <div class="mb-4">
                                <label class="form-label small fw-bold text-muted">Họ và tên</label>
                                <input type="text" name="fullname" class="form-control form-control-lg border-2"
                                       value="${user.fullname}" ${isUser ? 'readonly' : ''} required>
                            </div>

                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold text-muted">Email liên hệ</label>
                                    <input type="email" name="email" class="form-control border-2"
                                           value="${user.email}" ${isUser ? 'readonly' : ''} required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold text-muted">Số điện thoại</label>
                                    <input type="text" name="phone" class="form-control border-2"
                                           value="${user.phone}" ${isUser ? 'readonly' : ''}>
                                </div>
                            </div>

                            <div class="mb-0">
                                <label class="form-label small fw-bold text-muted">Địa chỉ thường trú</label>
                                <textarea name="address" class="form-control border-2" rows="5"
                                ${isUser ? 'readonly' : ''}>${user.address}</textarea>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="sys-panel border-2">
                            <h6 class="fw-bold text-primary text-uppercase mb-4 text-center">
                                <i class="bi bi-gear-fill me-2"></i>Thiết lập hệ thống
                            </h6>

                            <div class="mb-4 p-3 bg-light rounded-3">
                                <label class="form-label small fw-bold">Phân quyền</label>

                                <select name="role" class="form-select border-2" ${isUser ? 'disabled' : ''}>
                                    <option value="1" ${user.role == 1 ? 'selected' : ''}>Quản trị viên (Toàn quyền)</option>
                                    <option value="2" ${user.role == 2 ? 'selected' : ''}>Nhân viên (Vận hành)</option>
                                    <option value="0" ${user.role == 0 ? 'selected' : ''}>Khách hàng (Thành viên)</option>
                                </select>

                                <c:if test="${isUser}">
                                    <input type="hidden" name="role" value="0">
                                </c:if>
                            </div>

                            <div class="mb-3">
                                <label class="form-label small fw-bold text-danger">Quyền truy cập</label>
                                <div class="status-toggle-box shadow-sm">
                                    <span class="fw-bold small ${user.status == 1 ? 'text-success' : 'text-danger'}">
                                        ${user.status == 1 ? 'Đang hoạt động' : 'Đang bị khóa'}
                                    </span>
                                    <label class="t-switch">
                                        <input type="checkbox" name="status" value="1"
                                        ${user.status == 1 ? 'checked' : ''}>
                                        <span class="t-slider"></span>
                                    </label>
                                </div>
                            </div>

                            <div class="alert alert-warning border-0 small mt-4 shadow-sm">
                                <i class="bi bi-exclamation-triangle me-2"></i>
                                Lưu ý: Khóa tài khoản sẽ ngăn người dùng đăng nhập ngay lập tức.
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="footer-actions d-flex justify-content-end gap-3">
                <a href="user" class="btn btn-outline-secondary px-4 fw-bold">HỦY BỎ</a>
                    <button type="submit" class="btn btn-primary px-5 fw-bold shadow">
                        <i class="bi bi-check2-circle me-2"></i>LƯU THÔNG TIN
                    </button>
            </div>
        </form>
    </div>
</div>