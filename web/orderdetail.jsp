<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết đơn hàng</title>
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
            .product{
                justify-content: center;
                text-align: center;
            }
            .description{
                justify-content: center;
                text-align: center;
            }
            .price{
                justify-content: center;
                text-align: center;
            }
            .total{
                justify-content: center;
                text-align: center;
            }
            .cart_quantity_button{
                 justify-content: center;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <a href="salesevlet" class="btn btn-primary btn-back">Quay lại</a>
            <h2 class="text-center">Thông tin đơn hàng</h2>
            <table class="table table-bordered">
                <tr><th>Mã đơn hàng:</th><td>${suborder.id}</td></tr>
                <tr><th>Ngày đặt hàng:</th><td>${suborder.createdDate}</td></tr>
                <tr><th>Tổng tiền:</th><td>$${suborder.totalAmount}</td></tr>
                <tr><th>Trạng thái thanh toán:</th><td>${suborder.paymentStatus}</td></tr>
                <tr><th>Tên người nhận:</th><td>${suborder.receiverName}</td></tr>
                <tr><th>Số điện thoại:</th><td>${suborder.receiverPhone}</td></tr>
                <tr><th>Email:</th><td>${suborder.receiverEmail}</td></tr>
                <tr><th>Địa chỉ nhận hàng:</th><td>${suborder.receiverAddress}</td></tr>
            </table>

            <h2 class="text-center">Danh sách sản phẩm</h2>
            <section id="cart_items">
                <div class="container">
                    <div class="table-responsive cart_info">
                        <table class="table table-condensed">
                            <thead>
                                <tr class="cart_menu" style="background: black; color: white; text-align: center;">
                                    <td class="image">Sản phẩm</td>
                                    <td class="description">Tên sản phẩm</td>
                                    <td class="price">Giá</td>
                                    <td class="quantity">Số lượng</td>
                                    <td class="total">Tổng</td>
                                    <td></td>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty cart}">
                                        <c:forEach var="c" items="${cart}">
                                            <tr>
                                                <td class="product">
                                                    <a href="#"><img src="${c.getImage()}" alt="" width="80"></a>
                                                </td>
                                                <td class="description">
                                                    <h4><a href="#">${c.getName()}</a></h4>
                                                    <p>Size: ${c.size} | <span class="color-id">${c.getColor()}</span></p>
                                                </td>
                                                <td class="price">
                                                    <p>$${c.getPrice()}</p>
                                                </td>
                                                <td class="quantity">
                                                    <div class="cart_quantity_button">
                                                        <input class="cart_quantity_input" type="text" name="quantity" value="${c.getQuantity()}" autocomplete="off" size="2" readonly>
                                                    </div>
                                                </td>
                                                <td class="total">
                                                    <p class="cart_total_price">$${c.getPrice() * c.getQuantity()}</p>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>

            <div class="row">
                <div class="col-sm-12 text-right">
                    <h3 style="margin-right: 20px;">Tổng tiền: <span style="color: red;">$${suborder.totalAmount}</span></h3>
                </div>
            </div>

        </div>
    </body>
</html>