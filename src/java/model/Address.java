/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author BAO CHAU
 */
public class Address {

    public int AddressID;
    public int userID;
    public String reciverName, reciverPhone, reciverEmail, reciverAddress;

    public Address(int AddressID, int userID, String reciverName, String reciverPhone, String reciverEmail, String reciverAddress) {
        this.AddressID = AddressID;
        this.userID = userID;
        this.reciverName = reciverName;
        this.reciverPhone = reciverPhone;
        this.reciverEmail = reciverEmail;
        this.reciverAddress = reciverAddress;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getReciverName() {
        return reciverName;
    }

    public void setReciverName(String reciverName) {
        this.reciverName = reciverName;
    }

    public String getReciverPhone() {
        return reciverPhone;
    }

    public void setReciverPhone(String reciverPhone) {
        this.reciverPhone = reciverPhone;
    }

    public String getReciverEmail() {
        return reciverEmail;
    }

    public void setReciverEmail(String reciverEmail) {
        this.reciverEmail = reciverEmail;
    }

    public String getReciverAddress() {
        return reciverAddress;
    }

    public void setReciverAddress(String reciverAddress) {
        this.reciverAddress = reciverAddress;
    }

}
