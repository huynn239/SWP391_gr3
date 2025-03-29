<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <!-- Font Awesome cho biểu tượng -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/responsive.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f7fa;
            font-family: 'Roboto', sans-serif;
            min-height: 100vh;
            margin: 0;
            padding: 0;
        }
        .profile-container {
            max-width: 700px;
            margin: 50px auto;
            padding: 30px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .profile-avatar {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        .profile-avatar img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 4px solid #007bff;
            object-fit: cover;
        }
        .profile-card {
            padding: 20px;
            background: #f9f9f9;
            border-radius: 8px;
        }
        .profile-item {
            display: flex;
            align-items: center;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }
        .profile-item:last-child {
            border-bottom: none;
        }
        .profile-item i {
            font-size: 1.2rem;
            color: #007bff;
            margin-right: 15px;
        }
        .profile-item label {
            font-weight: 600;
            color: #333;
            width: 120px;
        }
        .profile-item span {
            color: #555;
            flex: 1;
        }
        .action-buttons {
            margin-top: 20px;
            text-align: center;
        }
        .action-buttons .btn {
            margin: 5px;
            padding: 10px 20px;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        .action-buttons .btn:hover {
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"/>

    <div class="container profile-container">
        <h2><i class="fas fa-user-circle"></i> User Profile</h2>

        <c:if test="${not empty message}">
            <div class="alert alert-success">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

<!--        <div class="profile-avatar">
            <img src="<c:choose>
                        <c:when test='${not empty user.avatar}'>
                            ${pageContext.request.contextPath}/${user.avatar}
                        </c:when>
                        <c:otherwise>
                            ${pageContext.request.contextPath}/images/default-avatar.png
                        </c:otherwise>
                     </c:choose>" alt="User Avatar">
        </div>-->

        <div class="profile-card">
            <div class="profile-item">
                <i class="fas fa-user"></i>
                <label>Name:</label>
                <span>${user.uName}</span>
            </div>
            <div class="profile-item">
                <i class="fas fa-envelope"></i>
                <label>Email:</label>
                <span>${user.email}</span>
            </div>
            <div class="profile-item">
                <i class="fas fa-user"></i>
                <label>Gender</label>
                <span>${user.gender}</span>
            </div>
            <div class="profile-item">
                <i class="fas fa-phone"></i>
                <label>Phone:</label>
                <span>${user.mobile}</span>
            </div>
            <div class="profile-item">
                <i class="fas fa-map-marker-alt"></i>
                <label>Address:</label>
                <span>${empty user.uAddress ? 'Not provided' : user.uAddress}</span>
            </div>
        </div>

        <div class="action-buttons">
            <a href="ProfileController?action=editProfile" class="btn btn-primary">Edit Profile</a>
                        <a href="changepassword.jsp" class="btn btn-primary">Change Password</a>

            <a href="MyOrderServlet" class="btn btn-primary">My Order</a>
        </div>
    </div>

    <jsp:include page="footer.jsp"/>
</body>
</html>