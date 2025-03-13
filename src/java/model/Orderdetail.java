/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author BAO CHAU
 */
public class Orderdetail {

    int orderDetail, orderID, productID, quantity;
    String size;
    String CheckboxStatus;
    public Orderdetail() {
    }

    public Orderdetail(int orderDetail, int orderID, int productID, int quantity, String size, String CheckboxStatus) {
        this.orderDetail = orderDetail;
        this.orderID = orderID;
        this.productID = productID;
        this.quantity = quantity;
        this.size = size;
        this.CheckboxStatus = CheckboxStatus;
    }

   

    public int getOrderDetail() {
        return orderDetail;
    }

    public void setOrderDetail(int orderDetail) {
        this.orderDetail = orderDetail;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
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

}
