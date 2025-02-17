package model;

/**
 * Model cho bảng `categoryblog`
 * 
 * @author Huy
 */
public class BlogCategory {
    private int id;
    private String name;
    private String description;

    // Constructor không tham số
    public BlogCategory() {
    }

    // Constructor có tham số
    public BlogCategory(int id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
    }

    // Getter và Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

  
   
}
