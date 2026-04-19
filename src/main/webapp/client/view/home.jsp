<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- DỮ LIỆU DEMO --%>
<%
    java.util.List<java.util.Map<String, Object>> demoCars = new java.util.ArrayList<>();
    String[][] data = {
            {"VinFast VF 9", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-hbp1hPj9GGICjHoH9pPY2lV9WCT6Cv_s4A&s", "E-SUV", "6 chỗ"},
            {"VinFast VF 8", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRiMfo--fhJasCne0iD9KLg4p64Iq--Egnyg&s", "D-SUV", "5 chỗ"},
            {"VinFast VF 7", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1y65Gh4zUM0YLpJ0tK_TVhH8EobA7rB6q1g&s", "C-SUV", "5 chỗ"},
            {"VinFast VF 6", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRfB1W10AK9eyRc0u1aEy4kkzGr8sF9bqLHw&s", "B-SUV", "5 chỗ"}
    };

    for(String[] row : data) {
        java.util.Map<String, Object> car = new java.util.HashMap<>();
        car.put("name", row[0]); car.put("img", row[1]); car.put("segment", row[2]); car.put("seats", row[3]);
        demoCars.add(car);
    }
    request.setAttribute("demoCars", demoCars);
%>

<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

<style>
    :root { --vf-blue: #0062ff; --text-main: #0f172a; }
    html { scroll-behavior: smooth; }
    body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #ffffff; margin: 0; }

    /* 1. HERO BANNER */
    .hero-banner {
        height: 70vh;
        background: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.3)),
        url('https://vinfastotominhdao.vn/wp-content/uploads/Vinfast-line-up.jpg') no-repeat center center;
        background-size: cover;
        display: flex; flex-direction: column; align-items: center; justify-content: center;
        position: relative;
    }

    .btn-banner-scroll {
        background: #ffffff; color: #000; padding: 12px 35px; border-radius: 50px;
        font-weight: 800; font-size: 0.85rem; text-transform: uppercase; text-decoration: none;
        box-shadow: 0 10px 25px rgba(0,0,0,0.2); transition: 0.3s;
    }
    .btn-banner-scroll:hover { transform: translateY(-5px); background: var(--vf-blue); color: #fff; }

    /* 2. ADS SECTION (SIÊU PHẨM CÔNG NGHỆ) */
    .ads-section { padding: 100px 0 60px 0; background: #f8fafc; }

    .ads-card {
        background: #000000; border-radius: 40px; padding: 45px;
        color: #ffffff; text-decoration: none !important;
        display: flex; flex-direction: column; height: 550px; /* Thu gọn chiều cao vì không có nút */
        transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        border: 1px solid rgba(255,255,255,0.05);
    }

    .slick-center .ads-card { transform: scale(1.08); box-shadow: 0 40px 80px rgba(0, 0, 0, 0.4); }

    .badge-charge {
        background: rgba(34, 197, 94, 0.15); color: #4ade80;
        padding: 8px 16px; border-radius: 50px; font-size: 0.75rem; font-weight: 800;
        display: inline-flex; align-items: center; width: fit-content;
    }

    .car-name { font-size: 2.2rem; font-weight: 800; margin-top: 15px; }

    .car-display { flex-grow: 1; display: flex; align-items: center; justify-content: center; }
    .car-display img { width: 110%; object-fit: contain; }

    .specs-grid {
        display: grid; grid-template-columns: 1fr 1fr; gap: 15px;
        border-top: 1px solid rgba(255,255,255,0.1); padding-top: 25px;
    }
    .spec-item { display: flex; align-items: center; gap: 10px; color: #94a3b8; font-size: 0.85rem; }
    .spec-item i { color: #fff; font-size: 1.1rem; }

    /* 3. NÚT XEM CHI TIẾT NẰM NGOÀI BOX (DƯỚI SLIDER) */
    .view-more-container {
        text-align: center;
        background: #f8fafc; /* Phải cùng màu nền với ads-section */
        padding-bottom: 80px;
    }

    .btn-view-all {
        display: inline-block;
        padding: 14px 50px;
        border: 1.5px solid #000;
        border-radius: 50px;
        color: #000;
        text-decoration: none;
        font-weight: 700;
        text-transform: uppercase;
        font-size: 0.9rem;
        transition: 0.3s;
    }

    .btn-view-all:hover {
        background: #000;
        color: #fff;
        transform: scale(1.05);
    }

    .slider-item { outline: none; padding: 40px 15px; }
    .slick-prev:before, .slick-next:before { color: #000; font-size: 30px; }
</style>

<div class="hero-banner">
    <h1 class="display-3 fw-900 text-white mb-4">VINFAST RENTAL</h1>
    <a href="#sieu-pham-section" class="btn-banner-scroll">Thuê xe tự lái</a>
</div>

<div class="ads-section" id="sieu-pham-section">
    <div class="container">
        <div class="mb-5 text-center">
            <h2 class="fw-900 mb-2">SIÊU PHẨM CÔNG NGHỆ</h2>
            <div class="mx-auto" style="width: 50px; height: 4px; background: var(--vf-blue); border-radius: 10px;"></div>
        </div>

        <div class="view-more-container">
            <a href="${pageContext.request.contextPath}/cars" class="btn-view-all shadow-sm">
                Xem chi tiết
            </a>
        </div>

        <div class="car-center-slider">
            <c:forEach items="${demoCars}" var="car">
                <div class="slider-item">
                    <a href="${pageContext.request.contextPath}/cars" class="text-decoration-none">
                        <div class="ads-card">
                            <div>
                                <div class="badge-charge"><i class="bi bi-lightning-fill me-2"></i> MIỄN PHÍ SẠC</div>
                                <h2 class="car-name">${car.name}</h2>
                            </div>
                            <div class="car-display">
                                <img src="${car.img}" alt="${car.name}">
                            </div>
                            <div class="specs-grid">
                                <div class="spec-item"><i class="bi bi-layers"></i> <span class="text-white">${car.segment}</span></div>
                                <div class="spec-item"><i class="bi bi-people"></i> <span class="text-white">${car.seats}</span></div>
                                <div class="spec-item"><i class="bi bi-speedometer2"></i> <span class="text-white">~500km/sạc</span></div>
                                <div class="spec-item"><i class="bi bi-shield-check"></i> <span class="text-white">ADAS 2.0</span></div>
                            </div>
                        </div>
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</div>



<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<script>
    $(document).ready(function(){
        $('.car-center-slider').slick({
            centerMode: true,
            centerPadding: '0px',
            slidesToShow: 3,
            infinite: true,
            autoplay: true,
            autoplaySpeed: 4000,
            arrows: true,
            responsive: [
                {
                    breakpoint: 1100,
                    settings: { slidesToShow: 1, centerPadding: '50px', arrows: false }
                }
            ]
        });
    });
</script>