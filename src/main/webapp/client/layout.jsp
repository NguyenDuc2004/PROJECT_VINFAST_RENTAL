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

<c:if test="${not empty view}">
    <jsp:include page="${view}" />
</c:if>

<jsp:include page="include/footer.jsp" />
</body>
</html>