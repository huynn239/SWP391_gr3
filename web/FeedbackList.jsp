<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Feedback" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách phản hồi | Admin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #e8eaf6 0%, #c3cfe2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', sans-serif;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            background-color: #fff;
        }
        .card-header {
            background: #6c5ce7;
            color: white;
            padding: 1.5rem;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }
        .card-header h2 {
            margin-bottom: 0;
            font-weight: 600;
        }
        .btn-primary {
            background: #6c5ce7;
            border-radius: 25px;
            transition: all 0.3s;
        }
        .btn-primary:hover {
            background: #5a4fcf;
        }
        .table-hover tbody tr:hover {
            background-color: #f1f3f8;
            transition: background-color 0.2s ease-in-out;
        }
        .no-data {
            text-align: center;
            padding: 20px;
            color: #888;
        }
        .control-panel {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .pagination {
            justify-content: center;
            margin-top: 20px;
        }
        .pagination .page-link {
            border-radius: 20px;
            padding: 8px 16px;
            font-size: 1rem;
        }
        .pagination .page-link:hover {
            background-color: #f1f3f8;
        }
        .form-control {
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .form-inline label {
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h2 class="mb-0">Danh sách phản hồi</h2>
                <a class="btn btn-primary" href="admin.jsp"><i class="fas fa-arrow-left me-2"></i>Quay lại</a>
            </div>
            <div class="card-body">
                <!-- Control Panel for Filters -->
                <div class="control-panel">
                    <form action="FeedbackListControllerServlet" method="get" class="d-flex flex-wrap align-items-center gap-2">
                        <div class="form-group d-flex align-items-center me-3">
                            <label for="ratedStar" class="me-2">RatedStar:</label>
                            <select name="ratedStar" id="ratedStar" class="form-control" onchange="this.form.submit()">
                                <option value="">All</option>
                                <option value="1" ${selectedRatedStar eq '1' ? 'selected' : ''}>1 sao</option>
                                <option value="2" ${selectedRatedStar eq '2' ? 'selected' : ''}>2 sao</option>
                                <option value="3" ${selectedRatedStar eq '3' ? 'selected' : ''}>3 sao</option>
                                <option value="4" ${selectedRatedStar eq '4' ? 'selected' : ''}>4 sao</option>
                                <option value="5" ${selectedRatedStar eq '5' ? 'selected' : ''}>5 sao</option>
                            </select>
                        </div>
                        <div class="form-group d-flex align-items-center me-3">
                            <label for="keyword" class="me-2">Search:</label>
                            <input type="text" class="form-control" id="keyword" name="keyword" 
                                   placeholder="Tên sản phẩm hoặc bình luận" value="${selectedKeyword}">
                        </div>
                        <button type="submit" class="btn btn-info d-flex align-items-center">
                            <i class="fa fa-search me-1"></i> Tìm
                        </button>
                    </form>

                </div>

                <!-- Feedback Table -->
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>Tên sản phẩm</th>
                                <th>RatedStar</th>
                                <th>Comment</th>
                                <th>Detail</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty feedbackList}">
                                    <c:forEach var="fb" items="${feedbackList}">
                                        <tr>
                                            <td><a href="productDetail.jsp?productId=${fb.productId}" class="text-decoration-none">${fb.productName}</a></td>
                                            <td>${fb.ratedStar} ★</td>
                                            <td>${fb.comment}</td>
                                            <td><a href="FeedbackDetail.jsp?feedbackId=${fb.id}" class="btn btn-info btn-sm">Xem chi tiết</a></td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="4" class="no-data">Không có phản hồi nào phù hợp</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="FeedbackListControllerServlet?page=${currentPage - 1}&keyword=${selectedKeyword}&ratedStar=${selectedRatedStar}">« Trước</a>
                            </li>
                        </c:if>
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="FeedbackListControllerServlet?page=${i}&keyword=${selectedKeyword}&ratedStar=${selectedRatedStar}">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="FeedbackListControllerServlet?page=${currentPage + 1}&keyword=${selectedKeyword}&ratedStar=${selectedRatedStar}">Sau »</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
