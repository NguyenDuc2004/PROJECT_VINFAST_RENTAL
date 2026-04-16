package org.example.pj_thuexe_vinfast.dao.order;

import org.example.pj_thuexe_vinfast.dbConnection.DbConnection;
import org.example.pj_thuexe_vinfast.modal.Order;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO implements IOrderDAO {

    // Tập hợp hằng số SQL để dễ quản lý và tránh viết đè chuỗi SQL nhiều lần
    private static final String SELECT_ALL_ORDERS = "SELECT id, customer_name, car_model, total_price, status, order_date FROM orders ORDER BY order_date DESC";
    private static final String SELECT_ORDER_BY_ID = "SELECT * FROM orders WHERE id = ?";
    private static final String INSERT_ORDER_SQL = "INSERT INTO orders (customer_name, car_model, total_price, status, order_date) VALUES (?, ?, ?, ?, ?)";
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

    @Override
    public void insertOrder(Order order) {
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_ORDER_SQL)) {

            ps.setString(1, order.getCustomerName());
            ps.setString(2, order.getCarModel());
            ps.setDouble(3, order.getTotalPrice());
            ps.setInt(4, order.getStatus());
            // Sử dụng thời gian hiện tại của hệ thống khi tạo đơn
            ps.setTimestamp(5, new Timestamp(System.currentTimeMillis()));

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
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
        order.setCustomerName(rs.getString("customer_name"));
        order.setCarModel(rs.getString("car_model"));
        order.setTotalPrice(rs.getDouble("total_price"));
        order.setStatus(rs.getInt("status"));
        order.setOrderDate(rs.getTimestamp("order_date"));
        return order;
    }
}