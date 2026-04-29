# 🚗 VinFast Rental - Hệ Thống Cho Thuê Xe Điện

VinFast Rental là hệ thống web cho phép người dùng đặt thuê xe điện VinFast trực tuyến, đồng thời cung cấp công cụ quản lý mạnh mẽ cho quản trị viên.

---

## 🌐 Tổng quan

* 👤 Người dùng có thể tìm kiếm và đặt xe dễ dàng
* 🛠️ Admin quản lý xe, đơn hàng và người dùng
* ⚡ Hệ thống được xây dựng theo mô hình MVC

---

## ✨ Tính năng chính

### 👤 Khách hàng

* Xem danh sách xe (VF5, VF8, VF9...)
* Đăng ký / Đăng nhập
* Đặt xe theo ngày nhận - trả
* Tự động tính giá thuê
* Theo dõi trạng thái đơn hàng

---

### 🛠️ Quản trị viên (Admin)

* Dashboard thống kê (xe, đơn hàng, doanh thu)
* Quản lý người dùng (CRUD, phân quyền, tìm kiếm)
* Quản lý xe (thông tin, biển số, giá thuê)
* Duyệt và cập nhật trạng thái đơn hàng
* Nhật ký hệ thống (log đăng nhập)

---

## 🛠 Công nghệ sử dụng

### Backend

* Java Servlet, JSP, JSTL

### Frontend

* HTML5, CSS3, JavaScript, Bootstrap 5

### Database

* MySQL (JDBC)

### Công cụ

* IntelliJ IDEA
* Tomcat 9
* Git

---

## 🧩 Kiến trúc hệ thống

Mô hình MVC:

User → Servlet (Controller) → Service → JDBC → MySQL → JSP (View)

---

## 📸 Demo

> Thêm ảnh hoặc GIF tại đây

![dashboard](./screenshots/dashboard.png)
![car](./screenshots/car.png)

---

## ⚙️ Hướng dẫn cài đặt

### 1. Cấu hình database

* Import file SQL trong thư mục:

```bash
/database/vinfast_rental.sql
```

---

### 2. Cấu hình project

```bash
git clone <repo-url>
```

* Mở bằng IntelliJ IDEA
* Cập nhật thông tin DB trong:

```
DbConnection.java
```

---

### 3. Chạy ứng dụng

* Cấu hình Tomcat 9
* Run project

---

## 🚀 Hướng phát triển

* Thêm thanh toán online
* Tối ưu UI/UX
* Xây dựng REST API (Spring Boot)

---

## 👥 Thành viên

* Đức - Developer
* Đào - Developer
* Thành - Developer

---

## 📫 Liên hệ

* Email: [nkmduc@gmail.com](mailto:your-email@gmail.com)
