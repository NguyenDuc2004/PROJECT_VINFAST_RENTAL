<%@ page contentType="text/html; charset=UTF-8" language="java" %>
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