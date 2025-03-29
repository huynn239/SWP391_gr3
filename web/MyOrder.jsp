<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="css/responsive.css" rel="stylesheet">
    <style>
        body {
            background: #f5f7fa;
            font-family: 'Roboto', sans-serif;
            font-size: 16px; /* Tăng font-size mặc định */
        }

        .container {
            max-width: 1400px;
        }

        h2 {
            font-size: 1.75rem; /* Tăng kích thước tiêu đề */
            color: #333;
            margin-bottom: 20px;
            text-align: center; /* Căn giữa tiêu đề */
        }

        /* Filter Section */
        .filter-section {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
        }

        .filter-section .form-label {
            font-size: 1rem;
            color: #333;
            margin-bottom: 8px;
        }

        .filter-section .form-control {
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            padding: 8px 12px;
            font-size: 1rem;
            height: 40px;
            transition: border-color 0.3s ease;
        }

        .filter-section .form-control:focus {
            border-color: #4CAF50;
            box-shadow: none;
        }

        .btn-search {
            background: #4CAF50;
            border: none;
            padding: 8px 20px;
            border-radius: 5px;
            font-size: 1rem;
            transition: background 0.3s ease;
        }

        .btn-search:hover {
            background: #45a049;
        }

        /* Table */
        .table-responsive {
            margin-bottom: 20px;
        }

        .table {
            background: white;
            border-radius: 8px;
            overflow: hidden;
        }

        .table thead {
            background: #f8f9fa;
        }

        .table th, .table td {
            vertical-align: middle;
            font-size: 1rem;
            padding: 12px;
        }

        .table th {
            font-weight: 600;
            color: #333;
        }

        .table td a {
            margin-right: 5px;
        }

        .btn-info, .btn-warning {
            font-size: 0.9rem;
            padding: 5px 10px;
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 5px;
            background-color: #f9f9f9;
        }

        .pagination a {
            margin: 0 5px;
            padding: 5px 10px;
            border: none;
            background: none;
            color: #333;
            text-decoration: none;
            cursor: pointer;
        }

        .pagination a.current {
            background-color: #e0e0e0; /* Nền màu xám nhạt cho trang hiện tại */
            border-radius: 3px;
        }

        .pagination a:hover {
            background-color: #f0f0f0;
            border-radius: 3px;
        }

        .pagination a.disabled {
            color: #ccc;
            cursor: not-allowed;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .filter-section .row {
                flex-direction: column;
                gap: 15px;
            }

            .filter-section .col-md-3 {
                width: 100%;
            }

            .btn-search {
                width: 100%;
            }

            .table th, .table td {
                font-size: 0.9rem;
                padding: 8px;
            }
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container mt-4 mb-5">
        <h2>My Orders</h2>

        <!-- Filter Section -->
        <div class="filter-section mb-3">
            <form action="MyOrderServlet" method="get" class="row">
                <div class="col-md-3">
                    <label for="orderId" class="form-label">Order ID</label>
                    <input type="text" id="orderId" name="orderId" class="form-control" value="${param.orderId}" placeholder="Enter Order ID">
                </div>
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

        <!-- Logic phân trang thủ công -->
        <%
            int ordersPerPage = 6; // Số đơn hàng trên mỗi trang
            java.util.List<model.Order> orderList = (java.util.List<model.Order>) request.getAttribute("orderList");
            if (orderList == null) {
                orderList = new java.util.ArrayList<>();
            }
            int totalOrders = orderList.size(); // Tổng số đơn hàng
            int totalPages = (int) Math.ceil((double) totalOrders / ordersPerPage); // Tổng số trang
            int currentPage = 1; // Trang hiện tại mặc định
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

            // Tính chỉ số bắt đầu và kết thúc của danh sách đơn hàng trên trang hiện tại
            int startIndex = (currentPage - 1) * ordersPerPage;
            int endIndex = Math.min(startIndex + ordersPerPage, totalOrders);
        %>

        <!-- Bảng danh sách đơn hàng -->
        <div class="table-responsive">
            <table id="orderTable" class="table table-bordered table-hover">
                <thead class="thead-dark">
                    <tr>
                        <th>Order ID</th>
                        <th>Ordered Date</th>
                        <th>Products</th>
                        <th>Total Cost</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orderList}" begin="<%=startIndex%>" end="<%=endIndex - 1%>">
                        <tr>
                            <td>${order.orderID}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty order.orderDateAsDate}">
                                        <fmt:formatDate value="${order.orderDateAsDate}" pattern="dd-MM-yyyy"/>
                                    </c:when>
                                    <c:otherwise>Not Available</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                ${order.firstProductName}
                                <c:if test="${order.otherProductsCount > 0}">
                                    (+${order.otherProductsCount} other products)
                                </c:if>
                            </td>
                            <td><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="$"/></td>
                            <td>${order.paymentStatus}</td>
                            <td>
                                <a href="OrderInfoServlet?orderId=${order.orderID}&fromPage=${currentPage}&fromOrderId=${param.orderId}&fromStatus=${param.status}&fromStartDate=${param.startDate}&fromEndDate=${param.endDate}" class="btn btn-info btn-sm">View</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Phân trang thủ công -->
        <div class="pagination">
            <%
                // Giữ các tham số lọc hiện tại
                String queryString = "";
                if (request.getParameter("orderId") != null && !request.getParameter("orderId").isEmpty()) {
                    queryString += "&orderId=" + request.getParameter("orderId");
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
                    queryString = queryString.substring(1); // Bỏ ký tự "&" đầu tiên
                    queryString = "?" + queryString;
                }

                // Nút Previous
                if (currentPage > 1) {
                    out.print("<a href='MyOrderServlet" + queryString + (queryString.isEmpty() ? "?" : "&") + "page=" + (currentPage - 1) + "'>Previous</a>");
                } else {
                    out.print("<a class='disabled'>Previous</a>");
                }

                // Các số trang
                for (int i = 1; i <= totalPages; i++) {
                    if (i == currentPage) {
                        out.print("<a class='current'>" + i + "</a>");
                    } else {
                        out.print("<a href='MyOrderServlet" + queryString + (queryString.isEmpty() ? "?" : "&") + "page=" + i + "'>" + i + "</a>");
                    }
                }

                // Nút Next
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
        // Form validation
        document.querySelector('.filter-section form').addEventListener('submit', function(e) {
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