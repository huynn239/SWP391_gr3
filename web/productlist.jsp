<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.ArrayList" %>

<%@ page import="model.Product, model.Brand, model.Category, model.Material,model.Account" %>

<jsp:useBean id="productDAO" class="dto.ProductDAO" scope="session"/>
<jsp:useBean id="brandDAO" class="dto.BrandDAO" scope="session"/>
<jsp:useBean id="categoryDAO" class="dto.CategoryDAO" scope="session"/>
<jsp:useBean id="materialDAO" class="dto.MaterialDAO" scope="session"/>

<%
    String category = (String)request.getParameter("category");
    int cate = Integer.parseInt(category);
    List<Product> products = productDAO.getAllProductCat(cate);
    List<Brand> brands = brandDAO.getAllBrands();
    List<Category> categories = categoryDAO.getAllCategories();
    List<Material> materials = materialDAO.getAllMaterial();
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
                                    <li><a href="home.jsp" class="active">Home</a></li>
                                    <li class="menu-item">
                                        <a href="#">Product</a>
                                        <div class="sub-menu">
                                            <div class="category-container"> 
                                                <% int count1 = 0; %>
                                                <% for (Category cat : categories) { %>
                                                <% if (count1 % 6 == 0) { %> 
                                                <div class="category-column">
                                                    <% } %>
                                                    <a href="productlist?category=<%= cat.getId() %>">
                                                        <%= cat.getName() %>
                                                    </a>
                                                    <% count1++; %>
                                                    <% if (count1 % 6 == 0 || count1 == categories.size()) { %>
                                                </div> 
                                                <% } %>
                                                <% } %>
                                            </div> 
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
                    <%
    String categoryParam = request.getParameter("category");
    if (categoryParam == null) {
        categoryParam = "";
    }
                    %>

                    <!-- SIDEBAR (CATEGORY + BRAND) -->
                    <div class="col-sm-3">
                        <div class="left-sidebar">

                            <h2>Material</h2>
                            <div class="panel-group category-products">
                                <form id="filterForm" action="productfilter" method="GET">
                                    <input type="hidden" name="category" value="<%= categoryParam %>">
                                    <ul class="nav nav-pills nav-stacked">
                                        <% for (Material mat : materials) { %>
                                        <li>
                                            <input type="checkbox" name="material" value="<%= mat.getMid() %>" 
                                                   <%= request.getParameterValues("material") != null && 
                         Arrays.asList(request.getParameterValues("material")).contains(String.valueOf(mat.getMid())) ? "checked" : "" %> 
                                                   onchange="submitFilterForm()">
                                            <%= mat.getMname() %>
                                        </li>
                                        <% } %>
                                    </ul>
                                    <br>
                                    <h2>Brands</h2>
                                    <div class="brands-name">
                                        <ul class="nav nav-pills nav-stacked">
                                            <% for (Brand brand : brands) { %>
                                            <li>
                                                <input type="checkbox" name="brand" value="<%= brand.getId() %>" 
                                                       <%= request.getParameterValues("brand") != null && 
                             Arrays.asList(request.getParameterValues("brand")).contains(brand.getId()) ? "checked" : "" %> 
                                                       onchange="submitFilterForm()">
                                                <%= brand.getName() %>
                                            </li>
                                            <% } %>
                                        </ul>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <script>
                        function submitFilterForm() {
                            document.getElementById("filterForm").submit();
                        }
                    </script>


                    <!-- FEATURED PRODUCTS -->
                    <div class="col-sm-9 padding-right">
                        <div class="features_items">
                            <h2 class="title text-center">Featured Products</h2>
                            <%
    List<Product> filteredProducts = (List<Product>) request.getAttribute("filteredProducts");
    if (filteredProducts == null) {
        if (categoryParam != null) {
            filteredProducts = productDAO.getAllProductCat(cate);
        } else {
            filteredProducts = productDAO.getAllProducts();
        }
    }
    if (filteredProducts == null) {
        filteredProducts = new ArrayList<>();
    }
    int currentPage = (request.getAttribute("currentPage") != null) ? (int) request.getAttribute("currentPage") : 1;
    int totalPages = (request.getAttribute("totalPages") != null) ? (int) request.getAttribute("totalPages") : 1;
                            %>
                            <div class="row">
                                <div class="product-list">
                                    <% for (Product p : filteredProducts) { %>
                                    <div class="col-sm-4">
                                        <div class="product-image-wrapper">
                                            <div class="single-products">
                                                <div class="productinfo text-center">
                                                    <img src="<%= p.getImage() %>" alt="<%= p.getName() %>"/>
                                                    <h2>$<%= p.getPrice() %></h2>
                                                    <p><%= p.getName() %></p>
                                                    <a href="<%= (user == null) ? "login.jsp" : "#" %>" 
                                                       class="btn btn-default add-to-cart"
                                                       <% if (user != null) { %>
                                                       onclick="openCartModal('<%= p.getId() %>', `<%= p.getName() %>`, '<%= p.getPrice() %>', '<%= p.getTypeId() %>'); return false;"
                                                       <% } %>>
                                                        <i class="fa fa-shopping-cart"></i> Add to cart
                                                    </a>
                                                </div>
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
                                                                    <input type="hidden" name="price" value="<%= p.getPrice() %>">
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
                                        </div>
                                    </div>
                                    <% } %>
                                </div>
                            </div>



                            <!-- Phân trang -->
                            <%
  
    String queryString = request.getQueryString(); // Lấy các tham số hiện tại trên URL
    String baseUrl = "productfilter"; // Servlet xử lý lọc sản phẩm
    String pageUrl = baseUrl + (queryString != null ? "?" + queryString.replaceAll("&?page=\\d+", "") : "?");
                            %>

                            <div class="pagination">
                                <ul class="pagination">
                                    <% if (currentPage > 1) { %>
                                    <li><a href="<%= pageUrl %>&page=<%= currentPage - 1 %>">&laquo; Previous</a></li>
                                        <% } %>

                                    <% for (int i = 1; i <= totalPages; i++) { %>
                                    <li class="<%= (i == currentPage) ? "active" : "" %>">
                                        <a href="<%= pageUrl %>&page=<%= i %>"><%= i %></a>
                                    </li>
                                    <% } %>

                                    <% if (currentPage < totalPages) { %>
                                    <li><a href="<%= pageUrl %>&page=<%= currentPage + 1 %>">Next &raquo;</a></li>
                                        <% } %>
                                </ul>
                            </div>

                        </div>
                    </div>
                </div>   
            </div> 
        </section>
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

        </footer><!--/Footer-->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.scrollUp.min.js"></script>
        <script src="js/price-range.js"></script>
        <script src="js/jquery.prettyPhoto.js"></script>
        <script src="js/main.js"></script>

    </body>
</html>
