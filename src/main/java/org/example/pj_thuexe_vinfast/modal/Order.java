package org.example.pj_thuexe_vinfast.modal;

import java.sql.Timestamp;

public class Order {
    private int id;
    private int userId;
    private String customerName;
    private String carModel;
    private double totalPrice;
    private int status;
    private Timestamp orderDate;

    public Order() {
    }

    public Order(int id, int userId, String carModel, String customerName, double totalPrice, int status, Timestamp orderDate) {
        this.id = id;
        this.userId = userId;
        this.carModel = carModel;
        this.customerName = customerName;
        this.totalPrice = totalPrice;
        this.status = status;
        this.orderDate = orderDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCarModel() {
        return carModel;
    }

    public void setCarModel(String carModel) {
        this.carModel = carModel;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }
}
