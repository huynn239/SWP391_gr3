package dto;

import dto.DBContext;

import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO extends DBContext {

    // Lấy danh sách sản phẩm từ database
    public List<Product> getAllProducts() {
    List<Product> productList = new ArrayList<>();
    String sql = "SELECT * FROM Product";

    try (PreparedStatement stmt = connection.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {

        System.out.println("Query executed successfully! Fetching data...");

        while (rs.next()) {
            Product product = new Product(
                    rs.getInt("ID"),
                    rs.getString("Name"),
                    rs.getString("Image"),
                    rs.getString("Size"),
                    rs.getInt("MaterialID"),
                    rs.getDouble("Price"),
                    rs.getString("Details"),
                    rs.getInt("Quantity"),
                    rs.getString("BranchID"),
                    rs.getInt("TypeID")
            );
            productList.add(product);
        System.out.println("Query executed successfully! Fetching data...");

        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    if (productList.isEmpty()) {
        System.out.println("No products found in database.");
    }

    return productList;
}

}
