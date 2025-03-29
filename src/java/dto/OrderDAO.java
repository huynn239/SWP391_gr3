/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.security.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Address;
import model.Category;
import model.Order;

/**
 *
 * @author BAO CHAU
 */
public class OrderDAO extends DBContext {

    public void insertOrder(int userID) {
        // Kiểm tra xem UsersID đã tồn tại trong bảng orders chưa
        String checkSql = "SELECT COUNT(*) FROM orders WHERE UsersID = ?";
        try (PreparedStatement checkStmt = connection.prepareStatement(checkSql)) {
            checkStmt.setInt(1, userID);
            ResultSet rs = checkStmt.executeQuery();
            rs.next();
            int count = rs.getInt(1);

            if (count > 0) {
                // Nếu đã tồn tại, cập nhật PaymentStatus và TotalAmount
                String updateSql = "UPDATE orders SET PaymentStatus = ?, TotalAmount = (SELECT SUM(TotalAmount) FROM suborder WHERE OrderID = orders.ID), OrderDate = ? WHERE UsersID = ?";
                try (PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {
                    // Kiểm tra trạng thái của tất cả suborder để cập nhật PaymentStatus
                    String statusSql = "SELECT COUNT(*) AS unpaidCount FROM suborder WHERE OrderID = (SELECT ID FROM orders WHERE UsersID = ?)";
                    try (PreparedStatement statusStmt = connection.prepareStatement(statusSql)) {
                        statusStmt.setInt(1, userID);
                        ResultSet statusRs = statusStmt.executeQuery();
                        statusRs.next();
                        String paymentStatus = (statusRs.getInt("unpaidCount") > 0) ? "Unpaid" : "Paid";

                        updateStmt.setString(1, paymentStatus);
                        updateStmt.setTimestamp(2, new java.sql.Timestamp(new java.util.Date().getTime()));
                        updateStmt.setInt(3, userID);
                        updateStmt.executeUpdate();
                        System.out.println("Updated order for UserID: " + userID);
                    }
                }
            } else {
                // Nếu chưa tồn tại, tạo mới
                String insertSql = "INSERT INTO Orders (UsersID, OrderDate, TotalAmount, PaymentStatus) VALUES (?, ?, 0, 'Unpaid')";
                try (PreparedStatement insertStmt = connection.prepareStatement(insertSql)) {
                    insertStmt.setInt(1, userID);
                    insertStmt.setTimestamp(2, new java.sql.Timestamp(new java.util.Date().getTime()));
                    insertStmt.executeUpdate();
                    System.out.println("Inserted new order for UserID: " + userID);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean checkSize(int orderID, int quantity, int productId, String sizeName, int colorID) {
        String sql = "SELECT ps.Quantity FROM ProductSize ps "
                + "JOIN Size s ON ps.SizeID = s.ID_Size "
                + "JOIN Color c ON ps.ColorID = c.ID_Color "
                + "WHERE s.SizeName = ? AND c.ID_Color = ? AND ps.ProductID = ?";

        String sql1 = "SELECT quantity AS OrderedQuantity \n"
                + "FROM orderdetails od \n"
                + "LEFT JOIN suborder so ON od.SubOrderID = so.ID \n"
                + "WHERE od.ProductID = ? \n"
                + "AND od.Size = ? \n"
                + "AND od.Color = ? \n"
                + "AND (LOWER(so.PaymentStatus) != 'paid' OR so.PaymentStatus IS NULL) \n"
                + "AND od.OrderID = ?;";

        try (PreparedStatement stmt = connection.prepareStatement(sql); PreparedStatement stmt1 = connection.prepareStatement(sql1)) {

            // Lấy số lượng tồn kho
            stmt.setString(1, sizeName);
            stmt.setInt(2, colorID);
            stmt.setInt(3, productId);
            ResultSet rs = stmt.executeQuery();

            int availableQuantity = 0;
            if (rs.next()) {
                availableQuantity = rs.getInt("Quantity");
            } else {
                // Nếu sản phẩm chưa có trong kho
                return false;
            }

            // Lấy số lượng đã đặt nhưng chưa thanh toán
            stmt1.setInt(1, productId);
            stmt1.setString(2, sizeName);
            stmt1.setInt(3, colorID);
            stmt1.setInt(4, orderID);
            ResultSet rs1 = stmt1.executeQuery();

            int orderedQuantity = 0;
            if (rs1.next()) {
                orderedQuantity = rs1.getInt("OrderedQuantity");
            }

            int actualAvailable = availableQuantity - orderedQuantity;
            return quantity <= actualAvailable;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkSize(int quantity, int productId, String sizeName, int colorID) {
        String sql = "SELECT ps.Quantity FROM ProductSize ps "
                + "JOIN Size s ON ps.SizeID = s.ID_Size "
                + "JOIN Color c ON ps.ColorID = c.ID_Color "
                + "WHERE s.SizeName = ? AND c.ID_Color = ? AND ps.ProductID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, sizeName);
            stmt.setInt(2, colorID);
            stmt.setInt(3, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int availableQuantity = rs.getInt("Quantity");
                return quantity <= availableQuantity;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkCreateNewOrder(int userID) {
        String sql = "SELECT TOP 1 PaymentStatus FROM Orders WHERE UsersID = ? ORDER BY ID DESC;";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String paymentStatus = rs.getString("PaymentStatus");
                return paymentStatus == null || paymentStatus.trim().isEmpty() || paymentStatus.equalsIgnoreCase("Paid");
            } else {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void insertsubOrderWithOrderId(int orderID, double totalAmount) {
        String sql = "INSERT INTO suborder (OrderID, TotalAmount, PaymentStatus, CreatedDate) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderID);
            stmt.setDouble(2, totalAmount);
            stmt.setString(3, "Unpaid");
            stmt.setTimestamp(4, new java.sql.Timestamp(new java.util.Date().getTime()));
            stmt.executeUpdate();
            System.out.println("SubOrder created successfully with OrderID: " + orderID);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getFirstOrderID(int userID) {
        String sql = "SELECT TOP 1 ID FROM Orders WHERE UsersID = ? ORDER BY ID ASC;";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int orderId = rs.getInt("ID");
                System.out.println("Found first OrderID: " + orderId + " for UserID: " + userID);
                return orderId;
            } else {
                System.out.println("No OrderID found for UserID: " + userID);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getsuborderID(int userID) {
        String sql = "SELECT TOP 1 s.ID \n"
                + "FROM suborder s join orders o on s.OrderID = o.ID \n"
                + "WHERE UsersID = ? \n"
                + "ORDER BY s.ID DESC;";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int oid = rs.getInt("ID");
                return oid;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean checkCreateNewSubOrder(int orderId) {
        String sql = "SELECT TOP 1 PaymentStatus FROM suborder WHERE OrderID = ? ORDER BY ID DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String status = rs.getString("PaymentStatus");
                return "Paid".equals(status) || "Pending".equals(status);
            }
            return true; // Nếu không có suborder, cho phép tạo mới
        } catch (SQLException e) {
            e.printStackTrace();
            return true;
        }
    }

    public int getorderID(int userID) {
        String sql = "SELECT TOP 1 ID FROM Orders WHERE UsersID = ? ORDER BY ID DESC;";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int oid = rs.getInt("ID");
                return oid;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void updateTotalAmount(int orderID) {
        String sql = "UPDATE orders \n"
                + "Set TotalAmount = (\n"
                + "SELECT SUM(od.Quantity * p.Price)\n"
                + "FROM orderdetails od\n"
                + "JOIN Product p ON od.ProductID = p.ID\n"
                + "WHERE od.OrderID = orders.ID )\n"
                + "WHERE orders.ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderID); // Cập nhật đúng đơn hàng theo ID
            int rowsUpdated = stmt.executeUpdate(); // Dùng executeUpdate() thay vì executeQuery()
            if (rowsUpdated > 0) {
                System.out.println("TotalAmount updated successfully!");
            } else {
                System.out.println("Order not found!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateOrderInfo(String Name, String Phone, String Email, String Address, int userID) {
        int suborderID = new OrderDAO().getsuborderID(userID);
        String sql = "Update suborder\n"
                + "Set ReceiverName = ?,\n"
                + "ReceiverPhone = ?,\n"
                + "ReceiverEmail = ?,\n"
                + "ReceiverAddress = ?\n"
                + "where suborder.ID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, Name);
            stmt.setString(2, Phone);
            stmt.setString(3, Email);
            stmt.setString(4, Address);
            stmt.setInt(5, suborderID);
            int rowsUpdated = stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void addAddress(String Name, String Phone, String Email, String Address, int userID) {
        String sql = "INSERT INTO Address (UserID, ReceiverName, ReceiverPhone, ReceiverEmail, ReceiverAddress) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            stmt.setString(2, Name);
            stmt.setString(3, Phone);
            stmt.setString(4, Email);
            stmt.setString(5, Address);

            int rowsUpdated = stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Order getInfoOrder(int orderID) {
        String sql = "SELECT ReceiverName, ReceiverPhone, ReceiverEmail, ReceiverAddress FROM orders WHERE ID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderID);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Order(
                            rs.getString("ReceiverName"),
                            rs.getString("ReceiverPhone"),
                            rs.getString("ReceiverEmail"),
                            rs.getString("ReceiverAddress")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<Address> listAddress(int userID) {
        List<Address> list = new ArrayList<>();
        String sql = "Select * from Address\n"
                + "where UserID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userID);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(new Address(
                            rs.getInt("AddressID"),
                            userID,
                            rs.getString("ReceiverName"),
                            rs.getString("ReceiverPhone"),
                            rs.getString("ReceiverEmail"),
                            rs.getString("ReceiverAddress"))
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteAddress(int addressID) {
        String sql = "DELETE FROM Address WHERE AddressID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, addressID);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void updateSuborder(int userId, double totalAmount) {
        int suborderId = getsuborderID(userId);
        if (suborderId == 0) {
            return;
        }
        String sql = "UPDATE suborder SET TotalAmount = ? WHERE ID = ? AND PaymentStatus = 'Unpaid'";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setDouble(1, totalAmount);
            stmt.setInt(2, suborderId);
            stmt.executeUpdate();
            System.out.println("SubOrder updated successfully with ID: " + suborderId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateSuborderStatusToPaid(int userID) {
        String sql = "UPDATE suborder SET PaymentStatus = 'Paid' WHERE ID = ("
                + "SELECT TOP 1 ID FROM suborder WHERE OrderID = ("
                + "SELECT TOP 1 ID FROM Orders WHERE UsersID = ? ORDER BY ID DESC) "
                + "ORDER BY ID DESC)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Suborder status updated to Paid!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateOrderStatusIfAllSubordersPaid(int userId) {
        int orderId = getorderID(userId);
        if (orderId == 0) {
            return; // Không có OrderId để cập nhật
        }
        // Kiểm tra xem tất cả suborder đã Paid chưa
        String checkSql = "SELECT COUNT(*) AS unpaidCount FROM suborder WHERE OrderID = ? AND PaymentStatus = 'Unpaid'";
        String updateSql = "UPDATE orders SET PaymentStatus = 'Paid', TotalAmount = (SELECT SUM(TotalAmount) FROM suborder WHERE OrderID = ?) WHERE ID = ?";

        try (PreparedStatement checkStmt = connection.prepareStatement(checkSql); PreparedStatement updateStmt = connection.prepareStatement(updateSql)) {

            // Đếm số suborder chưa Paid
            checkStmt.setInt(1, orderId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next() && rs.getInt("unpaidCount") == 0) {
                // Nếu không còn suborder nào Unpaid, cập nhật orders
                updateStmt.setInt(1, orderId); // Tổng TotalAmount từ suborder
                updateStmt.setInt(2, orderId); // OrderId cần cập nhật
                int rowsUpdated = updateStmt.executeUpdate();
                if (rowsUpdated > 0) {
                    System.out.println("Order updated to Paid with TotalAmount for OrderID: " + orderId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateOrderTotalAndStatus(int orderId) {
        // Cập nhật TotalAmount bằng tổng TotalAmount của tất cả suborder
        String updateTotalSql = "UPDATE orders SET TotalAmount = (SELECT SUM(TotalAmount) FROM suborder WHERE OrderID = ?) WHERE ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(updateTotalSql)) {
            stmt.setInt(1, orderId);
            stmt.setInt(2, orderId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Kiểm tra trạng thái của tất cả suborder
        String checkPaidSql = "SELECT COUNT(*) AS notPaidCount FROM suborder WHERE OrderID = ? AND PaymentStatus != 'Paid'";
        String updateStatusSql = "UPDATE orders SET PaymentStatus = ? WHERE ID = ?";
        try (PreparedStatement checkStmt = connection.prepareStatement(checkPaidSql); PreparedStatement updateStmt = connection.prepareStatement(updateStatusSql)) {

            checkStmt.setInt(1, orderId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                int notPaidCount = rs.getInt("notPaidCount");
                updateStmt.setString(1, notPaidCount == 0 ? "Paid" : "Unpaid");
                updateStmt.setInt(2, orderId);
                updateStmt.executeUpdate();
                System.out.println("Order updated: TotalAmount and PaymentStatus for OrderID: " + orderId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateLatestSuborderStatusToPaid(int orderId) {
        String sql = "UPDATE suborder SET PaymentStatus = 'Paid' WHERE ID = (SELECT TOP 1 ID FROM suborder WHERE OrderID = ? ORDER BY ID DESC)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Latest Suborder status updated to Paid for OrderID: " + orderId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateLatestSuborderStatusToPending(int orderId) {
        String sql = "UPDATE suborder SET PaymentStatus = 'Pending' WHERE ID = (SELECT TOP 1 ID FROM suborder WHERE OrderID = ? ORDER BY ID DESC)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Latest Suborder status updated to Pending for OrderID: " + orderId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
     public Order getOrderById(int orderId) {
                Order order = null;
                String sql = "SELECT ID, PaymentStatus, OrderDate, TotalAmount, UsersID " +
                            "FROM Orders " +
                            "WHERE ID = ?";

                try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                    stmt.setInt(1, orderId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            order = new Order();
                            order.setOrderID(rs.getInt("ID"));
                            order.setPaymentStatus(rs.getString("PaymentStatus"));
                            java.sql.Date sqlDate = rs.getDate("OrderDate");
                            order.setOrderDate(sqlDate != null ? sqlDate.toLocalDate() : null);
                            order.setTotalAmount(rs.getDouble("TotalAmount"));
                            order.setUserID(rs.getInt("UsersID"));
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    System.out.println("Error in getOrderById: " + e.getMessage());
                }
                return order;
            }
            public List<Order> getOrdersByUserId(int userId) {
                List<Order> orders = new ArrayList<>();
                String sql = "SELECT ID, PaymentStatus, OrderDate, TotalAmount, UsersID " +
                            "FROM Orders " +
                            "WHERE UsersID = ? " +
                            "ORDER BY ID DESC";

                try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                    stmt.setInt(1, userId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        while (rs.next()) {
                            Order order = new Order();
                            order.setOrderID(rs.getInt("ID"));
                            order.setPaymentStatus(rs.getString("PaymentStatus"));
                            java.sql.Date sqlDate = rs.getDate("OrderDate");
                            order.setOrderDate(sqlDate != null ? sqlDate.toLocalDate() : null);
                            order.setTotalAmount(rs.getDouble("TotalAmount"));
                            order.setUserID(rs.getInt("UsersID"));
                            orders.add(order);
                        }
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                return orders;
            }

    public static void main(String[] args) {
        OrderDAO o = new OrderDAO();
        System.out.println("" + o.checkCreateNewSubOrder(1));
        o.addAddress("ad", "đá", "adasd", "đá", 1);

    }

}
