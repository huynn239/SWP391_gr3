<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Blog List | E-Shopper</title>
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
        /* Tùy chỉnh phân trang */
        .pagination {
            display: inline-flex;
            list-style: none;
            padding-left: 0;
            margin-top: 20px;
        }

        .page-link {
            color: #000;
            padding: 8px 16px;
            text-decoration: none;
            border: 1px solid #ddd;
            margin: 0 4px;
            border-radius: 5px;
            background: white;
        }

        .page-link:hover {
            background-color: #f8f9fa;
            color: black;
            border-color: #007bff;
        }

        .page-link.active {
            background-color: #000;
            color: white;
            border-color: #007bff;
        }

        .page-link.disabled {
            color: #ccc;
            pointer-events: none;
        }

        .page-link:focus {
            box-shadow: none;
        }
        .blog-content h4 {
            display: -webkit-box;
            -webkit-line-clamp: 1;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 100%;
        }
        .search-bar, .sort-bar {
            margin-bottom: 20px;
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
                                    <li><a href="changepassword"><i class="fa fa-user"></i> ${not empty sessionScope.u ? sessionScope.u.getUsername() : "Account"}</a></li>
                                </c:if>
                                <c:if test="${sessionScope.u.roleID == 1}">
                                    <li><a href="UserControllerServlet"><i class="fa fa-star"></i> Admin</a></li>
                                </c:if>
                                <c:if test="${sessionScope.u.roleID == 2}">
                                    <li><a href="sliderList"><i class="fa fa-star"></i> Marketing</a></li>
                                </c:if>
                                <c:if test="${sessionScope.u.roleID == 3}">
                                    <li><a href="sale.jsp"><i class="fa fa-star"></i> Sale</a></li>
                                </c:if>
                                <li><a href="cartcontroller"><i class="fa fa-shopping-cart"></i> Cart</a></li>
                                <li><a href="${not empty sessionScope.u ? 'logout' : 'login'}"><i class="fa fa-lock"></i> ${not empty sessionScope.u ? 'Logout' : 'Login'}</a></li>
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
                                <li><a href="home.jsp" class="active">Home</a></li>
                                <li class="menu-item">
                                    <a href="#">Product</a>
                                    <div class="sub-menu">
                                        <div class="category-container">
                                            <c:forEach var="category" items="${categories}" varStatus="loop">
                                                <c:if test="${loop.index % 6 == 0}">
                                                    <div class="category-column">
                                                </c:if>
                                                <a href="productlist?category=${category.id}">${category.name}</a>
                                                <c:if test="${loop.index % 6 == 5 || loop.last}">
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
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
                <!-- SIDEBAR (CATEGORY + BRAND) -->
                <div class="col-sm-3">
                    <div class="left-sidebar">
                        <!-- CATEGORY PANEL (DANH MỤC BLOG) -->
                        <h2>Blog Categories</h2>
                        <div class="panel-group category-products">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        <a href="blogList">All Blogs</a>
                                    </h4>
                                </div>
                            </div>
                            <c:forEach var="category" items="${blogCategories}">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a href="blogList?category=${category.id}">${category.name}</a>
                                        </h4>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                 
                       
                        <div class="shipping text-center">
                            <img src="images/home/shipping.jpg" alt="" />
                        </div>
                    </div>
                </div>

                <!-- Blog List -->
                <div class="col-sm-9">
                    <h2 class="title text-center">Latest Blogs</h2>

                    <!-- Thanh tìm kiếm -->
                    <div class="search-bar">
                        <form action="blogList" method="GET">
                            <input type="text" name="keyword" value="${keyword}" placeholder="Search by category, title, content, or author..." style="width: 70%; padding: 8px;">
                            <button type="submit" class="btn btn-primary" style="margin: 0;padding: 8px 16px;">Search</button>
                            <c:if test="${not empty categoryParam}">
                                <input type="hidden" name="category" value="${categoryParam}">
                            </c:if>
                            <c:if test="${not empty sortBy}">
                                <input type="hidden" name="sortBy" value="${sortBy}">
                            </c:if>
                            <c:if test="${not empty sortOrder}">
                                <input type="hidden" name="sortOrder" value="${sortOrder}">
                            </c:if>
                        </form>
                    </div>

                    <!-- Nút sắp xếp theo bài viết mới nhất -->
                    <div class="sort-bar">
                        <form action="blogList" method="GET">
                            <button type="submit" class="btn btn-default" style="padding: 8px 16px;">
                                <i class="fa fa-clock-o"></i> Sort by Latest
                            </button>
                            <input type="hidden" name="sortBy" value="UploadDate">
                            <input type="hidden" name="sortOrder" value="DESC">
                            <c:if test="${not empty keyword}">
                                <input type="hidden" name="keyword" value="${keyword}">
                            </c:if>
                            <c:if test="${not empty categoryParam}">
                                <input type="hidden" name="category" value="${categoryParam}">
                            </c:if>
                        </form>
                    </div>

                    <!-- Danh sách blog -->
                    <div class="blog-sidebar">
                        <c:choose>
                            <c:when test="${empty blogs}">
                                <p>No blogs available.</p>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="blog" items="${blogs}">
                                    <div class="blog-item">
                                        <h4>
                                            <a href="blogDetail.jsp?id=${blog.id}" style="color: black; font-weight: bold;">
                                                ${blog.title}
                                            </a>
                                        </h4>
                                        <p><i class="fa fa-calendar"></i> ${blog.uploadDate} - <strong>Author: </strong>${blog.author}</p>
                                        <div class="blog-thumbnail">
                                            <img src="${blog.blogImage}" alt="${blog.title}" class="img-responsive">
                                        </div>
                                        <div class="blog-content">
                                            <h4>${blog.content}</h4>
                                            <a href="blogDetail.jsp?id=${blog.id}" class="btn btn-primary btn-sm">Read More</a>
                                        </div>
                                    </div>
                                    <hr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>

                        <!-- Pagination -->
                        <div class="pagination justify-content-center">
                            <c:if test="${currentPage > 1}">
                                <a class="page-link" href="blogList?page=${currentPage - 1}<c:if test='${not empty sortBy}'>&sortBy=${sortBy}</c:if><c:if test='${not empty sortOrder}'>&sortOrder=${sortOrder}</c:if><c:if test='${not empty keyword}'>&keyword=${keyword}</c:if><c:if test='${not empty categoryParam}'>&category=${categoryParam}</c:if>">Previous</a>
                            </c:if>

                            <c:forEach var="i" begin="1" end="${totalPages}">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <span class="page-link active">${i}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="page-link" href="blogList?page=${i}<c:if test='${not empty sortBy}'>&sortBy=${sortBy}</c:if><c:if test='${not empty sortOrder}'>&sortOrder=${sortOrder}</c:if><c:if test='${not empty keyword}'>&keyword=${keyword}</c:if><c:if test='${not empty categoryParam}'>&category=${categoryParam}</c:if>">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <a class="page-link" href="blogList?page=${currentPage + 1}<c:if test='${not empty sortBy}'>&sortBy=${sortBy}</c:if><c:if test='${not empty sortOrder}'>&sortOrder=${sortOrder}</c:if><c:if test='${not empty keyword}'>&keyword=${keyword}</c:if><c:if test='${not empty categoryParam}'>&category=${categoryParam}</c:if>">Next</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- FOOTER -->
    <footer id="footer">
        <div class="footer-top">
            <div class="container">
                <div class="row">
                    <div class="col-sm-2">
                        <div class="companyinfo">
                            <h2><span>Men</span>-shopper</h2>
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor</p>
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
                            <h2>Quick Shop</h2>
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
                                <li><a href="#">Privacy Policy</a></li>
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
                                <li><a href="#">Affiliate Program</a></li>
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
    </footer>

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.scrollUp.min.js"></script>
    <script src="js/price-range.js"></script>
    <script src="js/jquery.prettyPhoto.js"></script>
    <script src="js/main.js"></script>
</body>
</html>