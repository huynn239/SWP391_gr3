package controller;

import dto.OrderDAO;
import dto.OrderdetailDAO;
import dto.InventoryDAO;

import dto.DBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Order extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            int colorId = Integer.parseInt(request.getParameter("colorId"));
            int sizeId = Integer.parseInt(request.getParameter("sizeId"));

            InventoryDAO inventoryDAO = new InventoryDAO();
            int stock = inventoryDAO.getQuantity(productId, colorId, sizeId);

            out.write("{\"status\": \"success\", \"message\": \"" + stock + "\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"status\": \"error\", \"message\": \"Không thể lấy số lượng tồn kho: " + e.getMessage() + "\"}");
        } finally {
            out.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        Connection conn = null;
        try {
            // Lấy thông tin từ request
            String productId = request.getParameter("productId");
            String size = request.getParameter("size");
            String quantityStr = request.getParameter("quantity");
            String pricestr = request.getParameter("price");
            String color = request.getParameter("color");
            int colorID = Integer.parseInt(color);
            int quantity = Integer.parseInt(quantityStr);
            int productID = Integer.parseInt(productId);
            double price = Double.parseDouble(pricestr);

            HttpSession session = request.getSession();
            Account user = (Account) session.getAttribute("u");
            if (user == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.write("{\"status\": \"error\", \"message\": \"Vui lòng đăng nhập để đặt hàng!\"}");
                return;
            }

        
            conn = new DBContext().getConnection();
            conn.setAutoCommit(false);

            OrderDAO o = new OrderDAO();
            OrderdetailDAO od = new OrderdetailDAO();
            InventoryDAO inventoryDAO = new InventoryDAO();

            // Khóa bản ghi trong Product_Size để kiểm tra số lượng tồn kho
            String lockSql = "SELECT Quantity FROM ProductSize WITH (UPDLOCK) WHERE ProductID = ? AND ColorID = ? AND SizeID = ?";
            try (PreparedStatement lockStmt = conn.prepareStatement(lockSql)) {
                lockStmt.setInt(1, productID);
                lockStmt.setInt(2, colorID);
                lockStmt.setInt(3, Integer.parseInt(size));
                ResultSet rs = lockStmt.executeQuery();
                if (rs.next()) {
                    int stock = rs.getInt("Quantity");
                    if (quantity > stock) {
                        conn.rollback();
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        out.write("{\"status\": \"error\", \"message\": \"Sản phẩm không đủ số lượng, vui lòng giảm số lượng! Số lượng tồn kho hiện tại: " + stock + "\"}");
                        return;
                    }

                    // Cập nhật số lượng tồn kho
                    int newStock = stock - quantity;
                    String updateSql = "UPDATE ProductSize SET Quantity = ? WHERE ProductID = ? AND ColorID = ? AND SizeID = ?";
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                        updateStmt.setInt(1, newStock);
                        updateStmt.setInt(2, productID);
                        updateStmt.setInt(3, colorID);
                        updateStmt.setInt(4, Integer.parseInt(size));
                        updateStmt.executeUpdate();
                    }
                } else {
                    conn.rollback();
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    out.write("{\"status\": \"error\", \"message\": \"Sản phẩm không tồn tại!\"}");
                    return;
                }
            }

            // Tạo hoặc lấy orderID
            int orderID = o.getorderID(user.getId());
            if (o.checkCreateNewOrder(user.getId())) {
                o.insertOrder(user.getId());
                orderID = o.getorderID(user.getId());
            }

            // Thêm chi tiết đơn hàng
            od.insertOrderdetail(orderID, productID, quantity, size, color);
            o.updateTotalAmount(orderID);

            // Commit giao dịch
            conn.commit();
            out.write("{\"status\": \"success\", \"message\": \"Đặt hàng thành công!\"}");

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException se) {
                se.printStackTrace();
            }
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.write("{\"status\": \"error\", \"message\": \"Có lỗi xảy ra, vui lòng thử lại: " + e.getMessage() + "\"}");
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            out.close();
        }
    }

    @Override
    public String getServletInfo() {
        return "Order Servlet for handling order placement";
    }
}