package dto;

import model.Category;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO extends DBContext {

    // Lấy danh sách tất cả category từ database
    public List<Category> getAllCategories() {
        List<Category> categoryList = new ArrayList<>();
        String sql = "SELECT * FROM Category order by name";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("id"),
                        rs.getString("name")
                );
                categoryList.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categoryList;
    }
}
