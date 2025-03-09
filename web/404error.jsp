<%-- 
    Document   : 404error
    Created on : 8 Mar 2025, 10:44:45 am
    Author     : NBL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>404 - Page Not Found</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                text-align: center;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
            }
            .container {
                margin-top: 100px;
                padding: 20px;
            }
            h1 {
                font-size: 80px;
                color: #dc3545;
                margin: 0;
            }
            p {
                font-size: 22px;
                color: #6c757d;
                margin: 10px 0;
            }
            a {
                text-decoration: none;
                color: white;
                background-color: #007bff;
                padding: 12px 24px;
                border-radius: 5px;
                font-size: 18px;
                display: inline-block;
                margin-top: 20px;
                transition: 0.3s;
            }
            a:hover {
                background-color: #0056b3;
            }
            .error-image {
                width: 300px;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>404</h1>
            <p>Trang bạn tìm kiếm không tồn tại hoặc đã bị xóa.</p>
            <img class="error-image" src="https://cdn-icons-png.flaticon.com/512/2748/2748558.png" alt="Error Image">
            <p><a href="home">Quay về trang chủ</a></p>
        </div>
    </body>
</html>
