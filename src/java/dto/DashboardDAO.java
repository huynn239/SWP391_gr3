package dto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DashboardDAO extends DBContext {
    private Connection conn;

    public DashboardDAO() {
        conn = getConnection();
        if (conn == null) {
            throw new RuntimeException("Failed to initialize database connection");
        }
    }

    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) AS total FROM users";
        return executeCountQuery(sql, "getTotalUsers");
    }

    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) AS total FROM dbo.orders";
        return executeCountQuery(sql, "getTotalOrders");
    }

    public double getTotalSales() {
        String sql = "SELECT COALESCE(SUM(TotalAmount), 0) AS totalSales FROM dbo.orders";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble("totalSales");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    // Lấy TotalOrders trong 7 ngày gần nhất
    public List<Integer> getDailyOrdersLast7Days() {
        List<Integer> dailyOrders = new ArrayList<>();
        String sql = "SELECT CAST(OrderDate AS DATE) AS orderDate, COUNT(*) AS total " +
                     "FROM dbo.orders " +
                     "WHERE OrderDate >= DATEADD(day, -6, GETDATE()) " +
                     "GROUP BY CAST(OrderDate AS DATE) " +
                     "ORDER BY orderDate ASC";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            // Khởi tạo 7 ngày với giá trị 0
            for (int i = 0; i < 7; i++) {
                dailyOrders.add(0);
            }
            while (rs.next()) {
                java.sql.Date orderDate = rs.getDate("orderDate");
                int total = rs.getInt("total");
                long daysDiff = (System.currentTimeMillis() - orderDate.getTime()) / (1000 * 60 * 60 * 24);
                int index = 6 - (int) daysDiff; // Tính chỉ số trong 7 ngày
                if (index >= 0 && index < 7) {
                    dailyOrders.set(index, total);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dailyOrders;
    }

    // Lấy TotalSales trong 7 ngày gần nhất
    public List<Double> getDailySalesLast7Days() {
        List<Double> dailySales = new ArrayList<>();
        String sql = "SELECT CAST(OrderDate AS DATE) AS orderDate, COALESCE(SUM(TotalAmount), 0) AS totalSales " +
                     "FROM dbo.orders " +
                     "WHERE OrderDate >= DATEADD(day, -6, GETDATE()) " +
                     "GROUP BY CAST(OrderDate AS DATE) " +
                     "ORDER BY orderDate ASC";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            // Khởi tạo 7 ngày với giá trị 0
            for (int i = 0; i < 7; i++) {
                dailySales.add(0.0);
            }
            while (rs.next()) {
                java.sql.Date orderDate = rs.getDate("orderDate");
                double totalSales = rs.getDouble("totalSales");
                long daysDiff = (System.currentTimeMillis() - orderDate.getTime()) / (1000 * 60 * 60 * 24);
                int index = 6 - (int) daysDiff; // Tính chỉ số trong 7 ngày
                if (index >= 0 && index < 7) {
                    dailySales.set(index, totalSales);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dailySales;
    }

    private int executeCountQuery(String sql, String methodName) {
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void closeConnection() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}