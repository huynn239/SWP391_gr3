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
        String sql = "INSERT INTO Orders (PaymentStatus, OrderDate, TotalAmount, UsersID) VALUES (?, ?, ?, ?);";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "Unpaid");
            stmt.setDate(2, java.sql.Date.valueOf(LocalDate.now()));
            stmt.setInt(3, 0);
            stmt.setInt(4, userID);

            stmt.executeUpdate();
            System.out.println("Order created successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
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

    public void insertsubOrder(int userID, double totalAmount) {
        OrderDAO od = new OrderDAO();
        int orderID = od.getorderID(userID);
        String sql = "INSERT INTO suborder (OrderID, TotalAmount, PaymentStatus) VALUES (?, ?, ?)";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderID);
            stmt.setDouble(2, totalAmount);
            stmt.setString(3, "Unpaid");
            stmt.executeUpdate();
            System.out.println("SubOrder created successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
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

    public boolean checkCreateNewSubOrder(int userID) {
        String sql = """
        SELECT TOP 1 o.ID, s.PaymentStatus
        FROM Orders o
        LEFT JOIN suborder s ON o.ID = s.OrderID
        WHERE o.UsersID = ?
        ORDER BY s.ID DESC;
    """;

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

    public static void main(String[] args) {
        OrderDAO o = new OrderDAO();
        System.out.println("" + o.checkCreateNewSubOrder(1));
        o.addAddress("ad", "đá", "adasd", "đá", 1);

    }

}
