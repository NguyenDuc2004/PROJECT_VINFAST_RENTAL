<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    :root {
        --vf-blue: #0062ff;
        --text-dark: #0f172a;
        --bg-light: #f8fafc;
        --border-color: #f1f5f9;
    }

    body { background-color: #fff; font-family: 'Plus Jakarta Sans', sans-serif; color: var(--text-dark); }

    /* BREADCRUMB */
    .breadcrumb-item a { color: var(--vf-blue); text-decoration: none; font-weight: 600; }

    /* ẢNH XE STICKY */
    .detail-img-holder {
        border-radius: 32px;
        overflow: hidden;
        background: var(--bg-light);
        position: sticky;
        top: 20px;
    }

    .main-car-img {
        width: 100%;
        height: 480px;
        object-fit: contain;
        padding: 40px;
    }

    /* GIÁ & TIÊU ĐỀ */
    .price-large { font-size: 2.4rem; color: var(--text-dark); font-weight: 800; }

    /* ICON SPECS */
    .spec-card {
        background: var(--bg-light);
        border-radius: 20px;
        padding: 15px;
        text-align: center;
        border: 1px solid var(--border-color);
    }
    .spec-card i { font-size: 1.4rem; color: var(--vf-blue); margin-bottom: 5px; display: block; }
    .spec-card span { font-size: 0.7rem; color: #94a3b8; font-weight: 700; text-transform: uppercase; }
    .spec-card p { font-weight: 800; margin: 0; font-size: 0.9rem; }

    /* KHỐI NỘI DUNG CHI TIẾT (KHI CUỘN XUỐNG) */
    .section-header {
        font-weight: 800;
        font-size: 1.6rem;
        margin: 50px 0 25px;
        position: relative;
        padding-left: 18px;
    }
    .section-header::before {
        content: "";
        position: absolute;
        left: 0; top: 15%;
        height: 70%; width: 5px;
        background: var(--vf-blue);
        border-radius: 10px;
    }

    .gray-info-block {
        background: var(--bg-light);
        border-radius: 24px;
        padding: 35px;
        border: 1px solid var(--border-color);
    }

    /* GRID TIỆN NGHI */
    .amenity-list {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
    }
    .amenity-box {
        display: flex;
        align-items: center;
        gap: 15px;
        font-size: 0.95rem;
        color: #475569;
    }
    .amenity-box i { font-size: 1.2rem; color: #94a3b8; }

    /* ĐIỀU KIỆN & THANH TOÁN */
    .white-sub-card {
        background: #ffffff;
        border-radius: 18px;
        padding: 25px;
        margin-bottom: 20px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.03);
    }
    .sub-card-label { font-weight: 800; font-size: 1rem; margin-bottom: 15px; display: block; }
    .bullet-list { list-style: none; padding: 0; margin: 0; }
    .bullet-list li {
        position: relative;
        padding-left: 22px;
        margin-bottom: 12px;
        color: #475569;
        font-size: 0.95rem;
    }
    .bullet-list li::before {
        content: "•";
        position: absolute;
        left: 0;
        color: #000;
        font-weight: 900;
    }

    .btn-rent-main {
        background: var(--text-dark);
        color: #fff;
        padding: 18px;
        border-radius: 18px;
        font-weight: 800;
        transition: 0.3s;
        border: none;
    }
    .btn-rent-main:hover { background: var(--vf-blue); color: #fff; transform: translateY(-3px); }
</style>

<div class="container mt-5 pt-3">
    <nav aria-label="breadcrumb" class="mb-5">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cars">Đội xe</a></li>
            <li class="breadcrumb-item active text-muted">${car.modelName}</li>
        </ol>
    </nav>

    <div class="row g-5">
        <div class="col-lg-7">
            <div class="detail-img-holder shadow-sm">
                <img src="${not empty car.imageUrl ? car.imageUrl : 'https://img.vanhai.vn/202304/xe-dien-vinfast-vf8.jpg'}"
                     class="main-car-img" alt="${car.modelName}">
            </div>
        </div>

        <div class="col-lg-5">
            <div class="ps-lg-2">
                <div class="d-flex align-items-center gap-3 mb-3">
                    <span class="badge bg-primary rounded-pill px-3 py-2">${car.categoryName}</span>
                    <span class="small fw-800 ${car.status == 'AVAILABLE' ? 'text-success' : 'text-danger'}">
                        <i class="bi bi-circle-fill me-1" style="font-size: 8px;"></i>
                        ${car.status == 'AVAILABLE' ? 'SẴN SÀNG' : 'HẾT XE'}
                    </span>
                </div>

                <h1 class="display-5 fw-800 mb-2">${car.modelName}</h1>
                <p class="text-muted mb-4"><i class="bi bi-geo-alt-fill text-danger"></i> ${car.locationName}</p>

                <div class="mb-5">
                    <span class="text-muted fw-bold small text-uppercase letter-spacing-1">Giá thuê / 24h</span>
                    <div class="price-large">
                        <fmt:formatNumber value="${car.pricePerDay}" pattern="#,###"/> <small class="fs-5 fw-bold">VNĐ</small>
                    </div>
                </div>

                <div class="row g-3 mb-5">
                    <div class="col-4">
                        <div class="spec-card">
                            <i class="bi bi-tag-fill"></i>
                            <span>Biển số</span>
                            <p>${car.licensePlate}</p>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="spec-card">
                            <i class="bi bi-lightning-fill"></i>
                            <span>Động cơ</span>
                            <p>Điện</p>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="spec-card">
                            <i class="bi bi-gear-fill"></i>
                            <span>Hộp số</span>
                            <p>Tự động</p>
                        </div>
                    </div>
                </div>

                <div class="d-grid gap-3">
                    <a href="${empty sessionScope.currUser ? pageContext.request.contextPath.concat('/login') : pageContext.request.contextPath.concat('/cart?action=add&carId=').concat(car.id)}"
                       class="btn btn-rent-main shadow">
                        ĐẶT THUÊ XE NGAY
                    </a>
                    <a href="${pageContext.request.contextPath}/cars" class="btn btn-outline-dark py-3 rounded-4 fw-bold">
                        Quay lại danh sách
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="row mt-5 pb-5">
        <div class="col-lg-8">
            <h2 class="section-header">Mô tả chi tiết</h2>
            <div class="gray-info-block mb-5">
                <div class="lh-lg text-secondary">
                    ${not empty car.description ? car.description : 'Trải nghiệm phong cách sống xanh cùng VinFast. Mẫu xe hội tụ công nghệ đỉnh cao, vận hành mạnh mẽ và an toàn tuyệt đối.'}
                </div>
            </div>

            <h2 class="section-header">Các tiện nghi khác</h2>
            <div class="gray-info-block">
                <div class="amenity-list">
                    <div class="amenity-box"><i class="bi bi-cpu-fill"></i><span>Trợ lý ảo VinFast AI</span></div>
                    <div class="amenity-box"><i class="bi bi-shield-check"></i><span>Hỗ trợ lái ADAS nâng cao</span></div>
                    <div class="amenity-box"><i class="bi bi-display"></i><span>HUD tích hợp kính lái</span></div>
                    <div class="amenity-box"><i class="bi bi-camera-video"></i><span>Hệ thống Camera 360 độ</span></div>
                    <div class="amenity-box"><i class="bi bi-tablet-landscape"></i><span>Màn hình giải trí 12,9 inch</span></div>
                    <div class="amenity-box"><i class="bi bi-gear-wide-connected"></i><span>La-zăng 19 inch đa chấu</span></div>
                </div>
            </div>

            <h2 class="section-header">Điều kiện thuê xe</h2>
            <div class="gray-info-block">
                <div class="white-sub-card">
                    <span class="sub-card-label">Thông tin cần có khi nhận xe</span>
                    <ul class="bullet-list">
                        <li>CCCD hoặc Hộ chiếu còn thời hạn</li>
                        <li>Bằng lái xe ô tô hợp lệ, còn thời hạn</li>
                    </ul>
                </div>

                <div class="white-sub-card">
                    <span class="sub-card-label">Hình thức thanh toán</span>
                    <ul class="bullet-list">
                        <li>Thanh toán trả trước 100% giá trị gói thuê</li>
                        <li>Đặt cọc giữ xe: 200.000 VNĐ (Hoàn trả khi kết thúc hợp đồng)</li>
                        <li>Ký hợp đồng trực tiếp tại showroom hoặc tận nơi nhận xe</li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="card border-0 rounded-5 bg-dark text-white p-5 mt-5 position-sticky" style="top: 100px;">
                <h3 class="fw-800 mb-3">Hỗ trợ 24/7</h3>
                <p class="small opacity-75 mb-4">Mọi thắc mắc về thủ tục thuê xe vui lòng liên hệ hotline.</p>
                <a href="tel:19001234" class="btn btn-primary rounded-pill py-3 fw-bold fs-5 shadow">
                    <i class="bi bi-telephone-outbound me-2"></i> 1900 1234
                </a>
            </div>
        </div>
    </div>
</div>