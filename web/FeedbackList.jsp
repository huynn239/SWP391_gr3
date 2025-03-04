<%-- 
    Document   : FeedbackList
    Created on : Mar 4, 2025, 3:42:47 PM
    Author     : thang
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Feedback" %>  

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Danh sách phản hồi | Admin</title>

        <!-- CSS -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="css/bootstrap.min.css"/>
        <link type="text/css" rel="stylesheet" href="css/style.css"/>
        <link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
    </head>

    <body>
        <%@ include file="header.jsp" %>

        <div class="container mt-4">
            <h2 class="text-center">Danh sách phản hồi</h2>
            <div class="table-responsive">
                <table id="feedbackTable" class="table table-bordered table-hover">
                    <thead class="thead-dark">
                        <tr>
                            <th>ID</th>
                            <th>Tên sản phẩm</th>
                            <th>Số sao</th>
                            <th>Bình luận</th>
                            <th>User ID</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Feedback> feedbackList = (List<Feedback>) request.getAttribute("feedbackList");
                            if (feedbackList != null) {
                                for (Feedback fb : feedbackList) {
                        %>
                        <tr>
                            <td><%= fb.getId() %></td>
                            <td><a href="ProductDetail.jsp?productId=<%= fb.getProductId() %>"><%= fb.getProductName() %></a></td>
                            <td><%= fb.getRatedStar() %> ★</td>
                            <td><%= fb.getComment() %></td>
                            <td><%= fb.getUserId() %></td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <%@ include file="footer.jsp" %>

        <!-- JavaScript -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#feedbackTable').DataTable();
            });
        </script>
    </body>
</html>
