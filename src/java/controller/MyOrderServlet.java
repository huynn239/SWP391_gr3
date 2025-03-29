package controller;

import dto.SubOrderDAO;
import dto.ProductDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.SubOrder;
import model.Cart;
import model.Product;

@WebServlet(name = "MyOrderServlet", urlPatterns = {"/MyOrderServlet"})
public class MyOrderServlet extends HttpServlet {

    private static final int SUBORDERS_PER_PAGE = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Account user = (Account) request.getSession().getAttribute("u");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getId();
        SubOrderDAO subOrderDAO = new SubOrderDAO();
        ProductDAO productDAO = new ProductDAO();

        // Get filter parameters
        String subOrderIdParam = request.getParameter("subOrderId");
        String status = request.getParameter("status");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");

        // Fetch suborders
        List<SubOrder> allSubOrders = subOrderDAO.getSubOrdersByUserId(userId);
        System.out.println("User ID: " + userId + ", All sub-orders: " + allSubOrders.size());

        // Apply filters
        List<SubOrder> filteredSubOrders = new ArrayList<>(allSubOrders);
        if (subOrderIdParam != null && !subOrderIdParam.trim().isEmpty()) {
            try {
                int subOrderId = Integer.parseInt(subOrderIdParam);
                filteredSubOrders.removeIf(subOrder -> subOrder.getId() != subOrderId);
            } catch (NumberFormatException e) {
                // Ignore invalid SubOrder ID
            }
        }
        if (status != null && !status.isEmpty()) {
            filteredSubOrders.removeIf(subOrder -> !subOrder.getPaymentStatus().equalsIgnoreCase(status));
        }
        if (startDateStr != null && !startDateStr.isEmpty()) {
            Timestamp startDate = Timestamp.valueOf(startDateStr + " 00:00:00");
            filteredSubOrders.removeIf(subOrder -> subOrder.getCreatedDate() == null || 
                subOrder.getCreatedDate().before(startDate));
        }
        if (endDateStr != null && !endDateStr.isEmpty()) {
            Timestamp endDate = Timestamp.valueOf(endDateStr + " 23:59:59");
            filteredSubOrders.removeIf(subOrder -> subOrder.getCreatedDate() == null || 
                subOrder.getCreatedDate().after(endDate));
        }
        System.out.println("Filtered sub-orders: " + filteredSubOrders.size());

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

        int totalSubOrders = filteredSubOrders.size();
        int totalPages = totalSubOrders > 0 ? (int) Math.ceil((double) totalSubOrders / SUBORDERS_PER_PAGE) : 1;
        page = Math.max(1, Math.min(page, totalPages));

        int startIndex = (page - 1) * SUBORDERS_PER_PAGE;
        int endIndex = Math.min(startIndex + SUBORDERS_PER_PAGE, totalSubOrders);

        if (totalSubOrders == 0) {
            startIndex = 0;
            endIndex = 0;
        } else {
            startIndex = Math.max(0, startIndex);
            endIndex = Math.max(0, endIndex);
        }

        List<SubOrder> paginatedSubOrders = totalSubOrders > 0 ? 
            filteredSubOrders.subList(startIndex, endIndex) : new ArrayList<>();
        System.out.println("Paginated sub-orders: " + paginatedSubOrders.size());

        // Enrich suborders with product details
        for (SubOrder subOrder : paginatedSubOrders) {
            List<Cart> orderDetails = subOrderDAO.getOrderdetailbySuborder(subOrder.getId());
            if (!orderDetails.isEmpty()) {
                Cart firstDetail = orderDetails.get(0);
                subOrder.setReceiverName(firstDetail.getName());
                int otherProductsCount = orderDetails.size() - 1;
                subOrder.setReceiverPhone(otherProductsCount > 0 ? "+" + otherProductsCount + " other products" : "");
            } else {
                subOrder.setReceiverName("No Products");
                subOrder.setReceiverPhone("");
            }
        }

        // Fetch sidebar data
        List<String> categories = productDAO.getAllCategories();
        List<Product> latestProducts = productDAO.getLatestProducts();

        // Set attributes for JSP
        request.setAttribute("subOrderList", paginatedSubOrders);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("categories", categories != null ? categories : new ArrayList<>());
        request.setAttribute("latestProducts", latestProducts != null ? latestProducts : new ArrayList<>());

        RequestDispatcher dispatcher = request.getRequestDispatcher("MyOrder.jsp");
        dispatcher.forward(request, response);
    }
}