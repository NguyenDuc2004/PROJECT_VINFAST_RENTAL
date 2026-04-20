<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ thống Quản trị | Admin VF-RENTAL</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<%-- CHỐT CHẶN BẢO MẬT (Giống PrivateRoute trong React) --%>
<c:if test="${empty sessionScope.currUser}">
    <c:redirect url="/login"/>
</c:if>

<%-- CHỈ DÙNG 1 KHỐI DUY NHẤT ĐỂ TRÁNH XUNG ĐỘT ID --%>
<c:if test="${not empty sessionScope.toastMsg}">
    <div id="toast-container" style="position: fixed; top: 20px; right: 20px; z-index: 9999; min-width: 320px;">

        <div id="auto-close-alert"
             class="alert alert-${sessionScope.toastType} alert-dismissible fade show shadow-lg border-0"
             role="alert"
             style="border-left: 5px solid ${sessionScope.toastType == 'success' ? '#198754' : '#dc3545'}; background-color: white;">

            <div class="d-flex align-items-center">
                    <%-- Icon tự đổi theo loại --%>
                <i class="bi ${sessionScope.toastType == 'success' ? 'bi-check-circle-fill text-success' : 'bi-exclamation-triangle-fill text-danger'} fs-4 me-3"></i>

                <div class="me-4">
                    <h6 class="mb-0 fw-bold" style="color: #333;">Thông báo hệ thống</h6>
                    <small class="text-muted">${sessionScope.toastMsg}</small>
                </div>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </div>
    </div>
    <%-- QUAN TRỌNG: Hiển thị xong phải xóa ngay để F5 không bị hiện lại --%>
    <c:remove var="toastMsg" scope="session"/>
    <c:remove var="toastType" scope="session"/>
</c:if>
<jsp:include page="include/sidebar.jsp"/>

<div class="main-wrapper" id="content">

    <jsp:include page="include/header.jsp"/>

    <main class="content-body">
        <c:choose>
            <%-- TRANG DASHBOARD --%>
            <c:when test="${view == 'dashboard'}">
                <jsp:include page="view/dashboard.jsp"/>
            </c:when>

            <%-- CHỨC NĂNG XE (CAR) --%>
            <c:when test="${view == 'products'}">
                <jsp:include page="view/car/car.list.jsp"/>
            </c:when>
            <c:when test="${view == 'view-car'}"> <%-- Đổi tên để không trùng --%>
                <jsp:include page="view/car/car-detail.jsp"/>
            </c:when>
            <c:when test="${view == 'edit-car'}"> <%-- Đổi tên để không trùng --%>
                <jsp:include page="view/car/car-edit.jsp"/>
            </c:when>

            <%-- CHỨC NĂNG NGƯỜI DÙNG (USER) --%>
            <c:when test="${view == 'users'}">
                <jsp:include page="view/user/user-list.jsp" />
            </c:when>
            <c:when test="${view == 'view-user'}">
                <jsp:include page="view/user/user-detail.jsp" />
            </c:when>
            <c:when test="${view == 'edit-user'}">
                <jsp:include page="view/user/user-edit.jsp" />
            </c:when>

            <%-- CHỨC NĂNG ĐƠN HÀNG (ORDERS) --%>
            <c:when test="${view == 'orders'}">
                <jsp:include page="view/orders/order.jsp" />
            </c:when>
            <c:when test="${view == 'order-view'}"> <%-- Thêm dòng này --%>
                <jsp:include page="view/orders/order-detail.jsp" />
            </c:when>
            <c:when test="${view == 'order-edit'}"> <%-- Thêm dòng này --%>
                <jsp:include page="view/orders/order-edit.jsp" />
            </c:when>
            <c:when test="${view == 'order-add'}">
                <jsp:include page="view/orders/order-add.jsp" />
            </c:when>

            <%-- MẶC ĐỊNH --%>
            <c:otherwise>
                <jsp:include page="view/dashboard.jsp"/>
            </c:otherwise>
        </c:choose>
    </main>

    <jsp:include page="include/footer.jsp"/>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function () {

        // 1. KHAI BÁO CÁC PHẦN TỬ CHÍNH
        const sidebar = document.getElementById('sidebar');
        const content = document.getElementById('content');
        const btnCollapse = document.getElementById('sidebarCollapse');

        // 2. LOGIC ẨN/HIỆN SIDEBAR
        if (btnCollapse && sidebar && content) {
            btnCollapse.addEventListener('click', function () {
                // Toggle class để thay đổi chiều rộng sidebar và margin của content
                sidebar.classList.toggle('collapsed');
                content.classList.toggle('expanded');

                // Lưu trạng thái vào LocalStorage (giống như Persistence State trong React)
                // Để khi reload trang người dùng không bị reset trạng thái đóng/mở
                const isCollapsed = sidebar.classList.contains('collapsed');
                localStorage.setItem('sidebar-status', isCollapsed ? 'collapsed' : 'expanded');
            });

            // Khôi phục trạng thái sidebar từ lần truy cập trước
            const savedStatus = localStorage.getItem('sidebar-status');
            if (savedStatus === 'collapsed') {
                sidebar.classList.add('collapsed');
                content.classList.add('expanded');
            }
        }

        // 3. HIỆU ỨNG GỢN SÓNG (RIPPLE EFFECT) CHO CARD VÀ BUTTON
        // Áp dụng cho bất kỳ phần tử nào có class .card-stat hoặc .btn-primary
        const rippleElements = document.querySelectorAll('.card-stat, .btn-primary, .btn-action');

        rippleElements.forEach(el => {
            el.addEventListener('click', function (e) {
                // Tạo phần tử span để làm vòng tròn gợn sóng
                let x = e.clientX - e.target.getBoundingClientRect().left;
                let y = e.clientY - e.target.getBoundingClientRect().top;

                let ripples = document.createElement('span');
                ripples.classList.add('ripple'); // Class này đã có trong CSS của bạn
                ripples.style.left = x + 'px';
                ripples.style.top = y + 'px';

                this.appendChild(ripples);

                // Xóa sau khi animation kết thúc (600ms)
                setTimeout(() => {
                    ripples.remove();
                }, 600);
            });
        });

        // 4. TỰ ĐỘNG ĐÓNG SIDEBAR TRÊN MOBILE
        const handleResize = () => {
            if (window.innerWidth < 768) {
                sidebar.classList.add('collapsed');
                content.classList.add('expanded');
            } else {
                // Nếu không phải mobile, khôi phục theo localStorage
                const savedStatus = localStorage.getItem('sidebar-status');
                if (savedStatus !== 'collapsed') {
                    sidebar.classList.remove('collapsed');
                    content.classList.remove('expanded');
                }
            }
        };

        window.addEventListener('resize', handleResize);
        handleResize();
    });

    document.addEventListener("DOMContentLoaded", function () {
        const toast = document.getElementById('auto-close-alert');

        if (toast) {
            // 1. Hiệu ứng ban đầu (lướt nhẹ từ phải vào)
            toast.style.opacity = "0";
            toast.style.transform = "translateX(20px)";
            toast.style.transition = "all 0.5s ease";

            setTimeout(() => {
                toast.style.opacity = "1";
                toast.style.transform = "translateX(0)";
            }, 100);

            // 2. Tự động đóng sau 3 giây (3000ms)
            setTimeout(function () {
                // Hiệu ứng lướt ra
                toast.style.opacity = "0";
                toast.style.transform = "translateX(20px)";

                setTimeout(() => {
                    toast.remove(); // Xóa hẳn khỏi màn hình

                    // 3. Xóa tham số message trên URL để không hiện lại khi F5 trang
                    const url = new URL(window.location);
                    url.searchParams.delete('message');
                    window.history.replaceState({}, document.title, url);
                }, 500);
            }, 3000);
        }
    });
</script>
</body>
</html>