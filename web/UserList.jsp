<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User List | Admin</title>
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
        .no-data {
            text-align: center;
            padding: 20px;
            color: #888;
        }
        .control-panel {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .pagination {
            justify-content: center;
            margin-top: 20px;
        }
        .pagination a {
            border-radius: 20px;
            padding: 8px 16px;
            font-size: 1rem;
            color: #333;
            text-decoration: none;
            margin: 0 5px;
        }
        .pagination a:hover {
            background-color: #f1f3f8;
        }
        .pagination a.current {
            background-color: #6c5ce7;
            color: white;
        }
        .pagination a.disabled {
            color: #ccc;
            cursor: not-allowed;
        }
        .form-control {
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .form-group label {
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="container mt-4">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h2 class="mb-0">User List</h2>
                <div>
                    <a class="btn btn-primary me-2" href="admin.jsp"><i class="fas fa-arrow-left me-2"></i>Back to Dashboard</a>
                    <a class="btn btn-primary" href="UserControllerServlet?action=addPage"><i class="fas fa-plus me-2"></i>Add User</a>
                </div>
            </div>
            <div class="card-body">
                <!-- Filter and Search Form -->
                <div class="control-panel">
                    <form method="get" action="UserControllerServlet" class="d-flex flex-wrap align-items-center gap-2">
                        <input type="hidden" name="action" value="list">
                        <div class="form-group d-flex align-items-center me-3">
                            <label for="gender" class="me-2">Gender:</label>
                            <select name="gender" id="gender" class="form-control">
                                <option value="">All</option>
                                <option value="Male" ${param.gender == 'Male' ? 'selected' : ''}>Male</option>
                                <option value="Female" ${param.gender == 'Female' ? 'selected' : ''}>Female</option>
                            </select>
                        </div>
                        <div class="form-group d-flex align-items-center me-3">
                            <label for="roleId" class="me-2">Role:</label>
                            <select name="roleId" id="roleId" class="form-control">
                                <option value="">All</option>
                                <option value="1" ${param.roleId == '1' ? 'selected' : ''}>Admin</option>
                                <option value="2" ${param.roleId == '2' ? 'selected' : ''}>Marketing</option>
                                <option value="3" ${param.roleId == '3' ? 'selected' : ''}>Sale</option>
                            </select>
                        </div>
                        <div class="form-group d-flex align-items-center me-3">
                            <label for="status" class="me-2">Status:</label>
                            <select name="status" id="status" class="form-control">
                                <option value="">All</option>
                                <option value="1" ${param.status == '1' ? 'selected' : ''}>Active</option>
                                <option value="0" ${param.status == '0' ? 'selected' : ''}>Inactive</option>
                            </select>
                        </div>
                        <div class="form-group d-flex align-items-center me-3">
                            <label for="keyword" class="me-2">Search:</label>
                            <input type="text" name="keyword" id="keyword" class="form-control" placeholder="Name, Email, Phone" value="${param.keyword}">
                        </div>
                        <button type="submit" class="btn btn-success d-flex align-items-center">
                            <i class="fa fa-search me-1"></i>Search
                        </button>
                    </form>
                </div>

                <!-- Manual Pagination Logic -->
                <%
                    int usersPerPage = 6; // Number of users per page
                    java.util.List<model.Account> listU = (java.util.List<model.Account>) request.getAttribute("listU");
                    if (listU == null) {
                        listU = new java.util.ArrayList<>();
                    }
                    int totalUsers = listU.size(); // Total number of users
                    int totalPages = (int) Math.ceil((double) totalUsers / usersPerPage); // Total pages
                    int currentPage = 1; // Default current page
                    String pageParam = request.getParameter("page");
                    if (pageParam != null) {
                        try {
                            currentPage = Integer.parseInt(pageParam);
                        } catch (NumberFormatException e) {
                            currentPage = 1;
                        }
                    }
                    if (currentPage < 1) currentPage = 1;
                    if (currentPage > totalPages && totalPages > 0) currentPage = totalPages;

                    // Calculate start and end indices for the current page
                    int startIndex = (currentPage - 1) * usersPerPage;
                    int endIndex = Math.min(startIndex + usersPerPage, totalUsers);
                %>

                <!-- User List Table -->
                <div class="table-responsive">
                    <table id="userTable" class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Full Name</th>
                                <th>Gender</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty listU}">
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
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="8" class="no-data">No users found</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- Manual Pagination -->
                <div class="pagination">
                    <%
                        // Preserve current filter/search parameters
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
                            queryString = "?" + queryString.substring(1); // Remove leading "&"
                        }

                        // Previous button
                        if (currentPage > 1) {
                            out.print("<a href='UserControllerServlet" + queryString + (queryString.isEmpty() ? "?" : "&") + "page=" + (currentPage - 1) + "'>? Previous</a>");
                        } else {
                            out.print("<a class='disabled'>? Previous</a>");
                        }

                        // Page numbers
                        for (int i = 1; i <= totalPages; i++) {
                            if (i == currentPage) {
                                out.print("<a class='current'>" + i + "</a>");
                            } else {
                                out.print("<a href='UserControllerServlet" + queryString + (queryString.isEmpty() ? "?" : "&") + "page=" + i + "'>" + i + "</a>");
                            }
                        }

                        // Next button
                        if (currentPage < totalPages) {
                            out.print("<a href='UserControllerServlet" + queryString + (queryString.isEmpty() ? "?" : "&") + "page=" + (currentPage + 1) + "'>Next ?</a>");
                        } else {
                            out.print("<a class='disabled'>Next ?</a>");
                        }
                    %>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmRedirect(link) {
            if (confirm('Are you sure you want to delete?')) {
                window.location.href = link;
            }
        }
    </script>
</body>
</html>