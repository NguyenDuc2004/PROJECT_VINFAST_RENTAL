<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<fmt:setLocale value="vi_VN"/>

<div class="container-fluid py-4">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2 class="h3 mb-0 text-gray-800 text-uppercase fw-bold">Quản lý người dùng</h2>
    <c:if test="${sessionScope.currUser.role == 1}">
      <button type="button" class="btn btn-primary mb-3 shadow-sm" data-bs-toggle="modal" data-bs-target="#addUserModal">
        <i class="bi bi-person-plus-fill"></i> Thêm người dùng mới
      </button>
    </c:if>
  </div>

  <%-- KHỐI BỘ LỌC TÌM KIẾM --%>
  <div class="card border-0 shadow-sm mb-4">
    <div class="card-body p-3">
      <form action="${pageContext.request.contextPath}/user" method="GET" class="row g-2 align-items-end">
        <%-- Giữ view=users để không bị mất giao diện layout --%>
        <input type="hidden" name="view" value="users">

        <div class="col-md-5">
          <label class="form-label fw-bold small text-muted">Tìm kiếm</label>
          <div class="input-group">
            <span class="input-group-text bg-light border-end-0"><i class="bi bi-search text-muted"></i></span>
            <input type="text" name="keyword" class="form-control border-start-0 bg-light"
                   placeholder="Nhập tên hoặc email..." value="${keyword}">
          </div>
        </div>

        <div class="col-md-2">
          <label class="form-label fw-bold small text-muted">Vai trò</label>
          <select name="role" class="form-select bg-light">
            <option value="">-- Tất cả --</option>
            <option value="1" ${role == '1' ? 'selected' : ''}>Quản trị viên</option>
            <option value="2" ${role == '2' ? 'selected' : ''}>Nhân viên</option>
            <option value="0" ${role == '0' ? 'selected' : ''}>Khách hàng</option>
          </select>
        </div>

        <div class="col-md-2">
          <label class="form-label fw-bold small text-muted">Trạng thái</label>
          <select name="status" class="form-select bg-light">
            <option value="">-- Tất cả --</option>
            <option value="1" ${status == '1' ? 'selected' : ''}>Hoạt động</option>
            <option value="0" ${status == '0' ? 'selected' : ''}>Đã khóa</option>
          </select>
        </div>

        <div class="col-md-3 d-flex gap-2">
          <button type="submit" class="btn btn-primary w-100 fw-bold shadow-sm">
            <i class="bi bi-funnel-fill me-1"></i> LỌC
          </button>
          <a href="${pageContext.request.contextPath}/user?view=users" class="btn btn-outline-secondary" title="Làm mới">
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
                <a href="?view=users&action=view&id=${u.id}" class="btn btn-sm btn-light border" title="Xem">
                  <i class="bi bi-eye text-success"></i>
                </a>
                <c:if test="${sessionScope.currUser.role == 1}">
                  <a href="?view=users&action=edit&id=${u.id}" class="btn btn-sm btn-light border" title="Sửa">
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

    <%-- Footer bảng: Tổng số & Phân trang --%>
    <div class="d-flex justify-content-between align-items-center p-3 bg-white border-top">
      <div class="small text-muted">
        Tổng số tài khoản: <span class="fw-bold text-primary">${fn:length(listUser)}</span> |
        Trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong>
      </div>

      <nav aria-label="Page navigation">
        <ul class="pagination pagination-sm mb-0">
          <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
            <a class="page-link shadow-none"
               href="?view=users&page=${currentPage - 1}&keyword=${keyword}&role=${role}&status=${status}">
              <i class="bi bi-chevron-left"></i>
            </a>
          </li>

          <c:forEach begin="1" end="${totalPages}" var="i">
            <li class="page-item ${currentPage == i ? 'active' : ''}">
              <a class="page-link shadow-none ${currentPage == i ? 'bg-primary border-primary text-white' : ''}"
                 href="?view=users&page=${i}&keyword=${keyword}&role=${role}&status=${status}">${i}</a>
            </li>
          </c:forEach>

          <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
            <a class="page-link shadow-none"
               href="?view=users&page=${currentPage + 1}&keyword=${keyword}&role=${role}&status=${status}">
              <i class="bi bi-chevron-right"></i>
            </a>
          </li>
        </ul>
      </nav>
    </div>
  </div>
</div>

<%-- Modal thêm mới --%>
<div class="modal fade" id="addUserModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content border-0 shadow-lg">
      <div class="modal-header bg-primary text-white p-4">
        <h5 class="modal-title fw-bold">
          <i class="bi bi-person-plus-fill me-2"></i>THÊM NGƯỜI DÙNG MỚI
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <form action="${pageContext.request.contextPath}/user" method="post" class="needs-validation">
        <input type="hidden" name="action" value="create">
        <input type="hidden" name="view" value="users">

        <div class="modal-body p-4 bg-light">
          <div class="row g-3">
            <div class="col-md-6">
              <div class="card border-0 shadow-sm p-3 h-100">
                <h6 class="fw-bold text-primary mb-3"><i class="bi bi-shield-lock me-2"></i>Tài khoản</h6>
                <div class="mb-3">
                  <label class="form-label small fw-bold text-muted">Email</label>
                  <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                    <input type="email" name="email" class="form-control" required placeholder="example@gmail.com">
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
                <h6 class="fw-bold text-primary mb-3"><i class="bi bi-card-list me-2"></i>Thông tin</h6>
                <div class="mb-3">
                  <label class="form-label small fw-bold text-muted">Họ và tên</label>
                  <input type="text" name="fullname" class="form-control" placeholder="Nhập họ và tên...">
                </div>
                <div class="mb-2">
                  <label class="form-label small fw-bold text-muted">Số điện thoại</label>
                  <input type="text" name="phone" class="form-control" placeholder="09xxxxxxx">
                </div>
                <div class="mb-0">
                  <label class="form-label small fw-bold text-muted">Địa chỉ</label>
                  <input type="text" name="address" class="form-control" placeholder="Tỉnh/Thành phố">
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
                    <select name="roleId" class="form-select">
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
      text: "Dữ liệu sẽ bị khóa hoặc xóa vĩnh viễn!",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#d33',
      cancelButtonColor: '#6e7881',
      confirmButtonText: 'Đồng ý',
      cancelButtonText: 'Hủy bỏ',
      reverseButtons: true
    }).then((result) => {
      if (result.isConfirmed) {
        window.location.href = "user?view=users&action=delete&id=" + id;
      }
    })
  }

  document.addEventListener("DOMContentLoaded", function() {
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('openModal') === 'true' || "${not empty sessionScope.toastMsg}" === "true") {
      var modalElement = document.getElementById('addUserModal');
      if (modalElement) {
        var myModal = new bootstrap.Modal(modalElement);
        myModal.show();
        window.history.replaceState({}, document.title, "user?view=users");
      }
    }
  });
</script>

<style>
  /* 1. BADGE VAI TRÒ - THIẾT KẾ HIỆN ĐẠI */
  .badge-admin {
    background-color: #fff5f5;
    color: #e53e3e;
    border: 1px solid #fed7d7;
    padding: 4px 10px;
    border-radius: 6px;
    font-size: 0.7rem;
    font-weight: 700;
  }
  .badge-staff {
    background-color: #ebf8ff;
    color: #3182ce;
    border: 1px solid #bee3f8;
    padding: 4px 10px;
    border-radius: 6px;
    font-size: 0.7rem;
    font-weight: 700;
  }
  .badge-user {
    background-color: #f7fafc;
    color: #4a5568;
    border: 1px solid #e2e8f0;
    padding: 4px 10px;
    border-radius: 6px;
    font-size: 0.7rem;
    font-weight: 700;
  }

  /* 2. ĐỒNG BỘ PHÂN TRANG (PAGINATION) */
  .pagination .page-link {
    border-radius: 8px !important;
    margin: 0 3px;
    color: #4a5568;
    border: 1px solid #e2e8f0;
    font-weight: 600;
    transition: all 0.2s ease;
    padding: 6px 12px;
  }

  .pagination .page-item.active .page-link {
    background-color: #007bff !important; /* Màu xanh User Dashboard */
    border-color: #007bff !important;
    color: white !important;
    box-shadow: 0 4px 12px rgba(0, 123, 255, 0.25);
  }

  .pagination .page-link:hover:not(.active) {
    background-color: #f1f5f9;
    color: #007bff;
    border-color: #007bff;
  }

  .page-link.shadow-none:focus {
    box-shadow: none !important;
    outline: none;
  }

  /* 3. TINH CHỈNH BẢNG & MODAL */
  .table thead th {
    font-size: 0.75rem;
    color: #64748b;
    letter-spacing: 0.5px;
    font-weight: 700;
    text-transform: uppercase;
  }

  .table-hover tbody tr:hover {
    background-color: #f8fafc;
  }

  .modal-content {
    border-radius: 15px;
    overflow: hidden;
    border: none;
  }

  /* Custom scroll cho bảng nếu dữ liệu quá nhiều */
  .table-responsive {
    scrollbar-width: thin;
    scrollbar-color: #cbd5e1 #f8fafc;
  }
</style>