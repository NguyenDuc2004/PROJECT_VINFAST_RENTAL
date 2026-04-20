package org.example.pj_thuexe_vinfast.modal;

import java.sql.Date;
import java.sql.Timestamp;

public class Order {
    private int id;
    private int userId;
    private int carId;
    private String customerName;
    private String phone;
    private String email;
    private Date startDate;
    private Date endDate;
    private double totalPrice;
    private String note;
    private int status;
    private Timestamp orderDate;

    public Order() {
    }

    // Constructor đầy đủ tham số (Dùng khi insert đơn hàng mới)
    public Order(int userId, int carId, String customerName, String phone, String email,
                 Date startDate, Date endDate, double totalPrice, String note, int status) {
        this.userId = userId;
        this.carId = carId;
        this.customerName = customerName;
        this.phone = phone;
        this.email = email;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalPrice = totalPrice;
        this.note = note;
        this.status = status;
    }

    // GETTER & SETTER
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getCarId() { return carId; }
    public void setCarId(int carId) { this.carId = carId; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }

    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public Timestamp getOrderDate() { return orderDate; }
    public void setOrderDate(Timestamp orderDate) { this.orderDate = orderDate; }
}