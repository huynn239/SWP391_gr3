<%-- 
    Document   : accessdenied
    Created on : 5 Mar 2025, 3:37:42 pm
    Author     : NBL
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Access Denied</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8d7da;
                text-align: center;
                padding-top: 50px;
            }
            .container {
                display: inline-block;
                padding: 30px;
                background-color: #fff;
                border: 2px solid #f44336;
                border-radius: 10px;
                box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            }
            h1 {
                color: #f44336;
            }
            p {
                color: #333;
            }
            a {
                color: #007bff;
                text-decoration: none;
                font-weight: bold;
            }
            a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Access Denied</h1>
            <p>You don't have permission to access this page!</p>
            <p>Please <a href="login.jsp">login</a> or return to <a href="home.jsp">the home page</a>.</p>
        </div>
    </body>
</html>
