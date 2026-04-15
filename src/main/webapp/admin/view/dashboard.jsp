<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="dashboard-wrapper">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="fw-bold text-dark mb-0">Thống kê hệ thống</h4>
    <div class="text-muted small">Cập nhật lần cuối: <span id="current-time"></span></div>
  </div>

  <div class="row g-4 mb-5">
    <div class="col-md-4">
      <div class="card card-stat p-4 bg-white border-0 shadow-sm Ripple-effect"
           onclick="location.href='${pageContext.request.contextPath}/user'">
        <div class="d-flex align-items-center">
          <div class="icon-box bg-primary-subtle text-primary me-3">
            <i class="bi bi-people-fill"></i>
          </div>
          <div>
            <p class="text-muted mb-0 small fw-bold text-uppercase">Người dùng</p>
            <h3 class="mb-0 fw-bold text-dark">${TotalUser}</h3>
          </div>
        </div>
        <div class="mt-3 small">
          <span class="text-success fw-bold"><i class="bi bi-arrow-up"></i> 5%</span>
          <span class="text-muted ms-1">so với tháng trước</span>
        </div>
      </div>
    </div>

    <div class="col-md-4">
      <div class="card card-stat p-4 bg-white border-0 shadow-sm Ripple-effect">
        <div class="d-flex align-items-center">
          <div class="icon-box bg-success-subtle text-success me-3">
            <i class="bi bi-cart-check-fill"></i>
          </div>
          <div>
            <p class="text-muted mb-0 small fw-bold text-uppercase">Đơn hàng mới</p>
            <h3 class="mb-0 fw-bold text-dark">24</h3>
          </div>
        </div>
        <div class="mt-3 small">
          <span class="text-success fw-bold"><i class="bi bi-arrow-up"></i> 12%</span>
          <span class="text-muted ms-1">tăng trưởng</span>
        </div>
      </div>
    </div>

    <div class="col-md-4">
      <div class="card card-stat p-4 bg-white border-0 shadow-sm Ripple-effect" onclick="location.href='?view=products'">
        <div class="d-flex align-items-center">
          <div class="icon-box bg-warning-subtle text-warning me-3">
            <i class="bi bi-box-seam-fill"></i>
          </div>
          <div>
            <p class="text-muted mb-0 small fw-bold text-uppercase">Sản phẩm</p>
            <h3 class="mb-0 fw-bold text-dark">156</h3>
          </div>
        </div>
        <div class="mt-3 small">
          <span class="text-muted">Kho hàng: <strong class="text-dark">85%</strong> công suất</span>
        </div>
      </div>
    </div>
  </div>

  <div class="row g-4">
    <div class="col-lg-8">
      <div class="data-table-container shadow-sm border-0 h-100">
        <h5 class="fw-bold mb-4">Hoạt động gần đây</h5>
        <div class="alert alert-light border-0 py-5 text-center">
          <i class="bi bi-graph-up-arrow fs-1 text-muted opacity-25"></i>
          <p class="mt-3 text-muted">Biểu đồ doanh thu sẽ hiển thị tại đây khi có dữ liệu.</p>
        </div>
      </div>
    </div>
    <div class="col-lg-4">
      <div class="data-table-container shadow-sm border-0 h-100">
        <h5 class="fw-bold mb-4">Thông báo</h5>
        <ul class="list-group list-group-flush">
          <li class="list-group-item px-0 border-0 mb-2">
            <div class="d-flex align-items-start">
              <div class="bg-info-subtle text-info p-2 rounded-3 me-3"><i class="bi bi-info-circle"></i></div>
              <div>
                <div class="small fw-bold">Hệ thống bảo trì</div>
                <div class="text-muted" style="font-size: 0.75rem;">Dự kiến vào lúc 2h sáng mai.</div>
              </div>
            </div>
          </li>
          <li class="list-group-item px-0 border-0">
            <div class="d-flex align-items-start">
              <div class="bg-danger-subtle text-danger p-2 rounded-3 me-3"><i class="bi bi-exclamation-triangle"></i></div>
              <div>
                <div class="small fw-bold">Cảnh báo tồn kho</div>
                <div class="text-muted" style="font-size: 0.75rem;">iPhone 15 Pro Max sắp hết hàng.</div>
              </div>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </div>
</div>

<script>
  // Script nhỏ để hiển thị thời gian thực tế
  document.getElementById('current-time').innerText = new Date().toLocaleString('vi-VN');
</script>