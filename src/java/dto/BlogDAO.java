package dto;

import model.Blog;
import model.Category;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BlogDAO extends DBContext {

    // Lấy tất cả bài viết với phân trang và sắp xếp
    public List<Blog> getAllBlogs(int page, int limit, String sortBy, String sortOrder) {
        List<Blog> blogList = new ArrayList<>();
        String sql = "SELECT b.ID, b.Title, b.Content, b.UploadDate, b.BlogImage, u.uName AS Author, b.CateID " +
                     "FROM [shopOnline2].[dbo].[blog] b " +
                     "JOIN [shopOnline2].[dbo].[users] u ON b.UsersID = u.ID " +
                     "ORDER BY " + (sortBy != null ? sortBy : "b.UploadDate") + " " + (sortOrder != null ? sortOrder : "DESC") + " " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            int offset = (page - 1) * limit;
            stmt.setInt(1, offset);
            stmt.setInt(2, limit);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    blogList.add(new Blog(
                        rs.getString("ID"),
                        rs.getString("Title"),
                        rs.getString("Content"),
                        rs.getString("BlogImage"),
                        rs.getDate("UploadDate"),
                        rs.getString("Author"),
                        rs.getInt("CateID")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println("Total blogs retrieved: " + blogList.size()); // Debug
        return blogList;
    }
    public boolean addBlog(Blog blog, String userId) {
        String sql = "INSERT INTO [shopOnline2].[dbo].[blog] (Title, Content, BlogImage, UploadDate, UsersID, CateID) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, blog.getTitle());
            stmt.setString(2, blog.getContent());
            stmt.setString(3, blog.getBlogImage());
            stmt.setDate(4, blog.getUploadDate());
            stmt.setString(5, userId);
            stmt.setInt(6, blog.getCateID());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Lấy tổng số trang của blog
    public int getTotalPages(int limit) {
        String sql = "SELECT COUNT(*) FROM [shopOnline2].[dbo].[blog]";
        int totalRows = 0;

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                totalRows = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return (int) Math.ceil((double) totalRows / limit);
    }

    // Lấy danh mục blog từ bảng categoryblog
    public List<Category> getAllBlogCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT ID, Name FROM [shopOnline2].[dbo].[categoryblog]";

        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                categories.add(new Category(
                    rs.getInt("ID"),
                    rs.getString("Name")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    // Lấy blog theo danh mục với phân trang và sắp xếp
    public List<Blog> getBlogsByCategory(int categoryId, int page, int limit, String sortBy, String sortOrder) {
        List<Blog> blogList = new ArrayList<>();
        String sql = "SELECT b.ID, b.Title, b.Content, b.UploadDate, b.BlogImage, u.uName AS Author, b.CateID " +
                     "FROM [shopOnline2].[dbo].[blog] b " +
                     "JOIN [shopOnline2].[dbo].[users] u ON b.UsersID = u.ID " +
                     "WHERE b.CateID = ? " +
                     "ORDER BY " + (sortBy != null ? sortBy : "b.UploadDate") + " " + (sortOrder != null ? sortOrder : "DESC") + " " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            int offset = (page - 1) * limit;
            stmt.setInt(1, categoryId);
            stmt.setInt(2, offset);
            stmt.setInt(3, limit);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    blogList.add(new Blog(
                        rs.getString("ID"),
                        rs.getString("Title"),
                        rs.getString("Content"),
                        rs.getString("BlogImage"),
                        rs.getDate("UploadDate"),
                        rs.getString("Author"),
                        rs.getInt("CateID")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogList;
    }

    // Lấy tổng số trang của blog theo danh mục
    public int getTotalPagesByCategory(int categoryId, int limit) {
        String sql = "SELECT COUNT(*) FROM [shopOnline2].[dbo].[blog] WHERE CateID = ?";
        int totalRows = 0;

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    totalRows = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return (int) Math.ceil((double) totalRows / limit);
    }

    // Tìm kiếm blog với phân trang và sắp xếp
    public List<Blog> searchBlogs(String keyword, int page, int limit, String sortBy, String sortOrder) {
        List<Blog> blogList = new ArrayList<>();
        String sql = "SELECT b.ID, b.Title, b.Content, b.UploadDate, b.BlogImage, u.uName AS Author, b.CateID " +
                     "FROM [shopOnline2].[dbo].[blog] b " +
                     "JOIN [shopOnline2].[dbo].[users] u ON b.UsersID = u.ID " +
                     "JOIN [shopOnline2].[dbo].[categoryblog] c ON b.CateID = c.ID " +
                     "WHERE c.Name LIKE ? OR b.Title LIKE ? OR b.Content LIKE ? OR u.uName LIKE ? " +
                     "ORDER BY " + (sortBy != null ? sortBy : "b.UploadDate") + " " + (sortOrder != null ? sortOrder : "DESC") + " " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            int offset = (page - 1) * limit;
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            stmt.setString(4, searchPattern);
            stmt.setInt(5, offset);
            stmt.setInt(6, limit);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    blogList.add(new Blog(
                        rs.getString("ID"),
                        rs.getString("Title"),
                        rs.getString("Content"),
                        rs.getString("BlogImage"),
                        rs.getDate("UploadDate"),
                        rs.getString("Author"),
                        rs.getInt("CateID")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogList;
    }

    // Lấy tổng số trang khi tìm kiếm
    public int getTotalPagesBySearch(String keyword, int limit) {
        String sql = "SELECT COUNT(*) " +
                     "FROM [shopOnline2].[dbo].[blog] b " +
                     "JOIN [shopOnline2].[dbo].[users] u ON b.UsersID = u.ID " +
                     "JOIN [shopOnline2].[dbo].[categoryblog] c ON b.CateID = c.ID " +
                     "WHERE c.Name LIKE ? OR b.Title LIKE ? OR b.Content LIKE ? OR u.uName LIKE ?";
        int totalRows = 0;

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            stmt.setString(4, searchPattern);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    totalRows = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return (int) Math.ceil((double) totalRows / limit);
    }

    // Lấy chi tiết blog theo ID
 public Blog getBlogById(String id) {
        Blog blog = null;
        String sql = "SELECT b.ID, b.Title, b.Content, b.UploadDate, b.BlogImage, u.uName AS Author, b.CateID, c.Name AS CategoryName " +
                     "FROM [shopOnline2].[dbo].[blog] b " +
                     "JOIN [shopOnline2].[dbo].[users] u ON b.UsersID = u.ID " +
                     "LEFT JOIN [shopOnline2].[dbo].[categoryblog] c ON b.CateID = c.ID " + // LEFT JOIN để lấy categoryName
                     "WHERE b.ID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    blog = new Blog(
                        rs.getString("ID"),
                        rs.getString("Title"),
                        rs.getString("Content"),
                        rs.getString("BlogImage"),
                        rs.getDate("UploadDate"),
                        rs.getString("Author"),
                        rs.getInt("CateID")
                    );
                    blog.setCategoryName(rs.getString("CategoryName")); // Gán categoryName
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blog;
    }
    // Lấy danh mục theo CateID
    public Category getCategoryByCateID(int cateID) {
        Category category = null;
        String sql = "SELECT ID, Name FROM [shopOnline2].[dbo].[categoryblog] WHERE ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, cateID);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    category = new Category(rs.getInt("ID"), rs.getString("Name"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return category;
    }
    public boolean updateBlog(Blog blog) {
        String sql = "UPDATE [shopOnline2].[dbo].[blog] SET Title = ?, Content = ?, BlogImage = ?, CateID = ? WHERE ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, blog.getTitle());
            stmt.setString(2, blog.getContent());
            stmt.setString(3, blog.getBlogImage());
            stmt.setInt(4, blog.getCateID());
            stmt.setString(5, blog.getId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Xóa bài viết
    public boolean deleteBlog(String id) {
        String sql = "DELETE FROM [shopOnline2].[dbo].[blog] WHERE ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, id);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public int getCountByDate(String date) {
    String sql = "SELECT COUNT(*) FROM [shopOnline2].[dbo].[blog] WHERE CONVERT(date, UploadDate) = ?";
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

    public static void main(String[] args) {
        BlogDAO blogDAO = new BlogDAO();
        List<Blog> blogs = blogDAO.getAllBlogs(1, 3, "Title", "ASC");
        System.out.println("Blogs sorted by Title ASC: " + blogs.size());
    }
}