<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<div class="container mt-5">
    <h3>Lịch sử thuê xe của bạn</h3>
    <table class="table table-hover mt-3">
        <thead class="table-dark">
        <tr>
            <th>Ngày đặt</th>
            <th>Dòng xe</th>
            <th>Tổng tiền</th>
            <th>Trạng thái</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="order" items="${history}">
            <tr>
                <td>${order.orderDate}</td>
                <td><span class="badge bg-info text-dark">${order.carModel}</span></td>
                <td><strong>${order.totalPrice} VNĐ</strong></td>
                <td>
                    <c:choose>
                        <c:when test="${order.status == 0}"><span class="badge bg-warning">Chờ duyệt</span></c:when>
                        <c:when test="${order.status == 1}"><span class="badge bg-primary">Đang thuê</span></c:when>
                        <c:when test="${order.status == 2}"><span class="badge bg-success">Đã hoàn thành</span></c:when>
                        <c:otherwise><span class="badge bg-danger">Đã hủy</span></c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>