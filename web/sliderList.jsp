<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Danh sách Slider</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/responsive.css" rel="stylesheet">

    <style>
        /* Bảng */
        .table-custom {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
        }

        .table-custom thead th {
            background-color: #343a40;
            color: white;
            text-align: center;
            padding: 12px;
        }

        .table-custom tbody tr:hover {
            background-color: #f8f9fa;
        }

        /* Hình ảnh */
        .slider-img {
            width: 150px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
        }

        /* Trạng thái */
        .status-badge {
            padding: 5px 12px;
            font-size: 14px;
            border-radius: 5px;
            font-weight: bold;
            display: inline-block;
            text-align: center;
        }

        .status-active {
            background-color: #28a745;
            color: white;
        }

        .status-inactive {
            background-color: #dc3545;
            color: white;
        }

        /* Liên kết */
        .slider-link {
            display: block;
            max-width: 400px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            color: #007bff;
        }

        .slider-link:hover {
            text-decoration: underline;
        }

        /* Ngày tạo */
        .date-cell {
            text-align: center;
            white-space: nowrap;
        }

        /* Nút thao tác */
        .action-btn {
            margin-right: 5px;
        }
    </style>
</head>

<body>
    <jsp:include page="header.jsp"></jsp:include>

    <div class="container">
        <h2 class="mt-4 mb-4 text-center">Danh sách Slider</h2>

        <%-- Thông báo lỗi --%>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>

        <%-- Nút thêm slider --%>
        <div class="text-right mb-3">
            <a href="addSlider" class="btn btn-primary">Thêm Slider Mới</a>
        </div>

        <%-- Kiểm tra danh sách slider --%>
        <c:choose>
            <c:when test="${not empty sliders}">
                <div class="table-responsive">
                    <table class="table table-custom table-bordered">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Hình ảnh</th>
                                <th>Liên kết</th>
                                <th>Trạng thái</th>
                                <th>Ngày tạo</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                           <c:forEach var="slide" items="${sliders}">
    <tr>
        <td>${slide.id}</td>
        <td>
            <c:choose>
                <c:when test="${not empty slide.imageUrl}">
                    <img src="${slide.imageUrl}" class="slider-img" alt="Slider Image">
                </c:when>
                <c:otherwise>
                    Không có ảnh
                </c:otherwise>
            </c:choose>
        </td>
        <td>
            <a href="${slide.link}" target="_blank" class="slider-link">${slide.link}</a>
        </td>
        <td class="text-center">
            <c:choose>
                <c:when test="${slide.status}">
                    <span class="status-badge status-active">Hiển thị</span>
                </c:when>
                <c:otherwise>
                    <span class="status-badge status-inactive">Ẩn</span>
                </c:otherwise>
            </c:choose>
        </td>
        <td class="text-center">
            <fmt:formatDate value="${slide.createdAt}" pattern="dd-MM-yyyy HH:mm:ss" />
        </td>
        <td class="text-center">
            <a href="sliderDetail?action=sliderDetail&id=${slide.id}" class="btn btn-info btn-sm">Xem chi tiết</a>
          <a href="sliderList?action=deleteSlider&id=${slide.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc muốn xóa slider này?');">Xóa</a>

        </td>
    </tr>
</c:forEach>

                        </tbody>
                    </table>
                </div>

                <%-- Phân trang --%>
                <div class="pagination text-center">
                    <c:if test="${currentPage > 1}">
                        <a href="sliderList?page=${currentPage - 1}" class="btn btn-primary">← Trước</a>
                    </c:if>

                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <a href="sliderList?page=${i}" class="btn ${currentPage == i ? 'btn-dark' : 'btn-outline-primary'}">${i}</a>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <a href="sliderList?page=${currentPage + 1}" class="btn btn-primary">Sau →</a>
                    </c:if>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning text-center">Không có slider nào.</div>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- Footer --%>
    <jsp:include page="footer.jsp"></jsp:include>

    <%-- JS Scripts --%>
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
