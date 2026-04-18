<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${title} | VinFast Rental</title>
    <jsp:include page="include/header.jsp" />
</head>
<body>
<jsp:include page="include/navbar.jsp" />

<main>
    <c:choose>
        <c:when test="${view == 'home'}">
            <jsp:include page="view/home.jsp"/>
        </c:when>
        <c:when test="${view == 'cars'}">
            <jsp:include page="view/car-list.jsp"/>
        </c:when>
        <c:otherwise>
            <jsp:include page="view/home.jsp"/>
        </c:otherwise>
    </c:choose>
</main>

<jsp:include page="include/footer.jsp" />
</body>
</html>