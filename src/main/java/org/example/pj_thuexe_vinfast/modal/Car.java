package org.example.pj_thuexe_vinfast.modal;

public class Car {
    private int id;
    private int categoryId;
    private int locationId;
    private String modelName;
    private String licensePlate;
    private double pricePerDay;
    private String imageUrl;
    private String status;
    private String description;
    private String categoryName;
    private String locationName;

    public Car(int id, int categoryId, int locationId, String modelName, String licensePlate, double pricePerDay, String imageUrl, String status, String description, String categoryName) {
        this.id = id;
        this.categoryId = categoryId;
        this.locationId = locationId;
        this.modelName = modelName;
        this.licensePlate = licensePlate;
        this.pricePerDay = pricePerDay;
        this.imageUrl = imageUrl;
        this.status = status;
        this.description = description;
        this.categoryName = categoryName;
    }

    // Constructor mặc định
    public Car() {
    }

    public Car(int id, int categoryId, String locationName, String modelName, String licensePlate, double pricePerDay, String imageUrl, String status, String description, String categoryName) {
        this.id = id;
        this.categoryId = categoryId;
        this.modelName = modelName;
        this.licensePlate = licensePlate;
        this.pricePerDay = pricePerDay;
        this.imageUrl = imageUrl;
        this.status = status;
        this.description = description;
        this.categoryName = categoryName;
        this.locationName = locationName;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public String getModelName() {
        return modelName;
    }

    public void setModelName(String modelName) {
        this.modelName = modelName;
    }

    public String getLicensePlate() {
        return licensePlate;
    }

    public void setLicensePlate(String licensePlate) {
        this.licensePlate = licensePlate;
    }

    public double getPricePerDay() {
        return pricePerDay;
    }

    public void setPricePerDay(double pricePerDay) {
        this.pricePerDay = pricePerDay;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}