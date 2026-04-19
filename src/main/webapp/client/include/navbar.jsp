<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-lightning-charge-fill me-2"></i>VINFAST RENTAL
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link ${view == 'home' || empty view ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/home">Trang chủ</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link ${view == 'cars' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/home?page=cars">Danh sách xe</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link ${view == 'about' ? 'active' : ''}"
                       href="${pageContext.request.contextPath}/home?page=about">Về chúng tôi</a>
                </li>
            </ul>

            <div class="d-flex align-items-center">
                <%-- 1. ICON GIỎ HÀNG (Cần đăng nhập mới xem được chi tiết giỏ hàng) --%>
                <a href="${empty sessionScope.currUser ? pageContext.request.contextPath.concat('/login') : pageContext.request.contextPath.concat('/cart')}"
                   class="position-relative me-4 text-white decoration-none">
                    <i class="bi bi-cart3 fs-4"></i>
                    <c:if test="${not empty sessionScope.currUser}">
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.6rem;">
                            0 <%-- Số lượng xe trong giỏ --%>
                        </span>
                    </c:if>
                </a>

                <c:choose>
                    <%-- TRƯỜNG HỢP CHƯA ĐĂNG NHẬP --%>
                    <c:when test="${empty sessionScope.currUser}">
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light me-2 rounded-pill px-4">Đăng nhập</a>
                        <a href="#" class="btn btn-primary rounded-pill px-4">Đăng ký</a>
                    </c:when>

                    <%-- TRƯỜNG HỢP ĐÃ ĐĂNG NHẬP --%>
                    <c:otherwise>
                        <div class="dropdown">
                            <button class="btn btn-light dropdown-toggle rounded-pill px-3" type="button" data-bs-toggle="dropdown">
                                <i class="bi bi-person-circle me-2"></i>Chào, ${sessionScope.currUser.fullname}
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                                <c:if test="${sessionScope.currUser.role == 1 || sessionScope.currUser.role == 2}">
                                    <li><a class="dropdown-item text-danger fw-bold" href="${pageContext.request.contextPath}/dashboard">
                                        <i class="bi bi-speedometer2 me-2"></i>Quản trị hệ thống
                                    </a></li>
                                    <li><hr class="dropdown-divider"></li>
                                </c:if>
                                <li><a class="dropdown-item ${view == 'user-profile' ? 'active' : ''}"
                                       href="${pageContext.request.contextPath}/home?page=profile">
                                    <i class="bi bi-person me-2"></i>Cá nhân
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/cart"><i class="bi bi-cart-check me-2"></i>Giỏ hàng của tôi</a></li>
                                <li><a class="dropdown-item ${view == 'user-history' ? 'active' : ''}"
                                       href="${pageContext.request.contextPath}/home?page=history">
                                    <i class="bi bi-clock-history me-2"></i>Lịch sử thuê
                                </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/login?action=logout"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                            </ul>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>