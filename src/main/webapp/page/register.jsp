<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản - VinFast Rental</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        :root {
            --vin-blue: #063197;
            --vin-red: #da291c;
        }

        /* Chỉnh background bao phủ toàn trình duyệt */
        body {
            /* ANH THAY ĐƯỜNG DẪN ẢNH XE CỦA ANH VÀO ĐÂY */
            background-image: url('https://vinfastotominhdao.vn/wp-content/uploads/VF-Wild-2.jpg');

            background-size: cover; /* Phủ kín màn hình */
            background-position: center; /* Căn giữa ảnh */
            background-repeat: no-repeat; /* Không lặp lại */
            background-attachment: fixed; /* Cố định ảnh khi scroll */

            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            display: flex;
            align-items: center;
            position: relative; /* Để làm lớp phủ */
            margin: 0;
        }

        /* Lớp phủ màu đen mờ trên ảnh nền */
        body::before {
            content: "";
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.55); /* Độ mờ 55% */
            z-index: 1; /* Nằm dưới nội dung nhưng trên ảnh */
        }

        /* Đảm bảo nội dung nằm trên lớp phủ */
        .container {
            position: relative;
            z-index: 2;
        }

        /* Card đăng ký trong suốt nhẹ */
        .register-card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            overflow: hidden;
            /* Làm card trong suốt 95% để lộ nền */
            background-color: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(5px); /* Hiệu ứng mờ kính (Glassmorphism) */
        }

        .register-header {
            background: var(--vin-blue);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .btn-vin {
            background: var(--vin-blue);
            color: white;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            transition: all 0.3s;
            border: none;
        }
        .btn-vin:hover {
            background: #04246e;
            color: white;
            transform: translateY(-2px);
        }
        .form-control {
            border-radius: 10px;
            padding: 12px 15px;
            border: 1px solid #dee2e6;
            background-color: rgba(255, 255, 255, 0.8); /* Input cũng hơi trong suốt */
        }
        .form-control:focus {
            border-color: var(--vin-blue);
            box-shadow: 0 0 0 0.25rem rgba(6, 49, 151, 0.1);
            background-color: #fff;
        }

        /* Màu chữ trắng cho phần text bên ngoài card */
        .text-white-target {
            color: white !important;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.5); /* Thêm bóng cho dễ đọc */
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-12 col-md-8 col-lg-5">

            <div class="text-center mb-4">
                <h2 class="fw-bold text-white-target">
                    VINFAST <span style="color: var(--vin-red)">RENTAL</span>
                </h2>
            </div>

            <div class="card register-card">
                <div class="register-header">
                    <h4 class="mb-1 fw-bold">Tạo tài khoản mới</h4>
                    <p class="mb-0 opacity-75 small">Tham gia cùng cộng đồng thuê xe VinFast ngay hôm nay</p>
                </div>

                <div class="card-body p-4 p-md-5">

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger d-flex align-items-center mb-4 p-2 small" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            <div>${error}</div>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register" method="post">
                        <div class="mb-3">
                            <label class="form-label small fw-bold">Họ và tên <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-person"></i></span>
                                <input type="text" name="fullname" class="form-control border-start-0"
                                       placeholder="Nguyễn Văn A" value="${oldFullname}" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label small fw-bold">Email <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-envelope"></i></span>
                                <input type="email" name="email" class="form-control border-start-0"
                                       placeholder="name@gmail.com" value="${oldEmail}" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label small fw-bold">Số điện thoại</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-phone"></i></span>
                                <input type="text" name="phone" class="form-control border-start-0"
                                       placeholder="09xx xxx xxx" value="${oldPhone}">
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label small fw-bold">Mật khẩu <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-lock"></i></span>
                                <input type="password" name="password" class="form-control border-start-0"
                                       placeholder="Ít nhất 6 ký tự" required>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-vin w-100 shadow-sm mb-3">
                            ĐĂNG KÝ NGAY
                        </button>
                    </form>

                    <div class="text-center mt-3">
                        <p class="small text-muted mb-0">
                            Đã có tài khoản?
                            <a href="${pageContext.request.contextPath}/login" class="fw-bold text-decoration-none" style="color: var(--vin-blue)">Đăng nhập</a>
                        </p>
                    </div>
                </div>
            </div>

            <p class="text-center mt-4 small text-white-target opacity-75">
                &copy; 2026 VinFast Rental Project - Made by Team Đức
            </p>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bundle.min.js"></script>
</body>
</html>