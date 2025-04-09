<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm người dùng mới | Admin</title>
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
                <h2 class="mb-0">Add new User</h2>
            </div>
            <div class="card-body">
                <div class="control-panel">
                    <% String message = request.getParameter("message"); 
                       if (message != null) { %>
                        <div class="alert alert-info"><%= message %></div>
                    <% } %>
                    
                    <form action="UserControllerServlet" method="post">
                        <input type="hidden" name="action" value="add">

                        <div class="form-group mb-3">
                            <label for="uName" class="form-label">Name:</label>
                            <input type="text" name="uName" id="uName" class="form-control" required>
                        </div>

                        <div class="form-group mb-3">
                            <label for="username" class="form-label">Username:</label>
                            <input type="text" name="username" id="username" class="form-control" required>
                        </div>

                        <div class="form-group mb-3">
                            <label for="password" class="form-label">Password:</label>
                            <input type="password" name="password" id="password" class="form-control" required>
                        </div>

                        <div class="form-group mb-3">
                            <label for="gender" class="form-label">Gender:</label>
                            <select name="gender" id="gender" class="form-control">
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                            </select>
                        </div>

                        <div class="form-group mb-3">
                            <label for="email" class="form-label">Email:</label>
                            <input type="email" name="email" id="email" class="form-control" required>
                        </div>

                        <div class="form-group mb-3">
                            <label for="mobile" class="form-label">Phone:</label>
                            <input type="text" name="mobile" id="mobile" class="form-control" required>
                        </div>

                        <div class="form-group mb-3">
                            <label for="uAddress" class="form-label">Adress:</label>
                            <input type="text" name="uAddress" id="uAddress" class="form-control" required>
                        </div>

                        <div class="form-group mb-3">
                            <label for="roleID" class="form-label">Role:</label>
                            <select name="roleID" id="roleID" class="form-control">
                                <option value="1">Admin</option>
                                <option value="2">Marketing</option>
                                <option value="3">Sale</option>
                                <option value="4">Customer</option>
                            </select>
                        </div>

                        <button type="submit" class="btn btn-primary"><i class="fas fa-plus me-2"></i>Add User</button>
                        <a href="UserControllerServlet" class="btn btn-secondary">Cancel</a>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>