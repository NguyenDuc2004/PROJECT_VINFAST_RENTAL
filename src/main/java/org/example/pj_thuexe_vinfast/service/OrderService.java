package org.example.pj_thuexe_vinfast.service;

import org.example.pj_thuexe_vinfast.dao.order.IOrderDAO;
import org.example.pj_thuexe_vinfast.dao.order.OrderDAO;
import org.example.pj_thuexe_vinfast.modal.Order;

import java.util.List;

public class OrderService {
    private IOrderDAO orderDAO;

    public OrderService() {
        this.orderDAO = new OrderDAO();
    }

    public List<Order> getAllOrders() {
        return orderDAO.selectAllOrders();
    }

    public Order getOrderById(int id) {
        return orderDAO.getOrderById(id);
    }

    public boolean updateOrderStatus(int id, int status) {
        return orderDAO.updateStatus(id, status);
    }

    public boolean deleteOrder(int id) {
        return orderDAO.deleteOrder(id);
    }
}

