/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;
import java.lang.ProcessBuilder.Redirect.Type;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Pending;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;
import model.Product;
import model.ProductImage;
import model.ProductSize;

/**
 *
 * @author BAO CHAU
 */
public class PendingUpdateDAO extends DBContext {

    private Gson gson = new Gson();

    public List<Pending> getAllPendingUpdates() {
        List<Pending> updates = new ArrayList<>();
        String sql = "SELECT * FROM pending_updates";

        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String formattedChanges = rs.getString("formatted_changes");

                if (formattedChanges.equals("update<br>") && rs.getString("status").equals("pending")) {
                    String deleteQuery = "DELETE FROM pending_updates WHERE id = ?";
                    try (PreparedStatement deleteStmt = connection.prepareStatement(deleteQuery)) {
                        deleteStmt.setInt(1, rs.getInt("id"));
                        deleteStmt.executeUpdate();
                    }
                    continue;
                }

                Pending update = new Pending(
                        rs.getInt("id"),
                        rs.getInt("product_id"),
                        rs.getInt("updated_by"),
                        formattedChanges,
                        rs.getString("changes"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at")
                );
                updates.add(update);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return updates;
    }

    public void updateStatus(int id, String status) {
        String sql = "UPDATE pending_updates SET status = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, id);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        PendingUpdateDAO p = new PendingUpdateDAO();
        List<Pending> list = p.getAllPendingUpdates();
        for (Pending pending : list) {
            System.out.println("" + pending.getChanges());
        }
    }
}
