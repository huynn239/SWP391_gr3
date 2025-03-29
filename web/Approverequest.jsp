<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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

            .pagination {
                text-align: center;
                margin-top: 10px;
            }

            .pagination a {
                padding: 8px 12px;
                margin: 2px;
                border: 1px solid #ccc;
                text-decoration: none;
                color: #333;
                border-radius: 5px;
            }

            .pagination a.active {
                background-color: #007bff;
                color: white;
                font-weight: bold;
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


        <div class="container">
            <div class="page-header">
                <h2 class="text-center">Danh sách yêu cầu</h2>
            </div>

            <div class="control-panel">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <form  action="approverequest" method="get" class="form-inline d-flex">
                            <label for="keyword" class="mr-2">Tìm kiếm:</label>
                            <input type="text" class="form-control mr-2" id="keyword" name="keyword"
                                   placeholder="Nhập employeeID" value="${selectedKeyword}">
                            <button type="submit" class="btn btn-search">
                                <i class="fa fa-search"></i> Tìm
                            </button>
                        </form>
                    </div>
                </div>

                <div class="row filter-section mt-3">
                    <div class="col-md-12">
                        <form id="filterForm" action="approverequest" method="get" class="form-inline d-flex flex-wrap gap-2">
                            <label for="status" class="mr-2">Trạng thái:</label>
                            <select name="status" id="status" class="form-control mr-3">
                                <option value="">Tất cả</option>
                                <option value="pending" ${selectedStatus eq 'pending' ? 'selected' : ''}>pending</option>
                                <option value="approved" ${selectedStatus eq 'approved' ? 'selected' : ''}>approved</option>
                                <option value="rejected" ${selectedStatus eq 'rejected' ? 'selected' : ''}>rejected</option>
                            </select>
                        </form>
                    </div>
                </div>
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        document.getElementById("status").addEventListener("change", function () {
                            document.getElementById("filterForm").submit();
                        });
                    });
                </script>


            </div>




            <div id="pending-list">
                <c:choose>
                    <c:when test="${not empty pendinglist}">
                        <form action="approverequest" method="post" id="updateStatusForm">
                            <div class="table-responsive">
                                <table class="table table-custom">
                                    <thead>
                                        <tr>
                                            <th class="text-center">Product ID</th>
                                            <th class="text-center">Employee ID</th>
                                            <th class="text-center">Changes</th>
                                            <th class="text-center">Created At</th>
                                            <th class="text-center" style="width: 100px;">Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <c:forEach var="pending" items="${pendinglist}">
                                        <input type="hidden" name="page" value="${currentPage}">
                                        <tr>
                                            <td class="text-center align-middle">${pending.productId}</td>
                                            <td class="text-center align-middle">${pending.updatedBy}</td>
                                            <td class="text-left align-middle">${pending.changes}</td>
                                            <td class="text-center align-middle">${pending.createdAt}</td>
                                            <td class="text-center align-middle">
                                                <select name="status_${pending.id}" class="status-select"style="width: 100px;">
                                                    <option value="pending" ${pending.status == 'pending' ? 'selected' : ''} 
                                                            ${pending.status != 'pending' ? 'disabled' : ''}>pending</option>
                                                    <option value="approved" ${pending.status == 'approved' ? 'selected' : ''}>approved</option>
                                                    <option value="rejected" ${pending.status == 'rejected' ? 'selected' : ''} 
                                                            ${pending.status == 'approved' ? 'disabled' : ''}>rejected</option>
                                                </select>
                                                <input type="hidden" name="id_${pending.id}" value="${pending.id}">
                                                <input type="hidden" name="pid_${pending.id}" value="${pending.productId}">
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="text-center mt-3">
                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                            </div>
                        </form>
                        <div class="pagination">
                            <c:if test="${totalPages > 1}">
                                <c:forEach var="i" begin="1" end="${totalPages}">
                                    <a href="?page=${i}" class="${i == currentPage ? 'active' : ''}">${i}</a>
                                </c:forEach>
                            </c:if>
                        </div>


                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-warning text-center">Không có đơn hàng nào đang chờ duyệt.</div>
                    </c:otherwise>
                </c:choose>
            </div>

            <script>
                document.getElementById('updateStatusForm').addEventListener('submit', function (event) {
                    let selects = document.querySelectorAll('.status-select');
                    for (let select of selects) {
                        let oldValue = select.getAttribute('data-previous');
                        let newValue = select.value;

                        if (oldValue === 'rejected' && newValue === 'approved') {
                            if (!confirm("Bạn có chắc chắn muốn chuyển từ TỪ CHỐI thành CHẤP NHẬN không?")) {
                                event.preventDefault();
                                return;
                            }
                        }
                    }
                });

                document.addEventListener("DOMContentLoaded", function () {
                    let selects = document.querySelectorAll('.status-select');
                    selects.forEach(select => {
                        select.setAttribute('data-previous', select.value);
                    });
                });
            </script>


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






            </script>
        </footer><!--/Footer-->

        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
    </body>
</html>