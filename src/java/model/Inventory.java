package model;

public class Inventory {
    private int productId; // Ánh xạ với ProductID
    private int sizeId;    // Ánh xạ với SizeID
    private int quantity;  // Ánh xạ với Quantity
    private int colorId;   // Ánh xạ với ColorID

    // Constructor
    public Inventory() {}

    public Inventory(int productId, int sizeId, int quantity, int colorId) {
        this.productId = productId;
        this.sizeId = sizeId;
        this.quantity = quantity;
        this.colorId = colorId;
    }

    // Getters và Setters
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getSizeId() {
        return sizeId;
    }

    public void setSizeId(int sizeId) {
        this.sizeId = sizeId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getColorId() {
        return colorId;
    }

    public void setColorId(int colorId) {
        this.colorId = colorId;
    }
}