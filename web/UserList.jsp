<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách ng??i dùng | Admin</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container mt-4">
        <h2 class="text-center">UserList</h2>
        <div class="table-responsive">
            <table id="userTable" class="table table-bordered table-hover">
                <thead class="thead-dark">
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Address</th>
                        <th>Phone</th>
                        <th>Detail</th>
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
                                <a href="UserDetailServlet?id=${i.id}" class="btn btn-info btn-sm">Xem chi ti?t</a>
                            </td>
                            <td>
                                <a href="#" onclick="confirmRedirect('UserControllerServlet?action=delete&id=${i.id}')" class="btn btn-danger btn-sm">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#userTable').DataTable();
        });

        function confirmRedirect(link) {
            if(confirm('B?n có ch?c ch?n mu?n xóa?'))
                window.location.href = link;
        }
    </script>
</body>
</html>
