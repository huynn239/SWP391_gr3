/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.Product;

/**
 *
 * @author BAO CHAU
 */
public class OrderdetailDAO extends DBContext {

    public void insertOrderdetail(int orderID, int productId, int quantity, String size) {
        String checkSql = "SELECT Quantity FROM orderdetails WHERE OrderID = ? AND ProductID = ? AND Size = ?";
        String updateSql = "UPDATE orderdetails SET Quantity = Quantity + ? WHERE OrderID = ? AND ProductID = ? AND Size = ?";
        String insertSql = "INSERT INTO orderdetails (OrderID, ProductID, Quantity, Size) VALUES (?, ?, ?, ?)";

        try (PreparedStatement checkStmt = connection.prepareStatement(checkSql)) {
            checkStmt.setInt(1, orderID);
            checkStmt.setInt(2, productId);
            checkStmt.setString(3, size);

            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {  // Sản phẩm đã tồn tại -> Cập nhật số lượng
                try (PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {
                    updateStmt.setInt(1, quantity);
                    updateStmt.setInt(2, orderID);
                    updateStmt.setInt(3, productId);
                    updateStmt.setString(4, size);
                    updateStmt.executeUpdate();
                    System.out.println("Updated quantity for existing product in order!");
                }
            } else {  // Sản phẩm chưa có -> Thêm mới
                try (PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, orderID);
                    insertStmt.setInt(2, productId);
                    insertStmt.setInt(3, quantity);
                    insertStmt.setString(4, size);
                    insertStmt.executeUpdate();
                    System.out.println("New product added to order!");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Cart> cartDetail(int userID) {
        List<Cart> list = new ArrayList<>();
        OrderDAO od = new OrderDAO();
        int orderID = od.getorderID(userID);

        String sql = "SELECT p.ID,p.Image, p.Name, od.Size, p.Price, od.Quantity "
                + "FROM orderdetails od "
                + "JOIN Product p ON od.ProductID = p.ID "
                + "JOIN orders o ON od.OrderID = o.ID "
                + "WHERE od.OrderID = ? AND o.PaymentStatus = 'Unpaid'";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                list.add(new Cart(
                        rs.getString("Image"),
                        rs.getString("Name"),
                        rs.getString("Size"),
                        rs.getInt("Price"),
                        rs.getInt("Quantity"),
                        rs.getInt("ID")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void updateQuantity(int quantity, int productID, String size, int userID) {
        OrderDAO od = new OrderDAO();
        int orderID = od.getorderID(userID); // Lấy OrderID của người dùng

        String sql = "UPDATE orderdetails "
                + "SET Quantity = ? "
                + "WHERE OrderID = ? AND ProductID = ? AND Size = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, quantity);
            stmt.setInt(2, orderID);
            stmt.setInt(3, productID);
            stmt.setString(4, size);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Cập nhật số lượng thành công.");
                od.updateTotalAmount(orderID);
            } else {
                System.out.println("Không tìm thấy sản phẩm để cập nhật.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteCart(int productID, String size, int userID) {
        OrderDAO od = new OrderDAO();
        int orderID = od.getorderID(userID);
        String sql = "Delete from orderdetails\n"
                + "where ProductID = ? and OrderID = ? and Size = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, productID);
            stmt.setInt(2, orderID);
            stmt.setString(3, size);
            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                System.out.println("Xóa sản phẩm khỏi giỏ hàng thành công.");
                od.updateTotalAmount(orderID);
            } else {
                System.out.println("Không tìm thấy sản phẩm để xóa.");
            }

        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa sản phẩm khỏi giỏ hàng: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        OrderdetailDAO od = new OrderdetailDAO();
     
      od.insertOrderdetail(1, 1, 2, "S");
    }

}
