<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="footer mt-auto py-3 bg-white border-top">
  <div class="container-fluid px-4">
    <div class="d-flex align-items-center justify-content-between small">
      <div class="text-muted">Bản quyền &copy; Vinfast Rental</div>
      <div>
        <a href="#" class="text-decoration-none text-muted me-3">Chính sách bảo mật</a>
        <a href="#" class="text-decoration-none text-muted">Điều khoản sử dụng</a>
      </div>
    </div>
  </div>
</footer>

<style>
  /* Đảm bảo footer luôn nằm dưới cùng nếu nội dung ít */
  .main-wrapper {
    display: flex;
    flex-direction: column;
  }
  .content-body {
    flex: 1 0 auto;
  }
  .footer {
    flex-shrink: 0;
  }
</style>