<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Chi tiết Slider</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="header.jsp"/>

    <div class="container">
        <h2 class="mt-4 mb-4 text-center">Chi tiết Slider</h2>

        <!-- Hiển thị thông báo lỗi nếu có -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>

        <c:if test="${not empty slider}">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Thông tin Slider</h5>
                    <p><strong>Liên kết:</strong> ${slider.link}</p>
                    <p><strong>Trạng thái:</strong> <c:choose>
                        <c:when test="${slider.status == true}">Hiển thị</c:when>
                        <c:otherwise>Ẩn</c:otherwise>
                    </c:choose></p>
                    <p><strong>Ngày tạo:</strong> <fmt:formatDate value="${slider.createdAt}" pattern="dd-MM-yyyy HH:mm:ss"/></p>
                    <div>
                        <img src="${slider.imageUrl}" class="img-fluid" alt="Slider Image">
                    </div>
                    <a href="sliderList" class="btn btn-secondary mt-3">Quay lại danh sách</a>
                </div>
            </div>
        </c:if>
    </div>

    <jsp:include page="footer.jsp"/>
</body>
</html>
