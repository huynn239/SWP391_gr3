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
