package model;

import java.sql.Timestamp;

public class Slider {
    private int id;
    private String imageUrl;
    private String link;
    private boolean status;
    private Timestamp createdAt; // Thời gian tạo

    public Slider() {}
public Slider( String imageUrl, String link, boolean status) {
      
        this.imageUrl = imageUrl;
        this.link = link;
        this.status = status;
       
    }
    public Slider(int id, String imageUrl, String link, boolean status, Timestamp createdAt) {
        this.id = id;
        this.imageUrl = imageUrl;
        this.link = link;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getLink() { return link; }
    public void setLink(String link) { this.link = link; }

    public boolean isStatus() { return status; }
    public void setStatus(boolean status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
