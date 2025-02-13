package model;

import java.sql.Date;

public class Blog {
    private int id;
    private String title;
    private String content;
    private String blogImage;
    private Date uploadDate;
    private String author;  // Thêm trường author cho tên tác giả

    public Blog() {}

    public Blog(int id, String title, String content, String blogImage, Date uploadDate, String author) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.blogImage = blogImage;
        this.uploadDate = uploadDate;
        this.author = author;  // Khởi tạo tác giả
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getBlogImage() { return blogImage; }
    public void setBlogImage(String blogImage) { this.blogImage = blogImage; }

    public Date getUploadDate() { return uploadDate; }
    public void setUploadDate(Date uploadDate) { this.uploadDate = uploadDate; }

    public String getAuthor() { return author; }  // Getter cho tên tác giả
    public void setAuthor(String author) { this.author = author; }  // Setter cho tên tác giả
}
