package dto;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;
import dto.DBContext;

import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Material;
import model.ProductImage;
import model.ProductSize;

public class ProductDAO extends DBContext {

    private Gson gson = new Gson();

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
                + "where Status = 1 and is_deleted = 0\n"
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
        String sql = "Select * from Product where is_deleted = 0 order by ID DESC ";

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
        String sql = "SELECT * FROM Product WHERE  is_deleted = 0 and ID = ?";
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
        String sql = "Select * from Product where Status = 1 and is_deleted = 0 and TypeID = " + cat;

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
        String sql = "SELECT * FROM Product WHERE Status = 1 and is_deleted = 0 AND Name LIKE ?";

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

    public List<ProductSize> getSizesByProduct(int pID, int cID) {
        List<ProductSize> list = new ArrayList<>();
        String sql = "Select * from ProductSize \n"
                + "where ProductID = ? and ColorID = ? ";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, pID);
            stmt.setInt(2, cID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ProductSize product = new ProductSize(
                        rs.getInt("ProductID"),
                        rs.getInt("SizeID"),
                        rs.getInt("Quantity"),
                        rs.getInt("ColorID")
                );
                list.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        ProductDAO list = new ProductDAO();
        list.addProductColor(1, 11, "abc");
    }

    public void updateProductSize(int productId, int selectedColorId, int sizeId, int quantity) {
        String sql = "Update ProductSize\n"
                + "Set Quantity = ?\n"
                + "where ProductID= ? and ColorID = ? and SizeID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, productId);
            stmt.setInt(3, selectedColorId);
            stmt.setInt(4, sizeId);
            int rowsUpdated = stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(Product product) {
        String sql = "UPDATE product \n"
                + "SET \n"
                + "    name = ?, \n"
                + "    MaterialID = ?, \n"
                + "    Price = ?, \n"
                + "    Details = ?, \n"
                + "    BrandID = ?, \n"
                + "    TypeID = ?, \n"
                + "    Status = ? \n"
                + "WHERE ID = ?;";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, product.getName());
            stmt.setInt(2, product.getMaterialId());
            stmt.setDouble(3, product.getPrice());
            stmt.setString(4, product.getDetails());
            stmt.setString(5, product.getBrandId());
            stmt.setInt(6, product.getTypeId());
            if (product.isStatus() == true) {
                stmt.setInt(7, 1);
            } else {
                stmt.setInt(7, 0);
            }
            stmt.setInt(8, product.getId());
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("OK");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateProductImage(String url, String urlm, int productId, int selectedColorId) {
        String sql = "Update ProductImage\n"
                + "set ImageURL = ?\n"
                + "where ProductID = ? and ColorID = ?";
        String sql1 = "Update Product\n"
                + "Set Image = ?\n"
                + "where ID = ? ";
        try (PreparedStatement stmt = connection.prepareStatement(sql); PreparedStatement stmt1 = connection.prepareStatement(sql1)) {
            stmt.setString(1, url);
            stmt.setInt(2, productId);
            stmt.setInt(3, selectedColorId);
            stmt.executeUpdate();
            stmt1.setString(1, urlm);
            stmt1.setInt(2, productId);
            stmt1.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addProductColor(int productId, int colorName, String imageLink) {
        String sql = "INSERT INTO ProductImage (ProductID, ColorID, ImageURL) VALUES (?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            stmt.setInt(2, colorName);
            stmt.setString(3, imageLink);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addProductSize(int productId, int colorName, int sizeId, int quantity) {
        String sql = "INSERT INTO ProductSize(ProductID, SizeID, Quantity,ColorID) VALUES (?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            stmt.setInt(2, sizeId);
            stmt.setInt(3, quantity);
            stmt.setInt(4, colorName);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void savePendingUpdate(String action, int productId, int userId, HashMap<String, Object> changes) {
        String sql = "INSERT INTO pending_updates (product_id, updated_by, changes, formatted_changes, status) VALUES (?, ?, ?, ?, 'pending')";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            if (action.equals("update")) {
                String json = new Gson().toJson(changes);
                String fullJson = action + " " + json;

                String formattedChanges = formatChanges(fullJson, productId);
                stmt.setInt(1, productId);
                stmt.setInt(2, userId);
                stmt.setString(3, fullJson);
                stmt.setString(4, formattedChanges);
                stmt.executeUpdate();
                System.out.println("Update request saved successfully!");
            } else if (action.equals("addColor")) {
                String json = new Gson().toJson(changes);
                String fullJson = action + " " + json;
                String formattedChanges = formatAddColorChange(fullJson);
                stmt.setInt(1, productId);
                stmt.setInt(2, userId);
                stmt.setString(3, fullJson);
                stmt.setString(4, formattedChanges);
                stmt.executeUpdate();
            } else if (action.equals("delete")) {
                stmt.setInt(1, productId);
                stmt.setInt(2, userId);
                stmt.setString(3, "Xóa sản phẩm");
                stmt.setString(4, "Xóa sản phẩm");
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public String formatAddColorChange(String json) {
        ProductDAO dao = new ProductDAO();
        int firstSpaceIndex = json.indexOf(" ");
        if (firstSpaceIndex == -1) {
            return json; // Nếu không có action, trả về nguyên chuỗi
        }

        String action = json.substring(0, firstSpaceIndex);
        String jsonData = json.substring(firstSpaceIndex + 1).trim(); // Phần JSON còn lại
        java.lang.reflect.Type type = new TypeToken<HashMap<String, Object>>() {
        }.getType();
        HashMap<String, Object> data = gson.fromJson(jsonData, type);
        StringBuilder sb = new StringBuilder();
        sb.append(action).append("<br>");
        int colorId = ((Double) data.get("color")).intValue();

        sb.append(" Thêm màu mới:  ").append(dao.getColorNamebyID(colorId)).append("<br>");

        List<Map<String, Object>> sizes = (List<Map<String, Object>>) data.get("sizes");
        Map<Integer, String> sizeMap = Map.of(1, "S", 2, "M", 3, "L", 4, "XL");

        sb.append("Kích thước và số lượng: <br>");
        for (Map<String, Object> size : sizes) {
            int sizeId = ((Double) size.get("sizeId")).intValue();
            int quantity = ((Double) size.get("quantity")).intValue();

            sb.append("- Size ").append(sizeMap.getOrDefault(sizeId, "Unknown"))
                    .append(": ").append(quantity).append(" cái<br>");
        }

        return sb.toString();
    }

    public String formatChanges(String json, int productid) {
        ProductDAO dao = new ProductDAO();
        ProductImageDAO daoimg = new ProductImageDAO();
        Product pro = dao.getProductById(productid);
        try {

            int firstSpaceIndex = json.indexOf(" ");
            if (firstSpaceIndex == -1) {
                return json; // Trả về nguyên chuỗi nếu không có action
            }
            String action = json.substring(0, firstSpaceIndex);
            String jsonData = json.substring(firstSpaceIndex + 1); // Phần JSON còn lại
            java.lang.reflect.Type type = new TypeToken<HashMap<String, Object>>() {
            }.getType();
            HashMap<String, Object> data = gson.fromJson(jsonData, type);
            StringBuilder sb = new StringBuilder();

            int colorid = ((Double) data.get("color")).intValue();
            List<ProductSize> ps = dao.getSizesByProduct(productid, colorid);
            ProductImage pi = daoimg.getImageByProductColoe(productid, colorid);

            sb.append(action).append("<br>");
            if (!pro.getName().equals(data.get("name").toString())) {
                sb.append("+ Tên Sản phẩm: ").append(pro.getName()).append(" ➝ ").append(data.get("name")).append("<br>");
            }
            if (!pro.getBrandId().equals(data.get("brandId").toString())) {
                sb.append("+ Thương hiệu: ").append(dao.getBrandNamebyID(pro.getBrandId())).append(" ➝ ").append(dao.getBrandNamebyID(data.get("brandId").toString())).append("<br>");
            }
            if (pro.getMaterialId() != ((Double) data.get("materialID")).intValue()) {
                sb.append("+ Chất liệu ID: ").append(dao.getMaterialNamebyID(pro.getMaterialId())).append(" ➝ ").append(removeDecimal(dao.getMaterialNamebyID(((Double) data.get("materialID")).intValue()))).append("<br>");
            }
            if (pro.getTypeId() != ((Double) data.get("categoryId")).intValue()) {
                sb.append("+ Danh mục ID: ").append(dao.getCategoryNamebyID(pro.getTypeId())).append(" ➝ ").append(removeDecimal(((Double) data.get("categoryId")).intValue())).append("<br>");
            }
            if (pro.getPrice() != ((Double) data.get("price")).intValue()) {
                sb.append("+ Giá: ").append(String.format("%,.0f", (double) pro.getPrice())).append(" ➝ ")
                        .append(String.format("%,.0f", data.get("price"))).append(" VND<br>");
            }
            if (!pro.getDetails().equals(data.get("detail").toString())) {
                sb.append("+ Chi tiết: ").append(pro.getDetails()).append(" ➝ ").append(data.get("detail")).append("<br>");
            }
            if (pro.isStatus() != (Boolean) data.get("status")) {
                sb.append("+ Trạng thái: ").append(pro.isStatus() ? "✅ Hiển thị" : "❌ Ẩn")
                        .append(" ➝ ").append((Boolean) data.get("status") ? "✅ Hiển thị" : "❌ Ẩn").append("<br>");
            }

            // So sánh kích cỡ và số lượng
            Map<Integer, String> sizeMap = Map.of(1, "S", 2, "M", 3, "L", 4, "XL");
            List<Map<String, Object>> sizes = (List<Map<String, Object>>) data.get("sizes");
            boolean hasSizeChange = false;
            StringBuilder sizeSb = new StringBuilder();

            for (Map<String, Object> size : sizes) {
                int sizeId = ((Double) size.get("sizeId")).intValue();
                int newQuantity = ((Double) size.get("quantity")).intValue();

                int oldQuantity = 0;
                for (ProductSize p : ps) {
                    if (p.getsID() == sizeId) {
                        oldQuantity = p.getQuantity();
                        break;
                    }
                }

                if (oldQuantity != newQuantity) {
                    sizeSb.append("Size ").append(sizeMap.getOrDefault(sizeId, "Unknown")).append(": ")
                            .append(oldQuantity).append(" ➝ ").append(newQuantity).append(" cái, ");
                    hasSizeChange = true;
                }
            }

            if (hasSizeChange) {
                sb.append("+ Kích cỡ: ").append(sizeSb.substring(0, sizeSb.length() - 2)).append("<br>");
            }

            if (!pro.getImage().equals(data.get("url").toString())) {
                sb.append("+ Hình ảnh minh họa (URL): ").append(pro.getImage()).append(" ➝ ").append(data.get("url")).append("<br>");
            }
            if (!pi.getImageUrl().equals(data.get("urlm").toString())) {
                sb.append("+ Hình ảnh màu: ").append(pro.getImage()).append(" ➝ ").append(data.get("urlm")).append("<br>");
            }
            System.out.println("" + sb);
            return sb.toString().trim();
        } catch (JsonSyntaxException e) {
            System.out.println("Lỗi JSON: " + e.getMessage());
        } catch (Exception e) {
            return "abc";
        }
        return "";
    }

    public String getBrandNamebyID(String brandID) {
        String sql = "Select Name from brand where ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, brandID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("Name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Không tìm thấy";
    }

    public String getCategoryNamebyID(int catID) {
        String sql = "Select Name from Category where ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, catID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("Name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Không tìm thấy";
    }

    public String getMaterialNamebyID(int matID) {
        String sql = "Select Name from Material where ID_Material = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, matID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("Name");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Không tìm thấy";
    }

    public String getColorNamebyID(int colorID) {
        String sql = "Select ColorName from Color where ID_Color = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, colorID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("ColorName");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Không tìm thấy";
    }

// Hàm loại bỏ số thập phân .0 nếu không cần thiết
    private String removeDecimal(Object value) {
        if (value instanceof Double) {
            return String.valueOf(((Double) value).intValue());
        }
        return String.valueOf(value);
    }

    public void deleteProduct(int productID, int userID) {
        String sql = "Update Product \n"
                + "Set is_deleted = 1,\n"
                + "deleted_by = ?\n"
                + "where ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            stmt.setInt(2, productID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
     public int getCountByDate(String date) {
    String sql = "SELECT COUNT(*) FROM [shopOnline].[dbo].[product] WHERE CONVERT(date, created_date) = ?";
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setString(1, date);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0;
}
      public List<String> getAllCategories() {
    List<String> categories = new ArrayList<>();
    String sql = "SELECT Name FROM Category";
    try (PreparedStatement stmt = connection.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {
        while (rs.next()) {
            String categoryName = rs.getString("Name");
            if (categoryName != null && !categoryName.trim().isEmpty()) {
                categories.add(categoryName);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return categories;
}


    public List<Product> getLatestProducts() {
    List<Product> productList = new ArrayList<>();
    String sql = "SELECT TOP 10 * FROM Product WHERE Status = 1 AND is_deleted = 0 ORDER BY ID DESC";
    try (PreparedStatement stmt = connection.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {
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
}
