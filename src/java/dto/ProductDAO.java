package dto;

import dto.DBContext;

import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import model.Material;

public class ProductDAO extends DBContext {

    /**
     *
     * @param toString
     * @param params
     * @return
     */
    // Lấy danh sách sản phẩm từ database
    public List<Product> getAllProducts() {
        List<Product> productList = new ArrayList<>();
        String sql = "Select * from Product\n"
                + "where Status = 1\n"
                + "order by ID DESC ";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            System.out.println("Query executed successfully! Fetching data...");

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("ID"),
                        rs.getString("Name"),
                        rs.getString("Image"),
                        rs.getInt("MaterialID"),
                        rs.getDouble("Price"),
                        rs.getString("Details"),
                        rs.getString("BrandID"),
                        rs.getInt("TypeID"),
                        rs.getBoolean("Status")
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

    public List<Product> getAllProductmkt() {
        List<Product> productList = new ArrayList<>();
        String sql = "Select * from Product order by ID DESC ";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("ID"),
                        rs.getString("Name"),
                        rs.getString("Image"),
                        rs.getInt("MaterialID"),
                        rs.getDouble("Price"),
                        rs.getString("Details"),
                        rs.getString("BrandID"),
                        rs.getInt("TypeID"),
                        rs.getBoolean("Status")
                );
                productList.add(product);
                System.out.println("Query executed successfully! Fetching data...");

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }

    public Product getProductById(int id) {
        Product product = null;
        String sql = "SELECT * FROM Product WHERE Status = 1 and ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                product = new Product(
                        rs.getInt("ID"),
                        rs.getString("Name"),
                        rs.getString("Image"),
                        rs.getInt("MaterialID"),
                        rs.getDouble("Price"),
                        rs.getString("Details"),
                        rs.getString("BrandID"),
                        rs.getInt("TypeID"),
                        rs.getBoolean("Status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    public List<Product> getAllProductCat(int cat) {
        List<Product> productList = new ArrayList<>();
        String sql = "Select * from Product where Status = 1 and TypeID = " + cat;

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Product product = new Product(
                        rs.getInt("ID"),
                        rs.getString("Name"),
                        rs.getString("Image"),
                        rs.getInt("MaterialID"),
                        rs.getDouble("Price"),
                        rs.getString("Details"),
                        rs.getString("BrandID"),
                        rs.getInt("TypeID"),
                        rs.getBoolean("Status")
                );
                productList.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    public List<Product> searchProduct(String keyword) {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE Status = 1 AND Name LIKE ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%"); // Tìm kiếm tên chứa từ khóa
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product(
                            rs.getInt("ID"),
                            rs.getString("Name"),
                            rs.getString("Image"),
                            rs.getInt("MaterialID"),
                            rs.getDouble("Price"),
                            rs.getString("Details"),
                            rs.getString("BrandID"),
                            rs.getInt("TypeID"),
                            rs.getBoolean("Status")
                    );
                    productList.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }

    public static void main(String[] args) {
        ProductDAO list = new ProductDAO();
        List<Product> a = list.searchProduct("100");
        for (Product product : a) {
            System.out.println("" + product.getName());
        }
    }

}
