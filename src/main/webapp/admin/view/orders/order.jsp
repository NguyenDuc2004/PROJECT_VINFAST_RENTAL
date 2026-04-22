<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<fmt:setLocale value="vi_VN"/>

<style>
    /* 1. ĐỒNG BỘ BADGE TRẠNG THÁI - GIỐNG USER & PRODUCT */
    .status-badge {
        padding: 6px 12px;
        border-radius: 8px;
        font-weight: 700;
        font-size: 0.75rem;
        text-transform: uppercase;
    }
    .badge-pending { background-color: #fffaf0; color: #9c4221; border: 1px solid #feebc8; }
    .badge-active { background-color: #e6fffa; color: #38a169; border: 1px solid #c6f6d5; }
    .badge-completed { background-color: #ebf8ff; color: #3182ce; border: 1px solid #bee3f8; }
    .badge-canceled { background-color: #f7fafc; color: #718096; border: 1px solid #e2e8f0; }

    .car-badge {
        background: #f1f5f9;
        color: #475569;
        padding: 4px 10px;
        border-radius: 6px;
        font-weight: 700;
        font-size: 0.7rem;
    }

    .order-table thead th {
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 1px;
        font-weight: 700;
        color: #64748b;
        background-color: #f8fafc;
        border: none;
    }

    /* 2. ĐỒNG BỘ PHÂN TRANG (PAGINATION) */
    .pagination .page-link {
        border-radius: 8px !important;
        margin: 0 3px;
        color: #4a5568;
        border: 1px solid #e2e8f0;
        font-weight: 600;
        transition: all 0.2s ease;
    }
    .pagination .page-item.active .page-link {
        background-color: #0062ff !important; /* Màu xanh VinFast */
        border-color: #0062ff !important;
        color: white !important;
        box-shadow: 0 4px 12px rgba(0, 98, 255, 0.2);
    }
    .page-link.shadow-none:focus { box-shadow: none !important; outline: none; }

    .price-text { color: #0f172a; font-weight: 800; }
    .btn-action {
        width: 32px; height: 32px; padding: 0;
        display: inline-flex; align-items: center; justify-content: center;
        border-radius: 8px; transition: 0.2s; border: 1px solid #e2e8f0;
    }
</style>

<div class="container-fluid px-4 py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold m-0 text-dark text-uppercase">Quản lý Đơn hàng</h2>
            <p class="text-muted small m-0">Theo dõi và phê duyệt các yêu cầu thuê xe từ hệ thống</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin-orders?action=export" class="btn btn-primary px-4 shadow-sm fw-bold">
            <i class="bi bi-file-earmark-excel me-2"></i> Xuất Báo Cáo
        </a>
    </div>

    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0 order-table">
                    <thead>
                    <tr>
                        <th class="ps-4">Mã đơn</th>
                        <th>Thông tin khách</th>
                        <th>Xe thuê</th>
                        <th>Thời gian (Nhận - Trả)</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th class="text-end pe-4">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${listOrders}">
                        <tr>
                            <td class="ps-4">
                                <span class="fw-bold text-muted">#${order.id}</span>
                            </td>
                            <td>
                                <div class="d-flex flex-column">
                                    <span class="fw-bold text-dark">${order.customerName}</span>
                                    <span class="text-muted small"><i class="bi bi-telephone me-1"></i>${order.phone}</span>
                                </div>
                            </td>
                            <td>
                                <span class="car-badge small text-uppercase">ID Xe: ${order.carId}</span>
                            </td>
                            <td>
                                <div class="small">
                                    <div class="text-success fw-bold">
                                        <i class="bi bi-calendar-check me-1"></i>
                                        <fmt:formatDate value="${order.startDate}" pattern="dd/MM/yyyy"/>
                                    </div>
                                    <div class="text-danger fw-bold">
                                        <i class="bi bi-calendar-x me-1"></i>
                                        <fmt:formatDate value="${order.endDate}" pattern="dd/MM/yyyy"/>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="price-text text-primary">
                                    <fmt:formatNumber value="${order.totalPrice}" pattern="#,###"/> đ
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status == 0}">
                                        <span class="status-badge badge-pending">Chờ Duyệt</span>
                                    </c:when>
                                    <c:when test="${order.status == 1}">
                                        <span class="status-badge badge-active">Đang Thuê</span>
                                    </c:when>
                                    <c:when test="${order.status == 2}">
                                        <span class="status-badge badge-completed">Hoàn Thành</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge badge-canceled">Đã Hủy</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-end pe-4">
                                <div class="btn-group">
                                    <a href="admin-orders?view=orders&action=view&id=${order.id}"
                                       class="btn btn-light btn-action text-primary me-2" title="Xem">
                                        <i class="bi bi-eye"></i>
                                    </a>
                                    <a href="admin-orders?view=orders&action=edit&id=${order.id}"
                                       class="btn btn-light btn-action text-warning me-2" title="Sửa">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>
                                    <button type="button" class="btn btn-light btn-action text-danger"
                                            onclick="confirmDelete(${order.id}, '${order.customerName}')" title="Xóa">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty listOrders}">
                        <tr>
                            <td colspan="7" class="text-center py-5">
                                <h5 class="text-muted">Chưa có đơn đặt xe nào</h5>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>

            <%-- FOOTER PHÂN TRANG - ĐỒNG BỘ CSS --%>
            <div class="d-flex justify-content-between align-items-center p-3 bg-white border-top">
                <div class="small text-muted">
                    Tổng số đơn hàng: <span class="fw-bold text-primary">${totalRecords}</span> |
                    Trang <strong>${currentPage}</strong> / <strong>${totalPages}</strong>
                </div>

                <nav aria-label="Page navigation">
                    <ul class="pagination pagination-sm mb-0">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link shadow-none" href="?view=orders&page=${currentPage - 1}">
                                <i class="bi bi-chevron-left"></i>
                            </a>
                        </li>

                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link shadow-none" href="?view=orders&page=${i}">${i}</a>
                            </li>
                        </c:forEach>

                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link shadow-none" href="?view=orders&page=${currentPage + 1}">
                                <i class="bi bi-chevron-right"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>

<script>
    function confirmDelete(id, name) {
        Swal.fire({
            title: 'Xóa đơn hàng?',
            text: "Xóa đơn hàng của " + name + " sẽ không thể hoàn tác!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#6e7881',
            confirmButtonText: 'Xác nhận xóa',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "admin-orders?view=orders&action=delete&id=" + id;
            }
        })
    }
</script>