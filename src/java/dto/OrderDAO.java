/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Date;
import model.Category;

/**
 *
 * @author BAO CHAU
 */
public class OrderDAO extends DBContext {

    public void insertOrder(int userID) {
        String sql = "INSERT INTO Orders (PaymentStatus, OrderDate, TotalAmount, UsersID) VALUES (?, ?, ?, ?);";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "Unpaid");
            stmt.setDate(2, java.sql.Date.valueOf(LocalDate.now()));
            stmt.setInt(3, 0);
            stmt.setInt(4, userID);

            stmt.executeUpdate();
            System.out.println("Order created successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean checkSize(int quantity, int productId, String sizeName) {
        String sql = "Select Quantity from ProductSize ps join Size s on ps.SizeID = s.ID_Size\n"
                + "where s.SizeName = ? and ps.ProductID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, sizeName);
            stmt.setInt(2, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int number = rs.getInt("Quantity");
                if (quantity > number) {
                    return false;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true;
    }

    public boolean checkCreateNewOrder(int userID) {
        String sql = "SELECT TOP 1 PaymentStatus FROM Orders WHERE UsersID = ? ORDER BY ID DESC;";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String paymentStatus = rs.getString("PaymentStatus");
                return paymentStatus == null || paymentStatus.trim().isEmpty() || paymentStatus.equalsIgnoreCase("Paid");
            } else {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getorderID(int userID) {
        String sql = "SELECT TOP 1 ID FROM Orders WHERE UsersID = ? ORDER BY ID DESC;";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int oid = rs.getInt("ID");
                return oid;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void updateTotalAmount(int orderID) {
        String sql = "UPDATE orders \n"
                + "Set TotalAmount = (\n"
                + "    SELECT SUM(od.Quantity * p.Price) \n"
                + "    FROM orderdetails od\n"
                + "    JOIN Product p ON od.ProductID = p.ID\n"
                + "    WHERE od.OrderID = orders.ID\n"
                + "	)\n"
                + "WHERE orders.ID = ?;";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderID); // Cập nhật đúng đơn hàng theo ID
            int rowsUpdated = stmt.executeUpdate(); // Dùng executeUpdate() thay vì executeQuery()
            if (rowsUpdated > 0) {
                System.out.println("TotalAmount updated successfully!");
            } else {
                System.out.println("Order not found!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        OrderDAO o = new OrderDAO();
        System.out.println("" + o.checkSize(5, 1, "S"));
    }
}
