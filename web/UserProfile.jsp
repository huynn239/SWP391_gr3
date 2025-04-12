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
    <title>User Profile</title>
    <!-- Font Awesome cho biểu tượng -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/responsive.css" rel="stylesheet">
     <link href="css/modal.css" rel="stylesheet">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
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
            <a href="home.jsp" class="btn btn-primary">Back to HomePage</a>
        </div>
    </div>

    <jsp:include page="footer.jsp"/>
</body>
</html>