<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    :root {
        --vf-blue: #0062ff;
        --bg-soft: #f8fafc;
        --text-dark: #0f172a;
        --text-muted: #94a3b8;
    }

    .list-section { background-color: var(--bg-soft); min-height: 100vh; padding-bottom: 80px; }

    /* 1. TIÊU ĐỀ TRANG */
    .page-header {
        padding: 60px 0 60px;
        background: #ffffff;
        border-bottom: 1px solid #e2e8f0;
    }

    /* 2. THANH TÌM KIẾM PHONG CÁCH FLOATING CARD */
    .search-floating-container {
        max-width: 1100px;
        margin: -45px auto 40px;
        position: relative;
        z-index: 100;
        padding: 0 15px;
    }

    .search-card-wrapper {
        background: #ffffff;
        border-radius: 24px;
        padding: 12px 20px;
        box-shadow: 0 20px 50px rgba(0, 0, 0, 0.08);
        display: flex;
        align-items: center;
        border: 1px solid rgba(0,0,0,0.05);
    }

    .search-column {
        flex: 1;
        padding: 0 20px;
        display: flex;
        flex-direction: column;
    }

    .search-column:not(:last-child) {
        border-right: 1px solid #edf2f7;
    }

    .search-column label {
        font-size: 0.65rem;
        font-weight: 800;
        color: var(--text-muted);
        text-transform: uppercase;
        margin-bottom: 4px;
        letter-spacing: 0.8px;
    }

    .search-column input,
    .search-column select {
        border: none;
        outline: none;
        font-weight: 700;
        color: var(--text-dark);
        font-size: 0.9rem;
        width: 100%;
        background: transparent;
        padding: 0;
    }

    .btn-main-search {
        background: var(--text-dark);
        color: white;
        border: none;
        width: 55px;
        height: 55px;
        border-radius: 18px;
        display: flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s;
        margin-left: 10px;
    }

    .btn-main-search:hover { background: #000; transform: scale(1.05); }

    /* 3. BỘ LỌC CATEGORY (PILLS) */
    .filter-pills { display: flex; gap: 10px; justify-content: center; flex-wrap: wrap; margin-bottom: 40px; }
    .filter-btn {
        padding: 10px 22px; border-radius: 50px; font-weight: 700; font-size: 0.85rem;
        transition: 0.3s; border: 1px solid #e2e8f0; background: white; color: var(--text-dark); text-decoration: none;
    }
    .filter-btn.active, .filter-btn:hover { background: var(--text-dark); color: white; border-color: var(--text-dark); }

    /* 4. CARD XE */
    .car-card-link { text-decoration: none !important; display: block; color: inherit; height: 100%; }
    .car-card-premium {
        border: none; border-radius: 30px; background: white;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        overflow: hidden; height: 100%; border: 1px solid rgba(0,0,0,0.04);
    }
    .car-card-link:hover .car-card-premium {
        transform: translateY(-12px);
        box-shadow: 0 30px 60px rgba(0, 0, 0, 0.1);
    }
    .car-img-box { width: 100%; height: 260px; background: #f8fafc; overflow: hidden; position: relative; }
    .car-img-premium { width: 100%; height: 100%; object-fit: cover; transition: 0.6s; }
    .car-card-link:hover .car-img-premium { transform: scale(1.1); }

    .price-row {
        margin-top: 15px; padding-top: 15px;
        border-top: 1px solid #f1f5f9;
        display: flex; justify-content: space-between; align-items: center;
    }
    .price-val { font-size: 1.3rem; font-weight: 800; color: var(--text-dark); }
    .price-sub { font-size: 0.7rem; font-weight: 700; color: var(--text-muted); text-transform: uppercase; }
    .spec-tag { font-size: 0.75rem; font-weight: 600; color: var(--text-muted); background: #f1f5f9; padding: 4px 12px; border-radius: 6px; }

    /* 5. PHÂN TRANG CUSTOM */
    .pagination-wrapper { margin-top: 60px; display: flex; flex-direction: column; align-items: center; gap: 15px; }
    .custom-pagination { display: flex; gap: 8px; list-style: none; padding: 0; }
    .page-item-link {
        width: 45px; height: 45px; display: flex; align-items: center; justify-content: center;
        border-radius: 14px; background: white; color: var(--text-dark);
        font-weight: 700; text-decoration: none; border: 1px solid #e2e8f0; transition: all 0.3s;
    }
    .page-item-link:hover { border-color: var(--text-dark); transform: translateY(-2px); }
    .page-item-link.active { background: var(--text-dark); color: white; border-color: var(--text-dark); box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
    .page-item-link.disabled { opacity: 0.4; cursor: not-allowed; pointer-events: none; }
</style>

<div class="list-section">
    <div class="page-header text-center">
        <div class="container">
            <h1 class="fw-800 display-5 mb-2" style="font-weight: 800;">ĐỘI XE VINFAST</h1>
            <p class="text-muted fw-500 small">Trải nghiệm di chuyển xanh cùng công nghệ hàng đầu Việt Nam</p>
        </div>
    </div>

    <div class="search-floating-container">
        <form action="${pageContext.request.contextPath}/cars" method="GET">
            <div class="search-card-wrapper">
                <div class="search-column">
                    <label>Bạn muốn thuê xe gì?</label>
                    <input type="text" name="keyword" placeholder="Nhập tên xe..." value="${keyword}">
                </div>

                <div class="search-column">
                    <label>Loại xe</label>
                    <select name="category">
                        <option value="">-- Tất cả --</option>
                        <option value="1" ${category == '1' ? 'selected' : ''}>SUV</option>
                        <option value="2" ${category == '2' ? 'selected' : ''}>SEDAN</option>
                        <option value="3" ${category == '3' ? 'selected' : ''}>HATCHBACK</option>
                    </select>
                </div>

                <div class="search-column">
                    <label>Khu vực</label>
                    <select name="locationId">
                        <option value="">-- Tất cả --</option>
                        <c:forEach items="${listLocations}" var="loc">
                            <option value="${loc.id}" ${locationId == loc.id ? 'selected' : ''}>${loc.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <button type="submit" class="btn-main-search shadow-sm">
                    <i class="bi bi-search fs-4 text-white"></i>
                </button>
            </div>
        </form>
    </div>

    <div class="container">
        <div class="filter-pills">
            <a href="${pageContext.request.contextPath}/cars"
               class="filter-btn ${empty category ? 'active' : ''}">TẤT CẢ XE</a>
            <option value="1" style="display:none"></option>
            <a href="${pageContext.request.contextPath}/cars?category=1" class="filter-btn ${category == '1' ? 'active' : ''}">SUV</a>
            <a href="${pageContext.request.contextPath}/cars?category=2" class="filter-btn ${category == '2' ? 'active' : ''}">SEDAN</a>
            <a href="${pageContext.request.contextPath}/cars?category=3" class="filter-btn ${category == '3' ? 'active' : ''}">HATCHBACK</a>
        </div>

        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty listCars}">
                    <c:forEach items="${listCars}" var="car">
                        <div class="col-lg-4 col-md-6">
                            <a href="${pageContext.request.contextPath}/cars?action=detail&id=${car.id}" class="car-card-link">
                                <div class="card car-card-premium shadow-sm">
                                    <div class="car-img-box">
                                        <div class="position-absolute top-0 start-0 p-3" style="z-index: 2;">
                                            <span class="badge bg-white text-dark shadow-sm rounded-pill fw-800 py-2 px-3" style="font-size: 0.65rem; font-weight: 800;">
                                                <i class="bi ${car.status == 'AVAILABLE' ? 'bi-check-circle-fill text-success' : 'bi-x-circle-fill text-danger'} me-1"></i>
                                                <span class="${car.status == 'AVAILABLE' ? 'text-success' : 'text-secondary'}">
                                                        ${car.status == "AVAILABLE" ? "SẴN SÀNG" : "HẾT XE"}
                                                </span>
                                            </span>
                                        </div>
                                        <img src="${not empty car.imageUrl ? car.imageUrl : 'https://via.placeholder.com/400x300?text=VinFast'}"
                                             class="car-img-premium" alt="${car.modelName}">
                                    </div>

                                    <div class="card-body p-4">
                                        <h3 class="fw-800 text-dark mb-1 h4" style="font-weight: 800;">${car.modelName}</h3>
                                        <div class="d-flex align-items-center gap-2 mb-3 text-muted" style="font-size: 0.8rem;">
                                            <i class="bi bi-geo-alt-fill text-danger"></i> ${car.locationName}
                                        </div>

                                        <div class="d-flex gap-2 mb-2">
                                            <span class="spec-tag">Xe Điện</span>
                                            <span class="spec-tag">Số tự động</span>
                                        </div>

                                        <div class="price-row">
                                            <span class="price-sub">Giá thuê ngày</span>
                                            <div class="price-val">
                                                <fmt:formatNumber value="${car.pricePerDay}" pattern="#,###"/>
                                                <span style="font-size: 0.75rem; font-weight: 700;">VNĐ</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center py-5">
                        <div class="bg-white p-5 rounded-5 shadow-sm d-inline-block">
                            <i class="bi bi-search fs-1 text-muted opacity-25"></i>
                            <h4 class="mt-4 fw-bold">Không tìm thấy xe phù hợp</h4>
                            <a href="${pageContext.request.contextPath}/cars" class="btn btn-dark rounded-pill px-4 mt-3">Quay lại danh sách</a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <c:if test="${totalPages >= 1}">
            <div class="pagination-wrapper">
                <div class="small text-muted fw-600">
                    Trang <strong>${currentPage}</strong> trên <strong>${totalPages}</strong>
                </div>
                <ul class="custom-pagination">
                    <li>
                        <a href="?page=${currentPage - 1}&keyword=${keyword}&category=${category}&locationId=${locationId}"
                           class="page-item-link ${currentPage == 1 ? 'disabled' : ''}">
                            <i class="bi bi-chevron-left"></i>
                        </a>
                    </li>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li>
                            <a href="?page=${i}&keyword=${keyword}&category=${category}&locationId=${locationId}"
                               class="page-item-link ${currentPage == i ? 'active' : ''}">
                                    ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <li>
                        <a href="?page=${currentPage + 1}&keyword=${keyword}&category=${category}&locationId=${locationId}"
                           class="page-item-link ${currentPage == totalPages ? 'disabled' : ''}">
                            <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </div>
        </c:if>
    </div>
</div>