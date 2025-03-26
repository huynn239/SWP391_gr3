<%-- 
    Document   : AddSetting
    Created on : Mar 26, 2025, 5:29:20 PM
    Author     : thang
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${setting != null ? "Edit Setting" : "Add Setting"}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
        .btn-success, .btn-secondary {
            border-radius: 25px;
            padding: 8px 20px;
            transition: all 0.3s;
        }
        .btn-success:hover {
            background: #17a673;
            transform: translateY(-2px);
        }
        .btn-secondary:hover {
            background: #6c757d;
            transform: translateY(-2px);
        }
        .form-control {
            border-radius: 10px;
        }
    </style>
</head>
<body>
    <div class="container-fluid mt-4">
        <div class="card">
            <div class="card-header">
                <div class="d-flex justify-content-between align-items-center">
                    <h2 class="mb-0">${setting != null ? "Edit Setting" : "Add Setting"}</h2>
                    <a href="SettingController" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to Settings
                    </a>
                </div>
            </div>
            <div class="card-body">
                <c:if test="${not empty message}">
                    <div class="alert alert-info">${message}</div>
                </c:if>
                
                <form action="SettingController" method="post">
                    <input type="hidden" name="action" value="${setting != null ? "edit" : "add"}">
                    <c:if test="${setting != null}">
                        <input type="hidden" name="id" value="${setting.id}">
                    </c:if>

                    <div class="mb-3">
                        <label class="form-label">Type:</label>
                        <input type="text" name="type" class="form-control" value="${setting.type}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Value:</label>
                        <input type="text" name="value" class="form-control" value="${setting.value}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Order:</label>
                        <input type="number" name="order" class="form-control" value="${setting.order}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Description:</label>
                        <textarea name="description" class="form-control">${setting.description}</textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Status:</label>
                        <select name="status" class="form-control">
                            <option value="true" ${setting.status ? 'selected' : ''}>Active</option>
                            <option value="false" ${!setting.status ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>
                    
                    <div class="d-flex justify-content-end gap-2">
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-save me-2"></i>${setting != null ? "Update Setting" : "Add Setting"}
                        </button>
                        <a href="SettingController" class="btn btn-secondary">
                            <i class="fas fa-times me-2"></i>Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>