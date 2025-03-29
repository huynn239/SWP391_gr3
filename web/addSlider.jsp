<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Thêm Slider</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input, textarea, select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .error {
            color: red;
            margin-bottom: 10px;
        }
        button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            display: inline-block;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
<jsp:include page="header.jsp"/>

<div class="form-container">
    <h2 class="text-center">Thêm Slider Mới</h2>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="error">${errorMessage}</div>
    </c:if>
    <form action="sliderList" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" class="form-control" required placeholder="Nhập title">
        </div>
        <div class="form-group">
            <label for="blogImage">Hình ảnh Slider:</label>
            <input type="file" id="blogImage" name="blogImage" accept="image/*" required>
        </div>
        <div class="form-group">
            <label for="link">Liên kết:</label>
            <input type="text" id="link" name="link" class="form-control" required placeholder="Nhập liên kết">
        </div>
        <div class="form-group">
            <label for="status">Trạng thái:</label>
            <select id="status" name="status" class="form-control">
                <option value="true">Hiển thị</option>
                <option value="false">Ẩn</option>
            </select>
        </div>
        <input type="hidden" name="action" value="add">
        <button type="submit">Thêm Slider</button>
        <a href="sliderList" class="btn-secondary">Quay lại danh sách</a>
    </form>
</div>

<jsp:include page="footer.jsp"/>
</body>
</html>