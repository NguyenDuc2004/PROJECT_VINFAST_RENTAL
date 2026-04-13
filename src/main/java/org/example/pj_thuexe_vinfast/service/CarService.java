package org.example.pj_thuexe_vinfast.service;

import org.example.pj_thuexe_vinfast.dao.car.CarDAO;
import org.example.pj_thuexe_vinfast.dao.car.ICarDAO;
import org.example.pj_thuexe_vinfast.modal.Car;

import java.util.List;

public class CarService {
    private final ICarDAO carDAO = new CarDAO();

    public List<Car> getAllCars(String keyword, String status, String category) {
        return carDAO.filterSearchCars(keyword, status, category);
    }

    public void addProduct(Car car) {
        carDAO.insert(car);
    }

    public void removeProduct(int id) throws Exception {
        // 1. Check ID
        if (id <= 0) {
            throw new Exception("ID sản phẩm không hợp lệ!");
        }

        // 2. Check tồn tại
        Car car = carDAO.getById(id);
        if (car == null) {
            System.out.println("DEBUG: Khong tim thay Car id = " + id);
            throw new Exception("Xe này không tồn tại trên hệ thống!");
        }

        // 3. Check trạng thái (Dùng .equals và viết đúng chính tả)
        if ("UNAVAILABLE".equals(car.getStatus())) {
            throw new Exception("Xe này đã bị xóa hoặc đang ngừng kinh doanh!");
        }

        // 4. Gọi DAO để xóa mềm
        carDAO.delete(id);
    }

    public Car getCarById(int id) {
        return carDAO.getById(id);
    }

    public String updateProduct(Car c) throws Exception {
        // 1. Nghiệp vụ: Kiểm tra xe có tồn tại không
        Car existingCar = carDAO.getById(c.getId());
        if (existingCar == null) {
            throw new Exception("Lỗi: Không tìm thấy xe để cập nhật!");
        }

        // 2. Nghiệp vụ: Kiểm tra tính hợp lệ của dữ liệu (Validation)
        if (c.getModelName() == null || c.getModelName().trim().isEmpty()) {
            throw new Exception("Lỗi: Tên xe không được để trống!");
        }

        if (c.getPricePerDay() <= 0) {
            throw new Exception( "Lỗi: Giá thuê phải lớn hơn 0!");
        }

        // 3. Nghiệp vụ: Giữ lại các thông tin không cho phép sửa từ giao diện
        // Ví dụ: Không cho sửa biển số xe (license_plate) để tránh gian lận
        c.setLicensePlate(existingCar.getLicensePlate());

        // 4. Thực hiện cập nhật
        boolean isSuccess = carDAO.update(c);

        if (isSuccess) {
            System.out.println("Cập nhật thành công xe ID: " + c.getId());
            throw new Exception("SUCCESS") ;
        } else {
            throw new Exception("Lỗi: Cập nhật thất bại do lỗi hệ thống!") ;
        }
    }
}