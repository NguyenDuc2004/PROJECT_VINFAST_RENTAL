<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>VinFast Rental | Đăng nhập hệ thống</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

  <style>
    :root {
      --primary-color: #007bff;
      --primary-hover: #0056b3;
      --bg-gradient: linear-gradient(135deg, #e0eafc 0%, #cfdef3 100%);
    }

    body, html {
      height: 100%;
      margin: 0;
      font-family: 'Plus Jakarta Sans', sans-serif;
      background: var(--bg-gradient);
      overflow: hidden;
    }

    .login-container {
      display: flex;
      height: 100vh;
      width: 100vw;
    }

    /* PHẦN BÊN TRÁI: GIỮ NGUYÊN FORM */
    .login-side {
      flex: 0 0 500px;
      background: rgba(255, 255, 255, 0.6);
      backdrop-filter: blur(20px);
      -webkit-backdrop-filter: blur(20px);
      display: flex;
      align-items: center;
      padding: 0 4rem;
      border-right: 1px solid rgba(255, 255, 255, 0.3);
      z-index: 10;
    }

    /* PHẦN BÊN PHẢI: ẢNH XE CHÌM MỜ ẢO */
    .banner-side {
      flex: 1;
      position: relative;
      /* Lớp nền kết hợp giữa màu xanh VinFast và ảnh xe mờ */
      background:
              linear-gradient(135deg, rgba(0, 48, 135, 0.85) 0%, rgba(0, 20, 60, 0.9) 100%),
              url('https://vinfasthadong.com.vn/wp-content/uploads/2023/10/VinFast-VF8-1.jpg');
      background-size: cover;
      background-position: center;
      background-blend-mode: overlay; /* Kỹ thuật làm ảnh chìm xuống mờ mờ */
      display: flex;
      align-items: center;
      justify-content: center;
      overflow: hidden;
    }

    /* Thêm một hiệu ứng sáng nhẹ để chiếc xe trông ảo diệu hơn */
    .banner-side::after {
      content: '';
      position: absolute;
      top: 0; left: 0; right: 0; bottom: 0;
      background: radial-gradient(circle at center, rgba(0, 123, 255, 0.2) 0%, transparent 70%);
      pointer-events: none;
    }

    .login-form-wrapper {
      width: 100%;
      position: relative;
      z-index: 2;
    }

    .form-control {
      border-radius: 12px;
      padding: 0.8rem 1rem;
      border: 1px solid rgba(0, 0, 0, 0.08);
      background: rgba(255, 255, 255, 0.5);
      transition: all 0.3s ease;
    }

    .form-control:focus {
      background: #fff;
      box-shadow: 0 0 0 4px rgba(0, 123, 255, 0.1);
      border-color: var(--primary-color);
    }

    .btn-primary {
      background: var(--primary-color);
      border: none;
      border-radius: 12px;
      padding: 14px;
      font-weight: 700;
      box-shadow: 0 8px 20px rgba(0, 123, 255, 0.3);
      transition: all 0.3s ease;
    }

    /* Hiệu ứng chữ Banner chìm nổi */
    .banner-content {
      color: white;
      text-align: center;
      z-index: 2;
      /* Làm nội dung banner trông mượt và nhẹ nhàng hơn */
      text-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
    }

    .banner-content h1 {
      font-size: 4.5rem;
      letter-spacing: 2px;
      margin-bottom: 1rem;
      opacity: 0.9;
    }

    .banner-content p {
      font-size: 1.5rem;
      font-weight: 300;
      opacity: 0.7;
    }

    @media (max-width: 850px) {
      .banner-side { display: none; }
      .login-side { flex: 1; padding: 0 2rem; }
    }
  </style>
</head>
<body>

<div class="login-container">
  <div class="login-side">
    <div class="login-form-wrapper">
      <div class="mb-5">
        <h2 class="fw-bold text-dark display-6 mb-2">Đăng nhập</h2>
        <p class="text-secondary">VinFast Rental - Nơi mang lại sự thăng hoa</p>
      </div>

      <c:if test="${not empty toastMsg}">
        <div class="alert alert-${toastType == 'success' ? 'success' : 'danger'} d-flex align-items-center mb-4"
             style="border-radius: 12px; background: rgba(255,255,255,0.2); backdrop-filter: blur(5px); border: none;" role="alert">
          <i class="bi ${toastType == 'success' ? 'bi-check-circle' : 'bi-exclamation-circle'} me-2"></i>
          <div class="small">${toastMsg}</div>
        </div>
        <c:remove var="toastMsg" scope="session"/>
      </c:if>

      <form action="login" method="post" class="needs-validation" >
        <div class="mb-4">
          <label class="form-label fw-bold small text-muted">EMAIL</label>
          <div class="input-group">
            <span class="input-group-text border-end-0"><i class="bi bi-person-circle"></i></span>
            <input type="email" name="email" class="form-control border-start-0" placeholder="admin@vinfast.vn" required>
          </div>
        </div>

        <div class="mb-4">
          <label class="form-label fw-bold small text-muted">MẬT KHẨU</label>
          <div class="input-group">
            <span class="input-group-text border-end-0"><i class="bi bi-shield-lock"></i></span>
            <input type="password" name="password" id="password" class="form-control border-start-0 border-end-0" placeholder="••••••••" required>
            <span class="input-group-text border-start-0" id="togglePassword" style="cursor: pointer;">
              <i class="bi bi-eye-slash" id="eyeIcon"></i>
            </span>
          </div>
        </div>

        <button type="submit" class="btn btn-primary w-100 shadow mb-4">
          Đăng nhập<i class="bi bi-arrow-right-short ms-1"></i>
        </button>
      </form>

      <div class="mt-5 text-center">
        <p class="text-muted small">&copy; 2026 VinFast Rental Project</p>
      </div>
    </div>
  </div>

  <div class="banner-side">
    <div class="banner-content">
      <h1 class="fw-bold">VINFAST-RENTAL</h1>
      <p>Mãnh liệt tinh thần Việt Nam</p>
    </div>
  </div>
</div>

<script>
  // JS giữ nguyên để toggle mật khẩu
  const togglePassword = document.querySelector('#togglePassword');
  const passwordInput = document.querySelector('#password');
  const eyeIcon = document.querySelector('#eyeIcon');

  togglePassword.addEventListener('click', function () {
    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
    passwordInput.setAttribute('type', type);
    eyeIcon.classList.toggle('bi-eye');
    eyeIcon.classList.toggle('bi-eye-slash');
  });
</script>

</body>
</html>