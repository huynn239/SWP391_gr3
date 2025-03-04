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

    public Feedback(int id, int ratedStar, String comment, int productId, int userId, String productName) {
        this.id = id;
        this.ratedStar = ratedStar;
        this.comment = comment;
        this.productId = productId;
        this.userId = userId;
        this.productName = productName;
    }

    // Getters
    public int getId() { return id; }
    public int getRatedStar() { return ratedStar; }
    public String getComment() { return comment; }
    public int getProductId() { return productId; }
    public int getUserId() { return userId; }
    public String getProductName() { return productName; }
}
