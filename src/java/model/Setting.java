/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author thang
 */

public class Setting {
    private int id;
    private String type;
    private String value;
    private int order;
    private String description;
    private boolean status; // true = active, false = inactive

    public Setting() {
    }

    public Setting(int id, String type, String value, int order, String description, boolean status) {
        this.id = id;
        this.type = type;
        this.value = value;
        this.order = order;
        this.description = description;
        this.status = status;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getValue() { return value; }
    public void setValue(String value) { this.value = value; }
    public int getOrder() { return order; }
    public void setOrder(int order) { this.order = order; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public boolean isStatus() { return status; }
    public void setStatus(boolean status) { this.status = status; }

    @Override
    public String toString() {
        return "Setting{" + "id=" + id + ", type=" + type + ", value=" + value + ", order=" + order + ", description=" + description + ", status=" + status + '}';
    }
}