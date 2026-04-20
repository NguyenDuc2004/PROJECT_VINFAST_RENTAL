package org.example.pj_thuexe_vinfast.service;

import org.example.pj_thuexe_vinfast.dao.car.CarDAO;
import org.example.pj_thuexe_vinfast.dao.car.ICarDAO;
import org.example.pj_thuexe_vinfast.dao.order.IOrderDAO;
import org.example.pj_thuexe_vinfast.dao.order.OrderDAO;
import org.example.pj_thuexe_vinfast.modal.Car;
import org.example.pj_thuexe_vinfast.modal.Location;

import java.util.List;

public class CarService {
    private final ICarDAO carDAO = new CarDAO();
    IOrderDAO orderDAO = new OrderDAO();
    public List<Car> getAllCars(String keyword, String status, String category,String location) {
        return carDAO.filterSearchCars(keyword, status, category,location);
    }

    public List<Location> getAllLocations() {
        return carDAO.getLocation();
    }

    public void addProduct(Car car) throws Exception {
        // 1. Kiểm tra tên xe
        if (car.getModelName() == null || car.getModelName().trim().length() < 10) {
            throw new Exception("Thêm thất bại: Tên xe phải từ 10 ký tự trở lên!");
        }

        // 2. Kiểm tra giá thuê
        if (car.getPricePerDay() <= 0 || car.getPricePerDay() > 10000000) {
            throw new Exception("Thêm thất bại: Giá thuê phải từ 1VND đến 10.000.000VND!");
        }
        carDAO.insert(car);
    }

    public void removeProduct(int id) throws Exception {
        // Check ID
        if (id <= 0) {
            throw new Exception("ID không hợp lệ!");
        }

        // Check tồn tại
        Car car = carDAO.getById(id);
        if (car == null) {
            throw new Exception("Xe không tồn tại!");
        }

        // Check trạng thái
        if ("DELETED".equals(car.getStatus())) {
            throw new Exception("Xe này đã được xóa trước đó rồi!");
        }

        // Gọi DAO để xóa mềm
        carDAO.delete(id);
    }

    public Car getCarById(int id) {
        return carDAO.getById(id);
    }

    public void updateProduct(Car c) throws Exception {

        if (c.getModelName() == null || c.getModelName().trim().length() < 10 || c.getModelName().trim().length() > 155) {
            throw new Exception("Sửa thất bại: Tên xe phải từ 10 đến 155 ký tự!");
        }

        // 2. Kiểm tra Giá (Giữ nguyên logic của anh)
        if (c.getPricePerDay() <= 0 || c.getPricePerDay() > 10000000) {
            throw new Exception("Sửa thất bại: Giá thuê phải từ 1 VNĐ đến 10.000.000 VNĐ!");
        }

        // 3. Kiểm tra xe có tồn tại không
        Car existing = carDAO.getById(c.getId());
        if (existing == null) {
            throw new Exception("Sửa thất bại: Xe không tồn tại!");
        }

        // Nếu Admin định đổi trạng thái từ UNAVAILABLE sang AVAILABLE
        if (existing.getStatus().equals("UNAVAILABLE") && c.getStatus().equals("AVAILABLE")) {
            boolean hasActiveOrder = orderDAO.checkActiveOrder(c.getId());
            if (hasActiveOrder) {
                throw new Exception("Chặn thao tác: Xe này đang nằm trong đơn hàng chưa kết thúc. " +
                        "Bạn không thể chuyển về 'Sẵn sàng' cho đến khi đơn hàng được Hủy hoặc Hoàn thành!");
            }
        }

        // 5. Thực hiện cập nhật
        boolean success = carDAO.update(c);
        if (!success) {
            throw new Exception("Lỗi hệ thống: Không thể cập nhật thông tin xe vào cơ sở dữ liệu!");
        }
    }

    public boolean updateCarStatus(int carId, String status) {
        return carDAO.updateStatus(carId, status);
    }

    public int getTotalCarsCount(String... statuses) {
        return carDAO.getCountProduct(statuses);
    }
}