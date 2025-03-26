<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp"></jsp:include>

            <div class="container">
                <div class="page-header">
                    <h2 class="text-center">Danh sách Slider</h2>
                </div>

                <div class="control-panel">
                    <div class="row">
                        <div class="col-md-6 search-container">
                            <form action="sliderList" method="get" class="form-inline">
                                <label for="keyword" class="mr-2">Tìm kiếm:</label>
                                <input type="text" class="form-control mr-2" id="keyword" name="keyword" value="${keyword}" placeholder="Nhập từ khóa...">
                            <button type="submit" class="btn btn-search"><i class="fa fa-search"></i> Tìm</button>
                        </form>
                    </div>
                    <div class="col-md-6 text-right">
                        <div class="row">
                            <div class="col-md-6 sort-container">
                                <label for="sortBy">Sort:</label>
                                <select id="sortBy" onchange="location.href = 'sliderList?sortBy=' + this.value + '&page=${currentPage}&keyword=${keyword}'" class="form-control d-inline-block w-auto">
                                    <option value="created_at" ${sortBy == 'created_at' ? 'selected' : ''}>Mới nhất</option>
                                    <option value="status" ${sortBy == 'status' ? 'selected' : ''}>Trạng thái</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <a href="sliderList?action=addSlider" class="btn btn-add"><i class="fa fa-plus"></i> Thêm Slider</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%-- Thông báo lỗi --%>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>

            <%-- Kiểm tra danh sách slider --%>
            <c:choose>
                <c:when test="${not empty sliders}">
                    <div class="table-responsive">
                        <table class="table table-custom">
                            <thead>
                                <tr>
                                    <th style="
                                        text-align: center;
                                        ">ID</th>
                                     <th style="
                                        text-align: center;
                                        ">Title</th>
                                    <th style="
                                        text-align: center;
                                        ">Image</th>
                                    <th style="
                                        text-align: center;
                                        ">Link</th>
                                    <th style="
                                        text-align: center;
                                        ">Status</th>
                                    <th style="
                                        text-align: center;
                                        ">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="slide" items="${sliders}">
                                    <tr>
                                        <td class="text-center align-middle">${slide.id}</td>
                                          <td class="text-center align-middle">${slide.title}</td>
                                        <td class="text-center align-middle">
                                            <c:choose>
                                                <c:when test="${not empty slide.imageUrl}">
                                                    <img src="${slide.imageUrl}" class="slider-img" alt="Slider Image">
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Không có ảnh</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="align-middle">
                                            <a href="${slide.link}" target="_blank" class="slider-link">${slide.link}</a>
                                        </td>
                                        <td class="text-center align-middle">
                                            <c:choose>
                                                <c:when test="${slide.status}">
                                                    <span class="status-badge status-active">Actived</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge status-inactive">Inactive</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center align-middle">
                                            <a href="sliderList?action=sliderDetail&id=${slide.id}" class="btn btn-info btn-sm action-btn"><i class="fa fa-eye"></i> View</a>
                                            <a href="sliderList?action=editSlider&id=${slide.id}" class="btn btn-warning btn-sm action-btn"><i class="fa fa-edit"></i> Edit</a>
                                            <a href="sliderList?action=deleteSlider&id=${slide.id}" class="btn btn-danger btn-sm action-btn" onclick="return confirm('Bạn có chắc muốn xóa slider này?');"><i class="fa fa-trash"></i> Delete</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <%-- Phân trang --%>
                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="sliderList?page=${currentPage - 1}&sortBy=${sortBy}&keyword=${keyword}" class="btn btn-primary"style="
                               margin: 0;
                               color: black;
                               border: 1px solid;
                               border-radius: 20px;
                               background: white;
                               ">← Previous</a>
                        </c:if>

                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <a href="sliderList?page=${i}&sortBy=${sortBy}&keyword=${keyword}" class="btn ${currentPage == i ? 'btn-dark' : 'btn-outline-primary'}">${i}</a>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <a href="sliderList?page=${currentPage + 1}&sortBy=${sortBy}&keyword=${keyword}" class="btn btn-primary"style="margin:0;color: black;border: 1px solid;border-radius: 20px;background: white"; >Next →</a>
                        </c:if>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-warning text-center">Không có slider nào phù hợp với từ khóa.</div>
                </c:otherwise>
            </c:choose>
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
           
        </footer><!--/Footer-->

        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>