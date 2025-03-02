<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.ArrayList" %>

<%@ page import="model.Product, model.Brand, model.Category, model.Material,model.Account,model.Cart" %>

<jsp:useBean id="productDAO" class="dto.ProductDAO" scope="session"/>
<jsp:useBean id="brandDAO" class="dto.BrandDAO" scope="session"/>
<jsp:useBean id="categoryDAO" class="dto.CategoryDAO" scope="session"/>
<jsp:useBean id="materialDAO" class="dto.MaterialDAO" scope="session"/>

<%
    String categ = (String)request.getParameter("category");
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
        <style>
            .chose_area {
                padding: 20px !important;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            }

            .chose_area label {
                font-weight: bold;
                margin-bottom: 8px;
                display: block;
            }

            .chose_area input,
            .chose_area select {
                width: 100%;
                padding: 12px;
                margin-bottom: 15px;
                border-radius: 8px;
                border: 1px solid #ccc;
                background: #f9f9f9;
            }

            .location-select {
                display: flex;
                gap: 15px;
                margin-top: 10px;
            }

            .location-select select {
                flex: 1;
                padding: 10px;
                border-radius: 8px;
                border: 1px solid #ccc;
                background: #f9f9f9;
            }


        </style>
    </head>
    <body>

        <!-- HEADER -->
        <header id="header" style="margin-bottom: 50px">
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
                                    <li><a href="changepassword.jsp"><i class="fa fa-user"></i> ${not empty sessionScope.u? sessionScope.u.getUsername() : "Account"}</a></li>
                                    <li><a href="cartcontroller"><i class="fa fa-shopping-cart"></i> Cart</a></li>
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
                                    <span class="icon-bar"  ></span>
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
                                    <li><a href="blogList.jsp"><i class="dropdown fa fa-newspaper-o"></i> Blog</a></li>


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

        <section id="cart_items">
            <div class="container">
                <div class="table-responsive cart_info">
                    <table class="table table-condensed">
                        <thead>
                            <tr class="cart_menu" style="background: black">
                                <td class="image">Item</td>
                                <td class="description"></td>
                                <td class="price">Price</td>
                                <td class="quantity">Quantity</td>
                                <td class="total">Total</td>
                                <td></td>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Cart> cartList = (List<Cart>) request.getAttribute("cartList");
                                if (cartList != null && !cartList.isEmpty()) {
                                    for (Cart c : cartList) {
                            %>

                            <tr>
                                <td class="cart_product">
                                    <a href=""><img src="<%= c.getImage() %>" alt=""></a>
                                </td>
                                <td class="cart_description">
                                    <h4><a href=""><%= c.getName() %></a></h4>
                                    <p>Size: <%= c.getSize() %></p>
                                </td>
                                <td class="cart_price">
                                    <p>$<%= c.getPrice() %></p>
                                </td>
                                <td class="cart_quantity">
                                    <form action="cartcontroller" method="post" class="cart_quantity_form">
                                        <input type="hidden" name="Size" value="<%= c.getSize() %>"> 
                                        <input type="hidden" name="productId" value="<%= c.getProductID() %>"> 
                                        <div class="cart_quantity_button">
                                            <button type="submit" name="action" value="decrease" class="cart_btn cart_quantity_down">-</button>
                                            <input class="cart_quantity_input" type="text" name="quantity" value="<%= c.getQuantity() %>" autocomplete="off" size="2">
                                            <button type="submit" name="action" value="increase" class="cart_btn cart_quantity_up">+</button>
                                        </div>
                                    </form>
                                </td>



                                <td class="cart_total">
                                    <p class="cart_total_price"><%= c.getPrice() * c.getQuantity() %>đ</p>
                                </td>
                                <td class="cart_delete">
                                    <form action="cartcontroller" method="post" class="cart_delete_form">
                                        <input type="hidden" name="Size" value="<%= c.getSize() %>"> 
                                        <input type="hidden" name="productId" value="<%= c.getProductID() %>">
                                        <input type="hidden" name="Size" value="<%= c.getSize() %>">  
                                        <button type="submit" name="action" value="delete" class="cart_quantity_delete">
                                            <i class="fa fa-times"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <% 
                        String cartMessage = (String) request.getAttribute("cartMessage");
                        if (cartMessage != null && !cartMessage.isEmpty()) { 
                            %>
                        <div id="toast" class="toast"><%= cartMessage %></div>
                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                var toast = document.getElementById("toast");
                                toast.style.display = "block";
                                setTimeout(function () {
                                    toast.style.display = "none";
                                }, 3000);
                            });
                        </script>
                        <% } %>

                        <!-- CSS cho Toast -->
                        <style>
                            .toast {
                                position: fixed;
                                bottom: 20px;
                                left: 20px;
                                background: rgba(0, 0, 0, 0.7);
                                color: white;
                                padding: 10px 20px;
                                border-radius: 5px;
                                display: none;
                                z-index: 1000;
                            }
                        </style>

                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="6" style="text-align: center; font-size: 18px; padding: 20px;">
                                Bạn không có đơn hàng nào.
                            </td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                document.querySelectorAll(".cart_quantity_input").forEach(input => {
                    input.addEventListener("keydown", function (event) {
                        if (event.key === "Enter") {
                            event.preventDefault(); // Ngăn form gửi mặc định

                            let form = this.closest("form"); // Tìm form chứa input
                            let actionInput = document.createElement("input");
                            actionInput.type = "hidden";
                            actionInput.name = "action";
                            actionInput.value = "input"; // Gửi action="input"
                            form.appendChild(actionInput);

                            form.submit(); // Gửi form
                        }
                    });
                });
            });
        </script>

        <!--/#cart_items-->

        <% 
      int subtotal = 0;
      if (cartList != null) {
          for (Cart c : cartList) {
              subtotal += c.getPrice() * c.getQuantity();
          }
      }
      int shippingCost = 0; // Nếu có phí ship, đặt giá trị phù hợp
      int total = subtotal + shippingCost;
        %>

        <section id="do_action">
            <form action="checkout.jsp" method="post" onsubmit="return validateForm()">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="chose_area">
                                <label for="fullname">Họ và tên</label>
                                <div>
                                    <input type="text" id="fullname" name="fullname" value="<%= user.getuName() %>" required>
                                </div>

                                <label for="phone">Số điện thoại</label>
                                <input type="text" id="phone" name="phone" value="<%= user.getMobile() %>" required>

                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>

                                <div class="location-select">
                                    <select id="province" name="province" onchange="loadDistricts()" required>
                                        <option value="">Chọn tỉnh/thành phố</option>
                                    </select>
                                    <select id="district" name="district" onchange="loadWards()" required>
                                        <option value="">Chọn quận/huyện</option>
                                    </select>
                                    <select id="ward" name="ward" required>
                                        <option value="">Chọn xã/phường</option>
                                    </select>
                                </div>

                                <script src="js/location.js"></script>

                                <label for="address">Địa chỉ</label>
                                <input type="text" id="address" name="address" required>
                            </div>
                        </div>

                        <div class="col-sm-6">
                            <div class="total_area">
                                <ul>
                                    <li>Tạm tính <span><%= subtotal %>đ</span></li>
                                    <li>Phí ship <span><%= (shippingCost > 0) ? shippingCost + "đ" : "Free" %></span></li>
                                    <li>Tổng <span><%= total %>đ</span></li>
                                </ul>
                                <button type="submit" class="btn btn-default check_out">Check Out</button> <!-- Chuyển thành nút submit -->
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </section><!--/#do_action-->



        <footer id="footer"><!--Footer-->
            <div class="footer-top">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-2">
                            <div class="companyinfo">
                                <h2><span>e</span>-shopper</h2>
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
                                    <li><a href="">Online Help</a></li>
                                    <li><a href="">Contact Us</a></li>
                                    <li><a href="">Order Status</a></li>
                                    <li><a href="">Change Location</a></li>
                                    <li><a href="">FAQ’s</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="single-widget">
                                <h2>Quock Shop</h2>
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="">T-Shirt</a></li>
                                    <li><a href="">Mens</a></li>
                                    <li><a href="">Womens</a></li>
                                    <li><a href="">Gift Cards</a></li>
                                    <li><a href="">Shoes</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="single-widget">
                                <h2>Policies</h2>
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="">Terms of Use</a></li>
                                    <li><a href="">Privecy Policy</a></li>
                                    <li><a href="">Refund Policy</a></li>
                                    <li><a href="">Billing System</a></li>
                                    <li><a href="">Ticket System</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-sm-2">
                            <div class="single-widget">
                                <h2>About Shopper</h2>
                                <ul class="nav nav-pills nav-stacked">
                                    <li><a href="">Company Information</a></li>
                                    <li><a href="">Careers</a></li>
                                    <li><a href="">Store Location</a></li>
                                    <li><a href="">Affillate Program</a></li>
                                    <li><a href="">Copyright</a></li>
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
                        <p class="pull-left">Copyright © 2013 E-SHOPPER Inc. All rights reserved.</p>
                        <p class="pull-right">Designed by <span><a target="_blank" href="http://www.themeum.com">Themeum</a></span></p>
                    </div>
                </div>
            </div>

        </footer><!--/Footer-->



        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.scrollUp.min.js"></script>
        <script src="js/jquery.prettyPhoto.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>