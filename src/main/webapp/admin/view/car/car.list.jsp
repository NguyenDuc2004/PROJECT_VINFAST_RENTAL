<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<fmt:setLocale value="vi_VN"/>

<div class="container-fluid py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="h3 mb-0 text-gray-800 text-uppercase fw-bold">Quản lý sản phẩm</h2>
        <c:if test="${sessionScope.currUser.role == 1 || sessionScope.currUser.role == 2}">
            <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addProductModal">
                <i class="bi bi-plus-circle"></i> Thêm sản phẩm
            </button>
        </c:if>
    </div>

    <%-- Bộ lọc tìm kiếm --%>
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-body p-3">
            <form action="${pageContext.request.contextPath}/product" method="GET" class="row g-2 align-items-end">
                <div class="col-md-3">
                    <label class="form-label fw-bold small text-muted">Tìm kiếm</label>
                    <input type="text" name="keyword" class="form-control bg-light"
                           placeholder="Tên sản phẩm..." value="${keyword}">
                </div>

                <div class="col-md-2">
                    <label class="form-label fw-bold small text-muted">Trạng thái</label>
                    <select name="status" class="form-select bg-light">
                        <option value="">-- Tất cả --</option>
                        <option value="AVAILABLE" ${status == 'AVAILABLE' ? 'selected' : ''}>Còn hàng</option>
                        <option value="UNAVAILABLE" ${status == 'UNAVAILABLE' ? 'selected' : ''}>Hết hàng</option>
                        <option value="DELETED" ${status == 'DELETED' ? 'selected' : ''}>Xóa mềm</option>
                    </select>
                </div>

                <div class="col-md-2">
                    <label class="form-label fw-bold small text-muted">Danh mục</label>
                    <select name="category" class="form-select bg-light">
                        <option value="">-- Tất cả --</option>
                        <option value="1" ${category == '1' ? 'selected' : ''}>SUV</option>
                        <option value="2" ${category == '2' ? 'selected' : ''}>SEDAN</option>
                        <option value="3" ${category == '3' ? 'selected' : ''}>HATCHBACK</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label fw-bold small text-muted">Địa điểm</label>
                    <select name="locationId" class="form-select bg-light">
                        <option value="">-- Tất cả --</option>
                        <c:forEach items="${listLocations}" var="loc">
                            <option value="${loc.id}" ${locationId == loc.id ? 'selected' : ''}>${loc.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-2 d-flex gap-2">
                    <button class="btn btn-primary flex-grow-1 fw-bold">
                        <i class="bi bi-funnel-fill"></i> LỌC
                    </button>
                    <a href="${pageContext.request.contextPath}/product" class="btn btn-outline-secondary">
                        <i class="bi bi-arrow-clockwise"></i>
                    </a>
                </div>
            </form>
        </div>
    </div>

    <%-- Bảng danh sách sản phẩm --%>
    <div class="card border-0 shadow-sm overflow-hidden">
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="bg-light">
                <tr>
                    <th class="ps-4">ID</th>
                    <th class="ps-4">SẢN PHẨM</th>
                    <th>ĐỊA ĐIỂM</th>
                    <th>GIÁ</th>
                    <th>TRẠNG THÁI</th>
                    <th>NGÀY TẠO</th>
                    <th class="text-end pe-4">HÀNH ĐỘNG</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach items="${listProduct}" var="p">
                    <tr>
                        <td><div class="small">${p.id}</div></td>
                        <td class="ps-4">
                            <div class="d-flex align-items-center">
                                <c:set var="img" value="${p.imageUrl}"/>
                                <img src="${(fn:startsWith(img, 'http')) ? img : (pageContext.request.contextPath.concat('/').concat(img))}"
                                     width="45" height="45" class="rounded me-3" style="object-fit: cover;"
                                     onerror="this.src='https://img.vanhai.vn/202304/xe-dien-vinfast-vf8.jpg'">
                                <div>
                                    <div class="fw-bold">${p.modelName}</div>
                                    <c:if test="${not empty p.licensePlate}">
                                        <span class="badge bg-dark mt-1" style="letter-spacing: 1px;">${p.licensePlate}</span>
                                    </c:if>
                                    <div class="text-muted small">${p.categoryName}</div>
                                </div>
                            </div>
                        </td>
                        <td><div class="small"><i class="bi bi-geo-alt-fill text-danger me-1"></i>${p.locationName}</div></td>
                        <td class="fw-bold text-primary">
                            <fmt:formatNumber value="${p.pricePerDay}" pattern="#,###"/> VND
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${p.status == 'AVAILABLE'}">
                                    <span class="badge bg-light text-success border border-success">Còn hàng</span>
                                </c:when>
                                <c:when test="${p.status == 'UNAVAILABLE'}">
                                    <span class="badge bg-light text-danger border border-danger">Hết hàng</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-light text-danger border border-danger">Xóa mềm</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="small text-muted">20-04-2026</td>
                        <td class="text-end pe-4">
                            <div class="btn-group">
                                <a href="${pageContext.request.contextPath}/product?action=view-car&id=${p.id}" class="btn btn-sm btn-light border">
                                    <i class="bi bi-eye text-success"></i>
                                </a>
                                <c:if test="${sessionScope.currUser.role == 1 || sessionScope.currUser.role == 2}">
                                    <a href="${pageContext.request.contextPath}/product?action=edit-car&id=${p.id}" class="btn btn-sm btn-light border">
                                        <i class="bi bi-pencil-square text-primary"></i>
                                    </a>
                                    <button onclick="confirmDelete(${p.id})" class="btn btn-sm btn-light border">
                                        <i class="bi bi-trash text-danger"></i>
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
                Tổng số xe: <span class="fw-bold text-primary">${fn:length(listProduct)}</span> |
                Trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong>
            </div>

            <nav aria-label="Page navigation">
                <ul class="pagination pagination-sm mb-0">
                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                        <a class="page-link shadow-none" href="?page=${currentPage - 1}&keyword=${keyword}&status=${status}&category=${category}&locationId=${locationId}">
                            <i class="bi bi-chevron-left"></i>
                        </a>
                    </li>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link shadow-none ${currentPage == i ? 'bg-primary border-primary' : ''}"
                               href="?page=${i}&keyword=${keyword}&status=${status}&category=${category}&locationId=${locationId}">
                                    ${i}
                            </a>
                        </li>
                    </c:forEach>

                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                        <a class="page-link shadow-none" href="?page=${currentPage + 1}&keyword=${keyword}&status=${status}&category=${category}&locationId=${locationId}">
                            <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</div>

<%-- Modal Thêm sản phẩm --%>
<div class="modal fade" id="addProductModal">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-3">
            <form action="product" method="post">
                <input type="hidden" name="action" value="create">
                <div class="modal-header bg-primary text-white">
                    <h5 class="fw-bold mb-0"><i class="bi bi-plus-circle-fill me-2"></i> Thêm xe mới</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-8">
                            <label class="fw-bold small mb-1 text-secondary text-uppercase">Tên sản phẩm</label>
                            <input type="text" name="name" class="form-control" placeholder="Nhập tên xe..." required>
                        </div>
                        <div class="col-md-4">
                            <label class="fw-bold small mb-1 text-secondary text-uppercase">Biển số</label>
                            <input type="text" name="licensePlate" class="form-control" placeholder="29A-123.45">
                        </div>
                        <div class="col-md-6">
                            <label class="fw-bold small mb-1 text-secondary text-uppercase">Giá thuê (VNĐ/ngày)</label>
                            <div class="input-group">
                                <input type="text" name="price" id="add_price" class="form-control fw-bold text-primary" placeholder="Ví dụ: 500.000" required>
                                <span class="input-group-text bg-light">VND</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="fw-bold small mb-1 text-secondary text-uppercase">Danh mục</label>
                            <select name="categoryId" class="form-select">
                                <option value="1">SUV</option>
                                <option value="2">SEDAN</option>
                                <option value="3">HATCHBACK</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="fw-bold small mb-1 text-secondary text-uppercase">Điểm nhận xe</label>
                            <select name="locationId" class="form-select">
                                <c:forEach items="${listLocations}" var="loc">
                                    <option value="${loc.id}">${loc.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="fw-bold small mb-1 text-secondary text-uppercase">Trạng thái</label>
                            <select name="status" class="form-select">
                                <option value="AVAILABLE">Còn hàng</option>
                                <option value="UNAVAILABLE">Hết hàng</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="fw-bold small mb-1 text-secondary text-uppercase">Link ảnh (URL)</label>
                            <input type="text" name="imageUrl" class="form-control" placeholder="Dán đường dẫn ảnh tại đây...">
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-primary px-4 fw-bold">Lưu lại</button>
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
            confirmButtonColor: '#d33',
            cancelButtonColor: '#6e7881',
            confirmButtonText: 'Đồng ý',
            cancelButtonText: 'Hủy bỏ',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "product?action=delete&id=" + id;
            }
        })
    }

    const priceInput = document.getElementById('add_price');
    if (priceInput) {
        priceInput.addEventListener('input', function (e) {
            let cursorPosition = this.selectionStart;
            let originalLength = this.value.length;
            let rawValue = this.value.replace(/[^0-9]/g, '');
            if (rawValue === "") { this.value = ""; return; }
            let formattedValue = new Intl.NumberFormat('vi-VN').format(parseInt(rawValue));
            this.value = formattedValue;
            let newLength = this.value.length;
            cursorPosition = cursorPosition + (newLength - originalLength);
            this.setSelectionRange(cursorPosition, cursorPosition);
        });
    }
</script>
<style>
    /* Làm đẹp Footer phân trang */
    .pagination .page-link {
        border-radius: 8px !important; /* Bo góc cho hiện đại */
        margin: 0 3px;               /* Khoảng cách giữa các nút */
        color: #4a5568;              /* Màu chữ xám đậm */
        border: 1px solid #e2e8f0;   /* Viền mảnh */
        font-weight: 600;
        transition: all 0.2s ease;
        padding: 6px 12px;           /* Kích thước nút vừa vặn */
    }

    /* Khi di chuột vào nút (hover) */
    .pagination .page-link:hover:not(.active) {
        background-color: #f1f5f9;
        color: #0062ff;
        border-color: #0062ff;
    }

    /* Nút đang được chọn (Active) - Dùng màu xanh VinFast */
    .pagination .page-item.active .page-link {
        background-color: #0062ff !important;
        border-color: #0062ff !important;
        color: white !important;
        box-shadow: 0 4px 10px rgba(0, 98, 255, 0.25); /* Hiệu ứng nổi nhẹ */
    }

    /* Nút bị vô hiệu hóa (Disabled) */
    .pagination .page-item.disabled .page-link {
        background-color: #f8fafc;
        color: #cbd5e1;
        border-color: #e2e8f0;
    }

    /* Xóa cái viền xanh khó chịu khi click (focus) */
    .page-link.shadow-none:focus {
        box-shadow: none !important;
        outline: none;
    }
</style>