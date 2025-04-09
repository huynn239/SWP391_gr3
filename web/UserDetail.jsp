<%-- 
    Document   : UserDetail
    Created on : Feb 9, 2025, 2:11:01 PM
    Author     : thang
--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết người dùng | Admin</title>
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
        .table-hover tbody tr:hover {
            background-color: #f1f3f8;
            transition: background-color 0.2s ease-in-out;
        }
        .control-panel {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

    <div class="container mt-4">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h2 class="mb-0">User Detail</h2>
            </div>
            <div class="card-body">
                <div class="control-panel">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger">${error}</div>
                    </c:if>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <tbody>
                                <tr>
                                    <th scope="row">Name:</th>
                                    <td>${uname}</td>
                                </tr>
                                <tr>
                                    <th scope="row">Email:</th>
                                    <td>${email}</td>
                                </tr>
                                <tr>
                                    <th scope="row">Phone:</th>
                                    <td>${mobile}</td>
                                </tr>
                                <tr>
                                    <th scope="row">Gender:</th>
                                    <td>${gender}</td>
                                </tr>
                                <tr>
                                    <th scope="row">Adress:</th>
                                    <td>${uaddress}</td>
                                </tr>
                                <tr>
                                    <th scope="row">Role:</th>
                                    <td>
                                        <c:choose>
                                            <c:when test="${roleID == 1}">Admin</c:when>
                                            <c:when test="${roleID == 2}">Marketing</c:when>
                                            <c:when test="${roleID == 3}">Sale</c:when>
                                            <c:when test="${roleID == 4}">Customer</c:when>
                                            <c:otherwise>Unknown</c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="d-flex gap-2">
                        <a class="btn btn-primary" href="UserControllerServlet"><i class="fas fa-list me-2"></i>Back to User List</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>