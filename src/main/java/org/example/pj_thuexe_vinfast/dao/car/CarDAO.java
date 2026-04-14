package org.example.pj_thuexe_vinfast.dao.car;

import org.example.pj_thuexe_vinfast.modal.Car;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static org.example.pj_thuexe_vinfast.dbConnection.DbConnection.getConnection;

public class CarDAO implements ICarDAO {

    @Override
    public List<Car> filterSearchCars(String keyword, String status, String category) {
        List<Car> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT c.*, cat.name AS category_name ");
        sql.append("FROM cars c JOIN categories cat ON c.category_id = cat.id WHERE 1=1 ");

        if (keyword != null && !keyword.isEmpty()) sql.append(" AND model_name LIKE ?");
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
        } else sql.append(" AND c.status = 'AVAILABLE'");
        if (category != null && !category.isEmpty()) sql.append(" AND category_id = ?");

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            int index = 1;
            if (keyword != null && !keyword.isEmpty()) ps.setString(index++, "%" + keyword + "%");
            if (status != null && !status.isEmpty()) ps.setString(index++, status);
            if (category != null && !category.isEmpty()) ps.setInt(index++, Integer.parseInt(category));

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Car(
                        rs.getInt("id"), rs.getInt("category_id"), rs.getInt("location_id"),
                        rs.getString("model_name"), rs.getString("license_plate"),
                        rs.getDouble("price_per_day"), rs.getString("image_url"),
                        rs.getString("status"), rs.getString("description"),
                        rs.getString("category_name")
                ));
            }
        } catch (SQLException e) {
            System.err.println("Lỗi filterSearchCars: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Car getById(int id) {
        String sql = "SELECT * FROM cars WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Car c = new Car();
                c.setId(rs.getInt("id"));
                c.setModelName(rs.getString("model_name"));
                c.setPricePerDay(rs.getDouble("price_per_day"));
                c.setImageUrl(rs.getString("image_url"));
                c.setStatus(rs.getString("status"));
                c.setCategoryId(rs.getInt("category_id"));
                c.setLicensePlate(rs.getString("license_plate"));
                return c;
            }
        } catch (SQLException e) {
            System.err.println("Lỗi getById: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void insert(Car car) {
        String sql = "INSERT INTO cars (category_id, location_id, model_name, license_plate, price_per_day, image_url, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, car.getCategoryId());
            ps.setInt(2, 1); // location_id mặc định
            ps.setString(3, car.getModelName());
            ps.setString(4, car.getLicensePlate()); // Biển số lấy từ form
            ps.setDouble(5, car.getPricePerDay());
            ps.setString(6, car.getImageUrl());
            ps.setString(7, car.getStatus());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Lỗi insert: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void delete(int id) {
        String sql = "UPDATE cars SET status = 'UNAVAILABLE' WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

            System.out.println("Đã thực hiện xóa mềm xe có ID: " + id);

        } catch (SQLException e) {
            System.err.println("Lỗi xóa mềm (delete): " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public boolean update(Car car) {
        String sql = "UPDATE cars SET model_name = ?, price_per_day = ?, image_url = ?, status = ?, category_id = ? WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, car.getModelName());
            ps.setDouble(2, car.getPricePerDay());
            ps.setString(3, car.getImageUrl());
            ps.setString(4, car.getStatus());
            ps.setInt(5, car.getCategoryId());
            ps.setInt(6, car.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi update: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
}