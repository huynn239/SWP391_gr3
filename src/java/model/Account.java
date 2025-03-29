/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Huy
 */
public class Account {
    private int id;
    private String uName;
    private String Username;
    private String Password;
    private String Gender;
    private String Email;
    private String Mobile;
    private String uAddress;
    private int RoleID;
    private String Avatar; 
    private int status;

    public Account() {
    }
        public Account(int id, String uName, String Username, String Password, String Gender, 
                   String Email, String Mobile, String uAddress, int RoleID, String Avatar, int status) {
        this.id = id;
        this.uName = uName;
        this.Username = Username;
        this.Password = Password;
        this.Gender = Gender;
        this.Email = Email;
        this.Mobile = Mobile;
        this.uAddress = uAddress;
        this.RoleID = RoleID;
        this.Avatar = Avatar;
        this.status = status;
    }

    // Constructor cho addUser (không có id, status mặc định là 1)
    public Account(String uName, String Username, String Password, String Gender, 
                   String Email, String Mobile, String uAddress, int RoleID) {
        this.uName = uName;
        this.Username = Username;
        this.Password = Password;
        this.Gender = Gender;
        this.Email = Email;
        this.Mobile = Mobile;
        this.uAddress = uAddress;
        this.RoleID = RoleID;
        this.status = 1; // Mặc định Active
    }

    // Constructor cho addUser với Avatar
    public Account(String uName, String Username, String Password, String Gender, 
                   String Email, String Mobile, String uAddress, int RoleID, String Avatar) {
        this.uName = uName;
        this.Username = Username;
        this.Password = Password;
        this.Gender = Gender;
        this.Email = Email;
        this.Mobile = Mobile;
        this.uAddress = uAddress;
        this.RoleID = RoleID;
        this.Avatar = Avatar;
        this.status = 1; // Mặc định Active
    }

    // Constructor không có Mobile, uAddress
    public Account(int id, String uName, String Username, String Password, String Gender, 
                   String Email, int RoleID) {
        this.id = id;
        this.uName = uName;
        this.Username = Username;
        this.Password = Password;
        this.Gender = Gender;
        this.Email = Email;
        this.RoleID = RoleID;
        this.status = 1; // Mặc định Active
    }
    public Account(int id, String uName, String Username, String Password, String Gender, String Email, String Mobile, String uAddress, int RoleID) {
    this.id = id;
    this.uName = uName;
    this.Username = Username;
    this.Password = Password;
    this.Gender = Gender;
    this.Email = Email;
    this.Mobile = Mobile;
    this.uAddress = uAddress;
    this.RoleID = RoleID;
}
        public Account(int id, String uName, String Username, String Password, String Gender, String Email, String Mobile, String uAddress, int RoleID, String Avatar) {
        this.id = id;
        this.uName = uName;
        this.Username = Username;
        this.Password = Password;
        this.Gender = Gender;
        this.Email = Email;
        this.Mobile = Mobile;
        this.uAddress = uAddress;
        this.RoleID = RoleID;
        this.Avatar = Avatar;
    }
        

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getuName() {
        return uName;
    }

    public void setuName(String uName) {
        this.uName = uName;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String Username) {
        this.Username = Username;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public String getGender() {
        return Gender;
    }

    public void setGender(String Gender) {
        this.Gender = Gender;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }
    public String getMobile() {
        return Mobile;
    }

    public void setMobile (String Mobile) {
        this.Mobile = Mobile;
    }
    public String getuAddress() {
        return uAddress;
    }

    public void setuAddress(String uAdress) {
        this.uAddress = uAddress;
    }
    public int getRoleID() {
        return RoleID;
    }

    public void setRoleID(int RoleID) {
        this.RoleID = RoleID;
    }

  public String getAvatar() {
        return Avatar;
    }

    public void setAvatar(String Avatar) {
        this.Avatar = Avatar;
    }
     public int getStatus() {
        return status;
    }

    public void setStatus(int status ) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Account{" + "id=" + id + ", uName=" + uName + ", Username=" + Username + ", Password=" + Password + ", Gender=" + Gender + ", Email=" + Email + ", Mobile=" + Mobile + ", uAddress=" + uAddress + ", RoleID=" + RoleID + ", Avatar=" + Avatar + ", status=" + status + '}';
    }

    
    
    
}
