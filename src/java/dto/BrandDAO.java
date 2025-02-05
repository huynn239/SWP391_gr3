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
}
