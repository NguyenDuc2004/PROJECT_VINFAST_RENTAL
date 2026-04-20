<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container-fluid">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="h3 mb-0 text-gray-800 text-uppercase fw-bold">Quản lý người dùng</h2>
    <%-- Chỉ ADMIN mới thấy nút Thêm --%>
    <c:if test="${sessionScope.currUser.role == 1}">
      <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addUserModal">
        <i class="bi bi-person-plus-fill"></i> Thêm người dùng mới
      </button>
    </c:if>
  </div>

  <%-- KHỐI BỘ LỌC TÌM KIẾM --%>
  <div class="card border-0 shadow-sm mb-4">
    <div class="card-body p-3">
      <form action="${pageContext.request.contextPath}/user" method="GET" class="row g-2 align-items-end">
        <div class="col-md-5">
          <label class="form-label fw-bold small text-muted">Tìm kiếm</label>
          <div class="input-group">
            <span class="input-group-text bg-light border-end-0"><i class="bi bi-search text-muted"></i></span>
            <input type="text" name="keyword" class="form-control border-start-0 bg-light"
                   placeholder="Nhập tên hoặc email..." value="${param.keyword}">
          </div>
        </div>

        <div class="col-md-2">
          <label class="form-label fw-bold small text-muted">Vai trò</label>
          <select name="role" class="form-select bg-light">
            <option value="">-- Tất cả --</option>
            <option value="1" ${param.role == '1' ? 'selected' : ''}>Quản trị viên</option>
            <option value="2" ${param.role == '2' ? 'selected' : ''}>Nhân viên</option>
            <option value="0" ${param.role == '0' ? 'selected' : ''}>Khách hàng</option>
          </select>
        </div>

        <div class="col-md-2">
          <label class="form-label fw-bold small text-muted">Trạng thái</label>
          <select name="status" class="form-select bg-light">
            <option value="">-- Tất cả --</option>
            <option value="1" ${param.status == '1' ? 'selected' : ''}>Hoạt động</option>
            <option value="0" ${param.status == '0' ? 'selected' : ''}>Đã khóa</option>
          </select>
        </div>

        <div class="col-md-3 d-flex gap-2">
          <button type="submit" class="btn btn-primary w-100 fw-bold">
            <i class="bi bi-funnel-fill me-1"></i> LỌC
          </button>
          <a href="${pageContext.request.contextPath}/user" class="btn btn-outline-secondary" title="Làm mới">
            <i class="bi bi-arrow-clockwise"></i>
          </a>
        </div>
      </form>
    </div>
  </div>

  <%-- BẢNG DANH SÁCH --%>
  <div class="card border-0 shadow-sm overflow-hidden">
    <div class="table-responsive">
      <table class="table table-hover align-middle mb-0">
        <thead class="bg-light">
        <tr>
          <th class="ps-4 py-3">HỌ TÊN</th>
          <th>VAI TRÒ</th>
          <th>TRẠNG THÁI</th>
          <th>NGÀY TẠO</th>
          <th class="text-end pe-4">HÀNH ĐỘNG</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${listUser}" var="u">
          <tr>
            <td class="ps-4">
              <div class="d-flex align-items-center">
                <img src="https://ui-avatars.com/api/?name=${u.fullname}&background=random&color=fff"
                     class="rounded-circle me-3" width="38">
                <div>
                  <div class="fw-bold text-dark">${u.fullname}</div>
                  <div class="text-muted" style="font-size: 0.75rem;">${u.email}</div>
                </div>
              </div>
            </td>
            <td>
              <c:choose>
                <c:when test="${u.role == 1}"><span class="badge badge-admin">QUẢN TRỊ VIÊN</span></c:when>
                <c:when test="${u.role == 2}"><span class="badge badge-staff">NHÂN VIÊN</span></c:when>
                <c:otherwise><span class="badge badge-user">NGƯỜI DÙNG</span></c:otherwise>
              </c:choose>
            </td>
            <td>
              <c:choose>
                <c:when test="${u.status == 1}">
                  <span class="text-success fw-medium small"><i class="bi bi-check-circle-fill me-1"></i>Kích hoạt</span>
                </c:when>
                <c:otherwise>
                  <span class="text-danger fw-medium small"><i class="bi bi-dash-circle-fill me-1"></i>Bị khóa</span>
                </c:otherwise>
              </c:choose>
            </td>
            <td class="text-muted small">${u.createdAt}</td>
            <td class="text-end pe-4">
              <div class="btn-group">
                  <%-- Xem: Mọi người --%>
                <a href="?action=view&id=${u.id}" class="btn btn-sm btn-light border" title="Xem">
                  <i class="bi bi-eye text-success"></i>
                </a>

                  <%-- Sửa & Xóa: Chỉ ADMIN mới có quyền --%>
                <c:if test="${sessionScope.currUser.role == 1}">
                  <a href="?action=edit&id=${u.id}" class="btn btn-sm btn-light border" title="Sửa">
                    <i class="bi bi-pencil-square text-primary"></i>
                  </a>
                  <button onclick="confirmDelete(${u.id})" class="btn btn-sm btn-light border" title="Xóa">
                    <i class="bi bi-trash3 text-danger"></i>
                  </button>
                </c:if>
              </div>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
    <div class="p-3 bg-light border-top text-end pe-4">
      <span class="text-muted small">Tổng số tài khoản: </span>
      <span class="fw-bold text-primary">${fn:length(listUser)}</span>
    </div>
  </div>
</div>
<div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg"> <div class="modal-content border-0 shadow-lg">
    <div class="modal-header bg-primary text-white p-4">
      <h5 class="modal-title fw-bold" id="addUserModalLabel">
        <i class="bi bi-person-plus-fill me-2"></i>THÊM NGƯỜI DÙNG MỚI
      </h5>
      <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
    </div>

<%--    modal them moi--%>
    <form action=""user?action=create&openModal=true"" method="post" class="needs-validation" >
      <input type="hidden" name="action" value="create">

      <div class="modal-body p-4 bg-light">
        <div class="row g-3">
          <div class="col-md-6">
            <div class="card border-0 shadow-sm p-3 h-100">
              <h6 class="fw-bold text-primary mb-3"><i class="bi bi-shield-lock me-2"></i>Tài khoản</h6>
              <div class="mb-3">
                <label class="form-label small fw-bold text-muted">Email</label>
                <div class="input-group">
                  <span class="input-group-text"><i class="bi bi-person"></i></span>
                  <input type="text" name="email" class="form-control" required placeholder="example@gmail.com">
                </div>
              </div>
              <div class="mb-0">
                <label class="form-label small fw-bold text-muted">Mật khẩu</label>
                <div class="input-group">
                  <span class="input-group-text"><i class="bi bi-key"></i></span>
                  <input type="password" name="password" class="form-control" required placeholder="••••••">
                </div>
              </div>
            </div>
          </div>

          <div class="col-md-6">
            <div class="card border-0 shadow-sm p-3 h-100">
              <h6 class="fw-bold text-primary mb-3"><i class="bi bi-card-list me-2"></i>Thông tin chi tiết</h6>
              <div class="mb-3">
                <label class="form-label small fw-bold text-muted">Họ và tên</label>
                <input type="text" name="fullname" class="form-control"  placeholder="Nhập họ và tên......">
              </div>
              <div class="mb-0">
                <label class="form-label small fw-bold text-muted">Địa chỉ</label>
                <input type="text" name="address" class="form-control"  placeholder="vd: Thanh Hóa">
              </div>
              <div class="mb-0">
                <label class="form-label small fw-bold text-muted">Số điện thoại</label>
                <input type="text" name="phone" class="form-control"  placeholder="vd: 0903134522">
              </div>
            </div>
          </div>

          <div class="col-12">
            <div class="card border-0 shadow-sm p-3 mt-2">
              <div class="row align-items-center">
                <div class="col-md-6">
                  <label class="form-label fw-bold text-primary mb-0">
                    <i class="bi bi-person-badge me-2"></i>Vai trò hệ thống
                  </label>
                </div>
                <div class="col-md-6">
                  <select name="roleId" class="form-select border-primary-subtle">
                    <option value="1">ADMIN - Toàn quyền quản trị</option>
                    <option value="2" selected>STAFF - Nhân viên vận hành</option>
                    <option value="0">USER - Khách hàng thành viên</option>
                  </select>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="modal-footer bg-white border-0 p-4">
        <button type="button" class="btn btn-outline-secondary px-4 fw-bold" data-bs-dismiss="modal">HỦY BỎ</button>
        <button type="submit" class="btn btn-primary px-5 fw-bold shadow">
          <i class="bi bi-save2 me-2"></i>THÊM MỚI
        </button>
      </div>
    </form>
  </div>
  </div>
</div>
<script>
  function confirmDelete(id) {
    Swal.fire({
      title: 'Xác nhận xóa?',
      text: "Dữ liệu sẽ bị xóa vĩnh viễn, bạn không thể hoàn tác!",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#d33', // Màu đỏ cho nút xóa
      cancelButtonColor: '#6e7881',
      confirmButtonText: 'Đồng ý',
      cancelButtonText: 'Hủy bỏ',
      reverseButtons: true
    }).then((result) => {
      if (result.isConfirmed) {
        // Nếu người dùng nhấn OK, nhảy đến link xóa
        window.location.href = "user?action=delete&id=" + id;
      }
    })
  }
  document.addEventListener("DOMContentLoaded", function() {
    const urlParams = new URLSearchParams(window.location.search);

    // Nếu URL có openModal hoặc trong Session có tin nhắn lỗi
    if (urlParams.get('openModal') === 'true' || "${not empty sessionScope.toastMsg}" === "true") {

      var modalElement = document.getElementById('addUserModal');
      if (modalElement) {
        var myModal = new bootstrap.Modal(modalElement);
        myModal.show();

        // Mẹo nhỏ: Xóa tham số trên URL cho sạch sau khi đã mở Modal
        window.history.replaceState({}, document.title, "user");
      }
    }
  });
</script>

<style>
  .badge-admin { background-color: #ffe5e5; color: #d9534f; border: 1px solid #f5c6cb; padding: 4px 10px; border-radius: 6px; font-size: 0.7rem; }
  .badge-staff { background-color: #e7f3ff; color: #007bff; border: 1px solid #b8daff; padding: 4px 10px; border-radius: 6px; font-size: 0.7rem; }
  .badge-user { background-color: #f8f9fa; color: #6c757d; border: 1px solid #dee2e6; padding: 4px 10px; border-radius: 6px; font-size: 0.7rem; }
  .table thead th { font-size: 0.75rem; color: #6c757d; letter-spacing: 0.5px; }
  .btn-group .btn:hover { background-color: #f1f1f1; }

  /* Tùy chỉnh Modal */
  .modal-content { border-radius: 15px; overflow: hidden; }
  .modal-header { background: linear-gradient(135deg, #007bff 0%, #0069d9 100%) !important; } /* Màu xanh thương hiệu của ông */
  .form-control:focus, .form-select:focus {
    border-color: #38a41c;
    box-shadow: 0 0 0 0.25rem rgba(56, 164, 28, 0.15);
  }
  .card { border-radius: 10px; }
  .input-group-text { background-color: #f8f9fa; color: #38a41c; }
</style>