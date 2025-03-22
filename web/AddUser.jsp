<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add User</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>

    <div class="container mt-5">
        <h2>Add New User</h2>
        <% String message = request.getParameter("message"); 
           if (message != null) { %>
            <div class="alert alert-info"><%= message %></div>
        <% } %>
        
        <form action="UserControllerServlet" method="post">
            <input type="hidden" name="action" value="add">

            <div class="mb-3">
                <label>Name:</label>
                <input type="text" name="uName" class="form-control" required>
            </div>
            
            <div class="mb-3">
                <label>Username:</label>
                <input type="text" name="username" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Password:</label>
                <input type="password" name="password" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Gender:</label>
                <select name="gender" class="form-control">
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <div class="mb-3">
                <label>Email:</label>
                <input type="email" name="email" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Mobile:</label>
                <input type="text" name="mobile" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Address:</label>
                <input type="text" name="uAddress" class="form-control" required>
            </div>

            <div class="mb-3">
                <label>Role:</label>
                <select name="roleID" class="form-control">
                    <option value="1">Admin</option>
                    <option value="2">Marketing</option>
                    <option value="3">Sale</option>
                    <option value="4">Customer</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary">Add User</button>
        </form>
    </div>

    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>