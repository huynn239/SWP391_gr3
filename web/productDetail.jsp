<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList, java.util.List" %>
<%@ page import="model.Product, model.Brand, model.Category,model.Slider, model.Material, model.Account, model.Feedback" %>
<%@ page import="dto.ProductDAO, dto.BrandDAO, dto.CategoryDAO, dto.MaterialDAO, dto.FeedbackDAO" %>
<%@ page import="dto.ProductImageDAO, dto.ColorDAO, model.Color, model.ProductImage" %>
<%@ page import="com.google.gson.Gson" %>

<jsp:useBean id="productDAO" class="dto.ProductDAO" scope="session"/>
<jsp:useBean id="brandDAO" class="dto.BrandDAO" scope="session"/>
<jsp:useBean id="categoryDAO" class="dto.CategoryDAO" scope="session"/>
<jsp:useBean id="materialDAO" class="dto.MaterialDAO" scope="session"/>
<jsp:useBean id="productimageDAO" class="dto.ProductImageDAO" scope="session"/>
<jsp:useBean id="colorDAO" class="dto.ColorDAO" scope="session"/>
<jsp:useBean id="feedbackDAO" class="dto.FeedbackDAO" scope="session"/>
<jsp:useBean id="sliderDAO" class="dto.SliderDAO" scope="session"/>

<%
     List<Category> cate = categoryDAO.getAllCategories();
    String productIdStr = request.getParameter("productId");
    Product product = null;
    List<Feedback> feedbacks = null;
    List<ProductImage> productImages = null;
      List<Slider> allSliders = sliderDAO.getSlidersSorted(1, 3, "created_at","DESC"); 
    List<Slider> activeSliders = new ArrayList<>();
    for (Slider slider : allSliders) {
        if (slider.isStatus()) { 
            activeSliders.add(slider);
        }
    }

    if (productIdStr != null && !productIdStr.trim().isEmpty()) {
        try {
            int productId = Integer.parseInt(productIdStr);
            product = productDAO.getProductById(productId);
            feedbacks = feedbackDAO.getFeedbacksByProductId(productId);
            productImages = productimageDAO.getImagesByProductId(productId); // Lấy ảnh theo productId
            if (product != null) {
                    session.setAttribute("product", product); // Lưu vào session để sử dụng lại sau này
                }
            request.setAttribute("feedbacks", feedbacks);
        } catch (NumberFormatException e) {
            out.println("<p>Invalid product ID format!</p>");
            return;
        } catch (Exception e) {
            out.println("<p>Error retrieving product or feedbacks!</p>");
            e.printStackTrace();
            return;
        }
    }
            
        if (product == null) {
       product = (Product) session.getAttribute("product");
   }

   if (product == null) {
       out.println("<p style='color: red;'>Product not found!</p>");
       return;
   } else {
       session.setAttribute("product", product); 
   }
    
    Brand brand = brandDAO.getBrandById(product.getBrandId());
    List<Color> colors = colorDAO.getAllColors();
    Category category = categoryDAO.getCategoryById(product.getTypeId());
    List<Category> categories = categoryDAO.getAllCategories();
    Material material = materialDAO.getMaterialById(product.getMaterialId());
    Account user = (Account) session.getAttribute("u");
        if (user == null) {
                out.println("<p style='color: red;'>Bạn chưa đăng nhập!</p>");
                return;
}
    Gson gson = new Gson();
    String productImagesJson = gson.toJson(productImages);
    String colorsJson = gson.toJson(colors);
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <title><%= product.getName() %> | Men Shopper</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/font-awesome.min.css" rel="stylesheet">
        <link href="css/prettyPhoto.css" rel="stylesheet">
        <link href="css/price-range.css" rel="stylesheet">
        <link href="css/animate.css" rel="stylesheet">
        <link href="css/main.css" rel="stylesheet">
        <link href="css/responsive.css" rel="stylesheet">
        <link href="css/modal.css" rel="stylesheet">
        <link rel="shortcut icon" href="images/ico/favicon.ico">
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
                                    <c:if test="${sessionScope.u.roleID == 1 || sessionScope.u.roleID == 2 || sessionScope.u.roleID == 3 || sessionScope.u.roleID == 4}">
                                        <li><a href="changepassword"><i class="fa fa-user"></i> ${not empty sessionScope.u? sessionScope.u.getUsername() : "Account"}</a></li>
                                        </c:if>
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
                                    <li><a href="UserControllerServlet?action=viewProfile&id=${sessionScope.u.id}"><i class="fa fa-user"></i> ${not empty sessionScope.u ? sessionScope.u.username : "Account"}</a></li>
                                    <li><a href="${not empty sessionScope.u? 'logout' : 'login'}"><i class="fa fa-lock"></i> ${not empty sessionScope.u? 'Logout' : 'Login'}</a></li>
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
                                    <li class="menu-item">
                                        <a href="#">Product</a>
                                        <div class="sub-menu">
                                            <div class="category-container"> <!-- Bọc toàn bộ danh mục -->
                                                <% int count1 = 0; %>
                                                <% for (Category cates : cate) { %>
                                                <% if (count1 % 6 == 0) { %> <!-- Mỗi cột chứa tối đa 6 danh mục -->
                                                <div class="category-column">
                                                    <% } %>
                                                    <a href="productlist?category=<%= cates.getId() %>">
                                                        <%= cates.getName() %>
                                                    </a>
                                                    <% count1++; %>
                                                    <% if (count1 % 6 == 0 || count1 == cate.size()) { %>
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
            </div>
        </header>
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
                                        <h2>Featured Promotion</h2> <!-- Có thể thay bằng trường trong Slider nếu có -->
                                        <p>Check out our latest offers and deals!</p> <!-- Có thể thay bằng trường trong Slider nếu có -->
                                        <a href="<%= slider.getLink() %>" class="btn btn-default get">Get it now</a>
                                    </div>
                                    <div class="col-sm-6">
                                        <img src="<%= slider.getImageUrl() %>" class="girl img-responsive" alt="Slider Image" />
                                        <!-- Nếu cần hình pricing, có thể thêm logic kiểm tra hoặc để mặc định -->
                                        <img src="images/home/pricing.png" class="pricing" alt="" />
                                    </div>
                                </div>
                                <% 
                                    index++;
                                    } 
                                    // Nếu không có slider nào, hiển thị mặc định
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
        </section><!--/slider-->
        <!-- MAIN CONTENT -->
        <section>
            <div class="container">
                <div class="row">
                    <div class="col-sm-3">
                        <div class="left-sidebar">
                            <h2>Category</h2>
                            <div class="panel-group category-products">
                                <% for (Category cat : categories) { %>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a href="productlist?category=<%= cat.getId() %>">
                                                <%= cat.getName() %>
                                            </a>
                                        </h4>
                                    </div>
                                </div>
                                <% } %>
                            </div>
                            <div class="brands_products">
                                <h2>Brands</h2>
                                <div class="brands-name">
                                    <ul class="nav nav-pills nav-stacked">
                                        <% for (Brand b : brandDAO.getAllBrands()) { %>
                                        <li><a href="productlist?brand=<%= b.getId() %>"><span class="pull-right">(50)</span><%= b.getName() %></a></li>
                                            <% } %>
                                    </ul>
                                </div>
                            </div>
                            <div class="price-range">
                                <h2>Price Range</h2>
                                <div class="well">
                                    <input type="text" class="span2" value="" data-slider-min="0" data-slider-max="600" data-slider-step="5" data-slider-value="[250,450]" id="sl2">
                                    <br />
                                    <b>$ 0</b> <b class="pull-right">$ 600</b>
                                </div>
                            </div>
                            <div class="shipping text-center">
                                <img src="images/home/shipping.jpg" alt="Shipping" />
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-9 padding-right">
                        <div class="product-details">
                            <div class="col-sm-5">
                                <div class="view-product">
                                    <img id="productMainImage" src="<%= product.getImage() %>" alt="<%= product.getName() %>" class="img-responsive" />
                                </div>
                            </div>
                            <div class="col-sm-7">
                                <div class="product-information">
                                    <img src="images/product-details/new.jpg" class="newarrival" alt="New Arrival" />
                                    <h2><%= product.getName() %></h2>
                                    <p><strong>Web ID:</strong> <%= product.getId() %></p>
                                    <img src="images/product-details/rating.png" alt="Rating" />
                                    <span>
                                        <span> <%= product.getPrice() %>vnđ</span>
                                        <form id="addToCartForm" action="orderpdetail" method="POST" style="display:contents">
                                            <input type="hidden" name="productId" value="<%= product.getId() %>">
                                            <input type="hidden" name="productName" value="<%= product.getName() %>">
                                            <input type="hidden" name="price" value="<%= product.getPrice() %>">
                                            <label>Quantity:</label>
                                            <input type="number" name="quantity" min="1" value="1" id="quantity" required />
                                            <label>Size:</label>
                                            <select name="size" id="size" required>
                                                <option value="S">S</option>
                                                <option value="M">M</option>
                                                <option value="L">L</option>
                                                <option value="XL">XL</option>
                                            </select>
                                            <label for="color">Color:</label>
                                            <select name="color" id="color" onchange="updateCartImage()" required>
                                                <%
                                                    List<Integer> uniqueColorIds = new ArrayList<>();
                                                    for (ProductImage img : productImages) {
                                                        int colorId = img.getColorId();
                                                        if (!uniqueColorIds.contains(colorId)) {
                                                            uniqueColorIds.add(colorId);
                                                        }
                                                    }
                                                    for (Integer colorId : uniqueColorIds) {
                                                        Color color = colorDAO.getColorById(colorId);
                                                        if (color != null) {
                                                %>
                                                <option value="<%= color.getID() %>"><%= color.getColorName() %></option>
                                                <% 
                                                        }
                                                    } 
                                                %>
                                            </select>
                                            <br><br>
                                            <% if (user == null) { %>
                                            <a href="login.jsp" class="btn btn-default add-to-cart">
                                                <i class="fa fa-shopping-cart"></i> Add to Cart
                                            </a>
                                            <% } else { %>
                                            <button type="submit" class="btn btn-default add-to-cart">
                                                <i class="fa fa-shopping-cart"></i> Add to Cart
                                            </button>
                                            <% } %>
                                        </form>
                                    </span>
                                    <p><strong>Condition:</strong> New</p>
                                    <p><strong>Brand:</strong> <%= brand != null ? brand.getName() : "N/A" %></p>
                                    <p><strong>Category:</strong> <%= category != null ? category.getName() : "N/A" %></p>
                                    <p><strong>Material:</strong> <%= material != null ? material.getMname() : "N/A" %></p>
                                </div>
                            </div>
                        </div>

                        <div class="category-tab shop-details-tab">
                            <div class="col-sm-12">
                                <ul class="nav nav-tabs">
                                    <li><a href="#details" data-toggle="tab">Details</a></li>
                                    <li class="active"><a href="#reviews" data-toggle="tab">Reviews (<%= feedbacks != null ? feedbacks.size() : 0 %>)</a></li>
                                </ul>
                            </div>
                            <div class="tab-content">
                                <div class="tab-pane fade" id="details">
                                    <div class="col-sm-12">
                                        <h3>Product Details</h3>
                                        <p><%= product.getDetails() != null ? product.getDetails() : "No details available." %></p>
                                    </div>
                                </div>

                                <div class="tab-pane fade active in" id="reviews">
                                    <div class="col-sm-12">
                                        <c:choose>
                                            <c:when test="${empty feedbacks}">
                                                <p>Chưa có đánh giá nào cho sản phẩm này.</p>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="feedback" items="${feedbacks}">
                                                    <div class="feedback-item" style="margin-bottom: 20px; border-bottom: 1px solid #ddd; padding-bottom: 10px;">
                                                        <ul>
                                                            <li><a href="#"><i class="fa fa-user"></i>${feedback.fullName != null ? feedback.fullName : 'Ẩn danh'}</a></li>
                                                            <li><a href="#"><i class="fa fa-calendar-o"></i>N/A</a></li>
                                                        </ul>
                                                        <p><b>Đánh giá: </b>${feedback.ratedStar} <i class="fa fa-star" style="color: #f39c12;"></i></p>
                                                        <p>${feedback.comment}</p>
                                                    </div>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>

                                        <p><b>Viết đánh giá của bạn</b></p>
                                        <form action="submitFeedback" method="POST">
                                            <input type="hidden" name="productId" value="${product != null ? product.id : ''}">
                                            <span>
                                                <input type="text" name="fullName" placeholder="Tên của bạn" class="form-control" style="width: 45%; margin-right: 5%;" required/>
                                                <input type="email" name="email" placeholder="Địa chỉ email" class="form-control" style="width: 45%;" required/>
                                            </span>
                                            <input type="text" name="mobile" placeholder="Số điện thoại" class="form-control" style="width: 45%; margin-top: 10px;" required/>
                                            <textarea name="comment" placeholder="Đánh giá của bạn" class="form-control" rows="5" style="margin-top: 10px;" required></textarea>
                                            <b>Đánh giá: </b>
                                            <select name="ratedStar" class="form-control" style="width: 100px; display: inline-block;" required>
                                                <option value="1">1 sao</option>
                                                <option value="2">2 sao</option>
                                                <option value="3">3 sao</option>
                                                <option value="4">4 sao</option>
                                                <option value="5">5 sao</option>
                                            </select>
                                            <button type="submit" class="btn btn-default pull-right" style="margin-top: 10px;">
                                                Gửi đánh giá
                                            </button>
                                        </form>
                                    </div>
                                </div>
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
                                <h2>Newsletter</h2>
                                <form action="#" class="searchform">
                                    <input type="text" placeholder="Your email address" class="form-control" />
                                    <button type="submit" class="btn btn-default"><i class="fa fa-arrow-circle-o-right"></i></button>
                                    <p>Get the most recent updates from our site and stay updated!</p>
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

        <!-- SCRIPTS -->
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.scrollUp.min.js"></script>
        <script src="js/price-range.js"></script>
        <script src="js/jquery.prettyPhoto.js"></script>
        <script src="js/main.js"></script>
        <script>
                                                var productImages = <%= productImagesJson %>;
                                                var colors = <%= colorsJson %>;

                                                function updateCartImage() {
                                                    let selectedColor = document.getElementById("color").value;
                                                    let imageElement = document.getElementById("productMainImage");

                                                    let image = productImages.find(img => img.colorId == selectedColor);
                                                    imageElement.src = image ? image.imageUrl : "<%= product.getImage() %>";
                                                }

                                                window.onload = function () {
                                                    updateCartImage();
                                                };
        </script>
    </body>
</html>