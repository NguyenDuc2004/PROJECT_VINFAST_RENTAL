<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<style>
    :root {
        --vf-blue: #0062ff;
        --bg-light: #f1f5f9;
        --text-dark: #0f172a;
        --text-muted: #64748b;
    }

    body {
        background-color: var(--bg-light);
        /* Thêm font dự phòng sans-serif để nếu Google Font lỗi vẫn không bị phông có chân */
        font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
        margin: 0;
        -webkit-font-smoothing: antialiased;
    }

    .fw-black { font-weight: 900 !important; }

    .responsive-container {
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;
        padding: 40px 20px;
    }

    .main-card {
        background: #ffffff;
        border-radius: 32px;
        overflow: hidden;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.04);
        border: none;
    }

    .image-section {
        background: #ffffff;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 40px;
        position: relative;
        min-height: 450px;
    }

    .main-car-img {
        max-width: 100%;
        max-height: 380px;
        object-fit: contain;
        filter: drop-shadow(0 20px 30px rgba(0, 0, 0, 0.08));
    }

    .content-section {
        padding: 50px 60px !important;
        background: #fafbfc;
    }

    .display-title {
        font-size: 3rem;
        font-weight: 800;
        margin-bottom: 15px;
        line-height: 1.1;
        color: var(--text-dark);
        letter-spacing: -1px;
    }

    .price-box {
        background: #ffffff;
        border-radius: 20px;
        padding: 24px;
        margin-bottom: 30px;
        border: 1px solid #eef2f6;
        border-left: 6px solid var(--vf-blue);
        box-shadow: 0 4px 12px rgba(0,0,0,0.02);
    }

    .spec-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 15px;
        margin-bottom: 30px;
    }

    .spec-item {
        background: #ffffff;
        padding: 18px 10px;
        border-radius: 18px;
        text-align: center;
        border: 1px solid #f1f5f9;
        transition: 0.3s;
    }

    .spec-item:hover { border-color: var(--vf-blue); }
    .spec-item i { font-size: 1.6rem; color: var(--vf-blue); margin-bottom: 8px; display: block; }
    .spec-label { color: var(--text-muted); font-size: 0.7rem; font-weight: 700; text-transform: uppercase; margin-bottom: 4px; display: block; }
    .spec-value { font-weight: 700; color: var(--text-dark); font-size: 0.9rem; }

    .full-width-description {
        padding: 45px 60px;
        border-top: 1px solid #f1f5f9;
        background: #ffffff;
    }

    .description-title {
        font-size: 0.85rem;
        font-weight: 800;
        color: var(--vf-blue);
        text-transform: uppercase;
        margin-bottom: 18px;
        display: flex;
        align-items: center;
        gap: 12px;
        letter-spacing: 1px;
    }

    .description-text {
        color: var(--text-muted);
        font-size: 1.05rem;
        line-height: 1.8;
        white-space: pre-line;
        font-weight: 400;
    }

    .action-group { display: flex; gap: 15px; margin-top: 10px; }

    .btn-custom {
        flex: 1; padding: 18px; border-radius: 16px;
        font-weight: 700; text-transform: uppercase;
        display: flex; align-items: center; justify-content: center;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        text-decoration: none;
        font-size: 0.95rem;
    }

    .btn-main { background: var(--vf-blue); color: #fff; box-shadow: 0 8px 20px rgba(0, 98, 255, 0.2); }
    .btn-main:hover { background: #0052d4; transform: translateY(-2px); box-shadow: 0 12px 25px rgba(0, 98, 255, 0.3); }

    .btn-secondary-custom { background: #f1f5f9; color: var(--text-dark); border: 1px solid #e2e8f0; }
    .btn-secondary-custom:hover { background: #e2e8f0; }

    .status-badge {
        background: rgba(40, 167, 69, 0.1);
        color: #28a745;
        padding: 8px 16px;
        border-radius: 10px;
        font-weight: 700;
        font-size: 0.8rem;
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }

    @media (max-width: 992px) {
        .content-section { padding: 40px !important; }
        .full-width-description { padding: 30px 40px; }
        .display-title { font-size: 2.2rem; }
    }
</style>

<div class="responsive-container">
    <div class="mb-4 d-flex justify-content-between align-items-center">
        <a href="${pageContext.request.contextPath}/product" class="text-decoration-none text-muted fw-bold small">
            <i class="bi bi-arrow-left me-2"></i> QUAY LẠI DANH SÁCH
        </a>
        <div class="small">
            <i class="bi bi-geo-alt-fill text-danger"></i>
            <span class="fw-bold ms-1">${car.locationName}</span>
        </div>
    </div>

    <div class="main-card">
        <div class="row g-0">
            <div class="col-lg-7 image-section border-end">
                <div style="position: absolute; top: 30px; left: 30px;">
                    <div class="status-badge" style="${car.status != 'AVAILABLE' ? 'color: #dc3545; background: rgba(220, 53, 69, 0.1);' : ''}">
                        <i class="bi bi-circle-fill" style="font-size: 0.5rem;"></i>
                        ${car.status == 'AVAILABLE' ? 'SẴN SÀNG PHỤC VỤ' : 'ĐANG BẢO TRÌ'}
                    </div>
                </div>
                <img src="${car.imageUrl}" class="main-car-img"
                     onerror="this.src='https://img.vanhai.vn/202304/xe-dien-vinfast-vf8.jpg'">
            </div>

            <div class="col-lg-5 content-section d-flex flex-column justify-content-center">
                <div class="mb-4">
                    <h6 class="text-primary fw-800 text-uppercase small mb-2" style="letter-spacing: 2px;">VinFast Premium Rental</h6>
                    <h1 class="display-title">${car.modelName}</h1>
                    <span class="badge bg-dark px-3 py-2 rounded-3 fw-bold font-monospace" style="letter-spacing: 1px;">${car.licensePlate}</span>
                </div>

                <div class="price-box">
                    <small class="text-muted fw-bold d-block text-uppercase mb-2" style="font-size: 0.65rem; letter-spacing: 1px;">Giá thuê niêm yết</small>
                    <div class="d-flex align-items-baseline gap-2">
                        <span class="h1 fw-black text-primary mb-0" style="font-size: 2.5rem;">
                            <fmt:formatNumber value="${car.pricePerDay}" pattern="#,###"/>
                        </span>
                        <span class="fw-bold text-primary">VNĐ / NGÀY</span>
                    </div>
                </div>

                <div class="spec-grid">
                    <div class="spec-item">
                        <i class="bi bi-car-front"></i>
                        <span class="spec-label">Dòng xe</span>
                        <span class="spec-value">${car.categoryName}</span>
                    </div>
                    <div class="spec-item">
                        <i class="bi bi-fuel-pump-diesel"></i>
                        <span class="spec-label">Nhiên liệu</span>
                        <span class="spec-value">Xe Điện</span>
                    </div>
                    <div class="spec-item">
                        <i class="bi bi-people"></i>
                        <span class="spec-label">Chỗ ngồi</span>
                        <span class="spec-value">5 Chỗ</span>
                    </div>
                </div>

                <div class="action-group">
                    <c:if test="${sessionScope.currUser.role == 1}">
                        <a href="${pageContext.request.contextPath}/product?action=edit-car&id=${car.id}"
                           class="btn-custom btn-main">
                            <i class="bi bi-pencil-square me-2"></i> CHỈNH SỬA XE
                        </a>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/product" class="btn-custom btn-secondary-custom">
                        QUAY LẠI
                    </a>
                </div>
            </div>
        </div>

        <div class="full-width-description">
            <div class="description-title">
                <i class="bi bi-stars"></i> Thông tin chi tiết sản phẩm
            </div>
            <div class="description-text">
                <c:choose>
                    <c:when test="${not empty car.description}">
                        ${car.description}
                    </c:when>
                    <c:otherwise>
                        Mẫu xe điện ${car.modelName} là sự kết hợp hoàn hảo giữa thiết kế sang trọng và công nghệ thông minh. Xe được trang bị hệ thống trợ lái nâng cao cùng nội thất tinh tế, mang lại trải nghiệm lái êm ái và đẳng cấp cho người dùng.
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>