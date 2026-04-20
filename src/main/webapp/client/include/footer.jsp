<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<style>
    /* Đảm bảo khung bao ngoài luôn bao phủ toàn bộ màn hình */
    html, body {
        height: 100%;
        margin: 0;
    }

    /* Thiết lập body theo dạng Flexbox dọc */
    body {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    /* Quan trọng: Phần nội dung chính phải tự động "nở" ra để chiếm hết chỗ trống */
    /* Anh hãy đảm bảo các file list.jsp, detail.jsp... được bao bởi một thẻ có class là .main-content ở layout.jsp */
    .main-content {
        flex: 1 0 auto;
    }

    footer {
        flex-shrink: 0; /* Không cho phép footer bị co lại */
        background-color: #0f172a !important; /* Màu xanh đen sang trọng */
        border-top: 1px solid rgba(255,255,255,0.1);
    }

    .footer-text {
        letter-spacing: 1px;
        font-weight: 500;
    }
</style>

<footer class="text-white py-5">
    <div class="container text-center">
        <div class="mb-3">
            <img src="https://vinfastauto.com/themes/custom/vinfast_theme/logo.svg" alt="VinFast" style="height: 30px; filter: brightness(0) invert(1);">
        </div>
        <p class="mb-2 footer-text">VINFAST RENTAL - DỊCH VỤ THUÊ XE ĐIỆN THÔNG MINH</p>
        <div class="d-flex justify-content-center gap-3 mb-3">
            <a href="#" class="text-white opacity-75"><i class="bi bi-facebook"></i></a>
            <a href="#" class="text-white opacity-75"><i class="bi bi-youtube"></i></a>
            <a href="#" class="text-white opacity-75"><i class="bi bi-tiktok"></i></a>
        </div>
        <p class="mb-0 opacity-50 small" style="font-size: 0.75rem;">
            &copy; 2026 VinFast Rental. Tinh thần Việt Nam - Công nghệ dẫn đầu.
        </p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Tìm thẻ chứa nội dung chính (thường nằm sau Navbar và trước Footer)
        // Nếu anh chưa đặt class .main-content, script này sẽ cố gắng tìm div chính để ép nó giãn ra
        const content = document.querySelector('.main-content');
        if (!content) {
            console.warn("Lưu ý: Anh nên bọc nội dung trang trong <div class='main-content'> để Footer hoạt động chuẩn nhất.");
        }
    });
</script>