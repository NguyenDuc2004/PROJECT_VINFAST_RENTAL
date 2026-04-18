<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container mt-5 pt-5">
    <div class="row mb-5 text-center">
        <div class="col-12">
            <h1 class="fw-bold display-5">Danh sách xe điện VinFast</h1>
            <p class="text-muted">Khám phá các mẫu xe điện thông minh, hiện đại nhất Việt Nam</p>
            <div class="mx-auto" style="width: 80px; height: 4px; background-color: #007bff;"></div>
        </div>
    </div>

    <%-- Phần lọc xe (Để sau này xử lý logic lọc) --%>
    <div class="row mb-4">
        <div class="col-md-12 d-flex justify-content-center">
            <div class="btn-group shadow-sm">
                <a href="${pageContext.request.contextPath}/cars" class="btn btn-primary px-4">Tất cả</a>
                <c:forEach items="${listCategories}" var="cat">
                    <a href="${pageContext.request.contextPath}/cars?categoryId=${cat.id}"
                       class="btn btn-outline-primary px-4">${cat.name}</a>
                </c:forEach>
            </div>
        </div>
    </div>

    <div class="row g-4 mb-5">
        <c:choose>
            <c:when test="${not empty listCars}">
                <c:forEach items="${listCars}" var="car">
                    <div class="col-lg-4 col-md-6">
                        <div class="card car-card">
                                <%-- Hiển thị ảnh từ URL trong DB, nếu trống dùng ảnh mặc định --%>
                            <img src="${not empty car.imageUrl ? car.imageUrl : 'https://via.placeholder.com/300x200?text=VinFast'}"
                                 class="card-img-top car-img" alt="${car.modelName}">

                            <div class="card-body p-4">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span class="badge bg-primary-subtle text-primary px-3">
                                        ${car.categoryName} <%-- Cần Join bảng hoặc thêm thuộc tính này vào Modal --%>
                                    </span>
                                    <span class="price-tag">
                                        <fmt:formatNumber value="${car.pricePerDay}" type="number"/>đ
                                        <small class="text-muted">/ngày</small>
                                    </span>
                                </div>

                                <h5 class="card-title fw-bold">${car.modelName}</h5>

<%--                                <div class="d-flex gap-2 mb-3 text-muted small">--%>
<%--&lt;%&ndash;                                    <span><i class="bi bi-geo-alt me-1"></i> ${car.locationName}</span>&ndash;%&gt;--%>
<%--                                    <span><i class="bi bi-tag me-1"></i> ${car.licensePlate}</span>--%>
<%--                                </div>--%>

                                <hr>

                                <div class="d-grid gap-2 d-md-flex">
                                    <a href="${pageContext.request.contextPath}/cars?action=detail&id=${car.id}"
                                       class="btn btn-outline-secondary flex-grow-1">Chi tiết</a>

                                        <%-- Nút Thuê ngay: Kiểm tra đăng nhập như bạn yêu cầu --%>
                                    <a href="${empty sessionScope.currUser ? pageContext.request.contextPath.concat('/login') : pageContext.request.contextPath.concat('/cart?action=add&carId=').concat(car.id)}"
                                       class="btn btn-primary flex-grow-1">
                                        Thuê ngay
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="col-12 text-center py-5">
                    <i class="bi bi-search fs-1 text-muted"></i>
                    <p class="mt-3 text-muted">Hiện tại không có xe nào sẵn sàng để thuê.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>