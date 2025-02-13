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
    private int RoleID;

    public Account() {
    }

    public Account(int id, String uName, String Username, String Password, String Gender, String Email, int RoleID) {
        this.id = id;
        this.uName = uName;
        this.Username = Username;
        this.Password = Password;
        this.Gender = Gender;
        this.Email = Email;
        this.RoleID = RoleID;
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

    public int getRoleID() {
        return RoleID;
    }

    public void setRoleID(int RoleID) {
        this.RoleID = RoleID;
    }

    @Override
    public String toString() {
        return "Users{" + "id=" + id + ", uName=" + uName + ", Username=" + Username + ", Password=" + Password + ", Gender=" + Gender + ", Email=" + Email + ", RoleID=" + RoleID + '}';
    }
    
    
    
}
