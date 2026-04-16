<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="container-fluid px-4 py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold m-0">Quản lý đơn hàng đặt xe</h2>
        <a href="admin-orders?action=add" class="btn btn-primary shadow-sm">
            <i class="bi bi-plus-lg me-2"></i>Tạo đơn hàng mới
        </a>
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
                        <th class="ps-4">STT</th>
                        <th>Khách hàng</th>
                        <th>Dòng xe</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Ngày đặt</th>
                        <th class="text-center">Thao tác</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="totalItems" value="${listOrder.size()}" />
                    <c:forEach var="order" items="${listOrder}" varStatus="loop">
                        <tr>
                            <td class="ps-4 fw-bold text-muted">#${totalItems - loop.index}</td>
                            <td><span class="fw-semibold">${order.customerName}</span></td>
                            <td><span class="badge bg-info-subtle text-info px-3">${order.carModel}</span></td>
                            <td>
                                <span class="text-dark fw-bold">
                                    <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="đ" maxFractionDigits="0"/>
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status == 0}">
                                        <span class="badge bg-warning text-dark">Chờ duyệt</span>
                                    </c:when>
                                    <c:when test="${order.status == 1}">
                                        <span class="badge bg-success">Đang thuê</span>
                                    </c:when>
                                    <c:when test="${order.status == 2}">
                                        <span class="badge bg-primary">Đã hoàn thành</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">Đã hủy</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </td>
                            <td class="text-center">
                                <a href="admin-orders?action=view&id=${order.id}"
                                   class="btn btn-sm btn-outline-primary me-1 shadow-sm">
                                    <i class="bi bi-eye"></i>
                                </a>

                                <a href="admin-orders?action=edit&id=${order.id}"
                                   class="btn btn-sm btn-outline-warning me-1 shadow-sm">
                                    <i class="bi bi-pencil-square"></i>
                                </a>

                                <button type="button"
                                        class="btn btn-sm btn-outline-danger shadow-sm"
                                        onclick="confirmDelete(${order.id}, '${order.customerName}')">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>

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

<%-- Script xóa đơn hàng --%>
<script>
    function confirmDelete(id, name) {
        if(confirm("Bạn có chắc chắn muốn xóa đơn hàng của khách: " + name + "?")) {
            window.location.href = "admin-orders?action=delete&id=" + id;
        }
    }
</script>