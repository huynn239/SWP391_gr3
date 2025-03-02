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
import model.Category;
import model.Material;

/**
 *
 * @author BAO CHAU
 */
public class MaterialDAO extends DBContext {

    public List<Material> getAllMaterial() {
        List<Material> materialList = new ArrayList<>();
        String sql = "SELECT * FROM Material order by name";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Material mat = new Material(
                        rs.getInt("ID_Material"),
                        rs.getString("Name")
                );
                materialList.add(mat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return materialList;
    }
    
    public static void main(String[] args) {
        MaterialDAO a = new MaterialDAO();
        List<Material> list = a.getAllMaterial();
        for (Material material : list) {
            System.out.println("" + material.getMname());
        }
    }
    public Material getMaterialById(int id) {
        Material material = null;
        String sql = "SELECT * FROM Material WHERE ID_Material = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                material = new Material(
                        rs.getInt("ID_Material"),
                        rs.getString("Name")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return material;
    }
}
