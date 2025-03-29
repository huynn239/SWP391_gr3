/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import model.Setting;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author thang
 */
public class SettingDAO extends DBContext {
    public List<Setting> getAllSettings() {
        List<Setting> settings = new ArrayList<>();
        String sql = "SELECT * FROM settings ";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                settings.add(new Setting(
                    rs.getInt("id"),
                    rs.getString("type"),
                    rs.getString("value"),
                    rs.getInt("order"),
                    rs.getString("description"),
                    rs.getBoolean("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return settings;
    }
    
    public Setting getSettingById(int id) {
        String sql = "SELECT * FROM settings WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Setting(
                    rs.getInt("id"),
                    rs.getString("type"),
                    rs.getString("value"),
                    rs.getInt("order"),
                    rs.getString("description"),
                    rs.getBoolean("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addSetting(Setting setting) {
        String sql = "INSERT INTO settings (type, value, [order], description, status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, setting.getType());
            ps.setString(2, setting.getValue());
            ps.setInt(3, setting.getOrder());
            ps.setString(4, setting.getDescription());
            ps.setBoolean(5, setting.isStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean editSetting(int id, Setting setting) {
        String sql = "UPDATE settings SET type = ?, value = ?, [order] = ?, description = ?, status = ? WHERE id = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, setting.getType());
            ps.setString(2, setting.getValue());
            ps.setInt(3, setting.getOrder());
            ps.setString(4, setting.getDescription());
            ps.setBoolean(5, setting.isStatus());
            ps.setInt(6, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean toggleStatus(int id) {
        Setting setting = getSettingById(id);
        if (setting != null) {
            String sql = "UPDATE settings SET status = ? WHERE id = ?";
            try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setBoolean(1, !setting.isStatus());
                ps.setInt(2, id);
                return ps.executeUpdate() > 0;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false;
    }
    
    public boolean deleteSetting(int id) {
    String sql = "DELETE FROM settings WHERE id = ?";
    try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, id);
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
    public List<Setting> getFilteredSettings(String keyword, String type, String status, String sortBy) {
        List<Setting> settings = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM settings WHERE 1=1");

        // Thêm điều kiện lọc
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (type LIKE ? OR value LIKE ? OR description LIKE ?)");
        }
        if (type != null && !type.isEmpty()) {
            sql.append(" AND type = ?");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
        }

        // Thêm sắp xếp
        if (sortBy != null) {
            if ("order_asc".equals(sortBy)) {
                sql.append(" ORDER BY [order] ASC");
            } else if ("order_desc".equals(sortBy)) {
                sql.append(" ORDER BY [order] DESC");
            }
        }

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                String searchPattern = "%" + keyword + "%";
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
                ps.setString(paramIndex++, searchPattern);
            }
            if (type != null && !type.isEmpty()) {
                ps.setString(paramIndex++, type);
            }
            if (status != null && !status.isEmpty()) {
                ps.setBoolean(paramIndex++, Boolean.parseBoolean(status));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                settings.add(new Setting(
                    rs.getInt("id"),
                    rs.getString("type"),
                    rs.getString("value"),
                    rs.getInt("order"),
                    rs.getString("description"),
                    rs.getBoolean("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return settings;
    }

    // Phương thức lấy danh sách các type duy nhất
    public List<String> getAllTypes() {
        List<String> types = new ArrayList<>();
        String sql = "SELECT DISTINCT type FROM settings";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                types.add(rs.getString("type"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return types;
    }

    
}
