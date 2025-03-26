<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Feedback" %>
<%@ page import="dto.FeedbackDAO" %>
<%
    String feedbackIdParam = request.getParameter("feedbackId");
    Feedback feedback = null;
    
    try {
        if (feedbackIdParam != null && !feedbackIdParam.isEmpty()) {
            int feedbackId = Integer.parseInt(feedbackIdParam);
            FeedbackDAO dao = new FeedbackDAO();
            feedback = dao.getFeedbackById(feedbackId);
        }
    } catch (NumberFormatException e) {
        feedback = null;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết phản hồi</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding: 20px;
            font-family: 'Segoe UI', sans-serif;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .card-header {
            background: #4e73df;
            color: white;
            padding: 1.5rem;
            border-bottom: none;
        }
        .table {
            background: white;
            border-radius: 10px;
            margin-bottom: 0;
        }
        .table thead th {
            background: #f8f9fc;
            color: #5a5c69;
            border-bottom: 2px solid #e3e6f0;
        }
        .btn-primary {
            background: #4e73df;
            border: none;
            border-radius: 25px;
            padding: 8px 20px;
            transition: all 0.3s;
        }
        .btn-primary:hover {
            background: #2e59d9;
            transform: translateY(-2px);
        }
        .btn-back {
            background: #858796;
            border: none;
            border-radius: 25px;
            padding: 8px 20px;
            transition: all 0.3s;
        }
        .btn-back:hover {
            background: #6c757d;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h2 class="mb-0">Chi tiết phản hồi</h2>
                <a class="btn btn-back" href="FeedbackListControllerServlet">
                    <i class="fas fa-arrow-left me-2"></i> Quay lại danh sách
                </a>
            </div>
            <div class="card-body">
                <% if (feedback == null) { %>
                    <h2 class="text-danger text-center">Không tìm thấy phản hồi!</h2>
                <% } else { %>
                    <table class="table table-hover">
                        <tbody>
                            <tr><th>Họ và tên</th><td><%= feedback.getFullName() %></td></tr>
                            <tr><th>Email</th><td><%= feedback.getEmail() %></td></tr>
                            <tr><th>Số điện thoại</th><td><%= feedback.getMobile() %></td></tr>
                            <tr><th>Tên sản phẩm</th><td><%= feedback.getProductName() %></td></tr>
                            <tr><th>Số sao đánh giá</th><td><%= feedback.getRatedStar() %> ★</td></tr>
                            <tr><th>Nội dung phản hồi</th><td><%= feedback.getComment() %></td></tr>
                            </tr>
                        </tbody>
                    </table>
                <% } %>
            </div>
        </div>
    </div>
    <script>
    </script>
</body>
</html>