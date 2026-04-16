<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800;900&display=swap"
      rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<style>
    :root {
        --vf-blue: #0062ff;
        --bg-light: #f1f5f9;
        --text-dark: #0f172a;
    }

    body {
        background-color: var(--bg-light);
        font-family: 'Plus Jakarta Sans', sans-serif;
        margin: 0;
    }

    .fw-black {
        font-weight: 900 !important;
    }

    .responsive-container {
        width: 100%;
        max-width: 1350px;
        margin: 0 auto;
        padding: 40px 20px;
    }

    .main-card {
        background: #ffffff;
        border-radius: 32px;
        overflow: hidden;
        border: none;
        box-shadow: 0 15px 50px rgba(0, 0, 0, 0.06);
    }

    .image-section {
        background: #ffffff;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 50px;
        position: relative;
        min-height: 500px;
    }

    .status-badge-left {
        position: absolute;
        top: 30px;
        left: 30px;
        z-index: 10;
    }

    .custom-badge {
        background: #28a745;
        color: white;
        padding: 10px 22px;
        border-radius: 12px;
        font-weight: 800;
        font-size: 0.9rem;
        box-shadow: 0 5px 15px rgba(40, 167, 69, 0.2);
    }

    .main-car-img {
        max-width: 100%;
        height: auto;
        object-fit: contain;
        filter: drop-shadow(0 20px 40px rgba(0, 0, 0, 0.12));
    }

    .content-section {
        padding: 50px !important;
    }

    .display-title {
        font-size: 3.2rem;
        font-weight: 900;
        margin-bottom: 20px;
        line-height: 1.1;
    }

    .price-box {
        background: #f0f7ff;
        border-radius: 20px;
        padding: 28px;
        margin-bottom: 30px;
        border-left: 8px solid var(--vf-blue);
    }

    .spec-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr); /* Đổi sang 3 cột cho cân đối vì đã bỏ 1 mục */
        gap: 15px;
        margin-bottom: 35px;
    }

    .spec-item {
        background: #f8fafc;
        padding: 20px 10px;
        border-radius: 16px;
        text-align: center;
        border: 1px solid rgba(0, 0, 0, 0.03);
    }

    .spec-item i {
        font-size: 1.8rem;
        color: var(--vf-blue);
        margin-bottom: 8px;
    }

    .action-group {
        display: flex;
        gap: 15px;
        margin-bottom: 25px;
    }

    .btn-custom {
        flex: 1;
        padding: 18px;
        border-radius: 16px;
        font-weight: 800;
        font-size: 1rem;
        text-transform: uppercase;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s;
        text-decoration: none;
    }

    .btn-main {
        background: var(--vf-blue);
        color: #fff;
        border: none;
    }

    .btn-main:hover {
        background: #0052d4;
        transform: translateY(-3px);
    }

    .btn-secondary-custom {
        background: #f1f5f9;
        color: var(--text-dark);
        border: 1px solid #e2e8f0;
    }

    .update-info {
        background: #fff9e6;
        color: #856404;
        padding: 12px;
        border-radius: 12px;
        font-size: 0.85rem;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        border: 1px solid #ffeeba;
    }

    @media (max-width: 1199px) {
        .display-title {
            font-size: 2.6rem;
        }

        .image-section {
            min-height: 400px;
        }
    }

    @media (max-width: 767px) {
        .spec-grid {
            grid-template-columns: repeat(2, 1fr);
        }

        .action-group {
            flex-direction: column;
        }

        .content-section {
            padding: 35px !important;
        }
    }
</style>

<div class="responsive-container">
    <div class="mb-4">
        <a href="${pageContext.request.contextPath}/product" class="text-decoration-none text-muted fw-bold">
            <i class="bi bi-arrow-left-circle-fill me-2 fs-5"></i> DANH SÁCH XE
        </a>
    </div>

    <div class="main-card">
        <div class="row g-0">
            <div class="col-lg-7 image-section border-end bg-white">
                <div class="status-badge-left">
                    <div class="custom-badge">
                        <i class="bi bi-check-circle-fill me-1"></i> SẴN SÀNG
                    </div>
                </div>
                <img src="${car.imageUrl}" class="main-car-img"
                     onerror="this.src='https://img.vanhai.vn/202304/xe-dien-vinfast-vf8.jpg'">
            </div>

            <div class="col-lg-5 content-section bg-white d-flex flex-column justify-content-center">
                <div class="mb-5">
                    <h6 class="text-primary fw-bold text-uppercase small mb-2" style="letter-spacing: 3px;">VinFast
                        Premium</h6>
                    <h1 class="display-title text-dark">${car.modelName}</h1>
                    <div class="d-flex align-items-center gap-3">
                        <span class="badge bg-dark px-3 py-2 rounded-2 fs-6 font-monospace">30H - 259.99</span>
                        <span class="text-muted fw-bold">ID: #${car.id}</span>
                    </div>
                </div>

                <div class="price-box shadow-sm">
                    <small class="text-muted fw-bold d-block text-uppercase mb-2" style="font-size: 0.7rem;">Giá thuê ưu
                        đãi</small>
                    <div class="d-flex align-items-baseline gap-2">
                        <span class="h1 fw-black text-primary mb-0">3.000.000</span>
                        <span class="h4 fw-bold text-primary">VNĐ / NGÀY</span>
                    </div>
                </div>

                <div class="spec-grid">
                    <div class="spec-item shadow-sm">
                        <i class="bi bi-box-seam d-block"></i>
                        <small class="text-muted d-block fw-bold small">PHÂN LOẠI</small>
                        <span class="fw-bold">SUV Luxury</span>
                    </div>
                    <div class="spec-item shadow-sm">
                        <i class="bi bi-lightning-charge-fill text-warning d-block"></i>
                        <small class="text-muted d-block fw-bold small">NHIÊN LIỆU</small>
                        <span class="fw-bold">Xe Điện</span>
                    </div>
                    <div class="spec-item shadow-sm">
                        <i class="bi bi-cpu d-block text-primary"></i>
                        <small class="text-muted d-block fw-bold small">TRUYỀN ĐỘNG</small>
                        <span class="fw-bold">Tự Động</span>
                    </div>
                </div>

                <div class="action-group">
                    <c:if test="${sessionScope.currUser.role == 1}">
                        <a href="${pageContext.request.contextPath}/product?action=edit-car&id=${car.id}"
                           class="btn-custom btn-main shadow-sm">
                            <i class="bi bi-pencil-square me-2"></i> CHỈNH SỬA
                        </a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/product" class="btn-custom btn-secondary-custom">
                        QUAY LẠI
                    </a>
                </div>

                <div class="mt-4 text-center">
                    <small class="text-muted">
                        <i class="bi bi-shield-check text-success"></i>
                        Hệ thống cam kết xe đúng mô tả và bảo trì định kỳ.
                    </small>
                </div>
            </div>
        </div>
    </div>
</div>