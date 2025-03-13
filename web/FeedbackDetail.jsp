<%-- 
    Document   : FeedbackDetail
    Created on : Mar 4, 2025, 8:49:43 PM
    Author     : thang
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Feedback" %>
<%@ page import="dto.FeedbackDAO" %>

<%
    int feedbackId = Integer.parseInt(request.getParameter("feedbackId"));
    FeedbackDAO dao = new FeedbackDAO();
    Feedback feedback = dao.getFeedbackById(feedbackId);

    if (feedback == null) {
        response.getWriter().println("<h2>Không tìm thấy phản hồi!</h2>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết phản hồi</title>
        <link rel="stylesheet" href="css/bootstrap.min.css">
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <div class="container mt-4">
            <h2 class="text-center">Chi tiết phản hồi</h2>
            <table class="table table-bordered">
                <tr>
                    <th>Họ và tên</th>
                    <td><%= feedback.getFullName() %></td>
                </tr>
                <tr>
                    <th>Email</th>
                    <td><%= feedback.getEmail() %></td>
                </tr>
                <tr>
                    <th>Số điện thoại</th>
                    <td><%= feedback.getMobile() %></td>
                </tr>
                <tr>
                    <th>Tên sản phẩm</th>
                    <td><%= feedback.getProductName() %></td>
                </tr>
                <tr>
                    <th>Số sao đánh giá</th>
                    <td><%= feedback.getRatedStar() %> ★</td>
                </tr>
                <tr>
                    <th>Nội dung phản hồi</th>
                    <td><%= feedback.getComment() %></td>
                </tr>
                <tr>
                    <th>Trạng thái</th>
                    <td>
                        <form action="UpdateFeedbackStatusServlet" method="POST" onsubmit="return confirmUpdateStatus();">
                            <input type="hidden" name="feedbackId" value="<%= feedback.getId() %>">
                            <select name="status" class="form-control" id="statusSelect">
                                <option value="Chờ duyệt" <%= feedback.getStatus().equals("Chờ duyệt") ? "selected" : "" %>>Chờ duyệt</option>
                                <option value="Đã duyệt" <%= feedback.getStatus().equals("Đã duyệt") ? "selected" : "" %>>Đã duyệt</option>
                                <option value="Từ chối" <%= feedback.getStatus().equals("Từ chối") ? "selected" : "" %>>Từ chối</option>
                            </select>
                            <button type="submit" class="btn btn-success mt-2">Cập Nhật</button>
                        </form>
                    </td>
                </tr>

            </table>
            <div class="text-center mt-3">
                <a class="btn btn-primary" href="FeedbackListControllerServlet">Back to FeedbackList</a>
            </div>

        </div>
        <script>
            function confirmUpdateStatus() {
                let status = document.getElementById("statusSelect").value;
                return confirm("Bạn có chắc chắn muốn cập nhật trạng thái thành: " + status + "?");
            }
        </script>

        <%@ include file="footer.jsp" %>
    </body>
</html>
