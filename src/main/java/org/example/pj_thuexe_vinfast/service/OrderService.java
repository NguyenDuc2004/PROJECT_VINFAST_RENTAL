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

    public boolean updateStatus(int id, int status) {
        return orderDAO.updateStatus(id, status);
    }

    public boolean deleteOrder(int id) {
        Order order = orderDAO.getOrderById(id);
        // Logic: Chỉ cho phép xóa nếu đơn hàng đang ở trạng thái "Chờ duyệt" (0) hoặc "Đã hủy"
        if (order != null && (order.getStatus() == 0 || order.getStatus() == 3)) {
            return orderDAO.deleteOrder(id);
        }
        return false; // Không cho xóa nếu xe đang được thuê (tránh mất dữ liệu quan trọng)
    }

    public void addOrder(Order order) {
        orderDAO.insertOrder(order);
    }
}

