package model;

public class Product {

    private int id;
    private String name;
    private String image;
    private int materialId;
    private double price;
    private String details;
    private String brandId;
    private int typeId;
    private boolean status;
    private String brandName;
    private String typeName;
    private int is_deleted;
    private int deleted_by;

    public Product() {
    }

    public Product(int id, String name, String image, int materialId, double price, String details, String brandId, int typeId, boolean status) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.materialId = materialId;
        this.price = price;
        this.details = details;
        this.brandId = brandId;
        this.typeId = typeId;
        this.status = status;
    }

    public Product(int id, String name, int materialId, double price, String details, String brandId, int typeId, boolean status) {
        this.id = id;
        this.name = name;
        this.materialId = materialId;
        this.price = price;
        this.details = details;
        this.brandId = brandId;
        this.typeId = typeId;
        this.status = status;
    }

    public int getIs_deleted() {
        return is_deleted;
    }

    public void setIs_deleted(int is_deleted) {
        this.is_deleted = is_deleted;
    }

    public int getDeleted_by() {
        return deleted_by;
    }

    public void setDeleted_by(int deleted_by) {
        this.deleted_by = deleted_by;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getMaterialId() {
        return materialId;
    }

    public void setMaterialId(int materialId) {
        this.materialId = materialId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public String getBrandId() {
        return brandId;
    }

    public void setBrandId(String brandId) {
        this.brandId = brandId;
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

}
