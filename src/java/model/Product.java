    package model;

    public class Product {
        private int id;
        private String name;
        private String image;
        private String size;
        private int materialId;
        private double price;
        private String details;
        private int quantity;
        private String brandId;
        private int typeId;

        public Product() {}

        public Product(int id, String name, String image, String size, int materialId, double price, String details, int quantity, String branchId, int typeId) {
            this.id = id;
            this.name = name;
            this.image = image;
            this.size = size;
            this.materialId = materialId;
            this.price = price;
            this.details = details;
            this.quantity = quantity;
            this.brandId = branchId;
            this.typeId = typeId;
        }

        // Getters and Setters
        public int getId() { return id; }
        public void setId(int id) { this.id = id; }

        public String getName() { return name; }
        public void setName(String name) { this.name = name; }

        public String getImage() { return image; }
        public void setImage(String image) { this.image = image; }

        public String getSize() { return size; }
        public void setSize(String size) { this.size = size; }

        public int getMaterialId() { return materialId; }
        public void setMaterialId(int materialId) { this.materialId = materialId; }

        public double getPrice() { return price; }
        public void setPrice(double price) { this.price = price; }

        public String getDetails() { return details; }
        public void setDetails(String details) { this.details = details; }

        public int getQuantity() { return quantity; }
        public void setQuantity(int quantity) { this.quantity = quantity; }

        public String getBrandId() { return brandId; }
        public void setBrandId(String brandId) { this.brandId = brandId; }

        public int getTypeId() { return typeId; }
        public void setTypeId(int typeId) { this.typeId = typeId; }
    }
