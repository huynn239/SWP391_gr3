package dto;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.SubOrder;

public class SubOrderDAO extends DBContext {

    public List<SubOrder> getSubOrdersByOrderId(int orderId) {
        List<SubOrder> subOrders = new ArrayList<>();
        String sql = "SELECT ID, OrderID, TotalAmount, PaymentStatus, ReceiverName, ReceiverPhone, "
                + "ReceiverEmail, ReceiverAddress, CreatedDate FROM suborder WHERE OrderID = ? "
                + "ORDER BY ID DESC";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                SubOrder subOrder = new SubOrder();
                subOrder.setId(rs.getInt("ID"));
                subOrder.setOrderId(rs.getInt("OrderID"));
                subOrder.setTotalAmount(rs.getDouble("TotalAmount"));
                subOrder.setPaymentStatus(rs.getString("PaymentStatus"));
                subOrder.setReceiverName(rs.getString("ReceiverName"));
                subOrder.setReceiverPhone(rs.getString("ReceiverPhone"));
                subOrder.setReceiverEmail(rs.getString("ReceiverEmail"));
                subOrder.setReceiverAddress(rs.getString("ReceiverAddress"));
                subOrder.setCreatedDate(rs.getTimestamp("CreatedDate"));
                subOrders.add(subOrder);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return subOrders;
    }

    public SubOrder getSubOrderBysubOrderId(int suborderId) {

        String sql = "SELECT * FROM suborder WHERE ID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, suborderId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                SubOrder subOrder = new SubOrder();
                subOrder.setId(rs.getInt("ID"));
                subOrder.setOrderId(rs.getInt("OrderID"));
                subOrder.setTotalAmount(rs.getDouble("TotalAmount"));
                subOrder.setPaymentStatus(rs.getString("PaymentStatus"));
                subOrder.setReceiverName(rs.getString("ReceiverName"));
                subOrder.setReceiverPhone(rs.getString("ReceiverPhone"));
                subOrder.setReceiverEmail(rs.getString("ReceiverEmail"));
                subOrder.setReceiverAddress(rs.getString("ReceiverAddress"));
                subOrder.setCreatedDate(rs.getTimestamp("CreatedDate"));
                return subOrder;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Cart> getOrderdetailbySuborder(int suborderID) {
        List<Cart> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    (SELECT TOP 1 pri.ImageURL \n"
                + "     FROM ProductImage pri \n"
                + "     WHERE pri.ColorID = od.Color AND pri.ProductID = p.ID\n"
                + "     ORDER BY pri.ID ASC) AS ImageURL, \n"
                + "    p.Name, \n"
                + "    od.Quantity, \n"
                + "    p.Price, \n"
                + "    od.Size, \n"
                + "    c.ColorName\n"
                + "FROM orderdetails od\n"
                + "JOIN suborder su ON od.SubOrderID = su.ID\n"
                + "JOIN Color c ON od.Color = c.ID_Color\n"
                + "JOIN Product p ON od.ProductID = p.ID\n"
                + "WHERE od.SubOrderID = ?\n"
                + "GROUP BY p.Name, od.Quantity, p.Price, od.Size, c.ColorName, od.Color, p.ID;";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, suborderID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Cart cart = new Cart();
                cart.setImage(rs.getString("ImageURl"));
                cart.setColor(rs.getString("ColorName"));
                cart.setPrice(rs.getInt("Price"));
                cart.setName(rs.getString("Name"));
                cart.setQuantity(rs.getInt("Quantity"));
                cart.setSize(rs.getString("Size"));
                list.add(cart);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteSubOrder(int subOrderId) {
        String sql = "DELETE FROM suborder WHERE ID = ? AND PaymentStatus != 'Paid'";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, subOrderId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateSubOrder(int subOrderId, String receiverName, String receiverPhone,
            String receiverEmail, String receiverAddress) {
        String sql = "UPDATE suborder SET ReceiverName = ?, ReceiverPhone = ?, ReceiverEmail = ?, "
                + "ReceiverAddress = ? WHERE ID = ? AND PaymentStatus != 'Paid'";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, receiverName);
            stmt.setString(2, receiverPhone);
            stmt.setString(3, receiverEmail);
            stmt.setString(4, receiverAddress);
            stmt.setInt(5, subOrderId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {
        SubOrderDAO sd = new SubOrderDAO();
        List<SubOrder> list = sd.getSubOrdersByOrderId(1);
        for (SubOrder subOrder : list) {
            System.out.println("" + subOrder.getId());
        }
    }
}