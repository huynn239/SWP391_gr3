<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Feedback" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách phản hồi | Admin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding: 20px;
            font-family: 'Segoe UI', sans-serif;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background: #4e73df;
            color: white;
            padding: 1.5rem;
        }
        .btn-primary {
            background: #4e73df;
            border-radius: 25px;
            transition: all 0.3s;
        }
        .btn-primary:hover {
            background: #2e59d9;
        }
        .table-hover tbody tr:hover {
            background-color: #f8f9fc;
            transition: background-color 0.2s;
        }
        .no-data {
            text-align: center;
            padding: 20px;
            color: #666;
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
                <div class="table-responsive">
                    <table id="feedbackTable" class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Tên sản phẩm</th>
                                <th>Số sao</th>
                                <th>Bình luận</th>
                                <th>User ID</th>
                                <th>Chi tiết</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% List<Feedback> feedbackList = (List<Feedback>) request.getAttribute("feedbackList");
                               if (feedbackList != null && !feedbackList.isEmpty()) {
                                   for (Feedback fb : feedbackList) { %>
                            <tr>
                                <td><%= fb.getId() %></td>
                                <td><a href="productDetail.jsp?productId=<%= fb.getProductId() %>"><%= fb.getProductName() %></a></td>
                                <td><%= fb.getRatedStar() %> ★</td>
                                <td><%= fb.getComment() %></td>
                                <td><%= fb.getUserId() %></td>
                                <td><a href="FeedbackDetail.jsp?feedbackId=<%= fb.getId() %>" class="btn btn-info btn-sm">Xem chi tiết</a></td>
                            </tr>
                            <% } } else { %>
                            <tr>
                                <td colspan="6" class="no-data">Không có phản hồi nào</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#feedbackTable').DataTable({
                "pageLength": 10,
                "lengthMenu": [5, 10, 25, 50],
                "language": {
                    "search": "Tìm kiếm:",
                    "lengthMenu": "Hiển thị _MENU_ phản hồi"
                }
            });
        });
    </script>
</body>
</html>