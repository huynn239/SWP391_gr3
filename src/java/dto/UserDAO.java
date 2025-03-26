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
                        rs.getString("Mobile"),
                        rs.getString("uAddress"),
                        rs.getInt("RoleID")
                );

            }

        } catch (SQLException e) {
            System.out.println("Error in login: " + e.getMessage());
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
        // Lấy danh sách người dùng từ database
    public List<Account> getUserList() {
        List<Account> userList = new ArrayList<>();
        String sql = "SELECT * FROM users";
        try (
             PreparedStatement ps = connection.prepareStatement(sql);
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
                rs.getInt("RoleID")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }

  public boolean addUser(Account user) {
    String sql = "INSERT INTO users (uName, Username, Password, Gender, Email, Mobile, uAddress, RoleID, Avatar) " +
                 "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    try {
        Connection conn = getConnection();  // Sử dụng phương thức getConnection từ DBContext
        PreparedStatement ps = conn.prepareStatement(sql);
        
        ps.setString(1, user.getuName());
        ps.setString(2, user.getUsername());
        ps.setString(3, user.getPassword());
        ps.setString(4, user.getGender() != null ? user.getGender() : "0"); // Xử lý null cho gender
        ps.setString(5, user.getEmail());
        ps.setString(6, user.getMobile());
        ps.setString(7, user.getuAddress());
        ps.setInt(8, user.getRoleID());
        ps.setString(9, "0");  // Giá trị mặc định cho Avatar
        
        int rowsAffected = ps.executeUpdate();
        ps.close();
        conn.close();
        return rowsAffected > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

  public boolean editUser(int id, Account updatedUser) {
    String sql = "UPDATE users SET uName = ?, Username = ?, Password = ?, Gender = ?, Email = ?, Mobile = ?, uAddress = ?, RoleID = ? WHERE ID = ?";
    try (Connection conn = getConnection(); // Sử dụng getConnection từ DBContext
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, updatedUser.getuName());
        ps.setString(2, updatedUser.getUsername());
        ps.setString(3, updatedUser.getPassword());
        ps.setString(4, updatedUser.getGender());
        ps.setString(5, updatedUser.getEmail());
        ps.setString(6, updatedUser.getMobile());
        ps.setString(7, updatedUser.getuAddress());
        ps.setInt(8, updatedUser.getRoleID());
        ps.setInt(9, id);

        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

    // Tìm kiếm người dùng theo tên hoặc email từ database
    public List<Account> searchUser(String keyword) {
        List<Account> result = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE uName LIKE ? OR Email LIKE ?";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.add(new Account(
                    rs.getInt("ID"),
                    rs.getString("uName"),
                    rs.getString("Username"),
                    rs.getString("Password"),
                    rs.getString("Gender"),
                    rs.getString("Email"),
                    rs.getInt("RoleID")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
      public Account getUserById(int id) {
        String sql = "SELECT * FROM users WHERE ID = ?";
        try (
             PreparedStatement ps = connection.prepareStatement(sql)) {
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
                    rs.getInt("RoleID"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean deleteUserByID(int id) {
    String sql = "DELETE FROM users WHERE ID = ?";
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
         
        ps.setInt(1, id);
        ps.executeUpdate() ; // Trả về true nếu có ít nhất một dòng bị xóa
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
    }
    
    public boolean userExists(int userId) {
        String sql = "SELECT ID FROM [shopOnline].[dbo].[users] WHERE ID = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            return rs.next(); // Trả về true nếu userId tồn tại
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
