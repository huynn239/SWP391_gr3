<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Product, model.Brand, model.Category, model.Account,model.Slider,model.ProductImage,model.Color,model.ProductSize" %>
<%@ page import="com.google.gson.Gson" %>
<jsp:useBean id="productDAO" class="dto.ProductDAO" scope="session"/>
<jsp:useBean id="brandDAO" class="dto.BrandDAO" scope="session"/>
<jsp:useBean id="categoryDAO" class="dto.CategoryDAO" scope="session"/>
<jsp:useBean id="sliderDAO" class="dto.SliderDAO" scope="session"/>
<jsp:useBean id="productimageDAO" class="dto.ProductImageDAO" scope="session"/>
<jsp:useBean id="colorDAO" class="dto.ColorDAO" scope="session"/>
<%
    List<Product> products = productDAO.getAllProducts();
    List<Brand> brands = brandDAO.getAllBrands();
    List<Category> categories = categoryDAO.getAllCategories();
    Account user = (Account) session.getAttribute("u");
    List<ProductImage> productImages = productimageDAO.getAllImagesProduct();
    List<Color> colors = colorDAO.getAllColors();
    Gson gson = new Gson();
    List<Slider> allSliders = sliderDAO.getSlidersSorted(1, 3, "created_at","DESC"); 
    List<Slider> activeSliders = new ArrayList<>();
    for (Slider slider : allSliders) {
        if (slider.isStatus()) { 
            activeSliders.add(slider);
        }
    }
    List<ProductSize> lists = productDAO.getProductSizes();
    String productSizeJson = gson.toJson(lists);
%>
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
   <header id="header">
            <div class="header-middle">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="logo pull-left">
                                <h1>Men Shop</h1>
                            </div>
                        </div>
                        <div class="col-sm-8">
                            <div class="shop-menu pull-right">
                                <ul class="nav navbar-nav">

                                    <c:if test="${sessionScope.u.roleID == 1}">
                                        <li><a href="admin.jsp"><i class="fa fa-star"></i> Admin</a></li>
                                        </c:if>
                                        <c:if test="${sessionScope.u.roleID == 2}">
                                        <li><a href="sliderList"><i class="fa fa-star"></i> Marketing </a></li>
                                        </c:if>
                                        <c:if test="${sessionScope.u.roleID == 3}">
                                        <li><a href="sale.jsp"><i class="fa fa-star"></i> Sale</a></li>
                                        </c:if>       
                                    <li><a href="cartcontroller"><i class="fa fa-shopping-cart"></i> Cart</a></li>
                                        <c:if test="${sessionScope.u.roleID == 1 || sessionScope.u.roleID == 2 || sessionScope.u.roleID == 3 || sessionScope.u.roleID == 4}">
                                        <li><a href="ProfileController?action=viewProfile&id=${sessionScope.u.id}"><i class="fa fa-user"></i> ${not empty sessionScope.u ? sessionScope.u.username : "Account"}</a></li>
                                        </c:if>
                                    <li><a href="${not empty sessionScope.u? "logout" : "login"}"><i class="fa fa-lock"></i> ${not empty sessionScope.u? "Logout" : "Login"}</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="header-bottom"><!--header-bottom-->

                <div class="container">
                    <div class="row">
                        <div class="col-sm-9">
                            <div class="navbar-header">
                                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                                    <span class="sr-only">Toggle navigation</span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                            </div>
                            <div class="mainmenu pull-left">
                                <ul class="nav navbar-nav collapse navbar-collapse">
                                    <li><a href="home.jsp" class="active">Home</a></li>
                                    <li class="menu-item">
                                        <a href="#">Product</a>
                                        <div class="sub-menu">
                                            <div class="category-container"> <!-- Bọc toàn bộ danh mục -->
                                                <% int count1 = 0; %>
                                                <% for (Category category : categories) { %>
                                                <% if (count1 % 6 == 0) { %> <!-- Mỗi cột chứa tối đa 6 danh mục -->
                                                <div class="category-column">
                                                    <% } %>
                                                    <a href="productlist?category=<%= category.getId() %>">
                                                        <%= category.getName() %>
                                                    </a>
                                                    <% count1++; %>
                                                    <% if (count1 % 6 == 0 || count1 == categories.size()) { %>
                                                </div> <!-- Đóng cột khi đủ 6 danh mục hoặc hết danh mục -->
                                                <% } %>
                                                <% } %>
                                            </div> <!-- Kết thúc category-container -->
                                        </div>
                                    </li>





                                    <li><a href="blogList"><i class="dropdown fa fa-newspaper-o"></i> Blog</a></li>


                                    <li><a href="404.html">404</a></li>
                                    <li><a href="contact-us.html">Contact</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <form action="productsearch" method="GET" class="search_box pull-right">
                                <input type="text" name="query" placeholder="Search" required />
                            </form>
                        </div>
                    </div>
                </div>
            </div><!--/header-bottom-->




        </header>

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
