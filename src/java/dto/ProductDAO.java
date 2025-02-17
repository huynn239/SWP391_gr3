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
        String sql = "Select * from Product order by ID DESC";

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

    public List<Product> getAllProductCat(int cat) {
        List<Product> productList = new ArrayList<>();
        String sql = "Select * from Product where TypeID = " + cat;

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

    public static void main(String[] args) {
        ProductDAO list = new ProductDAO();
        List<Product> a = list.getAllProducts();
        for (Product product : a) {
            System.out.println("" + product.getName());
        }
    }

}
