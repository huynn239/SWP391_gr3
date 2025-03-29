<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Setting Detail</title>
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

        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            font-weight: bold;
            color: #555;
            margin-bottom: 5px;
            display: block;
        }

        .form-group input, .form-group textarea {
            width: 100%;
            padding: 10px;
            font-size: 14px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .form-group input[disabled], .form-group textarea[disabled] {
            background-color: #f5f5f5;
        }

        .btn-back, .btn-edit {
            background: #4e73df;
            border: none;
            border-radius: 25px;
            padding: 8px 20px;
            color: white;
            transition: all 0.3s;
        }

        .btn-back:hover, .btn-edit:hover {
            background: #2e59d9;
            transform: translateY(-2px);
        }

        .btn-edit {
            background: #f9bc24;
        }

        .btn-back {
            background: #858796;
            border: none;
            border-radius: 25px;
            padding: 8px 20px;
            color: white;
        }

        .error {
            color: red;
            text-align: center;
            font-weight: bold;
        }

    </style>
</head>
<body>

    <div class="container mt-4">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h2 class="mb-0">Setting Detail</h2>
                <a class="btn btn-back" href="SettingController">
                    <i class="fas fa-arrow-left me-2"></i> Back to Setting
                </a>
            </div>
            <div class="card-body">
                <div class="form-container">
                    <c:if test="${not empty setting}">
                        <form action="SettingDetail" method="post">
                            <input type="hidden" name="id" value="${setting.id}"/>
                            <input type="hidden" name="action" value="view"/>

                            <div class="form-group">
                                <label for="type">Role</label>
                                <input type="text" name="type" value="${setting.type}" disabled/>
                            </div>

                            <div class="form-group">
                                <label for="value">Username:</label>
                                <input type="text" name="value" value="${setting.value}" disabled/>
                            </div>

<!--                            <div class="form-group">
                                <label for="order">Order:</label>
                                <input type="number" name="order" value="${setting.order}" disabled/>
                            </div>-->

                            <div class="form-group">
                                <label for="description">Description:</label>
                                <textarea name="description" disabled>${setting.description}</textarea>
                            </div>

                            <div class="form-group">
                                <label for="status">Status:</label>
                                <input type="text" name="status" value="${setting.status ? 'Hoạt động' : 'Không hoạt động'}" disabled/>
                            </div>
                        </form>
                    </c:if>

                    <!-- Error Message if setting is not found -->
                    <c:if test="${empty setting}">
                        <p class="error">Setting not found.</p>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
