package dto;

import model.Brand;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BrandDAO extends DBContext {

    // Lấy danh sách tất cả brand từ database
    public List<Brand> getAllBrands() {
        List<Brand> brandList = new ArrayList<>();
        String sql = "SELECT * FROM brand";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Brand brand = new Brand(
                        rs.getString("id"),
                        rs.getString("name")
                );
                brandList.add(brand);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brandList;
    }
    public Brand getBrandById(String id) {
        Brand brand = null;
        String sql = "SELECT * FROM Brand WHERE ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                brand = new Brand(
                        rs.getString("id"),
                        rs.getString("name")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return brand;
    }
}
