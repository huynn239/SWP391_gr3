/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

/**
 *
 * @author BAO CHAU
 */
public class Order {

    private int orderID;
    private String PaymentStatus;
    private LocalDate orderDate;
    private double totalAmount, userID;
    private String ReceiverName, ReceiverPhone, ReceiverEmail, ReciverAddress;
    private String firstProductName;
    private int otherProductsCount;

    public Order(int orderID, String PaymentStatus, LocalDate orderDate, double totalAmount, int userID) {
        this.orderID = orderID;
        this.PaymentStatus = PaymentStatus;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.userID = userID;
    }

    public Order(String ReceiverName, String ReceiverPhone, String ReceiverEmail, String ReciverAddress) {
        this.ReceiverName = ReceiverName;
        this.ReceiverPhone = ReceiverPhone;
        this.ReceiverEmail = ReceiverEmail;
        this.ReciverAddress = ReciverAddress;
    }
    
    

    public Order() {
    }
    public Date getOrderDateAsDate() {
        if (orderDate == null) {
            return null;
        }
        return Date.from(orderDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }

    public String getReceiverName() {
        return ReceiverName;
    }

    public void setReceiverName(String ReceiverName) {
        this.ReceiverName = ReceiverName;
    }

    public String getReceiverPhone() {
        return ReceiverPhone;
    }

    public void setReceiverPhone(String ReceiverPhone) {
        this.ReceiverPhone = ReceiverPhone;
    }

    public String getReceiverEmail() {
        return ReceiverEmail;
    }

    public void setReceiverEmail(String ReceiverEmail) {
        this.ReceiverEmail = ReceiverEmail;
    }

    public String getReciverAddress() {
        return ReciverAddress;
    }

    public void setReciverAddress(String ReciverAddress) {
        this.ReciverAddress = ReciverAddress;
    }

    
    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public String getPaymentStatus() {
        return PaymentStatus;
    }

    public void setPaymentStatus(String PaymentStatus) {
        this.PaymentStatus = PaymentStatus;
    }

    public LocalDate getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDate orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public double getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }
    public String getFirstProductName() {
        return firstProductName;
    }

    public void setFirstProductName(String firstProductName) {
        this.firstProductName = firstProductName;
    }

    public int getOtherProductsCount() {
        return otherProductsCount;
    }

    public void setOtherProductsCount(int otherProductsCount) {
        this.otherProductsCount = otherProductsCount;
    }
}
