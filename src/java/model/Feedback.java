/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author thang
 */
public class Feedback {
    private int id;
    private int ratedStar;
    private String comment;
    private int productId;
    private int userId;
    private String fullName;
    private String email;
    private String mobile;
    private String productName; 
    
    public Feedback() {
    }

    public Feedback(int id, int ratedStar, String comment, int productId, int userId) {
        this.id = id;
        this.ratedStar = ratedStar;
        this.comment = comment;
        this.productId = productId;
        this.userId = userId;
    }
    public Feedback(int id, int ratedStar, String comment, int productId, int userId, String productName) {
        this.id = id;
        this.ratedStar = ratedStar;
        this.comment = comment;
        this.productId = productId;
        this.userId = userId;
        this.productName = productName;
    }

    public Feedback(int id, int ratedStar, String comment, int productId, int userId, 
                    String fullName, String email, String mobile) {
        this.id = id;
        this.ratedStar = ratedStar;
        this.comment = comment;
        this.productId = productId;
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.mobile = mobile;
    }
    public Feedback(int id, int ratedStar, String comment, int productId, int userId, 
                    String fullName, String email, String mobile, String productName) {
        this.id = id;
        this.ratedStar = ratedStar;
        this.comment = comment;
        this.productId = productId;
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.mobile = mobile;
        this.productName = productName;
    }

    // Getters
    public int getId() { return id; }
    public int getRatedStar() { return ratedStar; }
    public String getComment() { return comment; }
    public int getProductId() { return productId; }
    public int getUserId() { return userId; }
    public String getFullName() { return fullName; }
    public String getEmail() { return email; }
    public String getMobile() { return mobile; }
    public String getProductName() {
        return productName;
    }
    

    // Setters
    public void setId(int id) { this.id = id; }
    public void setRatedStar(int ratedStar) { this.ratedStar = ratedStar; }
    public void setComment(String comment) { this.comment = comment; }
    public void setProductId(int productId) { this.productId = productId; }
    public void setUserId(int userId) { this.userId = userId; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public void setEmail(String email) { this.email = email; }
    public void setMobile(String mobile) { this.mobile = mobile; }
    public void setProductName(String productName) {
        this.productName = productName;
    }
}

