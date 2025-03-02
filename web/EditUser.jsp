<%-- 
    Document   : EditUser
    Created on : Feb 17, 2025, 11:20:40 AM
    Author     : thang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>

    <div class="container mt-5">
        <h2>Edit User</h2>
        <form action="UserControllerServlet" method="post">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" value="${user.id}">

            <div class="mb-3">
                <label>Name:</label>
                <input type="text" name="uName" class="form-control" value="${user.uName}" required>
            </div>

            <div class="mb-3">
                <label>Username:</label>
                <input type="text" name="username" class="form-control" value="${user.username}" required>
            </div>

            <div class="mb-3">
                <label>Password:</label>
                <input type="password" name="password" class="form-control" value="${user.password}" required>
            </div>

            <div class="mb-3">
                <label>Email:</label>
                <input type="email" name="email" class="form-control" value="${user.email}" required>
            </div>

            <div class="mb-3">
                <label>Mobile:</label>
                <input type="text" name="mobile" class="form-control" value="${user.mobile}" required>
            </div>

            <div class="mb-3">
                <label>Address:</label>
                <input type="text" name="uAddress" class="form-control" value="${user.uAddress}" required>
            </div>

            <div class="mb-3">
                <label>Role:</label>
                <select name="roleID" class="form-control">
                    <option value="1" ${user.roleID == 1 ? 'selected' : ''}>Admin</option>
                    <option value="2" ${user.roleID == 2 ? 'selected' : ''}>Marketing</option>
                    <option value="3" ${user.roleID == 3 ? 'selected' : ''}>Sale</option>
                    <option value="4" ${user.roleID == 4 ? 'selected' : ''}>Customer</option>
                </select>
            </div>

            <button type="submit" class="btn btn-success">Update User</button>
            <a href="UserControllerServlet" class="btn btn-secondary">Cancel</a>
        </form>
    </div>

    <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>

