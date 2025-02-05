<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product, model.Brand, model.Category" %>

<jsp:useBean id="productDAO" class="dto.ProductDAO" scope="session"/>
<jsp:useBean id="brandDAO" class="dto.BrandDAO" scope="session"/>
<jsp:useBean id="categoryDAO" class="dto.CategoryDAO" scope="session"/>

<%
    List<Product> products = productDAO.getAllProducts();
    List<Brand> brands = brandDAO.getAllBrands();
    List<Category> categories = categoryDAO.getAllCategories();
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Home | E-Shopper</title>
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
                                    <li><a href="#"><i class="fa fa-user"></i> Account</a></li>
                                    <li><a href="#"><i class="fa fa-star"></i> Wishlist</a></li>
                                    <li><a href="#"><i class="fa fa-shopping-cart"></i> Cart</a></li>
                                    <li><a href="#"><i class="fa fa-lock"></i> Login</a></li>
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
								<li><a href="index.html" class="active">Home</a></li>
								<li class="dropdown"><a href="#">Shop<i class="fa fa-angle-down"></i></a>
                                    <ul role="menu" class="sub-menu">
                                        <li><a href="shop.html">Products</a></li>
										<li><a href="product-details.html">Product Details</a></li> 
										<li><a href="checkout.html">Checkout</a></li> 
										<li><a href="cart.html">Cart</a></li> 
										<li><a href="login.html">Login</a></li> 
                                    </ul>
                                </li> 
								<li class="dropdown"><a href="#">Blog<i class="fa fa-angle-down"></i></a>
                                    <ul role="menu" class="sub-menu">
                                        <li><a href="blog.html">Blog List</a></li>
										<li><a href="blog-single.html">Blog Single</a></li>
                                    </ul>
                                </li> 
								<li><a href="404.html">404</a></li>
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
		</div><!--/header-bottom-->
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
                                        <img src="images/home/product1.jpg" class="girl img-responsive" alt="" />
                                        <img src="images/home/pricing.png"  class="pricing" alt="" />
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
                                        <img src="images/home/girl1.jpg" class="girl img-responsive" alt="" />
                                        <img src="images/home/pricing.png"  class="pricing" alt="" />
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

                            <!-- CATEGORY PANEL -->
                            <h2>Categories</h2>
                            <div class="panel-group category-products">
                                <% for (Category category : categories) { %>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a href="shop.jsp?category=<%= category.getId() %>">
                                                <%= category.getName() %>
                                            </a>
                                        </h4>
                                    </div>
                                </div>
                                <% } %>
                            </div>

                            <!-- BRAND PANEL -->
                            <h2>Brands</h2>
                            <div class="brands-name">
                                <ul class="nav nav-pills nav-stacked">
                                    <% for (Brand brand : brands) { %>
                                    <li><a href="shop.jsp?brand=<%= brand.getId() %>">
                                            <span class="pull-right">(10)</span> <%= brand.getName() %>
                                        </a></li>
                                        <% } %>
                                </ul>
                            </div>

                        </div>
                    </div>

                 \
                   <!-- FEATURED PRODUCTS -->
<div class="col-sm-9 padding-right">
    <div class="features_items">
        <h2 class="title text-center">Featured Products</h2>

        <div class="row">
            <%
                int count = 0; // Đếm số sản phẩm hiển thị
                for (Product product : products) { 
                    if (count >= 6) break; // Dừng vòng lặp nếu đã đủ 6 sản phẩm
            %>
            <div class="col-sm-4">
                <div class="product-image-wrapper">
                    <div class="single-products">
                        <div class="productinfo text-center">
                            <img src="<%= product.getImage() %>" alt="<%= product.getName() %>"/>
                            <h2>$<%= product.getPrice() %></h2>
                            <p><%= product.getName() %></p>
                            <a href="productDetail.jsp?id=<%= product.getId() %>" class="btn btn-default add-to-cart">
                                <i class="fa fa-shopping-cart"></i> Add to cart
                            </a>
                        </div>
                    </div>
                    <div class="choose">
                        <ul class="nav nav-pills nav-justified">
                            <li><a href="#"><i class="fa fa-plus-square"></i> Add to wishlist</a></li>
                            <li><a href="#"><i class="fa fa-plus-square"></i> Add to compare</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <%
                    count++; // Tăng biến đếm
                } 
            %>
        </div>

    </div>
</div>
        

                </div>
        <!-- SECTION FOR 2 SELECTED BRANDS -->
<div class="category-tab">
    <h2 class="title text-center">Shop By Brands</h2>
    
    <% 
        int brandCount = 0; // Đếm số brand đã hiển thị
        for (Brand brand : brands) { 
            if (brandCount >= 2) break; // Chỉ lấy 2 brand đầu tiên
            int productCount = 0; // Đếm số sản phẩm đã hiển thị của mỗi brand
    %>

    <h3 class="title"><%= brand.getName() %></h3>
    <div class="row">
        <% for (Product product : products) { 
            if (product.getBrandId() == brand.getId() && productCount < 4) { // Lọc sản phẩm theo brand
                productCount++; // Tăng số lượng sản phẩm hiển thị
        %>
        <div class="col-sm-3">
            <div class="product-image-wrapper">
                <div class="single-products">
                    <div class="productinfo text-center">
                        <img src="<%= product.getImage() %>" alt="<%= product.getName() %>"/>
                        <h2>$<%= product.getPrice() %></h2>
                        <p><%= product.getName() %></p>
                        <a href="productDetail.jsp?id=<%= product.getId() %>" class="btn btn-default add-to-cart">
                            <i class="fa fa-shopping-cart"></i> Add to cart
                        </a>
                    </div>
                </div>
                <div class="choose">
                    <ul class="nav nav-pills nav-justified">
                        <li><a href="#"><i class="fa fa-plus-square"></i> Add to wishlist</a></li>
                        <li><a href="#"><i class="fa fa-plus-square"></i> Add to compare</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <% 
            }
        } %>
    </div>

    <% brandCount++; } %>
</div>
            </div>
        </section>

        <!-- FOOTER -->
        <footer id="footer">
            <div class="footer-bottom">
                <div class="container">
                    <div class="row">
                        <p class="pull-left">Copyright © 2025 M-Shop. All rights reserved.</p>
                        <p class="pull-right">Designed by Themeum</p>
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
