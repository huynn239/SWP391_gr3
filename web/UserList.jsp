<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách ng??i dùng | Admin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/responsive.css" rel="stylesheet">
    <style>
        /* Tùy ch?nh giao di?n phân trang */
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 5px;
            background-color: #f9f9f9;
        }
        .pagination a {
            margin: 0 5px;
            padding: 5px 10px;
            border: none;
            background: none;
            color: #333;
            text-decoration: none;
            cursor: pointer;
        }
        .pagination a.current {
            background-color: #e0e0e0; /* N?n màu xám nh?t cho trang hi?n t?i */
            border-radius: 3px;
        }
        .pagination a:hover {
            background-color: #f0f0f0;
            border-radius: 3px;
        }
        .pagination a.disabled {
            color: #ccc;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container mt-4">
        <h2 class="text-center">User List</h2>
        <a class="btn btn-primary mb-3" href="UserControllerServlet?action=addPage">Add User</a>

        <!-- Form l?c và tìm ki?m -->
        <form method="get" action="UserControllerServlet" class="mb-3">
            <div class="row">
                <div class="col-md-3">
                    <label for="gender">Gender:</label>
                    <select name="gender" id="gender" class="form-control">
                        <option value="">All</option>
                        <option value="Male" ${param.gender == 'Male' ? 'selected' : ''}>Male</option>
                        <option value="Female" ${param.gender == 'Female' ? 'selected' : ''}>Female</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label for="roleId">Role:</label>
                    <select name="roleId" id="roleId" class="form-control">
                        <option value="">All</option>
                        <option value="1" ${param.roleId == '1' ? 'selected' : ''}>Admin</option>
                        <option value="2" ${param.roleId == '2' ? 'selected' : ''}>Marketing</option>
                        <option value="3" ${param.roleId == '3' ? 'selected' : ''}>Sale</option>
                        <option value="4" ${param.roleId == '4' ? 'selected' : ''}>User</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label for="status">Status:</label>
                    <select name="status" id="status" class="form-control">
                        <option value="">All</option>
                        <option value="1" ${param.status == '1' ? 'selected' : ''}>Active</option>
                        <option value="0" ${param.status == '0' ? 'selected' : ''}>Inactive</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label for="keyword">Search:</label>
                    <input type="text" name="keyword" id="keyword" class="form-control" placeholder="Name, Email, Mobile" value="${param.keyword}">
                </div>
            </div>
            <button type="submit" class="btn btn-success mt-3">Apply Filter/Search</button>
        </form>

        <!-- Logic phân trang th? công -->
        <%
            int usersPerPage = 6; // S? ng??i dùng trên m?i trang
            java.util.List<model.Account> listU = (java.util.List<model.Account>) request.getAttribute("listU");
            if (listU == null) {
                listU = new java.util.ArrayList<>();
            }
            int totalUsers = listU.size(); // T?ng s? ng??i dùng
            int totalPages = (int) Math.ceil((double) totalUsers / usersPerPage); // T?ng s? trang
            int currentPage = 1; // Trang hi?n t?i m?c ??nh
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }
            if (currentPage < 1) currentPage = 1;
            if (currentPage > totalPages) currentPage = totalPages;

            // Tính ch? s? b?t ??u và k?t thúc c?a danh sách ng??i dùng trên trang hi?n t?i
            int startIndex = (currentPage - 1) * usersPerPage;
            int endIndex = Math.min(startIndex + usersPerPage, totalUsers);
        %>

        <!-- B?ng danh sách ng??i dùng -->
        <div class="table-responsive">
            <table id="userTable" class="table table-bordered table-hover">
                <thead class="thead-dark">
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Gender</th>
                        <th>Email</th>
                        <th>Mobile</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="i" items="${listU}" begin="<%=startIndex%>" end="<%=endIndex - 1%>">
                        <tr>
                            <td>${i.id}</td>
                            <td>${i.uName}</td>
                            <td>${i.gender}</td>
                            <td>${i.email}</td>
                            <td>${i.mobile}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${i.roleID == 1}">Admin</c:when>
                                    <c:when test="${i.roleID == 2}">Marketing</c:when>
                                    <c:when test="${i.roleID == 3}">Sale</c:when>
                                    <c:when test="${i.roleID == 4}">Customer</c:when>
                                    <c:otherwise>Unknown</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${i.status == 1 ? 'Active' : 'Inactive'}</td>
                            <td>
                                <a href="UserControllerServlet?action=viewDetail&id=${i.id}" class="btn btn-info btn-sm">View</a>
                                <a href="UserControllerServlet?action=editPage&id=${i.id}" class="btn btn-warning btn-sm">Edit</a>
                                <a href="#" onclick="confirmRedirect('UserControllerServlet?action=delete&id=${i.id}')" class="btn btn-danger btn-sm">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Phân trang th? công -->
        <div class="pagination">
            <%
                // Gi? các tham s? l?c/tìm ki?m hi?n t?i
                String queryString = "";
                if (request.getParameter("gender") != null && !request.getParameter("gender").isEmpty()) {
                    queryString += "&gender=" + request.getParameter("gender");
                }
                if (request.getParameter("roleId") != null && !request.getParameter("roleId").isEmpty()) {
                    queryString += "&roleId=" + request.getParameter("roleId");
                }
                if (request.getParameter("status") != null && !request.getParameter("status").isEmpty()) {
                    queryString += "&status=" + request.getParameter("status");
                }
                if (request.getParameter("keyword") != null && !request.getParameter("keyword").isEmpty()) {
                    queryString += "&keyword=" + java.net.URLEncoder.encode(request.getParameter("keyword"), "UTF-8");
                }
                if (!queryString.isEmpty()) {
                    queryString = queryString.substring(1); // B? ký t? "&" ??u tiên
                    queryString = "?" + queryString;
                }

                // Nút Previous
                if (currentPage > 1) {
                    out.print("<a href='UserControllerServlet" + queryString + (queryString.isEmpty() ? "?" : "&") + "page=" + (currentPage - 1) + "'>Previous</a>");
                } else {
                    out.print("<a class='disabled'>Previous</a>");
                }

                // Các s? trang
                for (int i = 1; i <= totalPages; i++) {
                    if (i == currentPage) {
                        out.print("<a class='current'>" + i + "</a>");
                    } else {
                        out.print("<a href='UserControllerServlet" + queryString + (queryString.isEmpty() ? "?" : "&") + "page=" + i + "'>" + i + "</a>");
                    }
                }

                // Nút Next
                if (currentPage < totalPages) {
                    out.print("<a href='UserControllerServlet" + queryString + (queryString.isEmpty() ? "?" : "&") + "page=" + (currentPage + 1) + "'>Next</a>");
                } else {
                    out.print("<a class='disabled'>Next</a>");
                }
            %>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function confirmRedirect(link) {
            if (confirm('B?n có ch?c ch?n mu?n xóa?')) {
                window.location.href = link;
            }
        }
    </script>
</body>
</html>