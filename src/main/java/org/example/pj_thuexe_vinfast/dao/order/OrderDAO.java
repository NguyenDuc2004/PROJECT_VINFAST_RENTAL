package org.example.pj_thuexe_vinfast.dao.order;

import org.example.pj_thuexe_vinfast.dbConnection.DbConnection;
import org.example.pj_thuexe_vinfast.modal.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO implements IOrderDAO {

    // 1. CẬP NHẬT CÁC CÂU SQL (Khớp với bảng orders mới)
    private static final String SELECT_ALL_ORDERS = "SELECT * FROM orders ORDER BY order_date DESC";
    private static final String SELECT_ORDER_BY_ID = "SELECT * FROM orders WHERE id = ?";
    private static final String INSERT_ORDER_SQL = "INSERT INTO orders (user_id, car_id, customer_name, phone, email, start_date, end_date, total_price, note, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_STATUS_SQL = "UPDATE orders SET status = ? WHERE id = ?";
    private static final String DELETE_ORDER_SQL = "DELETE FROM orders WHERE id = ?";

    @Override
    public List<Order> selectAllOrders() {
        List<Order> orders = new ArrayList<>();
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_ALL_ORDERS)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orders.add(mapResultSetToOrder(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public Order getOrderById(int id) {
        Order order = null;
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ORDER_BY_ID)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                order = mapResultSetToOrder(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    public List<Order> selectOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY order_date DESC";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orders.add(mapResultSetToOrder(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public boolean checkActiveOrder(int carId) {
        String sql = "SELECT COUNT(*) FROM orders WHERE car_id = ? AND status IN (0, 1)";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, carId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean insertOrder(Order order) {
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_ORDER_SQL)) {

            ps.setInt(1, order.getUserId());
            ps.setInt(2, order.getCarId());
            ps.setString(3, order.getCustomerName());
            ps.setString(4, order.getPhone());
            ps.setString(5, order.getEmail());
            ps.setDate(6, order.getStartDate());
            ps.setDate(7, order.getEndDate());
            ps.setDouble(8, order.getTotalPrice());
            ps.setString(9, order.getNote());
            ps.setInt(10, order.getStatus());
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Lỗi SQL tại insertOrder: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateStatus(int id, int status) {
        boolean rowUpdated = false;
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_STATUS_SQL)) {
            ps.setInt(1, status);
            ps.setInt(2, id);
            rowUpdated = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    @Override
    public boolean deleteOrder(int id) {
        boolean rowDeleted = false;
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_ORDER_SQL)) {
            ps.setInt(1, id);
            rowDeleted = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }


    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setId(rs.getInt("id"));
        order.setUserId(rs.getInt("user_id"));
        order.setCarId(rs.getInt("car_id"));
        order.setCustomerName(rs.getString("customer_name"));
        order.setPhone(rs.getString("phone"));
        order.setEmail(rs.getString("email"));
        order.setStartDate(rs.getDate("start_date"));
        order.setEndDate(rs.getDate("end_date"));
        order.setTotalPrice(rs.getDouble("total_price"));
        order.setNote(rs.getString("note"));
        order.setStatus(rs.getInt("status"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        return order;
    }

    @Override
    public int countOrdersByStatus(int status) {
        String sql = "SELECT COUNT(*) FROM orders WHERE status = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public double calculateTotalRevenue() {
        double total = 0;
        String sql = "SELECT SUM(total_price) FROM orders WHERE status = 2";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                total = rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

    @Override
    public List<Double> getRevenueLast6Months() {
        List<Double> revenues = new ArrayList<>();
        String sql = "SELECT SUM(total_price) as total " +
                "FROM orders " +
                "WHERE start_date >= DATE_SUB(NOW(), INTERVAL 5 MONTH) " +
                "AND status = 2 " +
                "GROUP BY MONTH(start_date), YEAR(start_date) " +
                "ORDER BY YEAR(start_date) ASC, MONTH(start_date) ASC";

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                revenues.add(rs.getDouble("total"));
            }

            while (revenues.size() < 6) {
                revenues.add(0, 0.0);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return revenues;
    }
}