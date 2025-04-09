<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa thông tin người dùng | Admin</title>
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
        .btn-success {
            border-radius: 25px;
            transition: all 0.3s;
        }
        .btn-secondary {
            border-radius: 25px;
            transition: all 0.3s;
        }
        .control-panel {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .form-control {
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .form-group label {
            font-weight: 500;
        }
    </style>
</head>
<body>

    <div class="container mt-4">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h2 class="mb-0">Edit User</h2>
            </div>
            <div class="card-body">
                <div class="control-panel">
                    <% String message = request.getParameter("message"); 
                       if (message != null) { %>
                        <div class="alert alert-info"><%= message %></div>
                    <% } %>
                    
                    <form action="UserControllerServlet" method="post">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" value="${user.id}">

                        <div class="form-group mb-3">
                            <label for="uName" class="form-label">Name:</label>
                            <input type="text" name="uName" id="uName" class="form-control" value="${user.uName}" required>
                        </div>

                        <div class="form-group mb-3">
                            <label for="gender" class="form-label">Gender:</label>
                            <select name="gender" id="gender" class="form-control">
                                <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                                <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                            </select>
                        </div>

                        <div class="form-group mb-3">
                            <label for="email" class="form-label">Email:</label>
                            <input type="email" name="email" id="email" class="form-control" value="${user.email}" required>
                        </div>

                        <div class="form-group mb-3">
                            <label for="mobile" class="form-label">Phone:</label>
                            <input type="text" name="mobile" id="mobile" class="form-control" value="${user.mobile}" required>
                        </div>

                        <div class="form-group mb-3">
                            <label for="uAddress" class="form-label">Adress:</label>
                            <input type="text" name="uAddress" id="uAddress" class="form-control" value="${user.uAddress}" required>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-success"><i class="fas fa-save me-2"></i>Update</button>
                            <a href="UserControllerServlet" class="btn btn-secondary"><i class="fas fa-times me-2"></i>Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>