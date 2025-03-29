/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import model.Account;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends DBContext {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

   public Account login(String user, String pass) {
        String sql = "SELECT * FROM users WHERE Username = ? AND Password = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user);
            ps.setString(2, pass);
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

    public Account checkAccountExist(String user, String email) {

        String sql = "SELECT * FROM users WHERE Username = ? OR Email = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, email);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Account(
                        rs.getInt("id"),
                        rs.getString("uName"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Gender"),
                        rs.getString("Email"),
                        rs.getInt("RoleID")
                );

            }

        } catch (SQLException e) {
            System.out.println("Error in login: " + e.getMessage());
        }
        return null;

    }

     public void register(String user, String email, String pass,String uName, String Mobile, String uAddress) {
        String sql = "INSERT INTO users  (Username,Email,[Password],uName, Avatar, Gender, Mobile, uAddress, RoleID)  \n"
                + "values(?,?,?,?,'0','0',?,?,'4')";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, email);
            ps.setString(3, pass);
            ps.setString(4, uName);
            ps.setString(5, Mobile);
            ps.setString(6, uAddress);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }


    public static void main(String[] args) {
        UserDAO DAO = new UserDAO();

        String username = "bubucon";
        String email = "testuser@example.com";
        String password = "password123";

        // Kiểm tra xem tài khoản đã tồn tại hay chưa
        Account acc = DAO.checkAccountExist(username, email);
        if (acc != null) {
            System.out.println("Account already exists: " + acc.getUsername());
        } else {
            System.out.println("Account does not exist. Proceeding with registration...");

            // Gọi hàm register() để đăng ký tài khoản mới
         //   DAO.register(username, email, password);

            // Kiểm tra lại sau khi đăng ký
            acc = DAO.checkAccountExist(username, email);
            if (acc != null) {
                System.out.println("Registration successful! New account created: " + acc.getUsername());
            } else {
                System.out.println("Registration failed.");
            }
        }
    }

    public Account getUserByEmail(String email) {
        String sql = "Select * from [users] where email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Account(
                        rs.getInt("id"),
                        rs.getString("uName"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Gender"),
                        rs.getString("Email"),
                        rs.getInt("RoleID")
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Account getUserByIdd(int userId) {
        String sql = "Select * from [users] where ID = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Account(
                        rs.getInt("id"),
                        rs.getString("uName"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Gender"),
                        rs.getString("Email"),
                        rs.getInt("RoleID")
                );
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void updatePassword(String email, String password) {
        String sql = "UPDATE [dbo].[users]\n"
                + "   SET [Password] = ?\n"
                + " WHERE [Email] = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, password);
            st.setString(2, email);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public Account checkAccToChangePass(String user, String pass) {

        String sql = "SELECT * FROM users WHERE Username = ? AND Password = ?";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Account(
                        rs.getInt("id"),
                        rs.getString("uName"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Gender"),
                        rs.getString("Email"),
                        rs.getInt("RoleID")
                );

            }

        } catch (SQLException e) {
            System.out.println("Error in login: " + e.getMessage());
        }
        return null;

    }
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
        String sql = "UPDATE users SET uName = ?, Username = ?, Password = ?, Gender = ?, Email = ?, Mobile = ?, uAddress = ?, RoleID = ?, Avatar = ?, status = ? WHERE ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, updatedUser.getuName());
            ps.setString(2, updatedUser.getUsername());
            ps.setString(3, updatedUser.getPassword());
            ps.setString(4, updatedUser.getGender());
            ps.setString(5, updatedUser.getEmail());
            ps.setString(6, updatedUser.getMobile());
            ps.setString(7, updatedUser.getuAddress());
            ps.setInt(8, updatedUser.getRoleID());
            ps.setString(9, updatedUser.getAvatar());
            ps.setInt(10, updatedUser.getStatus());
            ps.setInt(11, id);
            return ps.executeUpdate() > 0;
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
