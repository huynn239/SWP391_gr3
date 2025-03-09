<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="model.Blog, model.Category, dto.BlogDAO, java.util.List" %>

<jsp:useBean id="blogDAO" class="dto.BlogDAO" scope="session"/>

<%
    // Lấy id từ request parameter
    String blogId = request.getParameter("id");
    Blog blog = null;
    if (blogId != null && !blogId.isEmpty()) {
        blog = blogDAO.getBlogById(blogId);
    }

    // Nếu không tìm thấy blog
    if (blog == null) {
        out.println("<p>Blog not found!</p>");
        return;
    }

    // Lấy danh sách Blog Categories
    List<Category> blogCategories = blogDAO.getAllBlogCategories();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title><%= blog.getTitle() %> | Blog Detail</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/prettyPhoto.css" rel="stylesheet">
    <link href="css/price-range.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/responsive.css" rel="stylesheet">

    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">

    <style>
        /* Cải thiện giao diện chung */
        body {
            font-family: 'Arial', sans-serif;
         
            color: #333;
        }

        .blog-detail img {
            max-width: 100%;
            height: auto;
            margin: 20px 0;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .blog-detail h1 {
            font-size: 32px;
            margin-bottom: 15px;
            color: #2c3e50;
            font-weight: 600;
        }

        .blog-detail .meta {
            font-size: 16px;
            color: #7f8c8d;
            margin-bottom: 25px;
        }

        .blog-detail .meta i {
            margin-right: 8px;
        }

        .blog-detail .content {
            font-size: 18px;
            line-height: 1.8;
            color: #444;
        }

        .blog-detail .btn-primary {
            background-color: #3498db;
            border-color: #3498db;
            padding: 10px 20px;
            font-size: 16px;
        }

        .blog-detail .btn-primary:hover {
            background-color: #2980b9;
            border-color: #2980b9;
        }

        /* Sidebar cải tiến */
        .left-sidebar {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .left-sidebar h2 {
            font-size: 24px;
            color: #2c3e50;
            margin-bottom: 15px;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }

        .panel-group {
            margin-top: 15px;
        }

        .panel-default {
            border: none;
            box-shadow: none;
        }

        .panel-heading {
            background-color: #fff;
            border-bottom: 1px solid #eee;
        }

        .panel-title a {
            color: #333;
            font-size: 16px;
            text-decoration: none;
        }

        .panel-title a:hover {
            color: #3498db;
            text-decoration: underline;
        }

        /* Contacts & Links cải tiến */
        .contacts-links {
            margin-top: 30px;
        }

        .contacts-links h2 {
            font-size: 24px;
        
            margin-bottom: 15px;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }

        .contacts-links a {
            display: block;
            margin-bottom: 12px;
    color: black;
            font-size: 16px;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .contacts-links a:hover {
            color: #2980b9;
            text-decoration: underline;
        }

        /* Footer */
        #footer {
          
            color: #666663;
            padding: 20px 0;
            margin-top: 40px;
        }

        #footer .pull-left, #footer .pull-right {
            font-size: 16px;
        }

        #footer a {
            
            text-decoration: underline;
        }

        #footer a:hover {
            color: #3498db;
        }
    </style>
</head>
<body>

    <!-- HEADER -->
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
                                    <c:if test="${sessionScope.u.roleID == 1 || sessionScope.u.roleID == 2 || sessionScope.u.roleID == 3 || sessionScope.u.roleID == 4}">
                                        <li><a href="changepassword"><i class="fa fa-user"></i> ${not empty sessionScope.u? sessionScope.u.getUsername() : "Account"}</a></li>
                                        </c:if>
                                        <c:if test="${sessionScope.u.roleID == 1}">
                                        <li><a href="UserControllerServlet"><i class="fa fa-star"></i> Admin</a></li>
                                        </c:if>
                                        <c:if test="${sessionScope.u.roleID == 2}">
                                        <li><a href="sliderList"><i class="fa fa-star"></i> Marketing </a></li>
                                        </c:if>
                                        <c:if test="${sessionScope.u.roleID == 3}">
                                        <li><a href="sale.jsp"><i class="fa fa-star"></i> Sale</a></li>
                                        </c:if>
                                    <li><a href="cartcontroller"><i class="fa fa-shopping-cart"></i> Cart</a></li>
                                    <li><a href="${not empty sessionScope.u? "logout" : "login"}"><i class="fa fa-lock"></i> ${not empty sessionScope.u? "Logout" : "Login"}</a></li>
                                </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="header-bottom">
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
                                <li><a href="home.jsp">Home</a></li>
                                <li class="dropdown"><a href="#">Shop<i class="fa fa-angle-down"></i></a>
                                    <ul role="menu" class="sub-menu">
                                        <li><a href="shop.html">Products</a></li>
                                        <li><a href="product-details.html">Product Details</a></li>
                                        <li><a href="checkout.html">Checkout</a></li>
                                        <li><a href="cart.html">Cart</a></li>
                                        <li><a href="login.html">Login</a></li>
                                    </ul>
                                </li>
                                <li><a href="blogList.jsp" class="active">Blog</a></li>
                                <li><a href="contact-us.html">Contact</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="search_box pull-right">
                            <input type="text" placeholder="Search"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <section id="slider"><!--slider-->
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <div id="slider-carousel" class="carousel slide" data-ride="carousel">
                        <ol class="carousel-indicators">
                            <li data-target="#slider-carousel" data-slide-to="0" class="active"></li>
                            <li data-target="#slider-carousel" data-slide-to="1"></li>
                            <li data-target="#slider-carousel" data-slide-to="2"></li>
                        </ol>

                        <div class="carousel-inner">
                            <div class="item active">
                                <div class="col-sm-6">
                                    <h1><span>Men</span>-SHOPPER</h1>
                                    <h2>NEW
                                        ARRIVALS</h2>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
                                    <button type="button" class="btn btn-default get">Get it now</button>
                                </div>
                                <div class="col-sm-6">
                                    <img src="img/backpackMan.png" class="girl img-responsive" alt="" />
                                    <img src="img/feature1.png" class="pricing" alt="" />
                                </div>
                            </div>
                            <div class="item">
                                <div class="col-sm-6">
                                    <h1><span>Men</span>-SHOPPER</h1>
                                    <h2>100% Responsive Design</h2>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
                                    <button type="button" class="btn btn-default get">Get it now</button>
                                </div>
                                <div class="col-sm-6">
                                    <img src="img/1000_F_192794300_bNE6gfWRqTyhQdcfOesxL7YHyrhkMo5n.jpg" class="girl img-responsive" alt="" />
                                    <img src="images/home/pricing.png" class="pricing" alt="" />
                                </div>
                            </div>

                            <div class="item">
                                <div class="col-sm-6">
                                    <h1><span>Men</span>-SHOPPER</h1>
                                    <h2>Free Ecommerce Template</h2>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </p>
                                    <button type="button" class="btn btn-default get">Get it now</button>
                                </div>
                                <div class="col-sm-6">
                                    <img src="images/home/girl3.jpg" class="girl img-responsive" alt="" />
                                    <img src="images/home/pricing.png" class="pricing" alt="" />
                                </div>
                            </div>
                        </div>

                        <a href="#slider-carousel" class="left control-carousel hidden-xs" data-slide="prev">
                            <i class="fa fa-angle-left"></i>
                        </a>
                        <a href="#slider-carousel" class="right control-carousel hidden-xs" data-slide="next">
                            <i class="fa fa-angle-right"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section><!--/slider-->

    <!-- MAIN CONTENT -->
    <section>
        <div class="container">
            <div class="row">

                <!-- SIDEBAR (Categories, Contacts/Links) -->
                <div class="col-sm-3">
                    <div class="left-sidebar">

                        <!-- Post Categories -->
                        <h2>Blog Categories</h2>
                        <div class="panel-group category-products">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a href="blogList.jsp" class="category-link">All Blogs</a>
                                    </h4>
                                </div>
                            </div>
                            <% for (Category category : blogCategories) { %>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a href="blogList.jsp?category=<%= category.getId() %>" class="category-link">
                                            <%= category.getName() %>
                                        </a>
                                    </h4>
                                </div>
                            </div>
                            <% } %>
                        </div>

                        <!-- Contacts & Links (Chuyên nghiệp hơn) -->
                        <div class="contacts-links">
                            <h2>Contact Information</h2>
                            <div class="contact-item">
                                <i class="fa fa-envelope"></i> 
                                <a href="mailto:support@menshop.com" class="contact-link">support@menshop.com</a>
                            </div>
                            <div class="contact-item">
                                <i class="fa fa-phone"></i> 
                                <a href="tel:+1234567890" class="contact-link">+1 (234) 567-890</a>
                            </div>
                            <div class="contact-item">
                                <i class="fa fa-globe"></i> 
                                <a href="https://menshop.com/about" target="_blank" class="contact-link">About Us</a>
                            </div>
                            <div class="contact-item">
                                <i class="fa fa-question-circle"></i> 
                                <a href="https://menshop.com/contact-us" target="_blank" class="contact-link">Contact Us</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- BLOG DETAIL CONTENT -->
                <div class="col-sm-9">
                    <div class="blog-detail">
                        <h1><%= blog.getTitle() %></h1>
                        <p class="meta">
                            <i class="fa fa-user"></i> Author: <%= blog.getAuthor() %> - 
                            <i class="fa fa-calendar"></i> Updated Date: <%= blog.getUploadDate() %> - 
                            <i class="fa fa-folder"></i> Category: 
                            <%
                                int categoryId = blog.getCateID();
                                Category category = blogDAO.getCategoryByCateID(categoryId);
                                out.print(category != null ? category.getName() : "Uncategorized");
                            %>
                        </p>
                        <img src="<%= blog.getBlogImage() %>" alt="<%= blog.getTitle() %>" class="img-responsive">
                        <div class="content">
                            <p><%= blog.getContent() %></p>
                        </div>
                        <%
                            String backPage = request.getParameter("page") != null ? request.getParameter("page") : "1";
                            String backCategory = request.getParameter("category");
                            String backUrl = "blogList.jsp?page=" + backPage + (backCategory != null ? "&category=" + backCategory : "");
                        %>
                        <a href="<%= backUrl %>" class="btn btn-primary btn-sm">Back to Blog List</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- FOOTER -->
    <footer id="footer"><!--Footer-->
            <div class="footer-top">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-2">
                            <div class="companyinfo">
                                <h2><span>Men</span>-shopper</h2>
                                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit,sed do eiusmod tempor</p>
                            </div>
                        </div>
                        <div class="col-sm-7">
                            <div class="col-sm-3">
                                <div class="video-gallery text-center">
                                    <a href="#">
                                        <div class="iframe-img">
                                            <img src="images/home/iframe1.png" alt="" />
                                        </div>
                                        <div class="overlay-icon">
                                            <i class="fa fa-play-circle-o"></i>
                                        </div>
                                    </a>
                                    <p>Circle of Hands</p>
                                    <h2>24 DEC 2014</h2>
                                </div>
                            </div>

                            <div class="col-sm-3">
                                <div class="video-gallery text-center">
                                    <a href="#">
                                        <div class="iframe-img">
                                            <img src="images/home/iframe2.png" alt="" />
                                        </div>
                                        <div class="overlay-icon">
                                            <i class="fa fa-play-circle-o"></i>
                                        </div>
                                    </a>
                                    <p>Circle of Hands</p>
                                    <h2>24 DEC 2014</h2>
                                </div>
                            </div>

                            <div class="col-sm-3">
                                <div class="video-gallery text-center">
                                    <a href="#">
                                        <div class="iframe-img">
                                            <img src="images/home/iframe3.png" alt="" />
                                        </div>
                                        <div class="overlay-icon">
                                            <i class="fa fa-play-circle-o"></i>
                                        </div>
                                    </a>
                                    <p>Circle of Hands</p>
                                    <h2>24 DEC 2014</h2>
                                </div>
                            </div>

                            <div class="col-sm-3">
                                <div class="video-gallery text-center">
                                    <a href="#">
                                        <div class="iframe-img">
                                            <img src="images/home/iframe4.png" alt="" />
                                        </div>
                                        <div class="overlay-icon">
                                            <i class="fa fa-play-circle-o"></i>
                                        </div>
                                    </a>
                                    <p>Circle of Hands</p>
                                    <h2>24 DEC 2014</h2>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="address">
                                <img src="images/home/map.png" alt="" />
                                <p>505 S Atlantic Ave Virginia Beach, VA(Virginia)</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="footer-widget">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-2">
                            <div class="single-widget">
                                <h2>Service</h2>
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="#">Online Help</a></li>
                                    <li><a href="#">Contact Us</a></li>
                                    <li><a href="#">Order Status</a></li>
                                    <li><a href="#">Change Location</a></li>
                                    <li><a href="#">FAQ’s</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="single-widget">
                                <h2>Quock Shop</h2>
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="#">T-Shirt</a></li>
                                    <li><a href="#">Mens</a></li>
                                    <li><a href="#">Womens</a></li>
                                    <li><a href="#">Gift Cards</a></li>
                                    <li><a href="#">Shoes</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="single-widget">
                                <h2>Policies</h2>
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="#">Terms of Use</a></li>
                                    <li><a href="#">Privecy Policy</a></li>
                                    <li><a href="#">Refund Policy</a></li>
                                    <li><a href="#">Billing System</a></li>
                                    <li><a href="#">Ticket System</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="single-widget">
                                <h2>About Shopper</h2>
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="#">Company Information</a></li>
                                    <li><a href="#">Careers</a></li>
                                    <li><a href="#">Store Location</a></li>
                                    <li><a href="#">Affillate Program</a></li>
                                    <li><a href="#">Copyright</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-3 col-sm-offset-1">
                            <div class="single-widget">
                                <h2>About Shopper</h2>
                                <form action="#" class="searchform">
                                    <input type="text" placeholder="Your email address" />
                                    <button type="submit" class="btn btn-default"><i class="fa fa-arrow-circle-o-right"></i></button>
                                    <p>Get the most recent updates from <br />our site and be updated your self...</p>
                                </form>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

            <div class="footer-bottom">
                <div class="container">
                    <div class="row">
                        <p class="pull-left">Copyright © 2013 Men-SHOPPER Inc. All rights reserved.</p>
                        <p class="pull-right">Designed by <span><a target="_blank" href="http://www.themeum.com">Themeum</a></span></p>
                    </div>
                </div>
            </div>
            <script>
                function openCartModal(id, name, price) {
                    console.log("Opening Modal for Product:", id, name, price); // Debug để kiểm tra dữ liệu
                    document.getElementById("productId").value = id;
                    document.getElementById("productName").innerText = name;
                    document.getElementById("productPrice").innerText = price;

                    document.querySelector("input[name='price']").value = price;

                    document.getElementById("cartModal").style.display = "flex";
                }

                function closeCartModal() {
                    document.getElementById("cartModal").style.display = "none";
                }


                window.onclick = function (event) {
                    let modal = document.getElementById("cartModal");
                    if (event.target === modal) {
                        closeCartModal();
                    }
                };

            </script>
        </footer><!--/Footer-->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.scrollUp.min.js"></script>
        <script src="js/price-range.js"></script>
        <script src="js/jquery.prettyPhoto.js"></script>
        <script src="js/main.js"></script>

</body>
</html>