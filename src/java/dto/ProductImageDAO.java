/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.ProductImage;

/**
 *
 * @author BAO CHAU
 */
public class ProductImageDAO extends DBContext {

    public List<ProductImage> getAllImagesProduct() {
        List<ProductImage> images = new ArrayList<>();
        String sql = "SELECT * FROM ProductImage ";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                images.add(new ProductImage(rs.getInt("ID"), rs.getInt("ProductID"),
                        rs.getInt("ColorID"), rs.getString("ImageURL")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return images;
    }

    public List<ProductImage> getImagesByProduct(int id) {
        List<ProductImage> images = new ArrayList<>();
        String sql = "Select * from ProductImage where ProductID = ? ";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                images.add(new ProductImage(rs.getInt("ID"), rs.getInt("ProductID"),
                        rs.getInt("ColorID"), rs.getString("ImageURL")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return images;
    }

    public List<ProductImage> getImagesByProductId(int productId) {
        List<ProductImage> images = new ArrayList<>();
        String sql = "SELECT * FROM ProductImage WHERE ProductID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                images.add(new ProductImage(rs.getInt("ID"), rs.getInt("ProductID"),
                        rs.getInt("ColorID"), rs.getString("ImageURL")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return images;
    }

    public ProductImage getImageByProductColoe(int pid, int cid) {
        String sql = "Select * from ProductImage where ProductID = ? and ColorID = ? ";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, pid);
            stmt.setInt(2, cid);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new ProductImage(rs.getInt("ID"), rs.getInt("ProductID"),
                        rs.getInt("ColorID"), rs.getString("ImageURL"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean hasAnySizeWithQuantity(int productId, int quantity) {
        String sql = "SELECT * FROM ProductSize WHERE ProductID = ? AND Quantity = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, productId);
            stmt.setInt(2, quantity);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    return true; // chỉ cần có 1 dòng là thỏa
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean hasAnySizeWithQuantityLessThan(int productId, int threshold) {
        String sql = "SELECT * FROM ProductSize WHERE ProductID = ? AND Quantity < ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, productId);
            stmt.setInt(2, threshold);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    return true; // chỉ cần có 1 dòng là thỏa
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
