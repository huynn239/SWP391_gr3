/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
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


}
