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
        /* Giữ nguyên các style cũ của bạn */
        .control-panel {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .search-container, .filter-container {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .search-container label, .filter-container label {
            font-weight: 600;
            color: #495057;
        }

        .search-container input, .filter-container select {
            border-radius: 5px;
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .btn-search {
            background-color: #4e73df;
            color: white;
            border: none;
            padding: 8px 20px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .btn-search:hover {
            background-color: #2e59d9;
        }

        #settingTable_filter {
            display: none;
        }

        /* Cải tiến giao diện bảng */
        .table-responsive {
            border-radius: 10px;
            overflow: hidden;
        }

        .table th, .table td {
            vertical-align: middle;
        }

        .badge {
            font-size: 0.9rem;
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
                        <a class="btn btn-secondary" href="admin.jsp">
                            <i class="fas fa-arrow-left me-2"></i>Back to Admin Dashboard
                        </a>
                    </div>
                </div>
            </div>
            <div class="control-panel">
                <div class="row align-items-center">
                    <div class="col-md-12">
                        <form action="SettingController" method="get" class="form-inline d-flex flex-wrap gap-3">
                            <div class="search-container">
                                <label for="keyword">Search:</label>
                                <input type="text" class="form-control" id="keyword" name="keyword" placeholder="Enter keyword..." value="${selectedKeyword}">
                                <button type="submit" class="btn btn-search"><i class="fa fa-search"></i> Search</button>
                            </div>
                            <div class="filter-container">
                                <label for="status">Status:</label>
                                <select name="status" id="status" class="form-control" onchange="this.form.submit()">
                                    <option value="">All</option>
                                    <option value="true" ${selectedStatus eq 'true' ? 'selected' : ''}>Active</option>
                                    <option value="false" ${selectedStatus eq 'false' ? 'selected' : ''}>Inactive</option>
                                </select>
                            </div>
                        </form>
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
                                <th>Role</th>
                                <th>Username</th>
<!--                                <th>Order</th>-->
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
<!--                                            <td>${setting.order}</td>-->
                                            <td>${setting.description}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${setting.status}"><span class="badge bg-success">Active</span></c:when>
                                                    <c:otherwise><span class="badge bg-danger">Inactive</span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <a href="SettingController?id=${setting.id}&action=view" class="btn btn-info btn-sm">
                                                    <i class="fas fa-eye me-1"></i>View
                                                </a>
                                                <a href="SettingController?id=${setting.id}&action=edit" class="btn btn-warning btn-sm">
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
                                        <td colspan="7" class="text-center">No settings found in the system</td>
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
                    "lengthMenu": "Show _MENU_ entries"
                }
            });
        });

        function confirmRedirect(link) {
            if (confirm('Are you sure you want to delete this setting?')) {
                window.location.href = link;
            }
        }
    </script>
    
</body>
</html>
