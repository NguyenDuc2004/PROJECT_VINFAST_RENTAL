<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>VinFast Rental | Trải nghiệm xe điện thông minh</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8f9fa;
        }

        /* Navbar Style */
        .navbar {
            backdrop-filter: blur(10px);
            background-color: rgba(0, 0, 0, 0.8) !important;
            padding: 1rem 0;
        }
        .navbar-brand {
            font-weight: 700;
            letter-spacing: 1px;
            color: #007bff !important;
        }

        /* Hero Banner */
        .hero-section {
            height: 80vh;
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)),
            url('https://acquychinhhang.vn/upload/news/xe-vinfast-5-3861.jpg');
            background-size: cover;
            background-position: center;
            display: flex;
            align-items: center;
            color: white;
            margin-bottom: 3rem;
        }
        .hero-title {
            font-size: 4rem;
            font-weight: 800;
            text-shadow: 2px 2px 10px rgba(0,0,0,0.5);
        }

        /* Car Card Style */
        .car-card {
            border: none;
            border-radius: 20px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            overflow: hidden;
            background: white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        .car-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }
        .car-img {
            height: 200px;
            object-fit: cover;
        }
        .price-tag {
            color: #007bff;
            font-weight: 700;
            font-size: 1.2rem;
        }

        .btn-rent {
            border-radius: 12px;
            padding: 10px 20px;
            font-weight: 600;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <i class="bi bi-lightning-charge-fill me-2"></i>VINFAST RENTAL
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link active" href="#">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Danh sách xe</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Về chúng tôi</a></li>
            </ul>

            <div class="d-flex align-items-center">
                <c:choose>
                    <c:when test="${empty sessionScope.currUser}">
                        <a href="login" class="btn btn-outline-light me-2 rounded-pill px-4">Đăng nhập</a>
                        <a href="#" class="btn btn-primary rounded-pill px-4">Đăng ký</a>
                    </c:when>
                    <c:otherwise>
                        <div class="dropdown">
                            <button class="btn btn-light dropdown-toggle rounded-pill px-3" type="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle me-2"></i>Chào, ${sessionScope.currUser.fullname}
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                                <c:if test="${sessionScope.currUser.admin}">
                                    <li><a class="dropdown-item text-danger fw-bold" href="dashboard">
                                        <i class="bi bi-speedometer2 me-2"></i>Quản trị hệ thống
                                    </a></li>
                                    <li><hr class="dropdown-divider"></li>
                                </c:if>
                                <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i>Cá nhân</a></li>
                                <li><a class="dropdown-item" href="#"><i class="bi bi-clock-history me-2"></i>Lịch sử thuê</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="login?action=logout"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                            </ul>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

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

<footer class="bg-dark text-white py-4 mt-5">
    <div class="container text-center">
        <p class="mb-0 opacity-50 small">&copy; 2026 VinFast Rental. Tinh thần Việt Nam - Công nghệ dẫn đầu.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>