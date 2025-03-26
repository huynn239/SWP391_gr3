/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import model.Cart;
import model.Order;
import model.Product;

/**
 *
 * @author BAO CHAU
 */
public class OrderdetailDAO extends DBContext {

    public void insertOrderdetail(int orderID, int productId, int quantity, String size, String color) {
        String checkSql = "SELECT TOP 1 od.ID, od.Quantity, s.PaymentStatus FROM orderdetails od "
                + "LEFT JOIN suborder s ON od.SubOrderID = s.ID "
                + "WHERE od.OrderID = ? AND od.ProductID = ? AND od.Size = ? AND od.Color = ? "
                + "AND (s.PaymentStatus IS NULL OR s.PaymentStatus != 'Paid') "
                + "ORDER BY od.ID DESC";

        String updateSql = "UPDATE orderdetails SET Quantity = Quantity + ? WHERE ID = ?"; // Cập nhật số lượng

        String insertSql = "INSERT INTO orderdetails (OrderID, ProductID, Quantity, Size, Color) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement checkStmt = connection.prepareStatement(checkSql)) {
            checkStmt.setInt(1, orderID);
            checkStmt.setInt(2, productId);
            checkStmt.setString(3, size);
            checkStmt.setString(4, color);

            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {  // Nếu sản phẩm đã có trong giỏ hàng
                int orderDetailID = rs.getInt("ID"); // Lấy ID chính xác của order detail
                String paymentStatus = rs.getString("PaymentStatus");

                if (paymentStatus == null || !"Paid".equalsIgnoreCase(paymentStatus)) {
                    // Nếu đơn hàng chưa thanh toán, cập nhật số lượng
                    try (PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {
                        updateStmt.setInt(1, quantity);
                        updateStmt.setInt(2, orderDetailID);
                        updateStmt.executeUpdate();
                        System.out.println("Updated quantity for existing product in order!");
                    }
                } else {
                    // Nếu đơn hàng đã thanh toán, tạo mới bản ghi
                    try (PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {
                        insertStmt.setInt(1, orderID);
                        insertStmt.setInt(2, productId);
                        insertStmt.setInt(3, quantity);
                        insertStmt.setString(4, size);
                        insertStmt.setString(5, color);
                        insertStmt.executeUpdate();
                        System.out.println("New product added to order!");
                    }
                }
            } else {
                // Nếu sản phẩm chưa có -> Thêm mới vào giỏ hàng
                try (PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, orderID);
                    insertStmt.setInt(2, productId);
                    insertStmt.setInt(3, quantity);
                    insertStmt.setString(4, size);
                    insertStmt.setString(5, color);
                    insertStmt.executeUpdate();
                    System.out.println("New product added to order!");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Cart> cartDetail(int userID) {
        List<Cart> list = new ArrayList<>();
        OrderDAO od = new OrderDAO();
        int orderID = od.getorderID(userID);

        String sql = "SELECT p.ID, pis.ImageURL, p.Name, od.Size, p.Price, od.Quantity, od.CheckboxStatus,od.Color \n"
                + "                FROM orderdetails od \n"
                + "                JOIN Product p ON od.ProductID = p.ID \n"
                + "                JOIN orders o ON od.OrderID = o.ID \n"
                + "                LEFT JOIN suborder s ON od.SubOrderID = s.ID \n"
                + "				JOIN ProductImage pis on p.ID = pis.ProductID \n"
                + "                WHERE od.OrderID = ? and pis.ColorID = od.Color\n"
                + "                AND (\n"
                + "                   (s.ID IS NULL AND o.PaymentStatus = 'Unpaid')\n"
                + "                  OR (s.ID IS NOT NULL AND s.PaymentStatus = 'Unpaid') \n"
                + "                ) Order by od.ID";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Cart(
                        rs.getString("ImageURL"),
                        rs.getString("Name"),
                        rs.getString("Size"),
                        rs.getInt("Price"),
                        rs.getInt("Quantity"),
                        rs.getInt("ID"),
                        rs.getString("CheckboxStatus"),
                        rs.getString("Color")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void updateQuantity(int quantity, int productID, String size, int userID, String color) {
        OrderDAO od = new OrderDAO();
        int orderID = od.getorderID(userID);

        String sql = "UPDATE od\n"
                + "SET od.Quantity = ?\n"
                + "FROM orderdetails od\n"
                + "LEFT JOIN suborder s ON s.ID = od.SubOrderID\n"
                + "WHERE od.ID = (\n"
                + "    SELECT TOP 1 od_inner.ID\n"
                + "    FROM orderdetails od_inner\n"
                + "    LEFT JOIN suborder s_inner ON s_inner.ID = od_inner.SubOrderID\n"
                + "    WHERE od_inner.OrderID = ?\n"
                + "    AND od_inner.ProductID = ?\n"
                + "    AND od_inner.Size = ?\n"
                + "    AND od_inner.Color = ?\n"
                + "    ORDER BY od_inner.ID DESC\n"
                + ")\n"
                + "AND (s.PaymentStatus IS NULL OR s.PaymentStatus != 'Paid');";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, orderID);
            stmt.setInt(3, productID);
            stmt.setString(4, size);
            stmt.setString(5, color);
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Cập nhật số lượng thành công.");
                od.updateTotalAmount(orderID);
            } else {
                System.out.println("Không tìm thấy sản phẩm để cập nhật hoặc đơn hàng đã thanh toán.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteCart(int productID, String size, int userID, String color) {
        OrderDAO od = new OrderDAO();
        int orderID = od.getorderID(userID);

        String sql = "DELETE FROM orderdetails WHERE ID = ("
                + "    SELECT TOP 1 od.ID "
                + "    FROM orderdetails od "
                + "    LEFT JOIN suborder s ON s.ID = od.SubOrderID "
                + "    WHERE od.OrderID = ? AND od.ProductID = ? AND od.Size = ? AND od.Color = ? "
                + "    AND (s.PaymentStatus IS NULL OR s.PaymentStatus != 'Paid') "
                + "    ORDER BY od.ID DESC"
                + ")";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderID);
            stmt.setInt(2, productID);
            stmt.setString(3, size);
            stmt.setString(4, color);
            int rowsDeleted = stmt.executeUpdate();
            if (rowsDeleted > 0) {
                System.out.println("Xóa sản phẩm khỏi giỏ hàng thành công.");
                od.updateTotalAmount(orderID);
            } else {
                System.out.println("Không tìm thấy sản phẩm để xóa hoặc đơn hàng đã thanh toán.");
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi xóa sản phẩm khỏi giỏ hàng: " + e.getMessage());
        }
    }

    public boolean updateCheckboxStatus(int productId, String size, int userId, String status, String color) {
        OrderDAO od = new OrderDAO();
        int orderID = od.getorderID(userId);
        String sql = "UPDATE od\n"
                + "SET od.CheckboxStatus = ?\n"
                + "FROM orderdetails od\n"
                + "LEFT JOIN suborder s ON s.ID = od.SubOrderID\n"
                + "WHERE od.ID = (\n"
                + "    SELECT TOP 1 od_inner.ID\n"
                + "    FROM orderdetails od_inner\n"
                + "    LEFT JOIN suborder s_inner ON s_inner.ID = od_inner.SubOrderID\n"
                + "    WHERE od_inner.OrderID = ?\n"
                + "    AND od_inner.ProductID = ?\n"
                + "    AND od_inner.Size = ?\n"
                + "    AND od_inner.Color = ?\n"
                + "    ORDER BY od_inner.ID DESC\n"
                + ")\n"
                + "AND (s.PaymentStatus IS NULL OR s.PaymentStatus != 'Paid');";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            if (status.equals("checked")) {
                stmt.setString(1, "unchecked");
            } else {
                stmt.setString(1, "checked");
            }

            stmt.setInt(2, orderID);
            stmt.setInt(3, productId);
            stmt.setString(4, size);
            stmt.setString(5, color);
            stmt.executeUpdate();
            od.updateTotalAmount(orderID);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Cart> getSuborderbyID(int suborderID) {
        List<Cart> list = new ArrayList<>();

        String sql = " SELECT p.ID,p.Image, p.Name, od.Size, p.Price,od.Quantity,od.CheckboxStatus,od.Color \n"
                + "                FROM orderdetails od \n"
                + "                JOIN Product p ON od.ProductID = p.ID \n"
                + "				join suborder s on od.SubOrderID = s.ID\n"
                + "                WHERE s.ID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, suborderID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Cart(
                        rs.getString("Image"),
                        rs.getString("Name"),
                        rs.getString("Size"),
                        rs.getInt("Price"),
                        rs.getInt("Quantity"),
                        rs.getInt("ID"),
                        rs.getString("CheckboxStatus"),
                        rs.getString("Color")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;

    }

    public void updateToTalamountSuborder(int userID, List<Cart> selectedItems) {
        OrderDAO od = new OrderDAO();
        int subOrderID = od.getsuborderID(userID);

        if (subOrderID == 0) {
            return;
        }

        int totalAmount = 0;
        for (Cart item : selectedItems) {
            totalAmount += item.getPrice() * item.getQuantity();
        }

        String sql = "UPDATE suborder SET TotalAmount = ? WHERE ID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, totalAmount);
            stmt.setInt(2, subOrderID);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean updatesuborder(int userID, List<Cart> selectedItems) {
        OrderDAO od = new OrderDAO();
        int subOrderID = od.getsuborderID(userID);
        int orderID = od.getorderID(userID);

        if (subOrderID == 0 || orderID == 0) {
            return false;
        }

        List<Cart> oldList = getSuborderbyID(subOrderID);

        Set<String> newProductKeys = new HashSet<>();
        for (Cart item : selectedItems) {
            newProductKeys.add(item.getProductID() + "-" + item.getSize());
        }

        String sqlResetSubOrder = "UPDATE od\n"
                + "SET od.SubOrderID = NULL\n"
                + "FROM orderdetails od\n"
                + "LEFT JOIN suborder s ON s.ID = od.SubOrderID\n"
                + "WHERE od.ID = (\n"
                + "    SELECT TOP 1 od_inner.ID\n"
                + "    FROM orderdetails od_inner\n"
                + "    LEFT JOIN suborder s_inner ON s_inner.ID = od_inner.SubOrderID\n"
                + "    WHERE od_inner.OrderID = ?\n"
                + "    AND od_inner.ProductID = ?\n"
                + "    AND od_inner.Size = ?\n"
                + "    AND od_inner.Color = ?\n"
                + "    ORDER BY od_inner.ID DESC\n"
                + ")\n"
                + "AND (s.PaymentStatus IS NULL OR s.PaymentStatus != 'Paid');";

        try (PreparedStatement resetStmt = connection.prepareStatement(sqlResetSubOrder)) {
            for (Cart oldItem : oldList) {
                String key = oldItem.getProductID() + "-" + oldItem.getSize();
                if (!newProductKeys.contains(key)) {
                    resetStmt.setInt(1, orderID);
                    resetStmt.setInt(2, oldItem.getProductID());
                    resetStmt.setString(3, oldItem.getSize());
                    resetStmt.setString(4, oldItem.getColor());
                    resetStmt.addBatch();
                }
            }
            resetStmt.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        String sqlUpdateSubOrder = "UPDATE od\n"
                + "SET od.SubOrderID = ?\n"
                + "FROM orderdetails od\n"
                + "LEFT JOIN suborder s ON s.ID = od.SubOrderID\n"
                + "WHERE od.ID = (\n"
                + "    SELECT TOP 1 od_inner.ID\n"
                + "    FROM orderdetails od_inner\n"
                + "    LEFT JOIN suborder s_inner ON s_inner.ID = od_inner.SubOrderID\n"
                + "    WHERE od_inner.OrderID = ?\n"
                + "    AND od_inner.ProductID = ?\n"
                + "    AND od_inner.Size = ?\n"
                + "    AND od_inner.Color = ?\n"
                + "    ORDER BY od_inner.ID DESC\n"
                + ")\n"
                + "AND (s.PaymentStatus IS NULL OR s.PaymentStatus != 'Paid');";

        try (PreparedStatement updateStmt = connection.prepareStatement(sqlUpdateSubOrder)) {
            for (Cart item : selectedItems) {
                updateStmt.setInt(1, subOrderID);
                updateStmt.setInt(2, orderID);
                updateStmt.setInt(3, item.getProductID());
                updateStmt.setString(4, item.getSize());
                updateStmt.setString(5, item.getColor());
                updateStmt.addBatch();
            }
            int[] updatedRows = updateStmt.executeBatch();
            return updatedRows.length > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
    public boolean checkProductSizeAvailability(int subOrderID) {
    String sql = "SELECT od.ProductID, od.Quantity, od.Size, od.Color, ps.Quantity AS AvailableQty " +
                 "FROM orderdetails od " +
                 "JOIN ProductSize ps ON od.ProductID = ps.ProductID " +
                 "AND ps.SizeID = (SELECT ID_Size FROM Size WHERE SizeName = od.Size) " +
                 "AND ps.ColorID = (SELECT ID_Color FROM Color WHERE ColorName = od.Color) " +
                 "WHERE od.SubOrderID = ?";
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setInt(1, subOrderID);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            int orderedQty = rs.getInt("Quantity");
            int availableQty = rs.getInt("AvailableQty");
            if (orderedQty > availableQty) {
                return false; // Không đủ số lượng
            }
        }
        return true;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

public void updateProductSizeAfterPayment(int subOrderID) {
    String sqlSelect = "SELECT ProductID, Quantity, Size, Color " +
                      "FROM orderdetails WHERE SubOrderID = ?";
    String sqlUpdate = "UPDATE ProductSize " +
                       "SET Quantity = Quantity - ? " +
                       "WHERE ProductID = ? " +
                       "AND SizeID = (SELECT ID_Size FROM Size WHERE SizeName = ?) " +
                       "AND ColorID = ?"; // Dùng Color trực tiếp làm ColorID

    try {
        connection.setAutoCommit(false); // Bắt đầu transaction
        try (PreparedStatement selectStmt = connection.prepareStatement(sqlSelect)) {
            selectStmt.setInt(1, subOrderID);
            ResultSet rs = selectStmt.executeQuery();

            if (!rs.isBeforeFirst()) {
                System.out.println("No items found in orderdetails for SubOrderID: " + subOrderID);
                connection.commit();
                return;
            }

            int totalUpdatedRows = 0;
            try (PreparedStatement updateStmt = connection.prepareStatement(sqlUpdate)) {
                while (rs.next()) {
                    int productId = rs.getInt("ProductID");
                    int quantity = rs.getInt("Quantity");
                    String sizeName = rs.getString("Size");
                    String colorId = rs.getString("Color"); // Color là ID_Color

                    System.out.println("Updating ProductSize: ProductID=" + productId + 
                                      ", Quantity=" + quantity + ", Size='" + sizeName + 
                                      "', ColorID='" + colorId + "'");

                    updateStmt.setInt(1, quantity);
                    updateStmt.setInt(2, productId);
                    updateStmt.setString(3, sizeName);
                    updateStmt.setString(4, colorId); // Truyền Color trực tiếp làm ColorID
                    int updatedRows = updateStmt.executeUpdate();
                    totalUpdatedRows += updatedRows;

                    System.out.println("Rows updated for ProductID=" + productId + ": " + updatedRows);
                }
            }
            connection.commit();
            System.out.println("Total rows updated in ProductSize for SubOrderID: " + subOrderID + ": " + totalUpdatedRows);
        }
    } catch (SQLException e) {
        System.out.println("Error updating ProductSize for SubOrderID: " + subOrderID + ": " + e.getMessage());
        e.printStackTrace();
        try {
            connection.rollback();
        } catch (SQLException rollbackEx) {
            rollbackEx.printStackTrace();
        }
    } finally {
        try {
            connection.setAutoCommit(true);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
public String getReceiverName(int subOrderId) {
        String sql = "SELECT ReceiverName FROM suborder WHERE ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, subOrderId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("ReceiverName");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Khách hàng";
    }

    public String getReceiverAddress(int subOrderId) {
        String sql = "SELECT ReceiverAddress FROM suborder WHERE ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, subOrderId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("ReceiverAddress");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Không xác định";
    }
  public String getReceiverEmail(int subOrderId) {
        String sql = "SELECT ReceiverEmail FROM suborder WHERE ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, subOrderId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String email = rs.getString("ReceiverEmail");
                return email != null ? email : ""; // Trả về chuỗi rỗng nếu null
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ""; // Trả về chuỗi rỗng nếu không tìm thấy
    }

    public static void main(String[] args) {
        OrderdetailDAO od = new OrderdetailDAO();
        od.insertOrderdetail(1, 1, 1, "S", "Đen");
    }

}
