<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid px-4 py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold m-0">Quản lý đơn hàng đặt xe</h2>
        <button class="btn btn-primary shadow-sm">
            <i class="bi bi-plus-lg me-2"></i>Tạo đơn hàng mới
        </button>
    </div>

    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3 border-bottom">
            <h6 class="m-0 fw-bold text-primary">Danh sách đơn hàng thuê xe</h6>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="bg-light">
                    <tr>
                        <th class="ps-4">Mã đơn</th>
                        <th>Khách hàng</th>
                        <th>Dòng xe</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Ngày đặt</th>
                        <th class="text-center">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%-- Giả sử biến listOrder được gửi từ Servlet --%>
                    <c:forEach var="order" items="${listOrder}">
                        <tr>
                            <td class="ps-4 fw-bold">#${order.id}</td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="avatar-sm me-2 bg-info-subtle text-info rounded-circle d-flex align-items-center justify-content-center" style="width: 32px; height: 32px;">
                                        <i class="bi bi-person"></i>
                                    </div>
                                        ${order.customerName}
                                </div>
                            </td>
                            <td><span class="badge bg-secondary-subtle text-secondary">${order.carModel}</span></td>
                            <td class="fw-bold text-dark">
                                <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="đ" />
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status == 0}">
                                        <span class="badge bg-warning-subtle text-warning border border-warning-subtle rounded-pill px-3">Chờ duyệt</span>
                                    </c:when>
                                    <c:when test="${order.status == 1}">
                                        <span class="badge bg-success-subtle text-success border border-success-subtle rounded-pill px-3">Đang thuê</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger-subtle text-danger border border-danger-subtle rounded-pill px-3">Đã hủy</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-muted small">${order.orderDate}</td>
                            <td class="text-center pe-4">
                                <button class="btn btn-sm btn-light border me-1" title="Sửa">
                                    <i class="bi bi-pencil-square text-primary"></i>
                                </button>
                                <button class="btn btn-sm btn-light border" title="Xóa" onclick="confirmDelete(${order.id})">
                                    <i class="bi bi-trash text-danger"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>

                    <%-- Nếu chưa có dữ liệu thật, hiển thị dòng trống này để test --%>
                    <c:if test="${empty listOrder}">
                        <tr>
                            <td colspan="7" class="text-center py-5 text-muted">
                                <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                Chưa có dữ liệu đơn hàng
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
    function confirmDelete(id) {
        if(confirm("Bạn có chắc chắn muốn xóa đơn hàng #" + id + "?")) {
            window.location.href = "admin-orders?action=delete&id=" + id;
        }
    }
</script>