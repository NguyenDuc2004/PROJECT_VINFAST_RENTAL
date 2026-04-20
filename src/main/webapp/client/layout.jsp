<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${not empty title ? title : 'VinFast Rental'}</title>

    <jsp:include page="include/header.jsp" />

    <style>
        html, body {
            height: 100%;
            margin: 0;
        }
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .main-wrap {
            flex: 1 0 auto;
            display: flex;
            flex-direction: column;
        }
        footer {
            flex-shrink: 0;
        }
        /* Thêm khoảng cách cho alert để không dính sát Navbar */
        .custom-alert-container {
            padding: 15px 20px 0 20px;
            z-index: 1050;
        }
    </style>
</head>
<body>
<jsp:include page="include/navbar.jsp" />

<div class="main-wrap">
    <c:if test="${not empty sessionScope.message}">
        <div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 1100; margin-top: 60px;">
            <div id="liveToast" class="toast show border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="5000">
                <div class="toast-header ${sessionScope.msgType == 'success' ? 'bg-success' : (sessionScope.msgType == 'danger' ? 'bg-danger' : 'bg-warning')} text-white border-0">
                    <c:choose>
                        <c:when test="${sessionScope.msgType == 'success'}">
                            <i class="bi bi-check-circle-fill me-2"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        </c:otherwise>
                    </c:choose>
                    <strong class="me-auto">Hệ thống VinFast</strong>
                    <small class="text-white-50">Vừa xong</small>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body py-3 fw-bold text-dark bg-white rounded-bottom">
                        ${sessionScope.message}
                </div>
            </div>
        </div>

        <%-- Xóa trong session ngay sau khi lấy ra --%>
        <c:remove var="message" scope="session" />
        <c:remove var="msgType" scope="session" />

        <style>
            #liveToast {
                animation: slideInRight 0.5s ease-out;
                min-width: 300px;
            }

            @keyframes slideInRight {
                from {
                    transform: translateX(100%);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }
        </style>

        <script>
            // Tự động đóng Toast sau 5 giây với hiệu ứng mờ dần
            document.addEventListener('DOMContentLoaded', function() {
                var toastEl = document.getElementById('liveToast');
                if (toastEl) {
                    var toast = new bootstrap.Toast(toastEl, { autohide: true, delay: 5000 });
                    // Đã set class 'show' ở trên, ở đây chỉ cần đảm bảo nó biến mất đúng lúc
                    setTimeout(function() {
                        toast.hide();
                    }, 3000);
                }
            });
        </script>
    </c:if>
    <c:choose>
        <c:when test="${view == 'home'}">
            <jsp:include page="view/home.jsp"/>
        </c:when>
        <c:when test="${view == 'cars'}">
            <jsp:include page="view/car/car-list.jsp"/>
        </c:when>
        <c:when test="${view == 'car-detail'}">
            <jsp:include page="view/car/car-detail.jsp"/>
        </c:when>
        <c:when test="${view == 'checkout'}">
            <jsp:include page="view/car/checkout.jsp"/>
        </c:when>
        <c:when test="${view == 'order-success'}">
            <jsp:include page="view/car/order-success.jsp"/>
        </c:when>
        <c:when test="${view == 'user-history'}">
            <jsp:include page="view/user/user-history.jsp"/>
        </c:when>
        <c:when test="${view == 'user-profile'}">
            <jsp:include page="view/user/user-profile.jsp"/>
        </c:when>
        <c:otherwise>
            <jsp:include page="view/home.jsp"/>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="include/footer.jsp" />

<script>
    window.addEventListener('load', function() {
        var alert = document.getElementById('adminAlert');
        if (alert) {
            setTimeout(function() {
                // Kiểm tra xem bootstrap đã sẵn sàng chưa
                if (window.bootstrap && bootstrap.Alert) {
                    var bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                } else {
                    // Nếu không có bootstrap JS, dùng ẩn thủ công
                    alert.style.display = 'none';
                }
            }, 4000);
        }
    });
</script>

</body>
</html>