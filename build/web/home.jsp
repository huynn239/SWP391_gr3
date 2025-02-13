<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product, model.Brand, model.Category, model.Account" %>

<jsp:useBean id="productDAO" class="dto.ProductDAO" scope="session"/>
<jsp:useBean id="brandDAO" class="dto.BrandDAO" scope="session"/>
<jsp:useBean id="categoryDAO" class="dto.CategoryDAO" scope="session"/>

<%
    List<Product> products = productDAO.getAllProducts();
    List<Brand> brands = brandDAO.getAllBrands();
    List<Category> categories = categoryDAO.getAllCategories();
    Account user = (Account) session.getAttribute("u");
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
        <link href="css/modal.css" rel="stylesheet">
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
                                    <li><a href="#"><i class="fa fa-user"></i> ${not empty sessionScope.u? sessionScope.u.getuName() : "Account"}</a></li>
                                    <li><a href="#"><i class="fa fa-star"></i> Wishlist</a></li>
                                    <li><a href="#"><i class="fa fa-shopping-cart"></i> Cart</a></li>
                                    <li><a href="${not empty sessionScope.u? "logout" : "login.jsp"}"><i class="fa fa-lock"></i> ${not empty sessionScope.u? "Logout" : "Login"}</a></li>
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
                            <form action="productsearch" method="GET" class="search_box pull-right">
                                <input type="text" name="query" placeholder="Search" required />
                            </form>
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
                                        <img src="img/backpackMan.png" class="girl img-responsive" alt="" />
                                        <img src="img/feature1.png"  class="pricing" alt="" />
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
                                            <a href="productlist?category=<%= category.getId() %>">
                                                <%= category.getName() %>
                                            </a>
                                        </h4>
                                    </div>
                                </div>
                                <% } %>
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

                                                <!-- Nút "Add to cart" -->
                                                <a href="<%= (user == null) ? "login.jsp" : "#" %>" 
                                                   class="btn btn-default add-to-cart"
                                                   <% if (user != null) { %>
                                                   onclick="openCartModal('<%= product.getId() %>', `<%= product.getName() %>`, '<%= product.getPrice() %>', '<%= product.getTypeId() %>'); return false;"
                                                   <% } %>>
                                                    <i class="fa fa-shopping-cart"></i> Add to cart
                                                </a>

                                            </div>

                                            <!-- Modal -->
                                            <div id="cartModal" class="modal">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h2 class="modal-title">Add to Cart</h2>
                                                            <span class="close" onclick="closeCartModal()">&times;</span>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form action="order" method="post">
                                                                <input type="hidden" id="productId" name="productId">
                                                                <input type="hidden" name="price" value="<%= product.getPrice() %>">
                                                                <p><strong>Product:</strong> <span id="productName"></span></p>
                                                                <p><strong>Price:</strong> $<span id="productPrice"></span></p>

                                                                <!-- Chọn size dựa theo TypeId -->

                                                                <label for="size">Size:</label>
                                                                <select name="size" id="size">
                                                                    <option value="S">S</option>
                                                                    <option value="M">M</option>
                                                                    <option value="L">L</option>
                                                                    <option value="XL">XL</option>
                                                                </select>
                                                                <label for="quantity">Quantity:</label>
                                                                <input type="number" name="quantity" id="quantity" min="1" value="1">

                                                                <div class="modal-footer">
                                                                    <button type="submit" class="confirm">Confirm</button>
                                                                    <button type="button" class="cancel" onclick="closeCartModal()">Cancel</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
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

                    <div class="col-sm-12">
                        <ul class="nav nav-tabs">
                            <% 
                                int brandCount = 0; // Khai báo biến một lần duy nhất
                                for (Brand brand : brands) { 
                                    if (brandCount >= 2) break; // Chỉ lấy 2 thương hiệu đầu tiên
                            %>
                            <li class="<%= (brandCount == 0) ? "active" : "" %>">
                                <a href="#brand<%= brand.getId() %>" data-toggle="tab"><%= brand.getName() %></a>
                            </li>
                            <% brandCount++; } %>
                        </ul>
                    </div>

                    <div class="tab-content">
                        <% 
                            brandCount = 0; // Reset lại biến để dùng tiếp
                            for (Brand brand : brands) { 
                                if (brandCount >= 2) break; // Chỉ lấy 2 thương hiệu đầu tiên
                        %>
                        <div class="tab-pane fade <%= (brandCount == 0) ? "active in" : "" %>" id="brand<%= brand.getId() %>">
                            <div class="row">
                                <%
                                    int productCount = 0;
                                    for (Product product : products) { 
                                        if (product.getBrandId().trim().equalsIgnoreCase(brand.getId().trim())) { 
                                            if (productCount >= 4) break; // Chỉ hiển thị 4 sản phẩm của mỗi brand
                                            productCount++;
                                %>
                                <div class="col-sm-3">
                                    <div class="product-image-wrapper">
                                        <div class="single-products">
                                            <div class="productinfo text-center">
                                                <img src="<%= product.getImage() %>" alt="<%= product.getName() %>" class="img-responsive"/>
                                                <h2>$<%= product.getPrice() %></h2>
                                                <p><%= product.getName() %></p>
                                                <a href="<%= (user == null) ? "login.jsp" : "#" %>" 
                                                   class="btn btn-default add-to-cart"
                                                   <% if (user != null) { %>
                                                   onclick="openCartModal('<%= product.getId() %>', `<%= product.getName() %>`, '<%= product.getPrice() %>', '<%= product.getTypeId() %>'); return false;"
                                                   <% } %>>
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
                                    } 
                                %>

                                <!-- Nếu không có sản phẩm nào, hiển thị thông báo -->
                                <% if (productCount == 0) { %>
                                <div class="col-sm-12">
                                    <p class="text-center">No products available for <%= brand.getName() %></p>
                                </div>
                                <% } %>
                            </div>
                        </div>
                        <% brandCount++; } %>
                    </div>
                </div>
        </section>
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
