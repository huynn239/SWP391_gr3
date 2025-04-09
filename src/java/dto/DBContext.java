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
<<<<<<< HEAD
            String url = "jdbc:sqlserver://localhost:1433;databaseName=shopOnline2";
=======
            String url = "jdbc:sqlserver://localhost:1433;databaseName=shopOnlineUpdate1    ";
>>>>>>> 15df1232db13ba7da2edb3e10203c6fa877020d7
            String username = "sa";
            String password = "123";
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
