package org.example.pj_thuexe_vinfast.service;

import org.example.pj_thuexe_vinfast.dao.car.CarDAO;
import org.example.pj_thuexe_vinfast.dao.car.ICarDAO;
import org.example.pj_thuexe_vinfast.modal.Car;
import org.example.pj_thuexe_vinfast.modal.Location;

import java.util.List;

public class CarService {
    private final ICarDAO carDAO = new CarDAO();

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
        // 1. Check ID
        if (id <= 0) {
            throw new Exception("ID không hợp lệ!");
        }

        // 2. Check tồn tại
        Car car = carDAO.getById(id);
        if (car == null) {
            throw new Exception("Xe không tồn tại!");
        }

        // 3. Check trạng thái
        if ("DELETED".equals(car.getStatus())) {
            throw new Exception("Xe này đã được xóa trước đó rồi!");
        }

        // 4. Gọi DAO để xóa mềm
        carDAO.delete(id);
    }

    public Car getCarById(int id) {
        return carDAO.getById(id);
    }

    public void updateProduct(Car c) throws Exception {

        // 1.Tên (10 - 155 ký tự)
        if (c.getModelName() == null || c.getModelName().trim().length() < 10 || c.getModelName().trim().length() > 155) {
            throw new Exception("Sửa thất bại: Tên xe phải từ 10 ký tự trở lên!");
        }

        // 2.Giá (0 < Giá < 10,000,000)
        double price = c.getPricePerDay();
        if (price <= 0 || price > 10000000) {
            throw new Exception("Sửa thất bại: Giá thuê phải từ 1VND đến 10.000.000VND!");
        }

        // 3. Kiểm tra xe có tồn tại không trước khi sửa
        Car existing = carDAO.getById(c.getId());
        if (existing == null) {
            throw new Exception("Sửa thất bại: Xe không tồn tại!");
        }

        // 4. Thực hiện cập nhật
        boolean success = carDAO.update(c);
        if (!success) {
            throw new Exception("Lỗi hệ thống khi cập nhật!");
        }
    }

    public boolean updateCarStatus(int carId, String status) {
        return carDAO.updateStatus(carId, status);
    }
}