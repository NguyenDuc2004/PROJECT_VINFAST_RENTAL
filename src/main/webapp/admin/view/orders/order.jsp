<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .order-table thead th {
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 1px;
        font-weight: 700;
        color: #64748b;
        background-color: #f8fafc;
        border-top: none;
    }
    .status-badge {
        padding: 6px 12px;
        border-radius: 8px;
        font-weight: 700;
        font-size: 0.75rem;
    }
    .car-badge {
        background: #e0f2fe;
        color: #0369a1;
        padding: 4px 10px;
        border-radius: 6px;
        font-weight: 600;
    }
    .price-text {
        color: #0f172a;
        font-weight: 800;
    }
    .btn-action {
        width: 32px;
        height: 32px;
        padding: 0;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        border-radius: 8px;
        transition: 0.2s;
    }
</style>

<div class="container-fluid px-4 py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold m-0 text-dark">Quản lý Đơn hàng</h2>
            <p class="text-muted small m-0">Theo dõi và phê duyệt các yêu cầu thuê xe của khách hàng</p>
        </div>
        <a href="${pageContext.request.contextPath}/admin-orders?action=export" class="btn btn-primary px-4 shadow-sm">
            <i class="bi bi-file-earmark-excel me-2"></i> Xuất Báo Cáo
        </a>
    </div>

    <div class="card border-0 shadow-sm rounded-4 overflow-hidden">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0 order-table">
                    <thead>
                    <tr>
                        <th class="ps-4">ID</th>
                        <th>Thông tin khách</th>
                        <th>Chi tiết xe thuê</th>
                        <th>Lịch trình (Nhận - Trả)</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th class="text-end pe-4">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${listOrder}">
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
                                <span class="car-badge small text-uppercase">Xe ID: ${order.carId}</span>
                            </td>
                            <td>
                                <div class="small">
                                    <div class="text-success fw-600">
                                        <i class="bi bi-calendar-check me-1"></i>
                                        <fmt:formatDate value="${order.startDate}" pattern="dd/MM/yyyy"/>
                                    </div>
                                    <div class="text-danger fw-600">
                                        <i class="bi bi-calendar-x me-1"></i>
                                        <fmt:formatDate value="${order.endDate}" pattern="dd/MM/yyyy"/>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="price-text">
                                    <fmt:formatNumber value="${order.totalPrice}" pattern="#,###"/> đ
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status == 0}">
                                        <span class="badge bg-warning-subtle text-warning border border-warning-subtle status-badge">Chờ Duyệt</span>
                                    </c:when>
                                    <c:when test="${order.status == 1}">
                                        <span class="badge bg-success status-badge text-white">Đang Thuê</span>
                                    </c:when>
                                    <c:when test="${order.status == 2}">
                                        <span class="badge bg-primary-subtle text-primary border border-primary-subtle status-badge">Hoàn Thành</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-light text-muted border status-badge">Đã Hủy</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-end pe-4">
                                <div class="btn-group">
                                    <a href="admin-orders?action=view&id=${order.id}"
                                       class="btn btn-light btn-action text-primary me-2" title="Xem chi tiết">
                                        <i class="bi bi-eye"></i>
                                    </a>

                                    <a href="admin-orders?action=edit&id=${order.id}"
                                       class="btn btn-light btn-action text-warning me-2" title="Cập nhật trạng thái">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>

                                    <button type="button"
                                            class="btn btn-light btn-action text-danger"
                                            onclick="confirmDelete(${order.id}, '${order.customerName}')" title="Xóa">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty listOrder}">
                        <tr>
                            <td colspan="7" class="text-center py-5">
                                <img src="https://cdn-icons-png.flaticon.com/512/7486/7486744.png" width="80" class="opacity-25 mb-3">
                                <h5 class="text-muted">Chưa có đơn đặt xe nào</h5>
                                <p class="small text-muted">Các yêu cầu từ khách sẽ xuất hiện tại đây.</p>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    function confirmDelete(id, name) {
        if(confirm("Xóa đơn hàng của " + name + "? Thao tác này không thể hoàn tác.")) {
            window.location.href = "admin-orders?action=delete&id=" + id;
        }
    }
</script>