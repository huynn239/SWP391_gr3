package dto;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Inventory;

public class InventoryDAO extends DBContext {

    // Lấy danh sách tồn kho theo ProductID
    public List<Inventory> getInventoryByProductId(int productId) {
        List<Inventory> inventoryList = new ArrayList<>();
        String sql = "SELECT * FROM [shopOnlineUpdate1].[dbo].[ProductSize] WHERE ProductID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Inventory inventory = new Inventory();
                    inventory.setProductId(rs.getInt("ProductID"));
                    inventory.setSizeId(rs.getInt("SizeID"));
                    inventory.setQuantity(rs.getInt("Quantity"));
                    inventory.setColorId(rs.getInt("ColorID"));
                    inventoryList.add(inventory);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error retrieving inventory for ProductID " + productId + ": " + e.getMessage());
        }
        System.out.println("Total inventory items retrieved for ProductID " + productId + ": " + inventoryList.size());
        return inventoryList;
    }

   
    public int getQuantity(int productId, int colorId, int sizeId) {
        String sql = "SELECT Quantity FROM [shopOnlineUpdate1].[dbo].[ProductSize] WHERE ProductID = ? AND ColorID = ? AND SizeID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, colorId);
            ps.setInt(3, sizeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("Quantity");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Error retrieving quantity for ProductID " + productId + ", ColorID " + colorId + ", SizeID " + sizeId + ": " + e.getMessage());
        }
        return 0; // Trả về 0 nếu không tìm thấy
    }
}