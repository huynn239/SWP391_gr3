<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="model.Product, model.Brand, model.Category, model.Material,model.Account,model.Cart,model.Order,model.Address" %>

<jsp:useBean id="productDAO" class="dto.ProductDAO" scope="session"/>
<jsp:useBean id="brandDAO" class="dto.BrandDAO" scope="session"/>
<jsp:useBean id="categoryDAO" class="dto.CategoryDAO" scope="session"/>
<jsp:useBean id="materialDAO" class="dto.MaterialDAO" scope="session"/>
<jsp:useBean id="orderDAO" class="dto.OrderDAO" scope="session"/>
<%
    String categ = (String)request.getParameter("category");
    List<Brand> brands = brandDAO.getAllBrands();
    List<Category> categories = categoryDAO.getAllCategories();
    List<Material> materials = materialDAO.getAllMaterial();
    Account user = (Account) session.getAttribute("u");
   List<Address> listAddress = new ArrayList<>();
    if (user != null) {
        listAddress = orderDAO.listAddress(user.getId());
    } else {
        response.sendRedirect("login.jsp"); 
    }
    Gson gson = new Gson();
   
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
        <link href="css/saveaddress.css" rel="stylesheet">
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

            .save {
                display: flex;
                align-items: center;
                gap: 8px; /* Tạo khoảng cách giữa checkbox và label */
                margin-top: 10px; /* Khoảng cách với phần trên */
            }

            .save input[type="checkbox"] {
                width: 18px;
                height: 18px;
                accent-color: #007bff; /* Màu xanh giống Bootstrap */
                cursor: pointer;
            }

            .save label {
                font-size: 14px;
                cursor: pointer;
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
                                    <c:if test="${sessionScope.u.roleID == 1 || sessionScope.u.roleID == 2 || sessionScope.u.roleID == 3 || sessionScope.u.roleID == 4}">
                                        <li><a href="changepassword.jsp"><i class="fa fa-user"></i> ${not empty sessionScope.u? sessionScope.u.getUsername() : "Account"}</a></li>
                                        </c:if>
                                        <c:if test="${sessionScope.u.roleID == 1}">
                                        <li><a href="UserControllerServlet"><i class="fa fa-star"></i> Admin</a></li>
                                        </c:if>
                                        <c:if test="${sessionScope.u.roleID == 2}">
                                        <li><a href="mkt.jsp"><i class="fa fa-star"></i> Marketing </a></li>
                                        </c:if>
                                        <c:if test="${sessionScope.u.roleID == 3}">
                                        <li><a href="sale.jsp"><i class="fa fa-star"></i> Sale</a></li>
                                        </c:if>
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
        <script src="js/location.js"></script>
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
                                List<Cart> selectedItems = (List<Cart>) session.getAttribute("selectedItems");
                                if (selectedItems != null && !selectedItems.isEmpty()) {
                                     for (Cart c : selectedItems) {
                            %>

                            <tr>
                                <td class="cart_product">
                                    <a href=""><img src="<%= c.getImage() %>" alt=""></a>
                                </td>
                                <td class="cart_description">
                                    <h4><a href=""><%= c.getName() %></a></h4>
                                    <p>Size: <%= c.getSize() %> | <span class="color-id"><%= c.getColor() %></span></p>
                                </td>
                                <td class="cart_price">
                                    <p>$<%= c.getPrice() %></p>
                                </td>
                                <td class="cart_quantity">
                                    <div class="cart_quantity_button">
                                        <input class="cart_quantity_input" type="text" name="quantity" value="<%= c.getQuantity() %>" autocomplete="off" size="2" readonly>
                                    </div>
                                </td>
                                <td class="cart_total">
                                    <p class="cart_total_price"><%= c.getPrice() * c.getQuantity() %>đ</p>
                                </td>

                            </tr>


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


        <!--/#cart_items-->

        <% 
      int subtotal = 0;
      if (selectedItems != null) {
          for (Cart c : selectedItems) {
              subtotal += c.getPrice() * c.getQuantity();
          }
      }
      int shippingCost = 0; // Nếu có phí ship, đặt giá trị phù hợp
      int total = subtotal + shippingCost;
        %>

        <button class="address-btn" onclick="openAddressModal()">
                <i class="fa fa-book"></i> Address Book
        </button>


        <div id="addressModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeAddressModal()">&times;</span>


                <div id="addressListContainer">
                    <h2>Address Book</h2>
                    <div id="addressList">

                    </div>
                    <button class="add-address" onclick="showAddressForm()">Add adress</button>
                </div>

                <form id="addressForm" action="orderinfo" method="get" style="display: none;">
                    <h2>Add address</h2>
                    <input type="text" name="inputname" id="name-input" placeholder="Fullname" required>

                    <input type="text" name="inputphone" id="phone-input" placeholder="Phone" required 
                           pattern="[0-9]{10}" title="Số điện thoại gồm 10 chữ số">

                    <input type="text" name="inputaddress" id="address-input" placeholder="Address" required>
                    <input type="text" name="inputemail" id="email-input" placeholder="Email" required>
                    <select name="inputprovince" id="province-input" onchange="loadDistrictsForm()" required>
                        <option value="" hidden selected>Choose province</option>
                    </select>

                    <select name="inputdistrict" id="district-input" onchange="loadWardsForm()" required>
                        <option value="" hidden selected>Choose district</option>
                    </select>

                    <select name="inputward" id="ward-input" required>
                        <option value="" hidden selected>Choose ward</option>
                    </select>

                    <br>
                    <button type="button" onclick="cancelNewAddress()">Cancel</button>
                    <button type="submit">Add</button>
                </form>


            </div>
        </div>
        <script>
            var addresses = <%= gson.toJson(listAddress) %>;
            console.log(addresses);

            function openAddressModal() {
                document.getElementById('addressModal').style.display = 'block';
                loadAddresses();
            }

// Đóng modal
            function closeAddressModal() {
                document.getElementById('addressModal').style.display = 'none';
                resetAddressForm();
            }

            function showAddressList() {
                document.getElementById('addressListContainer').style.display = 'block';
                document.getElementById('addressForm').style.display = 'none';
                loadAddresses();

            }

            function selectAddress(element, addressText) {
                console.log("Đang chọn địa chỉ:", addressText);
                const lines = addressText.split("\n").map(line => line.trim());
                if (lines.length < 2) {
                    console.error("Dữ liệu địa chỉ không hợp lệ");
                    return;
                }
                let fullAddress = lines[0];
                let userInfo = lines[1].split(",").map(part => part.trim()); // Tên, SĐT, Email
                let receiverName = userInfo[0] || "Không có tên";
                let receiverPhone = userInfo[1] || "Không có SĐT";
                let receiverEmail = userInfo[2] || "Không có email";
                let addressParts = fullAddress.split("-").map(part => part.trim());

                let addressDetail = addressParts.slice(3).join(" - "); // Phần chi tiết địa chỉ
                let province = addressParts.length > 0 ? addressParts[0] : "";
                let district = addressParts.length > 1 ? addressParts[1] : "";
                let ward = addressParts.length > 2 ? addressParts[2] : "";
                document.getElementById("fullname").value = receiverName;
                document.getElementById("phone").value = receiverPhone;
                document.getElementById("email").value = receiverEmail;
                document.getElementById("address").value = addressDetail;
                loadProvinces(province).then(() => {
                    loadDistricts(province, district).then(() => {
                        loadWards(province, district, ward);
                    });
                });
                closeAddressModal();
            }


            function showAddressForm() {
                document.getElementById('addressListContainer').style.display = 'none';
                document.getElementById('addressForm').style.display = 'block';
                loadProvincesForm();

            }


            function loadAddresses() {
                let container = document.getElementById('addressList');
                if (!container) {
                    console.error("Không tìm thấy phần tử #addressList");
                    return;
                }
                container.innerHTML = '';

                if (!addresses || addresses.length === 0) {
                    container.innerHTML = "<p>Không có địa chỉ nào.</p>";
                    return;
                }

                let latestAddress = null; // Lưu địa chỉ mới nhất

                addresses.forEach((address, index) => {
                    let div = document.createElement('div');
                    div.className = 'address-item';

                    let receiverAddress = address.reciverAddress || address.receiverAddress || "Không có địa chỉ";
                    let receiverName = address.reciverName || address.receiverName || "Không có tên";
                    let receiverPhone = address.reciverPhone || address.receiverPhone || "Không có SĐT";
                    let receiverEmail = address.reciverEmail || address.receiverEmail || "Không có email";

                    div.innerHTML = receiverAddress + '<br>' + receiverName + ', ' + receiverPhone + ',' + receiverEmail;

                    let actionsDiv = document.createElement('div');
                    actionsDiv.className = 'address-actions';
                    let deleteButton = document.createElement('button');
                    deleteButton.textContent = 'Xóa';
                    deleteButton.onclick = function (event) {
                        event.stopPropagation();
                        deleteAddressFromServer(index);
                    };

                    actionsDiv.appendChild(deleteButton);
                    div.appendChild(actionsDiv);

                    div.addEventListener('click', function () {
                        let addressText = receiverAddress + '\n' + receiverName + ', ' + receiverPhone + ',' + receiverEmail;
                        console.log("Chọn địa chỉ:", addressText);
                        selectAddress(div, addressText);
                    });

                    container.appendChild(div);
                });
            }

            function selectLatestAddress() {
                if (!addresses || addresses.length === 0) {
                    console.log("Không có địa chỉ nào để chọn.");
                    return;
                }
                let latestAddress = addresses.at(-1);
                let receiverAddress = latestAddress.reciverAddress || latestAddress.receiverAddress || "Không có địa chỉ";
                let receiverName = latestAddress.reciverName || latestAddress.receiverName || "Không có tên";
                let receiverPhone = latestAddress.reciverPhone || latestAddress.receiverPhone || "Không có SĐT";
                let receiverEmail = latestAddress.reciverEmail || latestAddress.receiverEmail || "Không có email";
                let addressText = receiverAddress + '\n' + receiverName + ', ' + receiverPhone + ',' + receiverEmail;
                console.log("Chọn địa chỉ mới nhất:", addressText);
                let div = document.createElement('div');
                div.className = 'address-item';
                selectAddress(div, addressText); 
            }

            document.addEventListener('DOMContentLoaded', function () {
                selectLatestAddress();
            });


            function deleteAddressFromServer(index) {
                console.log("blabla");
                if (!addresses[index]) {
                    console.error("Không tìm thấy địa chỉ để xóa");
                    return;
                }

                let addressId = addresses[index].AddressID;
                console.log(addressId);
                window.location.href = "orderinfo?action=delete&id=" + addressId;
            }



            function cancelNewAddress() {
                showAddressList();
                resetAddressForm();
            }

            function resetAddressForm() {
                document.getElementById('name-input').value = '';
                document.getElementById('phone-input').value = '';
                document.getElementById('address-input').value = '';
                document.getElementById('province-input').selectedIndex = 0;
                document.getElementById('district-input').selectedIndex = 0;
                document.getElementById('ward-input').selectedIndex = 0;
            }
        </script>
        <section id="do_action">
            <form action="orderinfo" method="post" onsubmit="return validateForm()">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="chose_area">
                                <label for="fullname">Fullname</label>
                                <div>
                                    <input type="text" id="fullname" name="fullname" value="<%= user.getuName() %>" required>
                                </div>

                                <label for="phone">Phone</label>
                                <input type="text" id="phone" name="phone" value="<%= user.getMobile() %>" required>

                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" value="<%= user.getEmail() %>" required>

                                <div class="location-select">
                                    <div class="location-select">
                                        <select id="province" name="province" onchange="loadDistricts()" required>
                                            <option value="" hidden selected>Choose province</option>
                                        </select>
                                        <select id="district" name="district" onchange="loadWards()" required>
                                            <option value="" hidden selected>Choose district</option>
                                        </select>
                                        <select id="ward" name="ward" required>
                                            <option value="" hidden selected>Choose ward</option>
                                        </select>
                                    </div>
                                </div>



                                <label for="address">Address</label>
                                <input type="text" id="address" name="address" value="" required>
                                <div class="save">
                                    <input type="checkbox" id="saveAddress" name="saveAddress" >
                                    <label for="saveAddress">Save address</label>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-6">
                            <div class="total_area">
                                <ul>
                                    <li>Subtotal <span><%= subtotal %>đ</span></li>
                                    <li>Shipping Fee <span><%= (shippingCost > 0) ? shippingCost + "đ" : "Free" %></span></li>
                                    <li>Total<span><%= total %>đ</span></li>
                                </ul>
                                <button type="submit" class="btn btn-default check_out">Check Out</button> <!-- Chuyển thành nút submit -->
                                <a href="cartdetail.jsp" class="btn btn-default check_out">Update</a>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </section><!--/#do_action-->

        <script>
            function validateForm() {
                let fullname = document.getElementById("fullname").value.trim();
                let phone = document.getElementById("phone").value.trim();
                let email = document.getElementById("email").value.trim();
                let province = document.getElementById("province").value;
                let district = document.getElementById("district").value;
                let ward = document.getElementById("ward").value;
                let address = document.getElementById("address").value.trim();

                // Kiểm tra họ và tên
                if (fullname === "") {
                    alert("Vui lòng nhập họ và tên.");
                    return false;
                }

                // Kiểm tra số điện thoại (phải có 10 chữ số và chỉ chứa số)
                let phoneRegex = /^\d{10}$/;
                if (!phoneRegex.test(phone)) {
                    alert("Số điện thoại không hợp lệ. Vui lòng nhập 10 chữ số.");
                    return false;
                }

                // Kiểm tra email hợp lệ
                let emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                if (!emailRegex.test(email)) {
                    alert("Email không hợp lệ. Vui lòng nhập đúng định dạng email.");
                    return false;
                }

                // Kiểm tra chọn địa chỉ đầy đủ
                if (province === "") {
                    alert("Vui lòng chọn tỉnh/thành phố.");
                    return false;
                }
                if (district === "") {
                    alert("Vui lòng chọn quận/huyện.");
                    return false;
                }
                if (ward === "") {
                    alert("Vui lòng chọn xã/phường.");
                    return false;
                }

                // Kiểm tra địa chỉ cụ thể
                if (address === "") {
                    alert("Vui lòng nhập địa chỉ cụ thể.");
                    return false;
                }

                return true; // Form hợp lệ
            }
        </script>
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

        <script>
            // Tạo đối tượng ánh xạ ID_Color -> ColorName
            const colorMap = {
                1: "Đen",
                2: "Xám",
                3: "Trắng",
                4: "Be",
                5: "Đỏ",
                6: "Cam",
                7: "Vàng",
                8: "Nâu",
                9: "Xanh sáng",
                10: "Xanh đậm",
                11: "Xanh lá"
            };


            document.addEventListener("DOMContentLoaded", function () {
                document.querySelectorAll(".color-id").forEach(element => {
                    let colorID = element.innerText.trim(); // Lấy ID
                    if (colorMap[colorID]) {
                        element.innerText = colorMap[colorID]; // Thay bằng tên màu
                    }
                });
            }
            );
        </script>


        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.scrollUp.min.js"></script>
        <script src="js/jquery.prettyPhoto.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>