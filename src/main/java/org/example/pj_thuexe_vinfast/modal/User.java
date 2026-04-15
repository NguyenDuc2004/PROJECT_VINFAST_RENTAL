package org.example.pj_thuexe_vinfast.modal;

public class User {
    private int id;
    private String fullname;
    private String email;
    private String password;
    private String phone;
    private String address;
    private int role;
    private int status;
    private String createdAt;

    public User(){}

    //constructor lay day du cac truong cua user
    public User(int id, String fullname, String password, String email, String phone, String address, int role, int status, String createdAt) {
        this.id = id;
        this.fullname = fullname;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.status = status;
        this.createdAt = createdAt;
    }

    //constructor kiem tra login
    public User(int id, String fullname, String email, int role) {
        this.id = id;
        this.fullname = fullname;
        this.email =email;
        this.role = role;
    }

    public User(int id, String fullname, String email, String phone, String address, int role, int status, String createdAt) {
        this.id = id;
        this.fullname = fullname;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.status = status;
        this.createdAt = createdAt;
    }

    //constructor update
    public User(int id, String fullname, String email, String phone, String address, int role, int status) {
        this.id = id;
        this.fullname = fullname;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.status = status;
    }

    // Hàm kiểm tra quyền Admin
    public boolean isAdmin() {
        return this.role == 1 || this.role == 2;
    }

    // Hàm kiểm tra tài khoản có đang bị khóa không
    public boolean isActive() {
        return this.status == 1;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", fullname='" + fullname + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", role=" + role +
                ", status=" + status +
                ", createdAt='" + createdAt + '\'' +
                '}';
    }
}
