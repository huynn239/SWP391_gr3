/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

/**
 *
 * @author Huy
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    protected Connection connection;

    {
        try {
            // Edit URL , username, password to authenticate with your MS SQL Server

            String url = "jdbc:sqlserver://localhost:1433;databaseName=shopOnlineUpdate1";
            String username = "sa";
            String password = "sa";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println(ex);
        }
    }

    public static void main(String[] args) {
        DBContext a = new DBContext();
    }

    public Connection getConnection() {
        return connection;
    }
}
