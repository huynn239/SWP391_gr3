/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author BAO CHAU
 */
public class Pending {

    private int id;
    private int productId;
    private int updatedBy;
    private String changes;
    private String changeo;
    private String status;
    private Timestamp createdAt;

    public Pending(int id, int productId, int updatedBy, String changes, String changeo, String status, Timestamp createdAt) {
        this.id = id;
        this.productId = productId;
        this.updatedBy = updatedBy;
        this.changes = changes;
        this.changeo = changeo;
        this.status = status;
        this.createdAt = createdAt;
    }

    

    public String getChangeo() {
        return changeo;
    }

    public void setChangeo(String changeo) {
        this.changeo = changeo;
    }

    
    // Getter và Setter
    public int getId() {
        return id;
    }

    public int getProductId() {
        return productId;
    }

    public int getUpdatedBy() {
        return updatedBy;
    }

    public String getChanges() {
        return changes;
    }

    public String getStatus() {
        return status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
