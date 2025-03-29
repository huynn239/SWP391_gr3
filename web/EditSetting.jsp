<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Setting</title>
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
        .btn-primary, .btn-success, .btn-secondary {
            border-radius: 25px;
            padding: 8px 20px;
            transition: all 0.3s;
        }
        .btn-success {
            background: #28a745;
        }
        .btn-success:hover {
            background: #218838;
        }
        .btn-secondary {
            background: #6c757d;
        }
        .btn-secondary:hover {
            background: #5a6268;
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
    <div class="container mt-5">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h2 class="mb-0">Chỉnh sửa Cài đặt</h2>
                <a class="btn btn-primary" href="SettingController"><i class="fas fa-arrow-left me-2"></i>Quay lại</a>
            </div>
            <div class="card-body">
                <% String message = request.getParameter("message"); 
                   if (message != null) { %>
                    <div class="alert alert-info"><%= message %></div>
                <% } %>
                <form action="SettingController" method="post">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="id" value="${setting.id}">

                    <div class="mb-3">
                        <label>Role</label>
                        <select name="type" class="form-control">
                            <option value="Admin" ${setting.type == 'Admin' ? 'selected' : ''}>Admin</option>
                            <option value="Marketing" ${setting.type == 'Marketing' ? 'selected' : ''}>Marketing</option>
                            <option value="Sale" ${setting.type == 'Sale' ? 'selected' : ''}>Sale</option>
                            <option value="Customer" ${setting.type == 'Customer' ? 'selected' : ''}>Customer</option>
                            <option value="Unknown" ${setting.type == 'Unknown' ? 'selected' : ''}>Unknown</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label>Username:</label>
                        <input type="text" name="value" class="form-control" value="${setting.value}" readonly>
                    </div>

                    <div class="mb-3">
                        <label>Order:</label>
                        <input type="number" name="order" class="form-control" value="${setting.order}" readonly>
                    </div>

                    <div class="mb-3">
                        <label>Description:</label>
                        <textarea name="description" class="form-control" required>${setting.description}</textarea>
                    </div>

                    <div class="mb-3">
                        <label>Status:</label>
                        <select name="status" class="form-control">
                            <option value="true" ${setting.status ? 'selected' : ''}>Active</option>
                            <option value="false" ${!setting.status ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-success">Update</button>
                    <a href="SettingController" class="btn btn-secondary">Cancel</a>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
