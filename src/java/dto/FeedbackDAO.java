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

        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

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
        SELECT f.ID, f.RatedStar, f.Comment, f.ProductID, f.UsersID, f.Status, 
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
                rs.getString("ProductName"),
                rs.getString("FullName"),
                rs.getString("Email"),
                rs.getString("Mobile"),
                rs.getString("Status")
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
    public static void main(String[] args) {
    try {
        FeedbackDAO dao = new FeedbackDAO();
        List<Feedback> feedbacks = dao.getAllFeedbacks();
        System.out.println("Tổng số feedback: " + feedbacks.size());
    } catch (Exception e) {
        e.printStackTrace();
    }
}

}