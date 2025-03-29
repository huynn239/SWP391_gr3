/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

/**
 *
 * @author thang
 */
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Feedback;

public class FeedbackDAO extends DBContext {

    public List<Feedback> getAllFeedbacks() throws Exception {
        List<Feedback> feedbackList = new ArrayList<>();
        String query = """
            SELECT f.ID, f.RatedStar, f.Comment, f.ProductID, f.UsersID, p.Name AS ProductName
            FROM feedback f
            JOIN Product p ON f.ProductID = p.ID
            ORDER BY f.ID DESC
        """;

        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Feedback feedback = new Feedback(
                        rs.getInt("ID"),
                        rs.getInt("RatedStar"),
                        rs.getString("Comment"),
                        rs.getInt("ProductID"),
                        rs.getInt("UsersID"),
                        rs.getString("ProductName")
                );
                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Ghi log lỗi SQL
            throw new RuntimeException("Lỗi truy vấn cơ sở dữ liệu: " + e.getMessage());
        }
        return feedbackList;
    }

    public Feedback getFeedbackById(int feedbackId) throws SQLException {
        String query = """
        SELECT f.ID, f.RatedStar, f.Comment, f.ProductID, f.UsersID, 
               f.FullName, f.Email, f.Mobile, p.Name AS ProductName
        FROM feedback f
        JOIN Product p ON f.ProductID = p.ID
        WHERE f.ID = ?
    """;
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, feedbackId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Feedback(
                        rs.getInt("ID"),
                        rs.getInt("RatedStar"),
                        rs.getString("Comment"),
                        rs.getInt("ProductID"),
                        rs.getInt("UsersID"),
                        rs.getString("FullName"),
                        rs.getString("Email"),
                        rs.getString("Mobile"),
                        rs.getString("ProductName")
                );
            }
        }
        return null;
    }

    public boolean updateFeedbackStatus(int feedbackId, String status) throws SQLException {
        String query = "UPDATE feedback SET Status = ? WHERE ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, status);
            stmt.setInt(2, feedbackId);
            return stmt.executeUpdate() > 0;
        }
    }
    public List<Feedback> getFeedbacksByProductId(int productId) throws SQLException {
    List<Feedback> feedbackList = new ArrayList<>();
    String query = """
        SELECT f.ID, f.RatedStar, f.Comment, f.ProductID, f.UsersID, 
               f.FullName, f.Email, f.Mobile, p.Name AS ProductName
        FROM feedback f
        JOIN Product p ON f.ProductID = p.ID
        WHERE f.ProductID = ?
        ORDER BY f.ID DESC
    """;

    try (PreparedStatement stmt = connection.prepareStatement(query)) {
        stmt.setInt(1, productId);
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Feedback feedback = new Feedback(
                    rs.getInt("ID"),
                    rs.getInt("RatedStar"),
                    rs.getString("Comment"),
                    rs.getInt("ProductID"),
                    rs.getInt("UsersID"),
                    rs.getString("FullName"),
                    rs.getString("Email"),
                    rs.getString("Mobile")
                );
                feedbackList.add(feedback);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        throw new SQLException("Lỗi khi lấy feedback: " + e.getMessage());
    }
    return feedbackList;
}
    public boolean addFeedback(Feedback feedback) {
        String sql = "INSERT INTO Feedback (ProductID, UsersID, FullName, Email, Mobile, Comment, RatedStar) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, feedback.getProductId());
            stmt.setInt(2, feedback.getUserId());
            stmt.setString(3, feedback.getFullName());
            stmt.setString(4, feedback.getEmail());
            stmt.setString(5, feedback.getMobile());
            stmt.setString(6, feedback.getComment());
            stmt.setInt(7, feedback.getRatedStar());
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Feedback inserted successfully for productId: " + feedback.getProductId());
                return true;
            } else {
                System.out.println("No rows affected when inserting feedback for productId: " + feedback.getProductId());
                return false;
            }
        } catch (SQLException e) {
            System.err.println("Error in addFeedback: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    public int getCountByDate(String date) {
    String sql = "SELECT COUNT(*) FROM [shopOnline].[dbo].[feedback] WHERE CONVERT(date, created_date) = ?";
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
    public List<Feedback> getFilteredFeedbacks(String keyword, Integer ratedStar) throws SQLException {
        List<Feedback> feedbackList = new ArrayList<>();
        StringBuilder query = new StringBuilder(
            "SELECT f.ID, f.RatedStar, f.Comment, f.ProductID, f.UsersID, p.Name AS ProductName " +
            "FROM feedback f " +
            "JOIN Product p ON f.ProductID = p.ID " +
            "WHERE 1=1"
        );

        // Thêm điều kiện lọc
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            query.append(" AND (p.Name LIKE ? OR f.Comment LIKE ?)");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        if (ratedStar != null) {
            query.append(" AND f.RatedStar = ?");
            params.add(ratedStar);
        }
        query.append(" ORDER BY f.ID DESC");

        try (PreparedStatement stmt = connection.prepareStatement(query.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Feedback feedback = new Feedback(
                        rs.getInt("ID"),
                        rs.getInt("RatedStar"),
                        rs.getString("Comment"),
                        rs.getInt("ProductID"),
                        rs.getInt("UsersID"),
                        rs.getString("ProductName")
                    );
                    feedbackList.add(feedback);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Lỗi khi lấy danh sách phản hồi: " + e.getMessage());
        }
        return feedbackList;
    }

}