<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="model.Product, model.Brand, model.Category, model.Material, model.Account" %>
<%@ page import="dto.ProductDAO, dto.BrandDAO, dto.CategoryDAO, dto.MaterialDAO" %>

<jsp:useBean id="productDAO" class="dto.ProductDAO" scope="session"/>
<jsp:useBean id="brandDAO" class="dto.BrandDAO" scope="session"/>
<jsp:useBean id="categoryDAO" class="dto.CategoryDAO" scope="session"/>
<jsp:useBean id="materialDAO" class="dto.MaterialDAO" scope="session"/>

<%
    // Lấy tham số "id" từ URL (khớp với liên kết trong productlist.jsp)
   String productId = request.getParameter("productId");
Product product = null;

if (productId != null && !productId.trim().isEmpty()) {
    try {
        int id = Integer.parseInt(productId);
        product = productDAO.getProductById(id); // Gọi với int
    } catch (NumberFormatException e) {
        out.println("<p>Invalid product ID format!</p>");
        return;
    } catch (Exception e) {
        out.println("<p>Error retrieving product!</p>");
        return;
    }
}

    // Lấy thông tin liên quan
    Brand brand = brandDAO.getBrandById(product.getBrandId());
    Category category = categoryDAO.getCategoryById(product.getTypeId()); // Sử dụng TypeId thay vì CategoryId
    Material material = materialDAO.getMaterialById(product.getMaterialId());
    Account user = (Account) session.getAttribute("u");
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
        <header id="header">
            <div class="header_top">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="contactinfo">
                                <ul class="nav nav-pills">
                                    <li><a href=""><i class="fa fa-phone"></i> +2 95 01 88 821</a></li>
                                    <li><a href=""><i class="fa fa-envelope"></i> info@domain.com</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="social-icons pull-right">
                                <ul class="nav navbar-nav">
                                    <li><a href=""><i class="fa fa-facebook"></i></a></li>
                                    <li><a href=""><i class="fa fa-twitter"></i></a></li>
                                    <li><a href=""><i class="fa fa-linkedin"></i></a></li>
                                    <li><a href=""><i class="fa fa-dribbble"></i></a></li>
                                    <li><a href=""><i class="fa fa-google-plus"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="header-middle">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="logo pull-left">
                                <a href="home.jsp"><img src="images/home/logo.png" alt="Men Shop" /></a>
                            </div>
                            <div class="btn-group pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-default dropdown-toggle usa" data-toggle="dropdown">
                                        USA
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a href="">Canada</a></li>
                                        <li><a href="">UK</a></li>
                                    </ul>
                                </div>

                                <div class="btn-group">
                                    <button type="button" class="btn btn-default dropdown-toggle usa" data-toggle="dropdown">
                                        DOLLAR
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a href="">Canadian Dollar</a></li>
                                        <li><a href="">Pound</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-8">
                            <div class="shop-menu pull-right">
                                <ul class="nav navbar-nav">
                                    <li><a href="changepassword.jsp"><i class="fa fa-user"></i> ${not empty sessionScope.u? sessionScope.u.getUsername() : "Account"}</a></li>
                                    <li><a href="UserControllerServlet"><i class="fa fa-star"></i> Admin</a></li>
                                    <li><a href="#"><i class="fa fa-star"></i> Wishlist</a></li>
                                    <li><a href="#"><i class="fa fa-shopping-cart"></i> Cart</a></li>
                                    <li><a href="${not empty sessionScope.u? "logout" : "login.jsp"}"><i class="fa fa-lock"></i> ${not empty sessionScope.u? "Logout" : "Login"}</a></li>
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
                                            <li><a href="productlist?category=<%= product.getTypeId() %>">Products</a></li>
                                            <li><a href="productDetail.jsp?id=<%= product.getId() %>" class="active">Product Details</a></li>
                                            <li><a href="checkout.html">Checkout</a></li>
                                            <li><a href="cart.html">Cart</a></li>
                                            <li><a href="login.html">Login</a></li>
                                        </ul>
                                    </li>
                                    <li class="dropdown"><a href="#">Blog<i class="fa fa-angle-down"></i></a>
                                        <ul role="menu" class="sub-menu">
                                            <li><a href="blogList.jsp">Blog List</a></li>
                                            <li><a href="blogDetail.jsp">Blog Single</a></li>
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
        <section>
            <div class="container">
                <div class="row">
                    <div class="col-sm-3">
                        <div class="left-sidebar">
                            <h2>Category</h2>
                            <div class="panel-group category-products" id="accordian">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordian" href="#sportswear">
                                                <span class="badge pull-right"><i class="fa fa-plus"></i></span>
                                                Sportswear
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="sportswear" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <ul>
                                                <li><a href="productlist?category=1">Nike</a></li> <!-- Giả sử category ID là 1 -->
                                                <li><a href="productlist?category=2">Under Armour</a></li> <!-- Giả sử category ID là 2 -->
                                                <li><a href="productlist?category=3">Adidas</a></li> <!-- Giả sử category ID là 3 -->
                                                <li><a href="productlist?category=4">Puma</a></li> <!-- Giả sử category ID là 4 -->
                                                <li><a href="productlist?category=5">ASICS</a></li> <!-- Giả sử category ID là 5 -->
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordian" href="#mens">
                                                <span class="badge pull-right"><i class="fa fa-plus"></i></span>
                                                Mens
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="mens" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <ul>
                                                <li><a href="productlist?category=6">Fendi</a></li> <!-- Giả sử category ID là 6 -->
                                                <li><a href="productlist?category=7">Guess</a></li> <!-- Giả sử category ID là 7 -->
                                                <li><a href="productlist?category=8">Valentino</a></li> <!-- Giả sử category ID là 8 -->
                                                <li><a href="productlist?category=9">Dior</a></li> <!-- Giả sử category ID là 9 -->
                                                <li><a href="productlist?category=10">Versace</a></li> <!-- Giả sử category ID là 10 -->
                                                <li><a href="productlist?category=11">Armani</a></li> <!-- Giả sử category ID là 11 -->
                                                <li><a href="productlist?category=12">Prada</a></li> <!-- Giả sử category ID là 12 -->
                                                <li><a href="productlist?category=13">Dolce and Gabbana</a></li> <!-- Giả sử category ID là 13 -->
                                                <li><a href="productlist?category=14">Chanel</a></li> <!-- Giả sử category ID là 14 -->
                                                <li><a href="productlist?category=15">Gucci</a></li> <!-- Giả sử category ID là 15 -->
                                            </ul>
                                        </div>
                                    </div>
                                </div>

                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a data-toggle="collapse" data-parent="#accordian" href="#womens">
                                                <span class="badge pull-right"><i class="fa fa-plus"></i></span>
                                                Womens
                                            </a>
                                        </h4>
                                    </div>
                                    <div id="womens" class="panel-collapse collapse">
                                        <div class="panel-body">
                                            <ul>
                                                <li><a href="productlist?category=16">Fendi</a></li> <!-- Giả sử category ID là 16 -->
                                                <li><a href="productlist?category=17">Guess</a></li> <!-- Giả sử category ID là 17 -->
                                                <li><a href="productlist?category=18">Valentino</a></li> <!-- Giả sử category ID là 18 -->
                                                <li><a href="productlist?category=19">Dior</a></li> <!-- Giả sử category ID là 19 -->
                                                <li><a href="productlist?category=20">Versace</a></li> <!-- Giả sử category ID là 20 -->
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><a href="productlist?category=21">Kids</a></h4> <!-- Giả sử category ID là 21 -->
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><a href="productlist?category=22">Fashion</a></h4> <!-- Giả sử category ID là 22 -->
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><a href="productlist?category=23">Households</a></h4> <!-- Giả sử category ID là 23 -->
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><a href="productlist?category=24">Interiors</a></h4> <!-- Giả sử category ID là 24 -->
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><a href="productlist?category=25">Clothing</a></h4> <!-- Giả sử category ID là 25 -->
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><a href="productlist?category=26">Bags</a></h4> <!-- Giả sử category ID là 26 -->
                                    </div>
                                </div>
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title"><a href="productlist?category=27">Shoes</a></h4> <!-- Giả sử category ID là 27 -->
                                    </div>
                                </div>
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
                                    <img src="<%= product.getImage() %>" alt="<%= product.getName() %>" class="img-responsive" />

                                </div>
                                <div id="similar-product" class="carousel slide" data-ride="carousel">
                                    <!-- Wrapper for slides -->
                                    <div class="carousel-inner">
                                        <div class="item active">
                                            <a href=""><img src="images/product-details/similar1.jpg" alt="Similar Product"></a>
                                            <a href=""><img src="images/product-details/similar2.jpg" alt="Similar Product"></a>
                                            <a href=""><img src="images/product-details/similar3.jpg" alt="Similar Product"></a>
                                        </div>
                                        <div class="item">
                                            <a href=""><img src="images/product-details/similar1.jpg" alt="Similar Product"></a>
                                            <a href=""><img src="images/product-details/similar2.jpg" alt="Similar Product"></a>
                                            <a href=""><img src="images/product-details/similar3.jpg" alt="Similar Product"></a>
                                        </div>
                                        <div class="item">
                                            <a href=""><img src="images/product-details/similar1.jpg" alt="Similar Product"></a>
                                            <a href=""><img src="images/product-details/similar2.jpg" alt="Similar Product"></a>
                                            <a href=""><img src="images/product-details/similar3.jpg" alt="Similar Product"></a>
                                        </div>
                                    </div>

                                    <!-- Controls -->
                                    <a class="left item-control" href="#similar-product" data-slide="prev">
                                        <i class="fa fa-angle-left"></i>
                                    </a>
                                    <a class="right item-control" href="#similar-product" data-slide="next">
                                        <i class="fa fa-angle-right"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="col-sm-7">
                                <div class="product-information">
                                    <img src="images/product-details/new.jpg" class="newarrival" alt="New Arrival" />
                                    <h2><%= product.getName() %></h2>
                                    <p><strong>Web ID:</strong> <%= product.getId() %></p>
                                    <img src="images/product-details/rating.png" alt="Rating" />
                                    <span>
                                        <span>US $<%= product.getPrice() %></span>
                                        <label>Quantity:</label>
                                        <input type="number" min="1" value="1" id="quantity" />
                                        <label>Size:</label>
                                        <select id="size">
                                            <option value="S">S</option>
                                            <option value="M">M</option>
                                            <option value="L">L</option>
                                            <option value="XL">XL</option>
                                        </select>
                                        <br><br>
                                        <a href="<%= (user == null) ? "login.jsp" : "#" %>" 
                                           class="btn btn-default add-to-cart"
                                           <% if (user != null) { %>
                                           onclick="openCartModal('<%= product.getId() %>', `<%= product.getName() %>`, '<%= product.getPrice() %>', '<%= product.getTypeId() %>'); return false;"
                                           <% } %>>
                                            <i class="fa fa-shopping-cart"></i> Add to Cart
                                        </a>
                                    </span>

                                    <p><strong>Condition:</strong> New</p>
                                    <p><strong>Brand:</strong> <%= brand != null ? brand.getName() : "N/A" %></p>
                                    <p><strong>Category:</strong> <%= category != null ? category.getName() : "N/A" %></p>
                                    <p><strong>Material:</strong> <%= material != null ? material.getMname() : "N/A" %></p>
                                    <a href=""><img src="images/product-details/share.png" class="share img-responsive" alt="Share" /></a>
                                </div>
                            </div>
                        </div>

                        <div class="category-tab shop-details-tab">
                            <div class="col-sm-12">
                                <ul class="nav nav-tabs">
                                    <li><a href="#details" data-toggle="tab">Details</a></li>


                                    <li class="active"><a href="#reviews" data-toggle="tab">Reviews (5)</a></li>
                                </ul>
                            </div>
                            <div class="tab-content">
                                <div class="tab-pane fade active in" id="details">
                                    <div class="col-sm-12">
                                        <h3>Product Details</h3>
                                        <p><%= product.getDetails()%></p>
                                    </div>
                                </div>





                                <div class="tab-pane fade active in" id="reviews">
                                    <div class="col-sm-12">
                                        <ul>
                                            <li><a href=""><i class="fa fa-user"></i>EUGEN</a></li>
                                            <li><a href=""><i class="fa fa-clock-o"></i>12:41 PM</a></li>
                                            <li><a href=""><i class="fa fa-calendar-o"></i>31 DEC 2014</a></li>
                                        </ul>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
                                        <p><b>Write Your Review</b></p>

                                        <form action="#">
                                            <span>
                                                <input type="text" placeholder="Your Name" class="form-control" style="width: 45%; margin-right: 5%;"/>
                                                <input type="email" placeholder="Email Address" class="form-control" style="width: 45%;"/>
                                            </span>
                                            <textarea name="" placeholder="Your Review" class="form-control" rows="5" style="margin-top: 10px;"></textarea>
                                            <b>Rating: </b> <img src="images/product-details/rating.png" alt="Rating" />
                                            <button type="button" class="btn btn-default pull-right" style="margin-top: 10px;">
                                                Submit
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
        </footer><!--/Footer-->

        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.scrollUp.min.js"></script>
        <script src="js/price-range.js"></script>
        <script src="js/jquery.prettyPhoto.js"></script>
        <script src="js/main.js"></script>
        <script>
                                               function openCartModal(id, name, price, typeId) {
                                                   console.log("Opening Modal for Product:", id, name, price, typeId); // Debug để kiểm tra dữ liệu
                                                   document.getElementById("productId").value = id;
                                                   document.getElementById("productName").innerText = name;
                                                   document.getElementById("productPrice").innerText = price;

                                                   // Lấy giá trị size và quantity từ trang trước khi mở modal
                                                   const size = document.getElementById("size").value;
                                                   const quantity = document.getElementById("quantity").value;

                                                   document.querySelector("input[name='price']").value = price;
                                                   document.getElementById("sizeModal").value = size; // Đặt giá trị size trong modal
                                                   document.getElementById("quantityModal").value = quantity; // Đặt giá trị quantity trong modal

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
    </body>
</html>