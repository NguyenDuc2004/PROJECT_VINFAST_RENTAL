<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="hero-section">
    <div class="container text-center">
        <h1 class="hero-title mb-3">VINFAST RENTAL</h1>
        <p class="fs-4 mb-4 opacity-75">Trải nghiệm đẳng cấp xe điện dẫn đầu công nghệ Việt Nam</p>
        <a href="#booking" class="btn btn-primary btn-lg px-5 py-3 rounded-pill fw-bold shadow">THUÊ XE NGAY</a>
    </div>
</header>

<div class="container mb-5" id="booking">
    <div class="row mb-4">
        <div class="col-md-8">
            <h2 class="fw-bold">Mẫu xe sẵn có</h2>
            <p class="text-muted">Lựa chọn mẫu xe ưng ý để bắt đầu chuyến hành trình của bạn.</p>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-md-4">
            <div class="card car-card">
                <img src="https://shop.vinfastauto.com/on/demandware.static/-/Sites-app_vinfast_vn-Library/default/dw10d292bd/res/images/vfast/at-home/vf9/VF9_home.png" class="card-img-top car-img" alt="VF9">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="badge bg-primary-subtle text-primary px-3">SUV 7 Chỗ</span>
                        <span class="price-tag">1.500.000đ<small class="text-muted">/ngày</small></span>
                    </div>
                    <h5 class="card-title fw-bold">VinFast VF 9 - 2024</h5>
                    <p class="text-muted small"><i class="bi bi-geo-alt me-1"></i> VinFast Chùa Láng, Đống Đa</p>
                    <hr>
                    <div class="d-grid">
                        <button class="btn btn-outline-primary btn-rent">Xem chi tiết</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card car-card">
                <img src="https://static-images.vnncdn.net/files/publish/2022/11/17/vinfast-vf-8-1250.jpg" class="card-img-top car-img" alt="VF8">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="badge bg-primary-subtle text-primary px-3">SUV 5 Chỗ</span>
                        <span class="price-tag">1.200.000đ<small class="text-muted">/ngày</small></span>
                    </div>
                    <h5 class="card-title fw-bold">VinFast VF 8 - Plus</h5>
                    <p class="text-muted small"><i class="bi bi-geo-alt me-1"></i> VinFast Royal City</p>
                    <hr>
                    <div class="d-grid">
                        <button class="btn btn-outline-primary btn-rent">Xem chi tiết</button>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>