<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Quản Lý Bài Viết | Marketing Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/prettyPhoto.css" rel="stylesheet">
    <link href="css/price-range.css" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/responsive.css" rel="stylesheet">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
    <style>
        body {
            background-color: #f4f7fa;
        }
        .container {
            max-width: 1400px;
            margin-top: 20px;
        }
        .management-table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 8px;
            margin-bottom: 30px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .management-table th, .management-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .management-table th {
            background-color: #007bff;
            color: white;
            font-weight: 600;
        }
        .management-table tr:hover {
            background-color: #f8f9fa;
        }
        .pagination {
            display: flex;
            justify-content: center;
            list-style: none;
            padding-left: 0;
            margin-top: 20px;
        }
        .page-link {
            color: #007bff;
            padding: 8px 16px;
            text-decoration: none;
            border: 1px solid #ddd;
            margin: 0 4px;
            border-radius: 5px;
            background: white;
        }
        .page-link:hover {
            background-color: #e9ecef;
            border-color: #007bff;
        }
        .page-link.active {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
        .page-link.disabled {
            color: #ccc;
            pointer-events: none;
        }
        .search-bar, .action-bar {
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .action-btn {
            padding: 8px 16px;
            font-size: 14px;
        }
        .thumbnail-img {
            max-width: 100px;
            height: auto;
            border-radius: 4px;
        }
        .modal-body img {
            max-width: 100%;
            height: auto;
            border-radius: 4px;
        }
        .modal-body p {
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <!-- HEADER -->
    <jsp:include page="header.jsp"></jsp:include>

    <!-- MAIN CONTENT -->
    <section>
        <div class="container">
            <h2 class="title text-center" style="color: #2c3e50; margin-bottom: 30px;">Post Manager</h2>

            <!-- Thanh tìm kiếm -->
            <div class="search-bar">
                <form action="postList" method="GET" style="flex-grow: 1; display: flex; gap: 10px;">
                    <input type="text" name="keyword" value="${keyword}" placeholder="Tìm kiếm theo tiêu đề, nội dung hoặc tác giả..." class="form-control" style="flex-grow: 1;">
                    <button type="submit" class="btn btn-primary action-btn" style="
    margin-top: 0"><i class="fa fa-search"></i> Search</button>
                    <c:if test="${not empty categoryParam}">
                        <input type="hidden" name="category" value="${categoryParam}">
                    </c:if>
                    <c:if test="${not empty sortBy}">
                        <input type="hidden" name="sortBy" value="${sortBy}">
                    </c:if>
                    <c:if test="${not empty sortOrder}">
                        <input type="hidden" name="sortOrder" value="${sortOrder}">
                    </c:if>
                </form>
            </div>

            <!-- Nút thêm bài viết và sắp xếp -->
            <div class="action-bar">
                <a href="addPost" class="btn btn-success action-btn"><i class="fa fa-plus"></i> Add new Post</a>
                <form action="postList" method="GET" style="display: inline;">
                    <button type="submit" class="btn btn-default action-btn">
                        <i class="fa fa-clock-o"></i> Sort newest
                    </button>
                    <input type="hidden" name="sortBy" value="UploadDate">
                    <input type="hidden" name="sortOrder" value="DESC">
                    <c:if test="${not empty keyword}">
                        <input type="hidden" name="keyword" value="${keyword}">
                    </c:if>
                    <c:if test="${not empty categoryParam}">
                        <input type="hidden" name="category" value="${categoryParam}">
                    </c:if>
                </form>
            </div>

            <!-- Bảng danh sách bài viết -->
            <div class="management-table">
                <table class="management-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Title</th>
                            <th>Image</th>
                            <th>Author</th>
                            <th>Upload Date</th>
                            <th>Category</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty blogs}">
                                <tr>
                                    <td colspan="7" class="text-center">Không có bài viết nào.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="blog" items="${blogs}">
                                    <tr>
                                        <td>${blog.id}</td>
                                        <td><a href="postList?filterTitle=${blog.title}">${blog.title}</a></td>
                                        <td><img src="${blog.blogImage}" alt="${blog.title}" class="thumbnail-img"></td>
                                        <td><a href="postList?filterAuthor=${blog.author}">${blog.author}</a></td>
                                        <td>${blog.uploadDate}</td>
                                        <td><a href="postList?category=${blog.cateID}">${blog.categoryName}</a></td>
                                        <td>
                                            <button class="btn btn-info btn-sm action-btn view-detail" data-id="${blog.id}" data-toggle="modal" data-target="#postDetailModal">
                                                <i class="fa fa-eye"></i> Xem chi tiết
                                            </button>
                                            <a href="editPost?id=${blog.id}" class="btn btn-warning btn-sm action-btn"><i class="fa fa-edit"></i> Chỉnh Sửa</a>
                                            <a href="deletePost?id=${blog.id}" class="btn btn-danger btn-sm action-btn" onclick="return confirm('Bạn có chắc muốn xóa bài viết này?')"><i class="fa fa-trash"></i> Xóa</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a class="page-link" href="postList?page=${currentPage - 1}&sortBy=${sortBy}&sortOrder=${sortOrder}<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if><c:if test='${not empty categoryParam}'>&category=${categoryParam}</c:if><c:if test='${not empty filterTitle}'>&filterTitle=${filterTitle}</c:if><c:if test='${not empty filterAuthor}'>&filterAuthor=${filterAuthor}</c:if>">Back</a>
                </c:if>

                <c:forEach var="i" begin="1" end="${totalPages}">
                    <c:choose>
                        <c:when test="${i == currentPage}">
                            <span class="page-link active">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a class="page-link" href="postList?page=${i}&sortBy=${sortBy}&sortOrder=${sortOrder}<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if><c:if test='${not empty categoryParam}'>&category=${categoryParam}</c:if><c:if test='${not empty filterTitle}'>&filterTitle=${filterTitle}</c:if><c:if test='${not empty filterAuthor}'>&filterAuthor=${filterAuthor}</c:if>">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a class="page-link" href="postList?page=${currentPage + 1}&sortBy=${sortBy}&sortOrder=${sortOrder}<c:if test='${not empty keyword}'>&keyword=${keyword}</c:if><c:if test='${not empty categoryParam}'>&category=${categoryParam}</c:if><c:if test='${not empty filterTitle}'>&filterTitle=${filterTitle}</c:if><c:if test='${not empty filterAuthor}'>&filterAuthor=${filterAuthor}</c:if>">Next</a>
                </c:if>
            </div>

            <!-- Modal hiển thị chi tiết bài viết -->
            <div class="modal fade" id="postDetailModal" tabindex="-1" role="dialog" aria-labelledby="postDetailModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="postDetailModalLabel">Chi tiết bài viết</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">×</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <h4 id="modal-title"></h4>
                            <p><strong>Tác giả:</strong> <span id="modal-author"></span></p>
                            <p><strong>Ngày đăng:</strong> <span id="modal-uploadDate"></span></p>
                            <p><strong>Danh mục:</strong> <span id="modal-category"></span></p>
                            <img id="modal-image" src="" alt="Hình ảnh bài viết">
                            <p><strong>Nội dung:</strong></p>
                            <div id="modal-content"></div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- FOOTER -->
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

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.scrollUp.min.js"></script>
    <script src="js/price-range.js"></script>
    <script src="js/jquery.prettyPhoto.js"></script>
    <script src="js/main.js"></script>
    <script>
        $(document).ready(function() {
            $('.view-detail').click(function() {
                var postId = $(this).data('id');
                
                $.ajax({
                    url: 'postDetail',
                    type: 'GET',
                    data: { id: postId },
                    success: function(response) {
                        if (response.error) {
                            alert(response.error);
                        } else {
                            $('#modal-title').text(response.title);
                            $('#modal-author').text(response.author);
                            $('#modal-uploadDate').text(response.uploadDate);
                            $('#modal-category').text(response.categoryName);
                            $('#modal-image').attr('src', response.blogImage || 'images/default-placeholder.png'); 
                            $('#modal-content').html(response.content);
                            $('#postDetailModal').modal('show');
                        }
                    },
                    error: function(xhr, status, error) {
                        alert('Không thể tải chi tiết bài viết. Vui lòng thử lại!');
                    }
                });
            });
        });
    </script>
</body>
</html>