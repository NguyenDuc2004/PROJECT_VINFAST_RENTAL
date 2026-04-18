<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container mt-5 pt-5 mb-5">
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/cars">Danh sách xe</a></li>
            <li class="breadcrumb-item active" aria-current="page">${car.modelName}</li>
        </ol>
    </nav>

    <div class="row g-5">
        <div class="col-lg-7">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
                <img src="${not empty car.imageUrl ? car.imageUrl : 'https://via.placeholder.com/800x500'}"
                     class="img-fluid" alt="${car.modelName}" style="width: 100%; height: 450px; object-fit: cover;">
            </div>
        </div>

        <div class="col-lg-5">
            <div class="ps-lg-4">
                <span class="badge bg-primary px-3 mb-2">${car.categoryName}</span>
                <h1 class="fw-bold mb-3">${car.modelName}</h1>

                <div class="d-flex align-items-center mb-4">
                    <h2 class="text-primary fw-bold mb-0">
                        <fmt:formatNumber value="${car.pricePerDay}" type="number"/>đ
                    </h2>
                    <span class="text-muted ms-2">/ ngày</span>
                </div>

                <div class="card border-0 bg-light rounded-4 p-4 mb-4">
                    <h5 class="fw-bold mb-3">Thông số cơ bản</h5>
                    <div class="row g-3">
<%--                        <div class="col-6">--%>
<%--                            <small class="text-muted d-block">Biển số</small>--%>
<%--                            <span class="fw-semibold">${car.licensePlate}</span>--%>
<%--                        </div>--%>
<%--                        <div class="col-6">--%>
<%--                            <small class="text-muted d-block">Địa điểm</small>--%>
<%--                            <span class="fw-semibold">${car.locationName}</span>--%>
<%--                        </div>--%>
                        <div class="col-12">
                            <small class="text-muted d-block">Trạng thái</small>
                            <span class="badge ${car.status == 'AVAILABLE' ? 'bg-success' : 'bg-warning'}">
                                ${car.status == 'AVAILABLE' ? 'Sẵn sàng' : 'Đã được đặt'}
                            </span>
                        </div>
                    </div>
                </div>

                <div class="mb-4">
                    <h5 class="fw-bold">Mô tả</h5>
                    <p class="text-muted">${not empty car.description ? car.description : 'Đang cập nhật nội dung...'}</p>
                </div>

                <div class="d-grid gap-3">
                    <a href="${empty sessionScope.currUser ? pageContext.request.contextPath.concat('/login') : pageContext.request.contextPath.concat('/cart?action=add&carId=').concat(car.id)}"
                       class="btn btn-primary btn-lg py-3 rounded-pill fw-bold">
                        THUÊ NGAY
                    </a>
                    <a href="${pageContext.request.contextPath}/cars" class="btn btn-outline-secondary btn-lg py-3 rounded-pill">
                        Quay lại danh sách
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>