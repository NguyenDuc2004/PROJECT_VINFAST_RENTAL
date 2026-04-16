package org.example.pj_thuexe_vinfast.dao.order;

import org.example.pj_thuexe_vinfast.modal.Order;
import java.util.List;

public interface IOrderDAO {
    List<Order> selectAllOrders();

    Order getOrderById(int id);      // Lấy 1 đơn hàng theo ID

    boolean updateStatus(int id, int status); // Cập nhật trạng thái

    boolean deleteOrder(int id);     // Xóa đơn hàng

    void insertOrder(Order order);
}