/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;
import model.Account;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author NBL
 */
public class UserAdminDAO extends DBContext {
    public List<Account> getUserList() {
        List<Account> userList = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE RoleID IN (2, 3)"; // Chỉ lấy Marketing và Sale
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                userList.add(new Account(
                    rs.getInt("ID"),
                    rs.getString("uName"),
                    rs.getString("Username"),
                    rs.getString("Password"),
                    rs.getString("Gender"),
                    rs.getString("Email"),
                    rs.getString("Mobile"),
                    rs.getString("uAddress"),
                    rs.getInt("RoleID"),
                    rs.getString("Avatar"),
                    rs.getInt("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }

    public List<Account> getFilteredUserList(String gender, Integer roleId, Integer status) {
        List<Account> userList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM users WHERE 1=1");

        if (gender != null && !gender.isEmpty()) {
            sql.append(" AND Gender = ?");
        }
        if (roleId != null) {
            sql.append(" AND RoleID = ?");
        }
        if (status != null) {
            sql.append(" AND status = ?");
        }

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (gender != null && !gender.isEmpty()) {
                ps.setString(paramIndex++, gender);
            }
            if (roleId != null) {
                ps.setInt(paramIndex++, roleId);
            }
            if (status != null) {
                ps.setInt(paramIndex++, status);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                userList.add(new Account(
                    rs.getInt("ID"),
                    rs.getString("uName"),
                    rs.getString("Username"),
                    rs.getString("Password"),
                    rs.getString("Gender"),
                    rs.getString("Email"),
                    rs.getString("Mobile"),
                    rs.getString("uAddress"),
                    rs.getInt("RoleID"),
                    rs.getString("Avatar"),
                    rs.getInt("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }

    public List<Account> searchUser(String keyword) {
        List<Account> result = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE uName LIKE ? OR Email LIKE ? OR Mobile LIKE ?";
        try (Connection conn = getConnection();
PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ps.setString(3, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.add(new Account(
                    rs.getInt("ID"),
                    rs.getString("uName"),
                    rs.getString("Username"),
                    rs.getString("Password"),
                    rs.getString("Gender"),
                    rs.getString("Email"),
                    rs.getString("Mobile"),
                    rs.getString("uAddress"),
                    rs.getInt("RoleID"),
                    rs.getString("Avatar"),
                    rs.getInt("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public Account getUserById(int id) {
        String sql = "SELECT * FROM users WHERE ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Account(
                    rs.getInt("ID"),
                    rs.getString("uName"),
                    rs.getString("Username"),
                    rs.getString("Password"),
                    rs.getString("Gender"),
                    rs.getString("Email"),
                    rs.getString("Mobile"),
                    rs.getString("uAddress"),
                    rs.getInt("RoleID"),
                    rs.getString("Avatar"),
                    rs.getInt("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addUser(Account user) {
        String sql = "INSERT INTO users (uName, Username, Password, Gender, Email, Mobile, uAddress, RoleID, Avatar, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getuName());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getGender());
            ps.setString(5, user.getEmail());
            ps.setString(6, user.getMobile());
            ps.setString(7, user.getuAddress());
            ps.setInt(8, user.getRoleID());
            ps.setString(9, user.getAvatar());
            ps.setInt(10, user.getStatus());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

public boolean editUser(int id, Account updatedUser) {
    String sql = "UPDATE users SET uName = ?, Gender = ?, Email = ?, Mobile = ?, uAddress = ? WHERE ID = ?";
    try (Connection conn = getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, updatedUser.getuName());  // Cập nhật uName
        ps.setString(2, updatedUser.getGender());  // Cập nhật gender
        ps.setString(3, updatedUser.getEmail());  // Cập nhật email
        ps.setString(4, updatedUser.getMobile());  // Cập nhật mobile
        ps.setString(5, updatedUser.getuAddress());  // Cập nhật uAddress
        ps.setInt(6, id);  // ID của người dùng cần sửa
        return ps.executeUpdate() > 0;  // Thực thi và trả về kết quả
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}
public boolean editProfile(int userId, Account user) {
        String sql = "UPDATE users SET uName = ?, Gender = ?, Email = ?, Mobile = ?, uAddress = ?, Avatar = ? WHERE ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getuName());
            ps.setString(2, user.getGender());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getMobile());
            ps.setString(5, user.getuAddress());
            ps.setString(6, user.getAvatar());
            ps.setInt(7, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteUserByID(int id) {
        String sql = "DELETE FROM users WHERE ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0; // Trả về true nếu xóa thành công
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean userExists(int userId) {
        String sql = "SELECT ID FROM users WHERE ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
}