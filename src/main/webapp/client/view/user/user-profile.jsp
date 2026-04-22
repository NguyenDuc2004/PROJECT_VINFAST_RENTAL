<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    :root {
        --vf-blue: #0062ff;
        --bg-profile: #f4f7fe;
    }

    .profile-section {
        background-color: var(--bg-profile);
        min-height: 100vh;
        padding: 60px 0;
    }

    /* 1. CARD CHÍNH */
    .profile-card {
        border: none;
        border-radius: 24px;
        background: #ffffff;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.05);
        overflow: hidden;
    }

    /* 2. HEADER TRANG TRÍ */
    .profile-header-bg {
        height: 120px;
        background: linear-gradient(135deg, var(--vf-blue) 0%, #004dc9 100%);
    }

    /* 3. AVATAR KHỐI NỔI */
    .avatar-wrapper {
        margin-top: -60px;
        display: flex;
        justify-content: center;
        margin-bottom: 20px;
    }

    .avatar-inner {
        width: 120px;
        height: 120px;
        border-radius: 35px;
        background: #fff;
        padding: 5px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }

    .avatar-inner img {
        width: 100%;
        height: 100%;
        border-radius: 30px;
        object-fit: cover;
    }

    /* 4. FORM STYLE */
    .profile-label {
        font-size: 0.75rem;
        font-weight: 800;
        color: #94a3b8;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        margin-bottom: 8px;
    }

    .profile-input {
        border-radius: 12px;
        padding: 12px 16px;
        border: 1px solid #e2e8f0;
        font-weight: 600;
        color: #1e293b;
        background-color: #f8fafc;
        transition: all 0.3s;
    }

    .profile-input:focus {
        border-color: var(--vf-blue);
        box-shadow: 0 0 0 4px rgba(0, 98, 255, 0.1);
        background-color: #fff;
    }

    .profile-input[readonly] {
        background-color: #f1f5f9;
        cursor: not-allowed;
    }

    /* 5. NÚT LƯU */
    .btn-save-profile {
        background: var(--vf-blue);
        color: #fff;
        border: none;
        padding: 12px 35px;
        border-radius: 12px;
        font-weight: 700;
        transition: all 0.3s;
    }

    .btn-save-profile:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(0, 98, 255, 0.3);
        background: #0056e0;
    }
</style>
<c:if test="${not empty sessionScope.toastMsg}">
    <div id="toast-container" style="position: fixed; top: 20px; right: 20px; z-index: 9999; min-width: 320px;">

        <div id="auto-close-alert"
             class="alert alert-${sessionScope.toastType} alert-dismissible fade show shadow-lg border-0"
             role="alert"
             style="border-left: 5px solid ${sessionScope.toastType == 'success' ? '#198754' : '#dc3545'}; background-color: white;">

            <div class="d-flex align-items-center">
                    <%-- Icon tự đổi theo loại --%>
                <i class="bi ${sessionScope.toastType == 'success' ? 'bi-check-circle-fill text-success' : 'bi-exclamation-triangle-fill text-danger'} fs-4 me-3"></i>

                <div class="me-4">
                    <h6 class="mb-0 fw-bold" style="color: #333;">Thông báo hệ thống</h6>
                    <small class="text-muted">${sessionScope.toastMsg}</small>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </div>
    </div>
    <%-- QUAN TRỌNG: Hiển thị xong phải xóa ngay để F5 không bị hiện lại --%>
    <c:remove var="toastMsg" scope="session"/>
    <c:remove var="toastType" scope="session"/>
</c:if>
<div class="profile-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <div class="card profile-card">
                    <div class="profile-header-bg"></div>

                    <div class="card-body p-4 p-md-5">
                        <div class="avatar-wrapper">
                            <div class="avatar-inner">
                                <img src="https://ui-avatars.com/api/?name=${user.fullname}&background=0062ff&color=fff&size=128"
                                     alt="User Avatar">
                            </div>
                        </div>

                        <div class="text-center mb-5">
                            <h3 class="fw-800 text-dark mb-1" style="font-weight: 800;">Thiết lập hồ sơ</h3>
                            <p class="text-muted small">Cập nhật thông tin cá nhân của bạn để trải nghiệm dịch vụ tốt hơn</p>
                        </div>

                        <form action="home" method="post">
                            <input type="hidden" name="action" value="updateProfile">
                            <input type="hidden" name="id" value="${user.id}">

                            <div class="row g-4">
                                <div class="col-12">
                                    <label class="profile-label">Họ và tên</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-transparent border-end-0" style="border-radius: 12px 0 0 12px; border-color: #e2e8f0;">
                                            <i class="bi bi-person text-muted"></i>
                                        </span>
                                        <input type="text" name="fullname" class="form-control profile-input border-start-0"
                                               style="border-radius: 0 12px 12px 0;"
                                               value="${user.fullname}" required placeholder="Nhập họ và tên...">
                                    </div>
                                </div>

                                <div class="col-12">
                                    <label class="profile-label">Địa chỉ Email</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-transparent border-end-0" style="border-radius: 12px 0 0 12px; border-color: #e2e8f0;">
                                            <i class="bi bi-envelope text-muted"></i>
                                        </span>
                                        <input type="email" name="email" class="form-control profile-input border-start-0"
                                               style="border-radius: 0 12px 12px 0;"
                                               value="${user.email}" readonly>
                                    </div>
                                    <div class="form-text text-start ms-2" style="font-size: 0.7rem;">
                                        <i class="bi bi-info-circle me-1"></i> Email định danh không thể thay đổi
                                    </div>
                                </div>

                                <div class="col-12">
                                    <label class="profile-label">Số điện thoại</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-transparent border-end-0" style="border-radius: 12px 0 0 12px; border-color: #e2e8f0;">
                                            <i class="bi bi-telephone text-muted"></i>
                                        </span>
                                        <input type="text" name="phone" class="form-control profile-input border-start-0"
                                               style="border-radius: 0 12px 12px 0;"
                                               value="${user.phone}" placeholder="Nhập số điện thoại...">
                                    </div>
                                </div>

                                <div class="col-12">
                                    <label class="profile-label">Địa chỉ liên hệ</label>
                                    <textarea name="address" class="form-control profile-input" rows="3"
                                              placeholder="Nhập địa chỉ của bạn...">${user.address}</textarea>
                                </div>

                                <div class="col-12 text-center mt-4">
                                    <button type="submit" class="btn btn-save-profile w-100 shadow-sm">
                                        LƯU THÔNG TIN HỒ SƠ
                                    </button>
                                    <a href="home" class="btn btn-link mt-3 text-muted text-decoration-none small fw-bold">
                                        <i class="bi bi-arrow-left me-1"></i> QUAY LẠI TRANG CHỦ
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Tự động đóng thông báo sau 3 giây
    window.addEventListener('DOMContentLoaded', (event) => {
        const toast = document.getElementById('auto-close-alert');
        if (toast) {
            setTimeout(() => {
                // Sử dụng class của Bootstrap để fade out
                const bsAlert = new bootstrap.Alert(toast);
                bsAlert.close();
            }, 3000); // 3000ms = 3 giây
        }
    });
</script>