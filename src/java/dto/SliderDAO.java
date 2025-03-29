package dto;

import model.Slider;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SliderDAO {

    private Connection conn;

    public SliderDAO() {
        this.conn = new DBContext().getConnection();
    }

    // Lấy danh sách slider với phân trang và sắp xếp
    public List<Slider> getSlidersSorted(int page, int limit, String sortBy, String sortOrder) {
        List<Slider> sliders = new ArrayList<>();
        if (conn == null) {
            return sliders;
        }

        String sql = "SELECT id, title, image_url, link, status, created_at " +
                     "FROM Slider " +
                     "ORDER BY " + (sortBy.equals("status") ? "status" : "created_at") + " " + sortOrder + " " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, (page - 1) * limit);
            ps.setInt(2, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    sliders.add(new Slider(
                            rs.getInt("id"),
                            rs.getString("title"),
                            rs.getString("image_url"),
                            rs.getString("link"),
                            rs.getBoolean("status"),
                            rs.getTimestamp("created_at")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }

    // Lấy tổng số slider
    public int getTotalSliders() {
        String sql = "SELECT COUNT(*) FROM Slider";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Tìm kiếm slider theo từ khóa với phân trang và sắp xếp
    public List<Slider> searchSliders(String keyword, int page, int limit, String sortBy, String sortOrder) {
        List<Slider> sliders = new ArrayList<>();
        if (conn == null) {
            return sliders;
        }

        String sql = "SELECT id, title, image_url, link, status, created_at " +
                     "FROM Slider " +
                     "WHERE link LIKE ? OR image_url LIKE ? OR title LIKE ? " +
                     "ORDER BY " + (sortBy.equals("status") ? "status" : "created_at") + " " + sortOrder + " " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setInt(4, (page - 1) * limit);
            ps.setInt(5, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    sliders.add(new Slider(
                            rs.getInt("id"),
                            rs.getString("title"),
                            rs.getString("image_url"),
                            rs.getString("link"),
                            rs.getBoolean("status"),
                            rs.getTimestamp("created_at")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }

    // Lấy tổng số slider theo từ khóa
    public int getTotalSlidersByKeyword(String keyword) {
        String sql = "SELECT COUNT(*) FROM Slider WHERE link LIKE ? OR image_url LIKE ? OR title LIKE ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Lấy danh sách slider theo trạng thái với phân trang và sắp xếp
    public List<Slider> getSlidersByStatus(boolean status, int page, int limit, String sortBy, String sortOrder) {
        List<Slider> sliders = new ArrayList<>();
        if (conn == null) {
            return sliders;
        }

        String sql = "SELECT id, title, image_url, link, status, created_at " +
                     "FROM Slider " +
                     "WHERE status = ? " +
                     "ORDER BY " + (sortBy.equals("status") ? "status" : "created_at") + " " + sortOrder + " " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, status);
            ps.setInt(2, (page - 1) * limit);
            ps.setInt(3, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    sliders.add(new Slider(
                            rs.getInt("id"),
                            rs.getString("title"),
                            rs.getString("image_url"),
                            rs.getString("link"),
                            rs.getBoolean("status"),
                            rs.getTimestamp("created_at")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }

    // Lấy tổng số slider theo trạng thái
    public int getTotalSlidersByStatus(boolean status) {
        String sql = "SELECT COUNT(*) FROM Slider WHERE status = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBoolean(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Tìm kiếm slider theo từ khóa và trạng thái với phân trang và sắp xếp
    public List<Slider> searchSlidersByKeywordAndStatus(String keyword, boolean status, int page, int limit, String sortBy, String sortOrder) {
        List<Slider> sliders = new ArrayList<>();
        if (conn == null) {
            return sliders;
        }

        String sql = "SELECT id, title, image_url, link, status, created_at " +
                     "FROM Slider " +
                     "WHERE (link LIKE ? OR image_url LIKE ? OR title LIKE ?) AND status = ? " +
                     "ORDER BY " + (sortBy.equals("status") ? "status" : "created_at") + " " + sortOrder + " " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setBoolean(4, status);
            ps.setInt(5, (page - 1) * limit);
            ps.setInt(6, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    sliders.add(new Slider(
                            rs.getInt("id"),
                            rs.getString("title"),
                            rs.getString("image_url"),
                            rs.getString("link"),
                            rs.getBoolean("status"),
                            rs.getTimestamp("created_at")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }

    // Lấy tổng số slider theo từ khóa và trạng thái
    public int getTotalSlidersByKeywordAndStatus(String keyword, boolean status) {
        String sql = "SELECT COUNT(*) FROM Slider WHERE (link LIKE ? OR image_url LIKE ? OR title LIKE ?) AND status = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            ps.setBoolean(4, status);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Lấy slider theo ID
    public Slider getSliderById(int id) {
        String sql = "SELECT id, title, image_url, link, status, created_at FROM Slider WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Slider(
                            rs.getInt("id"),
                            rs.getString("title"),
                            rs.getString("image_url"),
                            rs.getString("link"),
                            rs.getBoolean("status"),
                            rs.getTimestamp("created_at")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm slider
    public boolean addSlider(Slider slider) {
        String sql = "INSERT INTO Slider (title, image_url, link, status, created_at) VALUES (?, ?, ?, ?, GETDATE())";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, slider.getTitle());
            ps.setString(2, slider.getImageUrl());
            ps.setString(3, slider.getLink());
            ps.setBoolean(4, slider.isStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật slider
    public boolean updateSlider(Slider slider) {
        String sql = "UPDATE Slider SET title = ?, image_url = ?, link = ?, status = ? WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, slider.getTitle());
            ps.setString(2, slider.getImageUrl());
            ps.setString(3, slider.getLink());
            ps.setBoolean(4, slider.isStatus());
            ps.setInt(5, slider.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Đếm số lượng slider theo ngày
    public int getCountByDate(String date) {
        String sql = "SELECT COUNT(*) FROM [shopOnline].[dbo].[slider] WHERE CONVERT(date, created_at) = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
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

    // Xóa slider
    public boolean deleteSlider(int id) {
        String sql = "DELETE FROM Slider WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}