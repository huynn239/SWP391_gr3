package dto;

import model.Blog;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BlogDAO extends DBContext {

    // Lấy tất cả bài viết
 public List<Blog> getAllBlogs(int page, int limit) {
    List<Blog> blogList = new ArrayList<>();
    String sql = "SELECT b.ID, b.Title, b.Content, b.UploadDate, b.BlogImage, u.uName AS Author " +
                 "FROM [shopOnline].[dbo].[blog] b " +
                 "JOIN [shopOnline].[dbo].[users] u ON b.UsersID = u.ID " +
                 "ORDER BY b.UploadDate DESC " +
                 "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";

    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        int offset = (page - 1) * limit;

        stmt.setInt(1, offset);  // Tính toán offset (start row)
        stmt.setInt(2, limit);  // Lấy số lượng bài viết theo trang

        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Blog blog = new Blog(
                    rs.getInt("ID"),
                    rs.getString("Title"),
                    rs.getString("Content"),
                    rs.getString("BlogImage"),
                    rs.getDate("UploadDate"),
                    rs.getString("Author")  // Lấy tên tác giả
                );
                blogList.add(blog);
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return blogList;
}


   public int getTotalPages(int limit) {
    String sql = "SELECT COUNT(*) FROM [shopOnline].[dbo].[blog]";
    int totalRows = 0;

    try (PreparedStatement stmt = connection.prepareStatement(sql);
         ResultSet rs = stmt.executeQuery()) {
        if (rs.next()) {
            totalRows = rs.getInt(1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    // Tính toán tổng số trang
    return (int) Math.ceil((double) totalRows / limit);
}

}
