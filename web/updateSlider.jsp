<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cập nhật Slider</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/font-awesome.min.css" rel="stylesheet">
        <link href="css/main.css" rel="stylesheet">
        <link href="css/responsive.css" rel="stylesheet">
        <style>
            .update-container {
                max-width: 60%;
                margin: 30px auto;
                padding: 20px;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
            }
            .form-group label {
                font-weight: bold;
                margin-bottom: 5px;
            }
            .form-group img {
                max-width: 300px;
                height: auto;
                border-radius: 5px;
                margin-top: 10px;
            }
            .status-toggle {
                display: flex;
                align-items: center;
            }
            .status-toggle label {
                margin-right: 15px;
            }
            .btn-submit {
                background-color: #007bff;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
            }
            .btn-submit:hover {
                background-color: #0056b3;
            }
            .btn-back {
                background-color: #6c757d;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
            }
            .btn-back:hover {
                background-color: #5a6268;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <div class="update-container">
            <h2 class="text-center mb-4">Cập nhật Slider</h2>


            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">${successMessage}</div>
            </c:if>


            <c:choose>
                <c:when test="${not empty slider}">
                    <form action="sliderList" method="post">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="${slider.id}">
                        <div class="form-group">
                            <label for="title">Title:</label>
                            <input type="text" class="form-control" id="title" name="title" value="${slider.title}" required>
                            <c:if test="${not empty slider.title}">
                                <img src="${slider.title}" alt="    " class="mt-2">
                            </c:if>
                        </div>
                        <div class="form-group">
                            <label for="imageUrl">URL Hình ảnh:</label>
                            <input type="text" class="form-control" id="imageUrl" name="imageUrl" value="${slider.imageUrl}" required>
                            <c:if test="${not empty slider.imageUrl}">
                                <img src="${slider.imageUrl}" alt="Current Slider Image" class="mt-2">
                            </c:if>
                        </div>

                        <div class="form-group">
                            <label for="link">Liên kết:</label>
                            <input type="text" class="form-control" id="link" name="link" value="${slider.link}" required>
                        </div>

                        <div class="form-group">
                            <label>Trạng thái:</label>
                            <div class="status-toggle">
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="status" id="statusActive" value="true" ${slider.status ? 'checked' : ''}>
                                    <label class="form-check-label" for="statusActive">Hiển thị</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="status" id="statusInactive" value="false" ${!slider.status ? 'checked' : ''}>
                                    <label class="form-check-label" for="statusInactive">Ẩn</label>
                                </div>
                            </div>
                        </div>

                        <div class="form-group text-center">
                            <button type="submit" class="btn btn-submit">Cập nhật</button>
                            <a href="sliderList" class="btn btn-back">Quay lại</a>
                        </div>
                    </form>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-warning text-center">Không tìm thấy slider để cập nhật.</div>
                    <div class="text-center">
                        <a href="sliderList" class="btn btn-back">Quay lại danh sách</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <jsp:include page="footer.jsp"/>

        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>