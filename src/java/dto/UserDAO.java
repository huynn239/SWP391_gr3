/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import model.Account;
import java.sql.*;

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
                        rs.getInt("RoleID")
                );

            }

        } catch (SQLException e) {
            System.out.println("Error in login: " + e.getMessage());
        }
        return null;

    }

    public Account checkAccountExist(String user) {

        String sql = "SELECT * FROM users WHERE Username = ? ";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, user);
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

    public void register(String user, String email, String pass) {
        String sql = "INSERT INTO users  (Username,Email,[Password],uName, Avatar, Gender, Mobile, uAddress, RoleID)  \n"
                + "values(?,?,?,'0','0','0','0','0','3')";
        try {
            conn = new DBContext().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, email);
            ps.setString(3, pass);
            ps.executeUpdate();
        } catch (Exception e) {
        }
    }

    public static void main(String[] args) {
        UserDAO DAO = new UserDAO();

        String username = "okok";
        String email = "testuser@example.com";
        String password = "password123";

        // Kiểm tra xem tài khoản đã tồn tại hay chưa
        Account acc = DAO.checkAccountExist(username);
        if (acc != null) {
            System.out.println("Account already exists: " + acc.getUsername());
        } else {
            System.out.println("Account does not exist. Proceeding with registration...");

            // Gọi hàm register() để đăng ký tài khoản mới
            DAO.register(username, email, password);

            // Kiểm tra lại sau khi đăng ký
            acc = DAO.checkAccountExist(username);
            if (acc != null) {
                System.out.println("Registration successful! New account created: " + acc.getUsername());
            } else {
                System.out.println("Registration failed.");
            }
        }
    }
}
