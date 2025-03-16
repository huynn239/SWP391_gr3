/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Cart {

    private String image, name, size;
    private int price, quantity,productID;
    private String CheckboxStatus;
    private String color;

    public Cart(String image, String name, String size, int price, int quantity, int productID, String CheckboxStatus,String color) {
        this.image = image;
        this.name = name;
        this.size = size;
        this.price = price;
        this.quantity = quantity;
        this.productID = productID;
        this.CheckboxStatus = CheckboxStatus;
        this.color = color;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }
    
    

    public String getCheckboxStatus() {
        return CheckboxStatus;
    }

    public void setCheckboxStatus(String CheckboxStatus) {
        this.CheckboxStatus = CheckboxStatus;
    }
    
    

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getName() {
        return name;
    }

    public void setName(String Name) {
        this.name = Name;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }
    
    

}
