<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/responsive.css" rel="stylesheet">
    <style>
        .avatar-container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .avatar-preview {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #ddd;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"/>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h2 class="mb-4 text-center">Edit Profile</h2>

                <!-- Thông báo -->
                <c:if test="${not empty sessionScope.message}">
                    <div class="alert alert-info">${sessionScope.message}</div>
                    <c:remove var="message" scope="session"/>
                </c:if>

                <form action="ProfileController" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="action" value="updateProfile">
                    <input type="hidden" name="id" value="${user.id}">

                    <!-- Avatar -->
<!--                    <div class="avatar-container">
                        <img id="avatarPreview" 
                            src="<c:choose>
                                   <c:when test='${not empty user.avatar}'>
                                       <c:out value='/${user.avatar}' />
                                   </c:when>
                                   <c:otherwise>images/default-avatar.png</c:otherwise>
                                 </c:choose>" 
                            class="avatar-preview" alt="Avatar">
=
                        <input type="file" name="avatar" class="form-control" accept="image/*" onchange="previewImage(event)">
                    </div>-->

                    <div class="mb-3">
                        <label class="form-label">Name:</label>
                        <input type="text" name="uName" class="form-control" value="${user.uName}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Gender:</label>
                        <select name="gender" class="form-control">
                            <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Email:</label>
                        <input type="email" name="email" class="form-control" value="${user.email}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Mobile:</label>
                        <input type="tel" name="mobile" pattern="[0-9]{10,11}" class="form-control" value="${user.mobile}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Address:</label>
                        <input type="text" name="uAddress" class="form-control" value="${user.uAddress}" required>
                    </div>

                    <button type="submit" class="btn btn-success">
                        <i class="fa fa-save"></i> Update Profile
                    </button>
                    <button type="button" class="btn btn-primary" onclick="window.location.href='ProfileController?action=viewProfile'">
                        <i class="fa fa-times"></i> Cancel
                    </button>
                </form>

            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp"/>

    <script>
        function previewImage(event) {
            var reader = new FileReader();
            reader.onload = function() {
                var output = document.getElementById('avatarPreview');
                output.src = reader.result;
            }
            reader.readAsDataURL(event.target.files[0]);
        }
    </script>
</body>
</html>
