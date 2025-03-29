<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="model.Product,model.ProductImage,model.Color,model.ProductSize" %>
<%@ page import="dto.ProductDAO, dto.CategoryDAO, dto.BrandDAO,dto.MaterialDAO,dto.ColorDAO" %>
<%@ page import="com.google.gson.Gson" %>
<jsp:useBean id="productDAO" class="dto.ProductDAO" scope="session"/>
<jsp:useBean id="categoryDAO" class="dto.CategoryDAO" scope="session"/>
<jsp:useBean id="brandDAO" class="dto.BrandDAO" scope="session"/>
<jsp:useBean id="productimageDAO" class="dto.ProductImageDAO" scope="session"/>
<jsp:useBean id="colorDAO" class="dto.ColorDAO" scope="session"/>
<jsp:useBean id="materialDAO" class="dto.MaterialDAO" scope="session"/>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set, java.util.HashSet" %>
<%@ page import="model.Product, model.Brand, model.Category, model.Account,model.Slider,model.ProductImage,model.Color,model.Material" %>
<%
 Account user = (Account) session.getAttribute("u");
%>
<%
    
    List<Category> categories = categoryDAO.getAllCategories();
    List<Material> materials = materialDAO.getAllMaterial();
    List<Brand> brands = brandDAO.getAllBrands();
    List<Color> colors = colorDAO.getAllColors();
    if (categories == null || categories.isEmpty() || 
        materials == null || materials.isEmpty() || 
        brands == null || brands.isEmpty() || 
        colors == null || colors.isEmpty()) {
        response.sendRedirect("home.jsp");
    }
    request.setAttribute("categories", categories);
    request.setAttribute("materials", materials);
    request.setAttribute("brands", brands);
    request.setAttribute("colors", colors);
%> 


<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi Tiết Sản Phẩm</title>
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
        <!-- Bootstrap CSS -->
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/font-awesome.min.css" rel="stylesheet">

        <style>
            .container {
                max-width: 80%;
                margin-top: 30px;
            }
            .card {
                margin-left: 20%;
                box-shadow: 0 0 20px rgba(0,0,0,0.1);
                border-radius: 10px;
                padding: 50px;
                width: 70%;
            }
            .card-header {
                background-color: #007bff;
                color: white;
                font-size: 1.5rem;
                font-weight: bold;
                padding: 15px;
                border-radius: 10px 10px 0 0;
            }
            .form-group {
                margin-bottom: 15px;
            }
            .btn-primary {
                width: 100%;
                padding: 12px;
                font-size: 1.2rem;
            }
            .product-image {
                width: 200px;
                height: auto;
                border-radius: 8px;
                margin-bottom: 15px;
            }
            .product-image-container {
                display: flex;
                align-items: center; /* Căn giữa theo chiều dọc */
                gap: 200px; /* Khoảng cách giữa hai ảnh */
            }

            .product-image-container img {
                max-width: 200px; /* Giới hạn kích thước ảnh */
                height: auto;
                border-radius: 10px;
                box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
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
        <a href="productlistsevlet" class="back-to-admin">Quay lại ProductList</a>
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
            <div class="card">
                <div class="card-header text-center">
                    Thêm sản phẩm
                </div>
                <div class="card-body">

                    <form action="productlistsevlet?action=addProduct" method="post">
                        <div id="product-image" class="form-group">
                            <label>Link ảnh minh họa:</label>
                            <input type="text" name="img" class="image-url" value="" style="width: 100%; padding: 5px; font-size: 14px;">
                            <br>
                            <label>Link ảnh:</label>
                            <input type="text" name="imgm" class="image-url" value="" style="width: 100%; padding: 5px; font-size: 14px;">
                        </div>


                        <!-- Nút mở modal -->
                        <label for="color">Màu sắc:</label>
                        <select name="color" id="color" class="form-control">
                            <c:forEach var="color" items="${colors}">
                                <option value="${color.getID()}">${color.getColorName()}</option>
                            </c:forEach>
                        </select>
                        <div class="form-group">
                            <label>Tên sản phẩm:</label>
                            <input type="text" name="name" class="form-control"  required>
                        </div>

                        <!-- Danh mục -->
                        <div class="form-group">
                            <label>Danh mục:</label>
                            <select name="category" class="form-control">
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}" >${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Chất liệu:</label>
                            <select name="material" class="form-control">
                                <c:forEach var="mat" items="${materials}">
                                    <option value="${mat.mid}" >${mat.mname}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Mô tả sản phẩm:</label>
                            <input type="text" name="detail" class="form-control" value="" required>
                        </div>
                        <div class="form-group">
                            <label>Nhãn hiệu:</label>
                            <select name="brand" class="form-control">
                                <c:forEach var="brand" items="${brands}">
                                    <option value="${brand.id}" >${brand.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Giá -->
                        <div class="form-group">
                            <label>Giá:</label>
                            <input type="number" name="price" class="form-control" value="" required>
                        </div>
                        <div class="form-group">
                            <label>Kích thước & Số lượng:</label>
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Size</th>
                                        <th>Số lượng</th>
                                    </tr>
                                </thead>
                                <tbody id="size-quantity">
                                    <tr>
                                        <td>S</td>
                                        <td>
                                            <input type="number" name="quantities" min="0" value="0">
                                            <input type="hidden" name="sizeIds" value="1">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>M</td>
                                        <td>
                                            <input type="number" name="quantities" min="0" value="0">
                                            <input type="hidden" name="sizeIds" value="2">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>L</td>
                                        <td>
                                            <input type="number" name="quantities" min="0" value="0">
                                            <input type="hidden" name="sizeIds" value="3">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>XL</td>
                                        <td>
                                            <input type="number" name="quantities" min="0" value="0">
                                            <input type="hidden" name="sizeIds" value="4">
                                        </td>
                                    </tr>
                                </tbody>

                            </table>
                        </div>


                        <!-- Nút Cập Nhật -->
                        <button type="submit" class="btn btn-primary">Thêm sản phẩm</button>
                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
