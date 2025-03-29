<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="model.Product, model.Brand, model.Category, model.Account,model.Slider,model.ProductImage,model.Color" %>
<%
 Account user = (Account) session.getAttribute("u");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách Slider</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/font-awesome.min.css" rel="stylesheet">
        <link href="css/main.css" rel="stylesheet">
        <link href="css/responsive.css" rel="stylesheet">
        <style>
            body {
                background-color: #f4f6f9;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .page-header {
                background: linear-gradient(90deg, #b5b7ba, #0056b3);
                color: white;
                padding: 20px;
                border-radius: 10px 10px 0 0;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            }
            .page-header h2 {
                margin: 0;
                font-size: 28px;
                font-weight: 600;
            }
            .control-panel {
                background: white;
                padding: 20px;
                border-radius: 0 0 10px 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                margin-bottom: 30px;
            }
            .search-container, .sort-container {
                display: flex;
                align-items: center;
            }
            .search-container label, .sort-container label {
                font-weight: 600;
                margin-right: 10px;
                color: #495057;
            }
            .search-container input, .sort-container select {
                border-radius: 5px;
                box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
            }
            .search-container .btn-search {
                background-color: #ffffff;
                margin-top: 10px;
                border: 1px solid;
                padding: 8px 20px;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }
            .search-container .btn-search:hover {
                background-color: #218838;
            }
            .btn-add {
                background-color: #415790;
                color: white;
                border: none;
                padding: 10px 25px;
                border-radius: 5px;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }
            .btn-add:hover {
                background-color: #0056b3;
                transform: translateY(-2px);
            }
            .table-custom {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                background: white;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }
            .table-custom thead th {
                background: #343a40;
                color: white;
                padding: 15px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            .table-custom tbody tr {
                transition: background-color 0.3s ease;
            }
            .table-custom tbody tr:hover {
                background-color: #f1f3f5;
            }
            .slider-img {
                width: 150px;
                height: 80px;
                object-fit: cover;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .status-badge {
                padding: 6px 15px;
                font-size: 14px;
                border-radius: 20px;
                font-weight: 600;
                display: inline-block;
                text-align: center;
                min-width: 90px;
            }
            .status-active {
                background-color: #28a745;
                color: white;
            }
            .status-inactive {
                background-color: #dc3545;
                color: white;
            }
            .slider-link {
                display: block;
                max-width: 400px;
                overflow: hidden;
                white-space: nowrap;
                text-overflow: ellipsis;
                color: #007bff;
                transition: color 0.3s ease;
            }
            .slider-link:hover {
                color: #0056b3;
                text-decoration: underline;
            }
            .action-btn {
                margin-right: 8px;
                padding: 6px 15px;
                border-radius: 5px;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }
            .action-btn:hover {
                transform: translateY(-2px);
            }
            .btn-info {
                background-color: #17a2b8;
                border: none;
            }
            .btn-info:hover {
                background-color: #138496;
            }
            .btn-warning {
                background-color: #ffc107;
                border: none;
                color: #212529;
            }
            .btn-warning:hover {
                background-color: #e0a800;
            }
            .btn-danger {
                background-color: #dc3545;
                border: none;
            }
            .btn-danger:hover {
                background-color: #c82333;
            }
            .pagination {
                justify-content: center;
                margin-top: 30px;
            }
            .pagination .btn {
                margin: 0 5px;
                padding: 8px 15px;
                border-radius: 20px;
                transition: background-color 0.3s ease;
            }
            .pagination .btn-dark {
                background-color: white;
                border: 1px solid black;
                color: black;

            }
            .pagination .btn-outline-primary {
                border-color: #007bff;
                color: black;
            }
            .pagination .btn-outline-primary:hover {
                background-color: red;
                color: white;
            }
            .pagination .btn-primary {
                background-color: #007bff;
                border: none;
            }
            .pagination .btn-primary:hover {
                background-color: #0056b3;
            }
            .alert {
                border-radius: 5px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }
            .message-box {
                position: fixed;
                top: 20px;
                right: 20px;
                padding: 15px 25px;
                font-size: 18px;
                background-color: rgba(0, 0, 0, 0.8);
                color: white;
                border-radius: 8px;
                z-index: 1000;
                display: flex;
                align-items: center;
                justify-content: space-between;
                min-width: 250px;
                max-width: 400px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            }

            .close-btn {
                background: none;
                border: none;
                color: white;
                font-size: 20px;
                margin-left: 15px;
                cursor: pointer;
            }
        </style>
    </head>

    <body>
        <% if (user.getRoleID() == 1) { %>
        <a href="admin.jsp" class="back-to-admin">Quay lại Admin</a>
        <style>
            .back-to-admin {
                position: absolute;
                left: 10px;
                top: 10px;
                padding: 10px 20px;
                background-color: #007bff;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                font-weight: bold;
                box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
                transition: 0.3s;
            }
            .back-to-admin:hover {
                background-color: #0056b3;
                box-shadow: 3px 3px 8px rgba(0, 0, 0, 0.3);
            }
        </style>
        <% } else { %>
        <jsp:include page="header.jsp"></jsp:include>
        <% } %>

        <div id="message-box" class="message-box" style="display: none;">
            <span id="message-text"></span>
            <button class="close-btn" onclick="closeMessage()">✖</button>
        </div>

        <script>
            function showMessage(message) {
                document.getElementById("message-text").innerText = message;
                document.getElementById("message-box").style.display = "flex";


                setTimeout(closeMessage, 3000);
            }

            function closeMessage() {
                document.getElementById("message-box").style.display = "none";
            }

        </script>
        <% 
        String message = (String) session.getAttribute("message");
        if (message != null) { 
        %>
        <script>
            showMessage("<%= message %>");
        </script>
        <% 
                session.removeAttribute("message"); // Xóa thông báo sau khi hiển thị
            } 
        %>


        <div class="container">
            <div class="page-header">
                <h2 class="text-center">Danh sách sản phẩm</h2>
            </div>

            <div class="control-panel">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <form action="productlistsevlet" method="get" class="form-inline d-flex">
                            <label for="keyword" class="mr-2">Tìm kiếm:</label>
                            <input type="text" class="form-control mr-2" id="keyword" name="keyword"
                                   placeholder="Nhập từ khóa..." value="${selectedKeyword}">
                            <button type="button" class="btn btn-search" onclick="applyFilters()"><i class="fa fa-search"></i> Tìm</button>
                        </form>
                    </div>

                    <div class="col-md-6 text-right">
                        <% if (user.getRoleID() == 1) { %>
                        <a href="Addproduct.jsp" class="btn btn-add"><i class="fa fa-plus"></i> Thêm sản phẩm</a>
                        <% } %>
                    </div>
                </div>

                <div class="row filter-section mt-3">
                    <div class="col-md-12">
                        <form class="form-inline d-flex flex-wrap gap-2">
                            <label for="brand" class="mr-2">Nhãn hàng:</label>
                            <select name="brand" id="brand" class="form-control mr-3" onchange="applyFilters()">
                                <option value="">Tất cả</option>
                                <c:forEach var="brand" items="${brandList}">
                                    <option value="${brand.id}" ${brand.id eq selectedBrand ? 'selected' : ''}>${brand.name}</option>
                                </c:forEach>
                            </select>

                            <label for="status" class="mr-2">Trạng thái:</label>
                            <select name="status" id="status" class="form-control mr-3" onchange="applyFilters()">
                                <option value="">Tất cả</option>
                                <option value="true" ${selectedStatus eq 'true' ? 'selected' : ''}>Hiển thị</option>
                                <option value="false" ${selectedStatus eq 'false' ? 'selected' : ''}>Ẩn</option>
                            </select>

                            <label for="type" class="mr-2">Loại sản phẩm:</label>
                            <select name="type" id="type" class="form-control mr-3" onchange="applyFilters()">
                                <option value="">Tất cả</option>
                                <c:forEach var="category" items="${categoryList}">
                                    <option value="${category.id}" ${category.id eq selectedType ? 'selected' : ''}>${category.name}</option>
                                </c:forEach>
                            </select>

                            <label for="sortBy" class="mr-2">Sắp xếp:</label>
                            <select name="sortBy" id="sortBy" class="form-control mr-3" onchange="applyFilters()">
                                <option value="created_at" ${selectedSortBy eq 'created_at' ? 'selected' : ''}>Mới nhất</option>
                                <option value="price_asc" ${selectedSortBy eq 'price_asc' ? 'selected' : ''}>Giá tăng dần</option>
                                <option value="price_desc" ${selectedSortBy eq 'price_desc' ? 'selected' : ''}>Giá giảm dần</option>
                            </select>
                        </form>
                    </div>
                </div>
            </div>



            <%-- Thông báo lỗi --%>


            <%-- Kiểm tra danh sách slider --%>
            <div id="product-list">
                <c:choose>
                    <c:when test="${not empty productlist}">
                        <div class="table-responsive">
                            <table class="table table-custom">
                                <thead>
                                    <tr>
                                        <th style="text-align: center">ID</th>
                                        <th style="text-align: center">Hình ảnh</th>
                                        <th style="text-align: center">Tên</th>
                                        <th style="text-align: center">Danh mục</th>
                                        <th style="text-align: center">Nhãn hàng</th>
                                        <th style="text-align: center">Giá tiền</th>
                                        <th style="text-align: center">Trạng thái</th>
                                        <th style="text-align: center">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="product" items="${productlist}">
                                        <tr>
                                            <td class="text-center align-middle">${product.getId()}</td>
                                            <td class="text-center align-middle">
                                                <c:choose>
                                                    <c:when test="${not empty product.getImage()}">
                                                        <img src="${product.getImage()}" class="slider-img" alt="Slider Image" onclick="openImage(this)" style="cursor: pointer; max-width: 100px;">
                                                        <div id="imageOverlay" onclick="closeImage()" style="display: none;
                                                             position: fixed; top: 0; left: 0; width: 100%; height: 100%;
                                                             background: rgba(0,0,0,0.8); text-align: center; z-index: 1000;">
                                                            <img id="largeImage" src="" style="max-width: 90%; max-height: 90%; margin-top: 5%;">
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Không có ảnh</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center align-middle">${product.getName()}</td>
                                            <td class="text-center align-middle">${product.getTypeName()}</td>
                                            <td class="text-center align-middle">${product.getBrandName()}</td>
                                            <td class="text-center align-middle">
                                                <fmt:formatNumber value="${product.getPrice()}" type="number" pattern="#,###"/>đ
                                            </td>

                                            <td class="text-center align-middle">
                                                <c:choose>
                                                    <c:when test="${product.isStatus()}">
                                                        <span class="status-badge status-active">Hiển thị</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge status-inactive">Ẩn</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>

                                            <td class="text-center align-middle">

                                                <a href="Productdetailmanage.jsp?id=${product.getId()}" class="btn btn-warning btn-sm action-btn">
                                                    <i class="fa fa-edit"></i> Sửa
                                                </a>

                                                <form action="productlistsevlet?action=deleteProduct" method="post" style="display:inline;" 
                                                      onsubmit="return confirm('Bạn có chắc muốn xóa product này?');">
                                                    <input type="hidden" name="id" value="${product.getId()}">
                                                    <button type="submit" class="btn btn-danger btn-sm action-btn">
                                                        <i class="fa fa-trash"></i> Xóa
                                                    </button>
                                                </form>

                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>

                        </div>
                        <div class="pagination-container text-center">
                            <ul class="pagination">
                                <c:set var="queryString" value=""/>
                                <c:if test="${not empty selectedKeyword}">
                                    <c:set var="queryString" value="${queryString}&keyword=${selectedKeyword}"/>
                                </c:if>
                                <c:if test="${not empty selectedBrand}">
                                    <c:set var="queryString" value="${queryString}&brand=${selectedBrand}"/>
                                </c:if>
                                <c:if test="${not empty selectedStatus}">
                                    <c:set var="queryString" value="${queryString}&status=${selectedStatus}"/>
                                </c:if>
                                <c:if test="${not empty selectedType}">
                                    <c:set var="queryString" value="${queryString}&type=${selectedType}"/>
                                </c:if>
                                <c:if test="${not empty selectedSortBy}">
                                    <c:set var="queryString" value="${queryString}&sortBy=${selectedSortBy}"/>
                                </c:if>

                                <c:if test="${currentPage > 1}">
                                    <li>
                                        <a href="productlistsevlet?page=${currentPage - 1}${queryString}">« Trước</a>
                                    </li>
                                </c:if>

                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <li class="${i == currentPage ? 'active' : ''}">
                                        <a href="productlistsevlet?page=${i}${queryString}">${i}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${currentPage < totalPages}">
                                    <li>
                                        <a href="productlistsevlet?page=${currentPage + 1}${queryString}">Sau »</a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>


                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-warning text-center">Không có product nào phù hợp với từ khóa.</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

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
            <script>
                function applyFilters() {
                    let params = new URLSearchParams(window.location.search);

                    let keyword = document.getElementById("keyword").value;
                    let brand = document.getElementById("brand").value;
                    let status = document.getElementById("status").value;
                    let type = document.getElementById("type").value;
                    let sortBy = document.getElementById("sortBy").value;

                    if (keyword)
                        params.set("keyword", keyword);
                    else
                        params.delete("keyword");
                    if (brand)
                        params.set("brand", brand);
                    else
                        params.delete("brand");
                    if (status)
                        params.set("status", status);
                    else
                        params.delete("status");
                    if (type)
                        params.set("type", type);
                    else
                        params.delete("type");
                    if (sortBy)
                        params.set("sortBy", sortBy);
                    else
                        params.delete("sortBy");

                    let newUrl = "productlistsevlet?" + params.toString();


                    history.pushState(null, "", newUrl);


                    window.location.href = newUrl;
                }





                function openImage(img) {
                    document.getElementById("largeImage").src = img.src;
                    document.getElementById("imageOverlay").style.display = "block";
                }
                function closeImage() {
                    document.getElementById("imageOverlay").style.display = "none";
                }
            </script>
        </footer><!--/Footer-->

        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>