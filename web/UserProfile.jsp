<%-- 
    Document   : UserProfile
    Created on : Mar 23, 2025
    Author     : Grok (assisted)
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>User Profile</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
    <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>
    <link type="text/css" rel="stylesheet" href="css/style.css"/>
    <style>
        .profile-container {
            margin-top: 50px;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
        .profile-table td {
            padding: 10px;
        }
        .profile-table th {
            padding: 10px;
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>

    <div class="container profile-container">
        <h2>User Profile</h2>
        <c:if test="${not empty message}">
            <div class="alert alert-info">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <table class="table table-bordered profile-table">
            <tr>
                <th>Name:</th>
                <td>${user.uName}</td>
            </tr>
            <tr>
                <th>Username:</th>
                <td>${user.username}</td>
            </tr>
            <tr>
                <th>Email:</th>
                <td>${user.email}</td>
            </tr>
            <tr>
                <th>Phone:</th>
                <td>${user.mobile}</td>
            </tr>
            <tr>
                <th>Gender:</th>
                <td>${user.gender}</td>
            </tr>
            <tr>
                <th>Address:</th>
                <td>${user.uAddress}</td>
            </tr>
        </table>

        <div class="mt-3">
            <a href="UserControllerServlet?action=editPage&id=${user.id}" class="btn btn-primary">Edit Profile</a>
        </div>
    </div>

    <jsp:include page="footer.jsp"></jsp:include>

    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
</body>
</html>