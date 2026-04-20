<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    .history-card { border-radius: 20px; border: none; overflow: hidden; }
    .table thead th { background-color: #f8fafc; color: #64748b; font-size: 0.8rem; text-transform: uppercase; letter-spacing: 1px; border-top: none; padding: 20px; }
    .table tbody td { padding: 20px; vertical-align: middle; border-bottom: 1px solid #f1f5f9; }
    .status-pill { padding: 6px 12px; border-radius: 8px; font-weight: 700; font-size: 0.75rem; }
    .price-text { font-weight: 800; color: #0062ff; }
    .date-box { font-size: 0.85rem; line-height: 1.4; }
</style>

<div class="container my-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-900 m-0">Lịch sử hành trình</h2>
            <p class="text-muted small">Xem lại các chuyến đi và trạng thái đơn hàng của bạn</p>
        </div>
        <a href="${pageContext.request.contextPath}/cars" class="btn btn-outline-primary rounded-pill px-4">
            <i class="bi bi-plus-lg me-2"></i>Thuê xe mới
        </a>
    </div>

    <div class="card history-card shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                    <tr>
                        <th>Mã đơn</th>
                        <th>Thời gian thuê</th>
                        <th>Thông tin xe</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Ngày đặt</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${history}">
                        <tr>
                            <td><span class="fw-bold text-muted">#${order.id}</span></td>
                            <td>
                                <div class="date-box">
                                    <div class="text-success fw-bold"><i class="bi bi-calendar-check me-1"></i> <fmt:formatDate value="${order.startDate}" pattern="dd/MM/yyyy"/></div>
                                    <div class="text-danger fw-bold"><i class="bi bi-calendar-x me-1"></i> <fmt:formatDate value="${order.endDate}" pattern="dd/MM/yyyy"/></div>
                                </div>
                            </td>
                            <td>
                                <span class="badge bg-light text-dark border px-3 py-2">
                                    <i class="bi bi-car-front-fill me-1 text-primary"></i> ID Xe: ${order.carId}
                                </span>
                            </td>
                            <td>
                                <span class="price-text">
                                    <fmt:formatNumber value="${order.totalPrice}" pattern="#,###"/> đ
                                </span>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status == 0}">
                                        <span class="status-pill bg-warning-subtle text-warning border border-warning-subtle text-uppercase">Chờ duyệt</span>
                                    </c:when>
                                    <c:when test="${order.status == 1}">
                                        <span class="status-pill bg-primary text-white text-uppercase shadow-sm">Đang thuê</span>
                                    </c:when>
                                    <c:when test="${order.status == 2}">
                                        <span class="status-pill bg-success-subtle text-success border border-success-subtle text-uppercase">Hoàn thành</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-pill bg-light text-muted border text-uppercase">Đã hủy</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <small class="text-muted fw-600">
                                    <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </small>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty history}">
                        <tr>
                            <td colspan="6" class="text-center py-5">
                                <div class="py-4">
                                    <i class="bi bi-calendar-x fs-1 text-muted opacity-25"></i>
                                    <p class="mt-3 text-muted fw-600">Bạn chưa có lịch sử thuê xe nào.</p>
                                    <a href="${pageContext.request.contextPath}/cars" class="btn btn-primary btn-sm rounded-pill px-4">Khám phá dòng xe</a>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>