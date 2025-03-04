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
        
    // Lấy danh sách slider với phân trang
    public List<Slider> getSliders(int page, int limit) {
    List<Slider> sliders = new ArrayList<>();
    if (conn == null) {
        return sliders;
    }

    // SQL sử dụng OFFSET ROWS FETCH NEXT cho SQL Server
    String sql = "SELECT id, image_url, link, status, created_at " +
                 "FROM Slider " +
                 "ORDER BY created_at DESC " +
                 "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, (page - 1) * limit); // OFFSET ROWS
        ps.setInt(2, limit);              // FETCH NEXT ROWS ONLY
        
        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                sliders.add(new Slider(
                        rs.getInt("id"),
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

    // Lấy tổng số slider để tính số trang
    public int getTotalSliders() {
        String sql = "SELECT COUNT(*) FROM Slider";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Lấy slider theo ID
    public Slider getSliderById(int id) {
        String sql = "SELECT * FROM Slider WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Slider(
                            rs.getInt("id"),
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

    // Thêm slider mới
  public boolean addSlider(Slider slider) {
    String sql = "INSERT INTO Slider (image_url, link, status, created_at) VALUES (?, ?, ?, GETDATE())";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, slider.getImageUrl());
        ps.setString(2, slider.getLink());
        ps.setBoolean(3, slider.isStatus());
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}



    // Cập nhật slider
    public boolean updateSlider(Slider slider) {
        String sql = "UPDATE Slider SET image_url = ?, link = ?, status = ? WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, slider.getImageUrl());
            ps.setString(2, slider.getLink());
            ps.setBoolean(3, slider.isStatus());
            ps.setInt(4, slider.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
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
