<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Product, model.Brand, model.Category, model.Account,model.Slider,model.ProductImage,model.Color,model.ProductSize" %>
<%@ page import="com.google.gson.Gson" %>
<jsp:useBean id="productDAO" class="dto.ProductDAO" scope="session"/>
<jsp:useBean id="brandDAO" class="dto.BrandDAO" scope="session"/>
<jsp:useBean id="categoryDAO" class="dto.CategoryDAO" scope="session"/>
<jsp:useBean id="sliderDAO" class="dto.SliderDAO" scope="session"/>
<jsp:useBean id="productimageDAO" class="dto.ProductImageDAO" scope="session"/>
<jsp:useBean id="colorDAO" class="dto.ColorDAO" scope="session"/>
<%
    List<Product> products = productDAO.getAllProducts();
    List<Brand> brands = brandDAO.getAllBrands();
    List<Category> categories = categoryDAO.getAllCategories();
    Account user = (Account) session.getAttribute("u");
    List<ProductImage> productImages = productimageDAO.getAllImagesProduct();
    List<Color> colors = colorDAO.getAllColors();
    Gson gson = new Gson();
    List<Slider> allSliders = sliderDAO.getSlidersSorted(1, 3, "created_at","DESC"); 
    List<Slider> activeSliders = new ArrayList<>();
    for (Slider slider : allSliders) {
        if (slider.isStatus()) { 
            activeSliders.add(slider);
        }
    }
    List<ProductSize> lists = productDAO.getProductSizes();
    String productSizeJson = gson.toJson(lists);
%>
<!DOCTYPE html>
<html lang="en">
    <head>
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
                                        <li><a href="sliderList"><i class="fa fa-star"></i> Marketing </a></li>
                                        </c:if>
                                        <c:if test="${sessionScope.u.roleID == 3}">
                                        <li><a href="sale.jsp"><i class="fa fa-star"></i> Sale</a></li>
                                        </c:if>       
                                    <li><a href="cartcontroller"><i class="fa fa-shopping-cart"></i> Cart</a></li>
                                        <c:if test="${sessionScope.u.roleID == 1 || sessionScope.u.roleID == 2 || sessionScope.u.roleID == 3 || sessionScope.u.roleID == 4}">
                                        <li><a href="ProfileController?action=viewProfile&id=${sessionScope.u.id}"><i class="fa fa-user"></i> ${not empty sessionScope.u ? sessionScope.u.username : "Account"}</a></li>
                                        </c:if>
                                    <li><a href="${not empty sessionScope.u? "logout" : "login"}"><i class="fa fa-lock"></i> ${not empty sessionScope.u? "Logout" : "Login"}</a></li>
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
            </div><!--/header-bottom-->




        </header>

        <div class="container mt-4 mb-5">
            <h2>My Sub-Orders</h2>

            <!-- Filter Section -->
            <div class="filter-section mb-3">
                <form action="MyOrderServlet" method="get" class="row">
                    <div class="col-md-3">
                        <label for="status" class="form-label">Status</label>
                        <select id="status" name="status" class="form-control">
                            <option value="">All</option>
                            <option value="Paid" ${param.status == 'Paid' ? 'selected' : ''}>Paid</option>
                            <option value="Unpaid" ${param.status == 'Unpaid' ? 'selected' : ''}>Unpaid</option>
                            <option value="Pending" ${param.status == 'Pending' ? 'selected' : ''}>Pending</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label for="startDate" class="form-label">From Date</label>
                        <input type="date" id="startDate" name="startDate" class="form-control" value="${param.startDate}">
                    </div>
                    <div class="col-md-3">
                        <label for="endDate" class="form-label">To Date</label>
                        <input type="date" id="endDate" name="endDate" class="form-control" value="${param.endDate}">
                    </div>
                    <div class="col-md-12 mt-3">
                        <button type="submit" class="btn btn-search"><i class="fas fa-search me-2"></i>Apply Filter</button>
                    </div>
                </form>
            </div>

            <!-- Pagination logic -->
            <%
                int subOrdersPerPage = 6;
                java.util.List<model.SubOrder> subOrderList = (java.util.List<model.SubOrder>) request.getAttribute("subOrderList");
                if (subOrderList == null) {
                    subOrderList = new java.util.ArrayList<>();
                }
                int totalSubOrders = subOrderList.size();
                int totalPages = (int) Math.ceil((double) totalSubOrders / subOrdersPerPage);
                int currentPage = 1;
                String pageParam = request.getParameter("page");
                if (pageParam != null) {
                    try {
                        currentPage = Integer.parseInt(pageParam);
                    } catch (NumberFormatException e) {
                        currentPage = 1;
                    }
                }
                if (currentPage < 1) currentPage = 1;
                if (currentPage > totalPages) currentPage = totalPages;

                int startIndex = (currentPage - 1) * subOrdersPerPage;
                int endIndex = Math.min(startIndex + subOrdersPerPage, totalSubOrders);
            %>

            <!-- Sub-order table -->
            <div class="table-responsive">
                <table id="subOrderTable" class="table table-bordered table-hover">
                    <thead class="thead-dark">
                        <tr>
                            <th>Sub-Order ID</th>
                            <th>Created Date</th>
                            <th>Products</th>
                            <th>Total Cost</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="subOrder" items="${subOrderList}" begin="<%=startIndex%>" end="<%=endIndex - 1%>">
                            <tr>
                                <td>${subOrder.id}</td>
                                <td>
                                    <fmt:formatDate value="${subOrder.createdDate}" pattern="dd-MM-yyyy HH:mm:ss"/>
                                </td>
                                <td>
                                    ${subOrder.receiverName}
                                    <c:if test="${not empty subOrder.receiverPhone}">
                                        ${subOrder.receiverPhone}
                                    </c:if>
                                </td>
                                <td><fmt:formatNumber value="${subOrder.totalAmount}" type="currency" currencySymbol="$"/></td>
                                <td>${subOrder.paymentStatus}</td>
                                <td>
                                    <a href="MyOrderDetailController?subOrderId=${subOrder.id}" class="btn btn-primary btn-sm">Chi tiết</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <div class="pagination">
                <%
                    String queryString = "";
                    if (request.getParameter("subOrderId") != null && !request.getParameter("subOrderId").isEmpty()) {
                        queryString += "&subOrderId=" + request.getParameter("subOrderId");
                    }
                    if (request.getParameter("status") != null && !request.getParameter("status").isEmpty()) {
                        queryString += "&status=" + request.getParameter("status");
                    }
                    if (request.getParameter("startDate") != null && !request.getParameter("startDate").isEmpty()) {
                        queryString += "&startDate=" + request.getParameter("startDate");
                    }
                    if (request.getParameter("endDate") != null && !request.getParameter("endDate").isEmpty()) {
                        queryString += "&endDate=" + request.getParameter("endDate");
                    }
                    if (!queryString.isEmpty()) {
                        queryString = queryString.substring(1);
                        queryString = "?" + queryString;
                    }

                    if (currentPage > 1) {
                        out.print("<a href='MyOrderServlet" + queryString + (queryString.isEmpty() ? "?" : "&") + "page=" + (currentPage - 1) + "'>Previous</a>");
                    } else {
                        out.print("<a class='disabled'>Previous</a>");
                    }

                    for (int i = 1; i <= totalPages; i++) {
                        if (i == currentPage) {
                            out.print("<a class='current'>" + i + "</a>");
                        } else {
                            out.print("<a href='MyOrderServlet" + queryString + (queryString.isEmpty() ? "?" : "&") + "page=" + i + "'>" + i + "</a>");
                        }
                    }

                    if (currentPage < totalPages) {
                        out.print("<a href='MyOrderServlet" + queryString + (queryString.isEmpty() ? "?" : "&") + "page=" + (currentPage + 1) + "'>Next</a>");
                    } else {
                        out.print("<a class='disabled'>Next</a>");
                    }
                %>
            </div>
        </div>

        <%@ include file="footer.jsp" %>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.querySelector('.filter-section form').addEventListener('submit', function (e) {
                const startDate = document.getElementById('startDate').value;
                const endDate = document.getElementById('endDate').value;

                if (startDate && endDate && new Date(startDate) > new Date(endDate)) {
                    e.preventDefault();
                    alert('Start date must be before end date');
                }
            });
        </script>
    </body>
</html>