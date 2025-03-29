<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Thêm Bài Viết Mới</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
        }
        input, textarea, select {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .error {
            color: red;
            margin-bottom: 10px;
        }
        button {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        .success {
            color: green;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
     <jsp:include page="header.jsp"></jsp:include>
    <div class="form-container">
        <h2>Add new post</h2>
<c:if test="${not empty successMessage}">
            <div class="success">${successMessage}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
       

        <form action="addPost" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="title">Title:</label>
                <input type="text" id="title" name="title" required>
            </div>
            <div class="form-group">
                <label for="content">Content:</label>
                <textarea id="content" name="content" rows="5" required></textarea>
            </div>
            <div class="form-group">
                <label for="blogImage">Image:</label>
                <input type="file" id="blogImage" name="blogImage" accept="image/*">
            </div>
            <div class="form-group">
                <label for="category">Categories:</label>
                <select id="category" name="category" required>
                    <option value="">Select categories</option>
                    <c:forEach var="category" items="${blogCategories}">
                        <option value="${category.id}">${category.name}</option>
                    </c:forEach>
                </select>
            </div>
            <button type="submit">Add new Post</button>
            <a href="postList">Back</a>
        </form>
    </div>
      <footer id="footer">
        <div class="footer-top">
            <div class="container">
                <div class="row">
                    <div class="col-sm-2">
                        <div class="companyinfo">
                            <h2><span>Men</span>-shopper</h2>
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor</p>
                        </div>
                    </div>
                    <div class="col-sm-7">
                        <div class="col-sm-3">
                            <div class="video-gallery text-center">
                                <a href="#"><div class="iframe-img"><img src="images/home/iframe1.png" alt="" /></div><div class="overlay-icon"><i class="fa fa-play-circle-o"></i></div></a>
                                <p>Circle of Hands</p>
                                <h2>24 DEC 2014</h2>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="video-gallery text-center">
                                <a href="#"><div class="iframe-img"><img src="images/home/iframe2.png" alt="" /></div><div class="overlay-icon"><i class="fa fa-play-circle-o"></i></div></a>
                                <p>Circle of Hands</p>
                                <h2>24 DEC 2014</h2>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="video-gallery text-center">
                                <a href="#"><div class="iframe-img"><img src="images/home/iframe3.png" alt="" /></div><div class="overlay-icon"><i class="fa fa-play-circle-o"></i></div></a>
                                <p>Circle of Hands</p>
                                <h2>24 DEC 2014</h2>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="video-gallery text-center">
                                <a href="#"><div class="iframe-img"><img src="images/home/iframe4.png" alt="" /></div><div class="overlay-icon"><i class="fa fa-play-circle-o"></i></div></a>
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
                            <h2>Dịch Vụ</h2>
                            <ul class="nav nav-pills nav-stacked">
                                <li><a href="#">Hỗ Trợ Online</a></li>
                                <li><a href="#">Liên Hệ</a></li>
                                <li><a href="#">Tình Trạng Đơn Hàng</a></li>
                                <li><a href="#">Thay Đổi Địa Điểm</a></li>
                                <li><a href="#">FAQ</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="single-widget">
                            <h2>Mua Sắm Nhanh</h2>
                            <ul class="nav nav-pills nav-stacked">
                                <li><a href="#">Áo Thun</a></li>
                                <li><a href="#">Đồ Nam</a></li>
                                <li><a href="#">Đồ Nữ</a></li>
                                <li><a href="#">Thẻ Quà Tặng</a></li>
                                <li><a href="#">Giày</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="single-widget">
                            <h2>Chính Sách</h2>
                            <ul class="nav nav-pills nav-stacked">
                                <li><a href="#">Điều Khoản Sử Dụng</a></li>
                                <li><a href="#">Chính Sách Bảo Mật</a></li>
                                <li><a href="#">Chính Sách Hoàn Tiền</a></li>
                                <li><a href="#">Hệ Thống Thanh Toán</a></li>
                                <li><a href="#">Hệ Thống Vé</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-2">
                        <div class="single-widget">
                            <h2>Về Shopper</h2>
                            <ul class="nav nav-pills nav-stacked">
                                <li><a href="#">Thông Tin Công Ty</a></li>
                                <li><a href="#">Tuyển Dụng</a></li>
                                <li><a href="#">Địa Điểm Cửa Hàng</a></li>
                                <li><a href="#">Chương Trình Liên Kết</a></li>
                                <li><a href="#">Bản Quyền</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-sm-3 col-sm-offset-1">
                        <div class="single-widget">
                            <h2>Về Shopper</h2>
                            <form action="#" class="searchform">
                                <input type="text" placeholder="Địa chỉ email của bạn" />
                                <button type="submit" class="btn btn-default"><i class="fa fa-arrow-circle-o-right"></i></button>
                                <p>Nhận cập nhật mới nhất từ trang web của chúng tôi...</p>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <div class="container">
                <div class="row">
                    <p class="pull-left">Bản quyền © 2013 Men-SHOPPER Inc. Đã đăng ký bản quyền.</p>
                    <p class="pull-right">Thiết kế bởi <span><a target="_blank" href="http://www.themeum.com">Themeum</a></span></p>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.ckeditor.com/4.18.0/standard/ckeditor.js"></script>
    <script>
        CKEDITOR.replace('content', {
            height: 200,
            filebrowserUploadUrl: '/uploadImage', // URL để xử lý upload ảnh trong CKEditor
            filebrowserUploadMethod: 'form'
        });
    </script>
</body>
</html>