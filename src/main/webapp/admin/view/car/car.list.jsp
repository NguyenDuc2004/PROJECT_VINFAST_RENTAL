<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<fmt:setLocale value="vi_VN"/>

<div class="container-fluid py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="h3 mb-0 text-gray-800 text-uppercase fw-bold">Quản lý sản phẩm</h2>
        <c:if test="${sessionScope.currUser.role == 1}">
            <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addProductModal">
                <i class="bi bi-plus-circle"></i> Thêm sản phẩm
            </button>
        </c:if>
    </div>

    <%-- Bộ lọc tìm kiếm --%>
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-body p-3">
            <form action="${pageContext.request.contextPath}/product" method="GET" class="row g-2 align-items-end">
                <%-- Ô tìm kiếm chiếm --%>
                <div class="col-md-4">
                    <label class="form-label fw-bold small text-muted">Tìm kiếm</label>
                    <input type="text" name="keyword" class="form-control bg-light"
                           placeholder="Tên sản phẩm..." value="${param.keyword}">
                </div>

                <%-- Trạng thái --%>
                <div class="col-md-2">
                    <label class="form-label fw-bold small text-muted">Trạng thái</label>
                    <select name="status" class="form-select bg-light">
                        <option value="">-- Tất cả --</option>
                        <option value="AVAILABLE" ${param.status == 'AVAILABLE' ? 'selected' : ''}>Còn hàng</option>
                        <option value="UNAVAILABLE" ${param.status == 'UNAVAILABLE' ? 'selected' : ''}>Hết hàng</option>
                    </select>
                </div>

                <%-- Danh mục chiếm --%>
                <div class="col-md-3">
                    <label class="form-label fw-bold small text-muted">Danh mục</label>
                    <select name="category" class="form-select bg-light">
                        <option value="">-- Tất cả --</option>
                        <option value="1" ${param.category == '1' ? 'selected' : ''}>SUV</option>
                        <option value="2" ${param.category == '2' ? 'selected' : ''}>SEDAN</option>
                        <option value="3" ${param.category == '3' ? 'selected' : ''}>HATCHBACK</option>
                    </select>
                </div>

                <%-- Nút bấm --%>
                <div class="col-md-3 d-flex gap-2">
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
                    <th class="ps-4">SẢN PHẨM</th>
                    <th>GIÁ</th>
                    <th>TRẠNG THÁI</th>
                    <th>NGÀY TẠO</th>
                    <th class="text-end pe-4">HÀNH ĐỘNG</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach items="${listProduct}" var="p">
                    <tr>
                        <td class="ps-4">
                            <div class="d-flex align-items-center">
                                <c:set var="img" value="${p.imageUrl}"/>
                                <img src="${(fn:startsWith(img, 'http')) ? img : (pageContext.request.contextPath.concat('/').concat(img))}"
                                     width="45" height="45" class="rounded me-3" style="object-fit: cover;"
                                     onerror="this.src='https://img.vanhai.vn/202304/xe-dien-vinfast-vf8.jpg'">
                                <div>
                                    <div class="fw-bold">${p.modelName}</div>
                                    <span class="badge bg-dark mt-1"
                                          style="letter-spacing: 1px;">30H - ${p.id}99.99</span>
                                    <div class="text-muted small">
                                            ${p.categoryName}
                                    </div>
                                </div>
                            </div>
                        </td>

                        <td class="fw-bold text-primary">
                            <fmt:formatNumber value="${p.pricePerDay}" pattern="#,###"/> VND
                        </td>

                        <td>
                            <c:choose>
                                <c:when test="${p.status == 'AVAILABLE'}">
                                    <span class="badge bg-light text-success border border-success">Còn hàng</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-light text-danger border border-danger">Hết hàng</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td class="small text-muted">13/04/2026</td>

                        <td class="text-end pe-4">
                            <div class="btn-group">
                                <a href="${pageContext.request.contextPath}/product?action=view&id=${p.id}"
                                   class="btn btn-sm btn-light border">
                                    <i class="bi bi-eye text-success"></i>
                                </a>
                                <c:if test="${sessionScope.currUser.role == 1}">
                                    <a href="${pageContext.request.contextPath}/product?action=edit&id=${p.id}"
                                       class="btn btn-sm btn-light border">
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
        <div class="p-3 bg-light text-end border-top">
            Tổng sản phẩm: <span class="fw-bold text-primary">${fn:length(listProduct)}</span>
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
                        <div class="col-12">
                            <label class="fw-bold small mb-1 text-secondary text-uppercase">Tên sản phẩm</label>
                            <input type="text" name="name" class="form-control" placeholder="Nhập tên xe..." required>
                        </div>

                        <div class="col-md-6">
                            <label class="fw-bold small mb-1 text-secondary text-uppercase">Giá thuê (VNĐ/ngày)</label>
                            <div class="input-group">
                                <input type="text" name="price" id="add_price"
                                       class="form-control fw-bold text-primary"
                                       placeholder="Ví dụ: 500.000" required>
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

                        <div class="col-12">
                            <label class="fw-bold small mb-1 text-secondary text-uppercase">Link ảnh (URL)</label>
                            <input type="text" name="imageUrl" class="form-control"
                                   placeholder="Dán đường dẫn ảnh tại đây...">
                        </div>

                        <div class="col-12">
                            <label class="fw-bold small mb-1 text-secondary text-uppercase">Trạng thái xe</label>
                            <select name="status" class="form-select">
                                <option value="AVAILABLE">Còn hàng</option>
                                <option value="UNAVAILABLE">Hết hàng</option>
                            </select>
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
            confirmButtonColor: '#d33', // Màu đỏ cho nút xóa
            cancelButtonColor: '#6e7881',
            confirmButtonText: 'Đồng ý',
            cancelButtonText: 'Hủy bỏ',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                // Nếu người dùng nhấn OK, nhảy đến link xóa
                window.location.href = "product?action=delete&id=" + id;
            }
        })
    }
    const priceInput = document.getElementById('add_price');

    if (priceInput) {
        priceInput.addEventListener('input', function (e) {
            // 1. Lưu lại vị trí con trỏ để không bị nhảy về cuối khi đang xóa
            let cursorPosition = this.selectionStart;
            let originalLength = this.value.length;

            // 2. Chỉ lấy số thuần túy
            let rawValue = this.value.replace(/[^0-9]/g, '');

            if (rawValue === "") {
                this.value = "";
                return;
            }

            // 3. Định dạng số
            let formattedValue = new Intl.NumberFormat('vi-VN').format(parseInt(rawValue));
            this.value = formattedValue;

            // 4. Tính toán lại vị trí con trỏ về trải nghiệm xóa/sửa
            let newLength = this.value.length;
            cursorPosition = cursorPosition + (newLength - originalLength);
            this.setSelectionRange(cursorPosition, cursorPosition);
        });

        // Chặn nhập chữ ngay từ đầu
        priceInput.addEventListener('keydown', function(e) {
            if (!/[0-9]/.test(e.key) && e.key !== 'Backspace' && e.key !== 'Delete' && e.key !== 'ArrowLeft' && e.key !== 'ArrowRight') {
                if (e.ctrlKey || e.metaKey) return; // Cho phép Ctrl+C, Ctrl+V
                e.preventDefault();
            }
        });
    }
</script>