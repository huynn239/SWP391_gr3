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
    private String productName;
    private String fullName;
    private String email;
    private String mobile;
    private String status; 

    public Feedback(int id, int ratedStar, String comment, int productId, int userId, String productName) {
        this.id = id;
        this.ratedStar = ratedStar;
        this.comment = comment;
        this.productId = productId;
        this.userId = userId;
        this.productName = productName;
    }


    public Feedback(int id, int ratedStar, String comment, int productId, int userId, String productName,
                    String fullName, String email, String mobile, String status) {
        this.id = id;
        this.ratedStar = ratedStar;
        this.comment = comment;
        this.productId = productId;
        this.userId = userId;
        this.productName = productName;
        this.fullName = fullName;
        this.email = email;
        this.mobile = mobile;
        this.status = status;
    }

    // Getters
    public int getId() { return id; }
    public int getRatedStar() { return ratedStar; }
    public String getComment() { return comment; }
    public int getProductId() { return productId; }
    public int getUserId() { return userId; }
    public String getProductName() { return productName; }
    public String getFullName() { return fullName; }
    public String getEmail() { return email; }
    public String getMobile() { return mobile; }
    public String getStatus() {
    return status != null ? status : "Chờ duyệt"; 
}

}

