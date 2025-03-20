<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Slider</title>
    <!-- CSS Libraries -->
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">
    <style>
        .slider-detail-container {
            max-width: 80%;
            margin: 0 auto;
            padding: 30px;
        }
        .card {
            border: none;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            border-radius: 12px;
        }
        .card-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
            border-radius: 12px 12px 0 0;
            padding: 1.5rem;
        }
        .card-body {
            padding: 3rem;
        }
        .slider-image {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin-top: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .status-badge {
            padding: 10px 18px;
            border-radius: 15px;
            font-size: 1.2em;
        }
        .status-active {
            background-color: #d4edda;
            color: #155724;
        }
        .status-inactive {
            background-color: #f8d7da;
            color: #721c24;
        }
        .slider-detail-text {
            font-size: 2.3rem;
            margin-bottom: 2rem;
        }
        h2 {
            font-size: 2.8rem;
        }
        .card-title {
            font-size: 1.8rem;
        }
        /* Thiết kế lại nút Quay lại danh sách */
        .back-btn {
            display: inline-block;
            padding: 12px 30px;
            font-size: 1.3rem;
            font-weight: 500;
            color: #ffffff;
            background-color: #007bff; /* Màu nền xanh đậm */
            border: none;
            border-radius: 25px; /* Bo tròn mạnh */
            text-decoration: none;
            transition: all 0.3s ease; /* Hiệu ứng mượt mà */
            box-shadow: 0 4px 15px rgba(0, 123, 255, 0.3); /* Thêm shadow */
        }
        .back-btn:hover {
            background-color: #0056b3; /* Màu tối hơn khi hover */
            color: #ffffff;
            text-decoration: none;
            transform: translateY(-2px); /* Nhấc nhẹ lên khi hover */
            box-shadow: 0 6px 20px rgba(0, 123, 255, 0.4); /* Tăng shadow */
        }
        .back-btn i {
            margin-right: 8px; /* Khoảng cách giữa icon và text */
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"/>

    <main class="slider-detail-container">
        <h2 class="mt-5 mb-5 text-center fw-bold">Chi Tiết Slider</h2>

        <!-- Error Message -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert" style="font-size: 1.2rem;">
                ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <!-- Slider Details -->
        <c:if test="${not empty slider}">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title mb-0">Thông Tin Slider</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                             <p class="slider-detail-text">
                                <strong>Title</strong>
                                <a target="_blank" class="text-primary">${slider.title}</a>
                            </p>
                            <p class="slider-detail-text">
                                <strong>Liên kết:</strong>
                                <a href="${slider.link}" target="_blank" class="text-primary">${slider.link}</a>
                            </p>
                            <p class="slider-detail-text">
                                <strong>Trạng thái:</strong>
                                <span class="status-badge ${slider.status ? 'status-active' : 'status-inactive'}">
                                    <c:choose>
                                        <c:when test="${slider.status}">Hiển thị</c:when>
                                        <c:otherwise>Ẩn</c:otherwise>
                                    </c:choose>
                                </span>
                            </p>
                            <p class="slider-detail-text">
                                <strong>Ngày tạo:</strong>
                                <fmt:formatDate value="${slider.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <img src="${slider.imageUrl}" class="slider-image" alt="Slider Image">
                        </div>
                    </div>
                    <div class="mt-5 text-center" style="margin-top: 80px;">
                        <a href="${pageContext.request.contextPath}/sliderList" class="back-btn">
                            <i class="fa fa-arrow-left"></i>Quay lại danh sách
                        </a>
                    </div>
                </div>
            </div>
        </c:if>
    </main>

    <jsp:include page="footer.jsp"/>

    <!-- Bootstrap JS (required for alert dismissal) -->
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>