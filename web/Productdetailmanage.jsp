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
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="java.util.Set, java.util.HashSet" %>
<%@ page import="model.Product, model.Brand, model.Category, model.Account,model.Slider,model.ProductImage,model.Color" %>
<%
 Account user = (Account) session.getAttribute("u");
%>
<%
 String productIdParam = request.getParameter("id");
if (productIdParam == null || productIdParam.trim().isEmpty()) {
    response.sendRedirect("productlistsevlet");
    return;
}

Product product = null;

try {
    int productId = Integer.parseInt(productIdParam);
    product = productDAO.getProductById(productId);
    if (product == null) { 
        // Nếu không tìm thấy sản phẩm -> chuyển hướng
        response.sendRedirect("ProductListServlet");
        return;
    }
    request.setAttribute("product", product);
} catch (NumberFormatException e) {
    System.out.println("Lỗi: ID sản phẩm không hợp lệ!");
    response.sendRedirect("ProductListServlet");
    return;
}

// Đảm bảo không bị NullPointerException
List<Color> colors = colorDAO.getAllColors();
List<ProductImage> images = productimageDAO.getImagesByProduct(product.getId());
if (images == null) {
    images = new ArrayList<>(); // Tránh lỗi NullPointerException
}

int firstColorID = images.isEmpty() ? 0 : images.get(0).getColorId();
String selectedColorId = request.getParameter("selectedColorId");

Set<Integer> existingColorIds = new HashSet<>();
for (ProductImage img : images) {
    existingColorIds.add(img.getColorId());
}

if (selectedColorId != null && !selectedColorId.trim().isEmpty()) {
    try {
        firstColorID = Integer.parseInt(selectedColorId);
        System.out.println("Color ID nhận được: " + firstColorID);
    } catch (NumberFormatException e) {
        System.out.println("Lỗi: selectedColorId không hợp lệ!");
    }
}

request.setAttribute("firstColorID", firstColorID);
request.setAttribute("colors", colors);
request.setAttribute("existingColorIds", existingColorIds);

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
                    Chỉnh sửa sản phẩm: ${product.name}
                </div>
                <div class="card-body">

                    <form action="productlistsevlet?action=update" enctype="multipart/form-data" method="post">
                        <input type="hidden" name="product_id" value="${product.id}">
                        <div id="product-image" class="form-group">
                            <c:set var="images" value="${productimageDAO.getImagesByProduct(product.id)}" />
                            <c:set var="firstImage" value="${not empty images ? images[0] : null}" />

                            <c:if test="${not empty firstImage}">
                                <c:forEach var="image" items="${images}" varStatus="status">
                                    <div class="image-container color-image-${image.colorId}" style="display: ${status.first ? 'block' : 'none'};">
                                        <!-- Ảnh minh họa chính -->
                                        <img src="${product.getImage()}" class="product-image">
                                        <input type="hidden" name="oldImgm" value="${product.getImage()}">
                                        <br>
                                        <label>Chọn ảnh minh họa:</label>
                                        <input type="file" name="imgm" class="image-file" accept="image/*" style="width: 100%; padding: 5px; font-size: 14px;">
                                        <p style="font-size: 13px; color: gray;">Ảnh hiện tại: ${product.getImage()}</p>
                                        <!-- Ảnh theo màu -->
                                        <img src="${image.imageUrl}" class="product-image" data-color="${image.colorId}">
                                        <input type="hidden" name="oldImg_${image.colorId}" value="${image.imageUrl}">
                                        <br>
                                        <label>Chọn ảnh theo màu:</label>
                                        <input type="file" name="img_${image.colorId}" class="image-file" accept="image/*" style="width: 100%; padding: 5px; font-size: 14px;">
                                        <p style="font-size: 13px; color: gray;">Ảnh hiện tại: ${image.imageUrl}</p>
                                    </div>
                                </c:forEach>

                            </c:if>
                        </div>

                        <div>
                            <button  type="button" class="btn btn-add" onclick="openColorModal()">
                                <i class="fa fa-plus"></i> Thêm màu sắc
                            </button>

                        </div>
                        <!-- Nút mở modal -->
                        <label for="color">Màu sắc:</label>
                        <select name="color" id="color" onchange="updateProductDetails()" class="form-control">


                            <c:forEach var="image" items="${productimageDAO.getImagesByProduct(product.id)}">
                                <option value="${image.colorId}" ${image.colorId == firstColorID ? 'selected' : ''}>
                                    ${colorDAO.getColorNameByID(image.colorId)}
                                </option>
                            </c:forEach>
                        </select>
                        <input type="hidden" id="selectedColorId" name="selectedColorId" value="${firstColorID}">


                        <div class="form-group">
                            <label>Tên sản phẩm:</label>
                            <input type="text" name="name" class="form-control" value="${product.name}" required>
                        </div>

                        <!-- Danh mục -->
                        <div class="form-group">
                            <label>Danh mục:</label>
                            <select name="category" class="form-control">
                                <c:forEach var="cat" items="${categoryDAO.getAllCategories()}">
                                    <option value="${cat.getId()}" <c:if test="${product.getTypeId() == cat.getId()}">selected</c:if>>${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Chất liệu:</label>
                            <select name="material" class="form-control">
                                <c:forEach var="brand" items="${materialDAO.getAllMaterial()}">
                                    <option value="${brand.getMid()}" <c:if test="${product.getMaterialId() == brand.getMid()}">selected</c:if>>${brand.getMname()}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="form-group">
                            <label>Mô tả sản phẩm:</label>
                            <input type="text" name="detail" class="form-control" value="${product.getDetails()}" required>
                        </div>
                        <div class="form-group">
                            <label>Nhãn hiệu:</label>
                            <select name="brand" class="form-control">
                                <c:forEach var="brand" items="${brandDAO.getAllBrands()}">
                                    <option value="${brand.getId()}" <c:if test="${product.getBrandId() == brand.getId()}">selected</c:if>>${brand.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Giá -->
                        <div class="form-group">
                            <label>Giá:</label>
                            <input type="number" name="price" class="form-control" value="${product.price}" required>
                        </div>

                        <!-- Trạng thái -->
                        <div class="form-group">
                            <label>Trạng thái:</label>
                            <select name="status" class="form-control">
                                <option value="true" <c:if test="${product.status}">selected</c:if>>Hiển thị</option>
                                <option value="false" <c:if test="${not product.status}">selected</c:if>>Ẩn</option>
                                </select>
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
                                    <c:forEach var="size" items="${productDAO.getSizesByProduct(product.id, firstColorID)}">
                                        <tr>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${size.sID == 1}">S</c:when>
                                                    <c:when test="${size.sID == 2}">M</c:when>
                                                    <c:when test="${size.sID == 3}">L</c:when>
                                                    <c:when test="${size.sID == 4}">XL</c:when>
                                                </c:choose>
                                            </td>
                                            <td>   <input type="number" name="quantities" min="0" value="${size.quantity}">
                                                <input type="hidden" name="sizeIds" value="${size.sID}"></td>
                                        </tr>
                                    </c:forEach>

                                </tbody>
                            </table>
                        </div>


                        <!-- Nút Cập Nhật -->
                        <button type="submit" class="btn btn-primary">Cập Nhật</button>
                    </form>
                </div>
            </div>
        </div>



        <!-- Modal -->
        <div id="colorModal" class="modal">
            <div class="modal-content">
                <span class="close" onclick="closeColorModal()">&times;</span>

                <h2>Thêm Màu Sắc</h2>
                <form id="colorForm" action="productlistsevlet?action=addcolor" enctype="multipart/form-data" method="POST">
                    <input type="hidden" name="product_id" value="${product.getId()}">
                    <!-- Chọn màu sắc -->
                    <div class="mb-3">
                        <label for="colorName" class="form-label">Màu sắc</label>
                        <select class="form-control" id="colorName" name="colorName" required>
                            <c:forEach var="color" items="${colors}">
                                <c:if test="${!existingColorIds.contains(color.getID())}">
                                    <option value="${color.getID()}">${color.getColorName()}</option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Nhập link ảnh -->
                    <div class="mb-3">
                        <label for="imageLink" class="form-label">Chọn ảnh</label>
                        <input type="file" class="form-control" id="imageLink" name="imageLink" accept="image/*" required>
                    </div>


                    <!-- Nhập số lượng theo size -->
                    <div class="mb-3">
                        <label class="form-label">Số lượng theo size</label>
                        <div class="row">
                            <div class="col">
                                <label for="size_S">S</label>
                                <input type="number" class="form-control" id="size_S" name="sizeQuantities[1]" min="0">
                            </div>
                            <div class="col">
                                <label for="size_M">M</label>
                                <input type="number" class="form-control" id="size_M" name="sizeQuantities[2]" min="0">
                            </div>
                            <div class="col">
                                <label for="size_L">L</label>
                                <input type="number" class="form-control" id="size_L" name="sizeQuantities[3]" min="0">
                            </div>
                            <div class="col">
                                <label for="size_XL">XL</label>
                                <input type="number" class="form-control" id="size_XL" name="sizeQuantities[4]" min="0">
                            </div>
                        </div>
                    </div>

                    <!-- Nút xác nhận -->
                    <button type="button" onclick="cancelColorForm()">Huỷ</button>
                    <button type="submit">Xác nhận</button>
                </form>

            </div>
        </div>
        <script>

            function openColorModal() {
                document.getElementById('colorModal').style.display = 'block';
            }


            function closeColorModal() {
                document.getElementById('colorModal').style.display = 'none';
                resetColorForm();
            }


            function cancelColorForm() {
                closeColorModal();
            }


            function confirmAddColor() {
                let form = document.getElementById("colorForm");

                if (!form.checkValidity()) {
                    alert("Vui lòng nhập đầy đủ thông tin trước khi thêm!");
                    return;
                }

                console.log("Submitting form...");

                form.submit();
            }


            // Reset form khi đóng modal
            function resetColorForm() {
                document.getElementById("colorForm").reset();
            }

            // Đóng modal khi nhấn ra ngoài
            window.onclick = function (event) {
                var modal = document.getElementById("colorModal");
                if (event.target === modal) {
                    closeColorModal();
                }
            }
        </script>

        <!-- CSS -->
        <style>
            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.4);
            }
            .modal-content {
                background-color: white;
                margin: 10% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 50%;
                border-radius: 5px;
            }
            .close {
                float: right;
                font-size: 28px;
                font-weight: bold;
                cursor: pointer;
            }
        </style>

        <jsp:include page="footer.jsp"/>
        <script>
            function updateProductDetails() {
                var selectedColor = document.getElementById("color").value;
                document.getElementById("selectedColorId").value = selectedColor; // Cập nhật giá trị mới
                var productId = "${product.id}";
                document.querySelectorAll(".image-container").forEach(container => container.style.display = "none");
                var selectedImageContainer = document.querySelector(".color-image-" + selectedColor);
                if (selectedImageContainer) {
                    selectedImageContainer.style.display = "block";
                }

                updateSizes();

            }

            function updateSizes() {
                var selectedColor = document.getElementById("selectedColorId").value;
                console.log("" + selectedColor);
                var xhr = new XMLHttpRequest();
                xhr.open("POST", window.location.href, true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                xhr.onload = function () {
                    if (xhr.status === 200) {
                        var tempDiv = document.createElement("div");
                        tempDiv.innerHTML = xhr.responseText;

                        var newSizeTable = tempDiv.querySelector("#size-quantity");
                        if (newSizeTable) {
                            document.getElementById("size-quantity").innerHTML = newSizeTable.innerHTML;
                            console.log(newSizeTable);
                        } else {
                            console.log("Không tìm thấy #size-quantity trong phản hồi từ JSP");
                        }
                    } else {
                        console.log("" + xhr.status);
                    }
                };

                xhr.onerror = function () {
                    console.log("Lỗi khi gửi request AJAX");
                };

                xhr.send("selectedColorId=" + encodeURIComponent(selectedColor));
            }


            document.addEventListener("DOMContentLoaded", function () {
                updateProductDetails();
            });

        </script>




        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
