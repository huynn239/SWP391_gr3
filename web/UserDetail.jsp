<%-- 
    Document   : UserDetail
    Created on : Feb 9, 2025, 2:11:01 PM
    Author     : thang
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>User Details</title>
    <!-- Font Awesome cho biểu tượng -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/font-awesome.min.css" rel="stylesheet">
        <link href="css/main.css" rel="stylesheet">
        <link href="css/responsive.css" rel="stylesheet">
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        <div class="section">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <h2>User Details</h2>
                        <c:if test="${not empty error}">
                            <p style="color:red;">${error}</p>
                        </c:if>
                        <table class="table table-bordered">
                            <tr>
                                <td><b>Name:</b></td>
                                <td>${uname}</td>
                            </tr>
                            <tr>
                                <td><b>Email:</b></td>
                                <td>${email}</td>
                            </tr>
                            <tr>
                                <td><b>Phone:</b></td>
                                <td>${mobile}</td>
                            </tr>
                            <tr>
                                <td><b>Gender:</b></td>
                                <td>${gender}</td>
                            </tr>
                            <tr>
                                <td><b>Address:</b></td>
                                <td>${uaddress}</td>
                            </tr>
                            <tr>
                                <td><b>Role ID:</b></td> 
                                <td>${roleID}</td> <!-- Đảm bảo attribute tên là "roleID" -->
                            </tr>
                        </table>
                        <br>
                        <a class="btn btn-primary" href="UserControllerServlet?action=editPage&id=${id}">Edit User</a>
                        <a class="btn btn-primary" href="UserControllerServlet">Back to User List</a>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include>
        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    </body>
</html>