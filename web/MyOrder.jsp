<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
</head>
<body>
    <%@ include file="header.jsp" %>

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