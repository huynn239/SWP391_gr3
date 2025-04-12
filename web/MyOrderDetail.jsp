<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi Tiết Đơn Hàng #${subOrder.id}</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="css/main.css">

    </head>
    <body class="bg-light">
        <%-- <%@ include file="header.jsp" %> --%>
        <div style="height: 120px;"></div> <%-- placeholder giữ khoảng trống header --%>

        <div class="container mt-5 mb-5">
            <div class="card shadow-lg">
                <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                    <h4 class="mb-0">Chi Tiết Đơn Hàng #${subOrder.id}</h4>
                    <a href="MyOrderServlet" class="btn btn-light">
                        <i class="fas fa-arrow-left"></i> Quay lại danh sách
                    </a>
                </div>
                <div class="card-body">
                    <h5 class="mb-3 fw-bold">Thông Tin Đơn Hàng</h5>
                    <table class="table table-bordered">
                        <tbody>
                            <tr><th class="bg-light">Tổng Tiền</th><td><fmt:formatNumber value="${subOrder.totalAmount}" type="currency" currencySymbol="VNĐ"/></td></tr>
                            <tr><th class="bg-light">Trạng Thái</th><td>${subOrder.paymentStatus}</td></tr>
                            <tr><th class="bg-light">Người Nhận</th><td>${subOrder.receiverName}</td></tr>
                            <tr><th class="bg-light">Điện Thoại</th><td>${subOrder.receiverPhone}</td></tr>
                            <tr><th class="bg-light">Email</th><td>${subOrder.receiverEmail}</td></tr>
                            <tr><th class="bg-light">Địa Chỉ</th><td>${subOrder.receiverAddress}</td></tr>
                            <tr><th class="bg-light">Ngày Đặt Hàng</th><td><fmt:formatDate value="${subOrder.createdDate}" pattern="dd-MM-yyyy HH:mm:ss"/></td></tr>
                        </tbody>
                    </table>

                    <h5 class="mt-4 fw-bold">Danh Sách Sản Phẩm</h5>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                                <tr>
                                    <th>Hình Ảnh</th>
                                    <th>Sản Phẩm</th>
                                    <th>Số Lượng</th>
                                    <th>Giá</th>
                                    <th>Kích Cỡ</th>
                                    <th>Màu Sắc</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cart" items="${orderDetails}">
                                    <tr>
                                        <td><img src="${cart.image}" alt="Sản phẩm" width="60" class="img-thumbnail rounded"></td>
                                        <td class="fw-bold">${cart.name}</td>
                                        <td>${cart.quantity}</td>
                                        <td><fmt:formatNumber value="${cart.price}" type="currency" currencySymbol="VNĐ"/></td>
                                        <td>${cart.size}</td>
                                        <td>${cart.color}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="mt-3">
                <c:if test="${subOrder.paymentStatus == 'Unpaid'}">
                    <form action="cancelorder" method="post" style="display:inline;">
                        <input type="hidden" name="subOrderId" value="${subOrder.id}" />
                        <button type="submit" class="btn btn-danger">Huỷ Đơn</button>
                    </form>
                    <form action="orderinfo" method="post" style="display:inline;">
                        <input type="hidden" name="subOrderId" value="${subOrder.id}" />
                        <input type="hidden" name="fullname" value="${subOrder.receiverName}" />
                        <input type="hidden" name="phone" value="${subOrder.receiverPhone}" />
                        <input type="hidden" name="email" value="${subOrder.receiverEmail}" />
                        <input type="hidden" name="province" value="${fn:split(subOrder.receiverAddress, '-')[0]}" />
                        <input type="hidden" name="district" value="${fn:split(subOrder.receiverAddress, '-')[1]}" />
                        <input type="hidden" name="ward" value="${fn:split(subOrder.receiverAddress, '-')[2]}" />
                        <input type="hidden" name="address" value="${fn:split(subOrder.receiverAddress, '-')[3]}" />
                        <button type="submit" class="btn btn-success">Thanh Toán Ngay</button>
                    </form>

                </c:if>

                <c:if test="${subOrder.paymentStatus == 'Pending'}">
                    <form action="cancelorder" method="post" style="display:inline;">
                        <input type="hidden" name="subOrderId" value="${subOrder.id}" />
                        <button type="submit" class="btn btn-warning">Huỷ Đơn</button>
                    </form>
                </c:if>
            </div>

        </div>

        <%@ include file="footer.jsp" %>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
