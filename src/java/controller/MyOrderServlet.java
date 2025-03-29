package controller;

import dto.OrderDAO;
import dto.OrderdetailDAO;
import dto.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Order;
import model.Orderdetail;
import model.Product;

@WebServlet(name = "MyOrderServlet", urlPatterns = {"/MyOrderServlet"})
public class MyOrderServlet extends HttpServlet {

    private static final int ORDERS_PER_PAGE = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account user = (Account) request.getSession().getAttribute("u");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId();
        OrderDAO orderDAO = new OrderDAO();
        ProductDAO productDAO = new ProductDAO();
        OrderdetailDAO orderDetailDAO = new OrderdetailDAO();

        // Get filter parameters
        String orderIdParam = request.getParameter("orderId");
        String status = request.getParameter("status");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");

        // Fetch all orders for the user
        List<Order> allOrders = orderDAO.getOrdersByUserId(userId);

        // Apply filters
        List<Order> filteredOrders = new ArrayList<>(allOrders);
        if (orderIdParam != null && !orderIdParam.trim().isEmpty()) {
            try {
                int orderId = Integer.parseInt(orderIdParam);
                filteredOrders.removeIf(order -> order.getOrderID() != orderId);
            } catch (NumberFormatException e) {
                // Ignore invalid Order ID
            }
        }
        if (status != null && !status.isEmpty()) {
            filteredOrders.removeIf(order -> !order.getPaymentStatus().equalsIgnoreCase(status));
        }
        if (startDateStr != null && !startDateStr.isEmpty()) {
            LocalDate startDate = LocalDate.parse(startDateStr);
            filteredOrders.removeIf(order -> order.getOrderDate() == null || order.getOrderDate().isBefore(startDate));
        }
        if (endDateStr != null && !endDateStr.isEmpty()) {
            LocalDate endDate = LocalDate.parse(endDateStr);
            filteredOrders.removeIf(order -> order.getOrderDate() == null || order.getOrderDate().isAfter(endDate));
        }

        // Pagination
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int totalOrders = filteredOrders.size();
        int totalPages = (int) Math.ceil((double) totalOrders / ORDERS_PER_PAGE);
        page = Math.max(1, Math.min(page, totalPages));

        int startIndex = (page - 1) * ORDERS_PER_PAGE;
        int endIndex = Math.min(startIndex + ORDERS_PER_PAGE, totalOrders);
        List<Order> paginatedOrders = filteredOrders.subList(startIndex, endIndex);

        // Enrich orders with product details
        for (Order order : paginatedOrders) {
            List<Orderdetail> orderDetails = orderDetailDAO.getOrderDetailsByOrderId(order.getOrderID());
            if (!orderDetails.isEmpty()) {
                Orderdetail firstDetail = orderDetails.get(0);
                Product firstProduct = productDAO.getProductById(firstDetail.getProductID());
                order.setFirstProductName(firstProduct != null ? firstProduct.getName() : "Unknown Product");
                int otherProductsCount = orderDetails.size() - 1;
                order.setOtherProductsCount(otherProductsCount > 0 ? otherProductsCount : 0);
            } else {
                order.setFirstProductName("No Products");
                order.setOtherProductsCount(0);
            }
        }

        // Fetch sidebar data
        List<String> categories = productDAO.getAllCategories();
        List<Product> latestProducts = productDAO.getLatestProducts();

        // Set attributes for JSP
        request.setAttribute("orderList", paginatedOrders);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("categories", categories != null ? categories : new ArrayList<>());
        request.setAttribute("latestProducts", latestProducts != null ? latestProducts : new ArrayList<>());

        RequestDispatcher dispatcher = request.getRequestDispatcher("MyOrder.jsp");
        dispatcher.forward(request, response);
    }
}