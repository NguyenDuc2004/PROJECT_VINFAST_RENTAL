package org.example.pj_thuexe_vinfast.dao.order;

import org.example.pj_thuexe_vinfast.dbConnection.DbConnection;
import org.example.pj_thuexe_vinfast.modal.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class OrderDAO implements IOrderDAO{
    private static final String SELECT_ALL_ORDERS = "SELECT * FROM orders";
    private static final String SELECT_ORDER_BY_ID = "SELECT * FROM orders WHERE id = ?";
    private static final String UPDATE_STATUS_SQL = "UPDATE orders SET status = ? WHERE id = ?";
    private static final String DELETE_ORDER_SQL = "DELETE FROM orders WHERE id = ?";

    @Override
    public List<Order> selectAllOrders() {
        List<Order> orders = new ArrayList<>();
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_ORDERS)) {

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setCarModel(rs.getString("car_model"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getInt("status"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                orders.add(order);
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
                order = new Order();
                order.setId(rs.getInt("id"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setCarModel(rs.getString("car_model"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getInt("status"));
                order.setOrderDate(rs.getTimestamp("order_date"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return order;
    }

    @Override
    public boolean updateStatus(int id, int status) {
        boolean rowUpdated = false;
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_STATUS_SQL)) {
            ps.setInt(1, status);
            ps.setInt(2, id);
            rowUpdated = ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return rowUpdated;
    }

    @Override
    public boolean deleteOrder(int id) {
        boolean rowDeleted = false;
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_ORDER_SQL)) {
            ps.setInt(1, id);
            rowDeleted = ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return rowDeleted;
    }
}
