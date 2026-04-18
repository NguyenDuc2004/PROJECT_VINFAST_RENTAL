<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container mt-5 pt-5">
    <div class="row mb-5 text-center">
        <div class="col-12">
            <h1 class="fw-bold display-5">Danh sách xe điện VinFast</h1>
            <p class="text-muted">Khám phá các mẫu xe điện thông minh, hiện đại nhất Việt Nam</p>
            <div class="mx-auto" style="width: 80px; height: 4px; background-color: #007bff;"></div>
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-md-12 d-flex justify-content-center">
            <div class="btn-group shadow-sm">
                <button class="btn btn-primary px-4">Tất cả</button>
                <button class="btn btn-outline-primary px-4">SUV</button>
                <button class="btn btn-outline-primary px-4">Sedan</button>
                <button class="btn btn-outline-primary px-4">Hatchback</button>
            </div>
        </div>
    </div>

    <div class="row g-4 mb-5">
        <c:forEach var="i" begin="1" end="6"> <%-- Sau này sẽ dùng dữ liệu thật từ DB --%>
            <div class="col-lg-4 col-md-6">
                <div class="card car-card">
                    <img src="https://shop.vinfastauto.com/on/demandware.static/-/Sites-app_vinfast_vn-Library/default/dw10d292bd/res/images/vfast/at-home/vf9/VF9_home.png"
                         class="card-img-top car-img" alt="VinFast">
                    <div class="card-body p-4">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="badge bg-primary-subtle text-primary px-3">Xe điện</span>
                            <span class="price-tag">1.000.000đ<small class="text-muted">/ngày</small></span>
                        </div>
                        <h5 class="card-title fw-bold">VinFast VF Model ${i}</h5>
                        <div class="d-flex gap-2 mb-3 text-muted small">
                            <span><i class="bi bi-people me-1"></i> 5 chỗ</span>
                            <span><i class="bi bi-fuel-pump-diesel me-1"></i> Điện</span>
                            <span><i class="bi bi-gear me-1"></i> Tự động</span>
                        </div>
                        <hr>
                        <div class="d-grid">
                            <a href="#" class="btn btn-outline-primary btn-rent">Thuê ngay</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>