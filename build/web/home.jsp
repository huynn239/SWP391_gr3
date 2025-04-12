<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Product, model.Brand, model.Category, model.Account, model.Slider, model.ProductImage, model.Color, model.Inventory" %>
<%@ page import="com.google.gson.Gson" %>
<jsp:useBean id="productDAO" class="dto.ProductDAO" scope="session"/>
<jsp:useBean id="brandDAO" class="dto.BrandDAO" scope="session"/>
<jsp:useBean id="categoryDAO" class="dto.CategoryDAO" scope="session"/>
<jsp:useBean id="sliderDAO" class="dto.SliderDAO" scope="session"/>
<jsp:useBean id="productimageDAO" class="dto.ProductImageDAO" scope="session"/>
<jsp:useBean id="colorDAO" class="dto.ColorDAO" scope="session"/>
<jsp:useBean id="inventoryDAO" class="dto.InventoryDAO" scope="session"/>
<%
    List<Product> products = productDAO.getAllProducts();
    List<Brand> brands = brandDAO.getAllBrands();
    List<Category> categories = categoryDAO.getAllCategories();
    Account user = (Account) session.getAttribute("u");
    List<ProductImage> productImages = productimageDAO.getAllImagesProduct();
    List<Color> colors = colorDAO.getAllColors();
    List<Inventory> inventoryList = new ArrayList<>();
    for (Product product : products) {
        inventoryList.addAll(inventoryDAO.getInventoryByProductId(product.getId()));
    }
    Gson gson = new Gson();
    List<Slider> allSliders = sliderDAO.getSlidersSorted(1, 3, "created_at", "DESC");
    List<Slider> activeSliders = new ArrayList<>();
    for (Slider slider : allSliders) {
        if (slider.isStatus()) {
            activeSliders.add(slider);
        }
    }
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
                                    <c:if test="${sessionScope.u.roleID == 1}">
                                        <li><a href="admin.jsp"><i class="fa fa-star"></i> Admin</a></li>
                                    </c:if>
                                    <c:if test="${sessionScope.u.roleID == 2}">
                                        <li><a href="sliderList"><i class="fa fa-star"></i> Marketing</a></li>
                                    </c:if>
                                    <c:if test="${sessionScope.u.roleID == 3}">
                                        <li><a href="sale.jsp"><i class="fa fa-star"></i> Sale</a></li>
                                    </c:if>
                                    <li><a href="cartcontroller"><i class="fa fa-shopping-cart"></i> Cart</a></li>
                                    <c:if test="${sessionScope.u.roleID == 1 || sessionScope.u.roleID == 2 || sessionScope.u.roleID == 3 || sessionScope.u.roleID == 4}">
                                        <li><a href="ProfileController?action=viewProfile&id=${sessionScope.u.id}"><i class="fa fa-user"></i> ${not empty sessionScope.u ? sessionScope.u.username : "Account"}</a></li>
                                    </c:if>
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
                                                <% int count1 = 0; %>
                                                <% for (Category category : categories) { %>
                                                    <% if (count1 % 6 == 0) { %>
                                                        <div class="category-column">
                                                    <% } %>
                                                    <a href="productlist?category=<%= category.getId() %>">
                                                        <%= category.getName() %>
                                                    </a>
                                                    <% count1++; %>
                                                    <% if (count1 % 6 == 0 || count1 == categories.size()) { %>
                                                        </div>
                                                    <% } %>
                                                <% } %>
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

        <!-- SLIDER -->
        <section id="slider">
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <div id="slider-carousel" class="carousel slide" data-ride="carousel">
                            <!-- Carousel Indicators -->
                            <ol class="carousel-indicators">
                                <% for (int i = 0; i < activeSliders.size(); i++) { %>
                                    <li data-target="#slider-carousel" data-slide-to="<%= i %>" class="<%= i == 0 ? "active" : "" %>"></li>
                                <% } %>
                            </ol>

                            <!-- Carousel Inner -->
                            <div class="carousel-inner">
                                <% 
                                    int index = 0;
                                    for (Slider slider : activeSliders) { 
                                %>
                                    <div class="item <%= index == 0 ? "active" : "" %>">
                                        <div class="col-sm-6">
                                            <h1><span>Men</span>-SHOPPER</h1>
                                            <h2>Featured Promotion</h2>
                                            <p>Check out our latest offers and deals!</p>
                                            <a href="<%= slider.getLink() %>" class="btn btn-default get">Get it now</a>
                                        </div>
                                        <div class="col-sm-6">
                                            <img src="<%= slider.getImageUrl() %>" class="girl img-responsive" alt="Slider Image" />
                                            <img src="images/home/pricing.png" class="pricing" alt="" />
                                        </div>
                                    </div>
                                <% 
                                    index++;
                                    } 
                                    if (activeSliders.isEmpty()) { 
                                %>
                                    <div class="item active">
                                        <div class="col-sm-6">
                                            <h1><span>Men</span>-SHOPPER</h1>
                                            <h2>NEW ARRIVALS</h2>
                                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
                                            <button type="button" class="btn btn-default get">Get it now</button>
                                        </div>
                                        <div class="col-sm-6">
                                            <img src="img/backpackMan.png" class="girl img-responsive" alt="" />
                                            <img src="img/feature1.png" class="pricing" alt="" />
                                        </div>
                                    </div>
                                <% } %>
                            </div>

                            <!-- Carousel Controls -->
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
        </section>

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
                        <div class="shipping text-center">
                            <img src="img/backpackMan.png" alt="Shipping Promotion" />
                        </div>
                    </div>

                    <!-- FEATURED PRODUCTS -->
                    <div class="col-sm-9 padding-right">
                        <div class="features_items">
                            <h2 class="title text-center">Featured Products</h2>
                            <div class="row">
                                <%
                                    int count = 0;
                                    for (Product product : products) { 
                                        if (count >= 6) break;
                                %>
                                    <div class="col-sm-4">
                                        <div class="product-image-wrapper">
                                            <div class="single-products">
                                                <div class="productinfo text-center">
                                                    <a href="productDetail.jsp?productId=<%= product.getId() %>">
                                                        <img src="<%= product.getImage() %>" alt="<%= product.getName() %>"/>
                                                    </a>
                                                    <h2>$<%= product.getPrice() %></h2>
                                                    <p><%= product.getName() %></p>

                                                    <!-- Nút "Add to cart" -->
                                                    <a href="<%= (user == null) ? "login.jsp" : "#" %>" 
                                                       class="btn btn-default add-to-cart"
                                                       <% if (user != null) { %>
                                                       onclick="openCartModal('<%= product.getId() %>',
                                                                       `<%= product.getName() %>`,
                                                                       '<%= product.getPrice() %>');
                                                               return false;"
                                                       <% } %>>
                                                        <i class="fa fa-shopping-cart"></i> Add to cart
                                                    </a>
                                                </div>

                                                <!-- Thêm thông báo -->
                                                <div id="orderSuccessMessage" class="order-success">Đặt hàng thành công</div>

                                                <!-- Modal -->
                                                <div id="cartModal" class="modal">
                                                    <div class="modal-dialog">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h2 class="modal-title">Add to Cart</h2>
                                                                <span class="close" onclick="closeCartModal()">×</span>
                                                            </div>
                                                            <div class="modal-body">
                                                                <form id="orderForm">
                                                                    <input type="hidden" id="productId" name="productId">
                                                                    <input type="hidden" id="price" name="price">
                                                                    <div class="product-modal-image">
                                                                        <img id="productImage" src="" alt="Product Image">
                                                                    </div>
                                                                    <p><strong>Product:</strong> <span id="productName"></span></p>
                                                                    <p><strong>Price:</strong> $<span id="productPrice"></span></p>

                                                                    <label for="color">Color:</label>
                                                                    <select name="color" id="color" onchange="updateCartImageAndQuantity()">
                                                                        <!-- Màu sẽ được load từ JS -->
                                                                    </select>

                                                                    <label for="size">Size:</label>
                                                                    <select name="size" id="size" onchange="updateCartImageAndQuantity()">
                                                                        <option value="1">S</option>
                                                                        <option value="2">M</option>
                                                                        <option value="3">L</option>
                                                                        <option value="4">XL</option>
                                                                    </select>

                                                                    <label for="quantity">Quantity:</label>
                                                                    <input type="number" name="quantity" id="quantity" min="1" value="1" onchange="checkQuantity()">

                                                                    <!-- Hiển thị số lượng tồn kho -->
                                                                    <p style="margin-top: 20px"><strong>Stock:</strong> <span id="stockQuantity">0</span></p>

                                                                    <div class="modal-footer">
                                                                        <button type="button" id="confirmButton" class="confirm" onclick="submitOrder()">Confirm</button>
                                                                        <button type="button" class="cancel" onclick="closeCartModal()">Cancel</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <style>
                                                    /* CSS cho thông báo */
                                                    .order-success {
                                                        display: none;
                                                        position: fixed;
                                                        bottom: 20px;
                                                        left: 20px;
                                                        background: black;
                                                        color: white;
                                                        padding: 10px 20px;
                                                        border-radius: 5px;
                                                        font-size: 16px;
                                                        z-index: 1000;
                                                    }
                                                </style>
                                            </div>
                                        </div>
                                    </div>
                                <%
                                        count++;
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
                                int brandCount = 0;
                                for (Brand brand : brands) { 
                                    if (brandCount >= 2) break;
                            %>
                                <li class="<%= (brandCount == 0) ? "active" : "" %>">
                                    <a href="#brand<%= brand.getId() %>" data-toggle="tab"><%= brand.getName() %></a>
                                </li>
                            <% brandCount++; } %>
                        </ul>
                    </div>

                    <div class="tab-content">
                        <% 
                            brandCount = 0;
                            for (Brand brand : brands) { 
                                if (brandCount >= 2) break;
                        %>
                            <div class="tab-pane fade <%= (brandCount == 0) ? "active in" : "" %>" id="brand<%= brand.getId() %>">
                                <div class="row">
                                    <%
                                        int productCount = 0;
                                        for (Product product : products) { 
                                            if (product.getBrandId().trim().equalsIgnoreCase(brand.getId().trim())) { 
                                                if (productCount >= 4) break;
                                                productCount++;
                                    %>
                                        <div class="col-sm-3">
                                            <div class="product-image-wrapper">
                                                <div class="single-products">
                                                    <div class="productinfo text-center">
                                                        <a href="productDetail.jsp?productId=<%= product.getId() %>">
                                                            <img src="<%= product.getImage() %>" alt="<%= product.getName() %>"/>
                                                        </a>
                                                        <h2>$<%= product.getPrice() %></h2>
                                                        <p><%= product.getName() %></p>
                                                        <a href="<%= (user == null) ? "login.jsp" : "#" %>" 
                                                           class="btn btn-default add-to-cart"
                                                           <% if (user != null) { %>
                                                           onclick="openCartModal('<%= product.getId() %>', `<%= product.getName() %>`, '<%= product.getPrice() %>');
                                                                   return false;"
                                                           <% } %>>
                                                            <i class="fa fa-shopping-cart"></i> Add to cart
                                                        </a>
                                                    </div>
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
                var productImages = <%= gson.toJson(productImages) %>;
                var colors = <%= gson.toJson(colors) %>;
                var inventoryList = <%= gson.toJson(inventoryList) %>;

                console.log("Danh sách màu:", colors);
                console.log("Danh sách ảnh sản phẩm:", productImages);
                console.log("Danh sách tồn kho:", inventoryList);

                function openCartModal(productId, productName, productPrice) {
                    document.getElementById("productId").value = productId;
                    document.getElementById("productName").innerText = productName;
                    document.getElementById("productPrice").innerText = productPrice;
                    document.getElementById("price").value = productPrice;

                    let colorSelect = document.getElementById("color");
                    colorSelect.innerHTML = ""; // Xóa danh sách cũ

                    let imageElement = document.getElementById("productImage");
                    imageElement.src = "default.jpg"; // Đặt hình ảnh mặc định

                    // Lọc danh sách ảnh theo productId
                    let images = productImages.filter(img => img.productId == productId);

                    if (images.length > 0) {
                        let uniqueColors = [...new Set(images.map(img => Number(img.colorId)))];
                        console.log("Màu sắc có sẵn cho sản phẩm này:", uniqueColors);
                        uniqueColors.forEach(colorId => {
                            let colorObj = colors.find(c => c.ID === colorId);
                            if (colorObj) {
                                let option = document.createElement("option");
                                option.value = colorObj.ID;
                                option.textContent = colorObj.colorName;
                                colorSelect.appendChild(option);
                            }
                        });
                        if (uniqueColors.length > 0) {
                            let firstColor = uniqueColors[0];
                            let firstImage = images.find(img => Number(img.colorId) === firstColor);
                            if (firstImage) {
                                imageElement.src = firstImage.imageUrl;
                            }
                        }
                    }

                    // Cập nhật số lượng tồn kho ban đầu
                    updateCartImageAndQuantity();

                    document.getElementById("cartModal").style.display = "block";
                }

                function updateCartImageAndQuantity() {
                    let selectedColor = document.getElementById("color").value;
                    let selectedSize = document.getElementById("size").value; // Đây là SizeID (1, 2, 3, 4)
                    let productId = document.getElementById("productId").value;
                    let imageElement = document.getElementById("productImage");
                    let stockElement = document.getElementById("stockQuantity");
                    let confirmButton = document.getElementById("confirmButton");

                    // Cập nhật hình ảnh
                    let image = productImages.find(img => img.productId == productId && img.colorId == selectedColor);
                    imageElement.src = image ? image.imageUrl : "default.jpg";

                    // Lấy số lượng tồn kho
                    let inventory = inventoryList.find(item => 
                        item.productId == productId && 
                        item.colorId == selectedColor && 
                        item.sizeId == selectedSize
                    );
                    let stock = inventory ? inventory.quantity : 0;
                    stockElement.innerText = stock;

                    // Kiểm tra số lượng tồn kho
                    if (stock <= 0) {
                        confirmButton.disabled = true;
                        confirmButton.innerText = "Out of Stock";
                    } else {
                        confirmButton.disabled = false;
                        confirmButton.innerText = "Confirm";
                    }

                    // Cập nhật số lượng tối đa có thể chọn
                    let quantityInput = document.getElementById("quantity");
                    quantityInput.max = stock; // Giới hạn số lượng tối đa
                    if (quantityInput.value > stock) {
                        quantityInput.value = stock; // Đặt lại số lượng nếu vượt quá
                    }
                }

                function checkQuantity() {
                    let quantityInput = document.getElementById("quantity");
                    let stock = parseInt(document.getElementById("stockQuantity").innerText);
                    let confirmButton = document.getElementById("confirmButton");

                    if (quantityInput.value > stock) {
                        quantityInput.value = stock;
                        alert("Số lượng vượt quá tồn kho!");
                    }

                    if (stock <= 0) {
                        confirmButton.disabled = true;
                        confirmButton.innerText = "Out of Stock";
                    } else {
                        confirmButton.disabled = false;
                        confirmButton.innerText = "Confirm";
                    }
                }

                function submitOrder() {
                    let quantity = parseInt(document.getElementById("quantity").value);
                    let stock = parseInt(document.getElementById("stockQuantity").innerText);

                    if (quantity > stock) {
                        alert("Số lượng vượt quá tồn kho!");
                        return;
                    }

                    let form = document.getElementById("orderForm");
                    let formData = new URLSearchParams(new FormData(form)).toString();
                    console.log("FormData:", formData);

                    fetch("order", {
                        method: "POST",
                        headers: {"Content-Type": "application/x-www-form-urlencoded"},
                        body: formData
                    })
                    .then(response => response.json())
                    .then(data => {
                        let message = document.getElementById("orderSuccessMessage");

                        if (data.status === "success") {
                            message.innerText = "Đặt hàng thành công!";
                            message.style.backgroundColor = "black";
                        } else {
                            message.innerText = data.message;
                            message.style.backgroundColor = "red";
                        }

                        message.style.display = "block";
                        setTimeout(() => {
                            message.style.display = "none";
                        }, 3000);

                        if (data.status === "success") {
                            closeCartModal();
                            // Cập nhật lại số lượng tồn kho (có thể gọi API để lấy dữ liệu mới)
                            updateCartImageAndQuantity();
                        }
                    })
                    .catch(error => console.error("Error:", error));
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
        </footer>

        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.scrollUp.min.js"></script>
        <script src="js/price-range.js"></script>
        <script src="js/jquery.prettyPhoto.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>