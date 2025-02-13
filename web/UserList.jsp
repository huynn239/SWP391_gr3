<%-- 
    Document   : UserList
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
        <title>Admin</title>
        <!-- Include your stylesheets and scripts -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>
        <link type="text/css" rel="stylesheet" href="css/slick.css"/>
        <link type="text/css" rel="stylesheet" href="css/slick-theme.css"/>
        <link type="text/css" rel="stylesheet" href="css/nouislider.min.css"/>
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link type="text/css" rel="stylesheet" href="css/style.css"/>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
    </head>
    <body>
<jsp:include page="header.jsp"></jsp:include>
        <!-- User Management Section -->
        <div class="section">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <h3 style="color: green;">${mess}</h3>
                    <a href=AddUserList >Add a new User</a>
                        <table id="datatable">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Address</th>
                                    <th>Mobile</th>
                                    <th>Details</th>
                                    <th>Delete</th>
                                </tr>
                            </thead>
                            <tbody>
                               <c:forEach var="i" items="${listU}">
                                        <tr>
                                            <td>${i.uName}</td>
                                            <td>${i.email}</td>
                                            <td>${i.uAddress}</td>
                                            <td>${i.mobile}</td>
                                            <td>
                                                <a href="UserDetailServlet?id=${i.id}">Details</a>
                                            </td>
                                            <td>
                                                <a href="#" onclick="confirmRedirect('UserControllerServlet?action=delete&id=${i.id}')">Delete</a>
                                            </td>
                                        </tr>
                                </c:forEach>
                            </tbody>
                        </table>    
                    </div>
                </div>
            </div>
        </div>

<jsp:include page="footer.jsp"></jsp:include>

        <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
        <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#datatable').DataTable();
            });
            
            function confirmRedirect(link) {
                if(confirm('Are you sure?'))
                    window.location.href = link;
            }
        </script>
    </body>
</html>
