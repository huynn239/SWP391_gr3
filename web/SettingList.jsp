<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Setting Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding: 20px;
            font-family: 'Segoe UI', sans-serif;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .card-header {
            background: #4e73df;
            color: white;
            padding: 1.5rem;
            border-bottom: none;
        }
        .btn-primary {
            background: #4e73df;
            border: none;
            border-radius: 25px;
            padding: 8px 20px;
            transition: all 0.3s;
        }
        .btn-primary:hover {
            background: #2e59d9;
            transform: translateY(-2px);
        }
        .btn-back {
            background: #858796;
            border: none;
            border-radius: 25px;
            padding: 8px 20px;
            transition: all 0.3s;
        }
        .btn-back:hover {
            background: #6c757d;
            transform: translateY(-2px);
        }
        .table {
            background: white;
            border-radius: 10px;
            margin-bottom: 0;
        }
        .table thead th {
            background: #f8f9fc;
            color: #5a5c69;
            border-bottom: 2px solid #e3e6f0;
        }
        .table-hover tbody tr:hover {
            background-color: #f8f9fc;
            transition: background-color 0.2s;
        }
        .container-fluid {
            max-width: 1400px;
        }
        .no-data {
            text-align: center;
            padding: 20px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="card">
            <div class="card-header">
                <div class="d-flex justify-content-between align-items-center">
                    <h2 class="mb-0">Setting Management</h2>
                    <div>
                        <a class="btn btn-primary me-2" href="SettingController?action=add">
                            <i class="fas fa-plus me-2"></i>Add New Setting
                        </a>
                        <a class="btn btn-back" href="admin.jsp">
                            <i class="fas fa-arrow-left me-2"></i>Back to Admin Dashboard
                        </a>
                    </div>
                </div>
            </div>
            <div class="card-body p-0">
                <c:if test="${not empty message}">
                    <div class="alert alert-info m-3">${message}</div>
                </c:if>
                <div class="table-responsive">
                    <table id="settingTable" class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Type</th>
                                <th>Username</th>
                                <th>Order</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty settingList}">
                                    <c:forEach var="setting" items="${settingList}">
                                        <tr>
                                            <td>${setting.id}</td>
                                            <td>${setting.type}</td>
                                            <td>${setting.value}</td>
                                            <td>${setting.order}</td>
                                            <td>${setting.description}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${setting.status}"><span class="badge bg-success">Active</span></c:when>
                                                    <c:otherwise><span class="badge bg-danger">Inactive</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="SettingDetail?id=${setting.id}&action=edit" class="btn btn-info btn-sm">
                                                    <i class="fas fa-edit me-1"></i>Edit
                                                </a>
                                                <a href="#" onclick="confirmRedirect('DeleteSetting?id=${setting.id}')" class="btn btn-danger btn-sm">
                                                    <i class="fas fa-trash me-1"></i>Delete
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="7" class="no-data">No settings found in the system</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#settingTable').DataTable({
                "pageLength": 10,
                "lengthMenu": [5, 10, 25, 50],
                "language": {
                    "search": "Search settings:",
                    "lengthMenu": "Show _MENU_ entries"
                }
            });
        });

        function confirmRedirect(link) {
            if(confirm('Are you sure you want to delete this setting?')) {
                window.location.href = link;
            }
        }
    </script>
</body>
</html>
