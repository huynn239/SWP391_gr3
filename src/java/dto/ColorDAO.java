/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Color;

/**
 *
 * @author BAO CHAU
 */
public class ColorDAO extends DBContext {

    public List<Color> getAllColors() {
        List<Color> colors = new ArrayList<>();
        String sql = "Select * from Color";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    colors.add(new Color(rs.getInt("ID_Color"), rs.getString("ColorName")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return colors;
    }

    public Color getColorById(int id) {
        String sql = "SELECT * FROM Color WHERE ID_Color = ?";
        Color color = null;

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    color = new Color(rs.getInt("ID_Color"), rs.getString("ColorName"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return color;
    }

    public String getColorNameByID(int colorID) {
        String sql = "Select ColorName from Color where ID_Color = ?";
        String color = "";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, colorID);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    return rs.getString("ColorName");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return color;
    }

    public static void main(String[] args) {
        ColorDAO c = new ColorDAO();
        List<Color> l = c.getAllColors();
        for (Color color : l) {
            System.out.println("" + color.getColorName());
        }
    }

    public boolean checkColor(int productID, int colorID) {
        String sql = "SELECT 1 FROM ProductImage WHERE ProductID = ? AND ColorID = ?";
        boolean isAvailable = true;

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, productID);
            stmt.setInt(2, colorID);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    return false; 
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isAvailable; 
    }

}
