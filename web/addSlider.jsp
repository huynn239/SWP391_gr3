<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Thêm Slider</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="container">
    <h2 class="text-center mt-4">Thêm Slider Mới</h2>

    <!-- Hiển thị thông báo thành công -->
    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>

    <!-- Hiển thị thông báo lỗi -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <form action="addSlider" method="post">
        <div class="form-group">
            <label>Hình ảnh Slider (URL):</label>
            <input type="text" name="imageUrl" class="form-control" required placeholder="Nhập URL của hình ảnh">
        </div>
        <div class="form-group">
            <label>Liên kết:</label>
            <input type="text" name="link" class="form-control" required placeholder="Nhập liên kết">
        </div>
        <div class="form-group">
            <label>Trạng thái:</label>
            <select name="status" class="form-control">
                <option value="true">Hiển thị</option>
                <option value="false">Ẩn</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary" name="action" value="add">Thêm Slider</button>
        <a href="sliderList" class="btn btn-secondary">Quay lại danh sách</a>
    </form>
</div>

<jsp:include page="footer.jsp"/>
</body>
</html>
