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
}
