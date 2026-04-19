package org.example.pj_thuexe_vinfast.service;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.example.pj_thuexe_vinfast.dao.order.IOrderDAO;
import org.example.pj_thuexe_vinfast.dao.order.OrderDAO;
import org.example.pj_thuexe_vinfast.modal.Order;

import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

public class OrderService {
    private IOrderDAO orderDAO;

    public OrderService() {
        this.orderDAO = new OrderDAO();
    }

    public List<Order> getAllOrders() {
        return orderDAO.selectAllOrders();
    }

    public List<Order> getAllOrdersByUserId(int userId) {
        return orderDAO.selectOrdersByUserId(userId);
    }

    public Order getOrderById(int id) {
        return orderDAO.getOrderById(id);
    }

    public boolean updateStatus(int id, int status) {
        return orderDAO.updateStatus(id, status);
    }

    public void exportOrdersToExcel(List<Order> orders, OutputStream out) throws IOException {
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Danh sách đơn hàng");

            // 1. Tạo Header
            String[] headers = {"ID", "Khách hàng", "Dòng xe", "Tổng tiền", "Trạng thái", "Ngày đặt"};
            Row headerRow = sheet.createRow(0);

            // Định dạng Header (In đậm)
            CellStyle headerStyle = workbook.createCellStyle();
            Font font = workbook.createFont();
            font.setBold(true);
            headerStyle.setFont(font);

            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }

            // 2. Đổ dữ liệu từ danh sách đơn hàng
            int rowIdx = 1;
            for (Order order : orders) {
                Row row = sheet.createRow(rowIdx++);
                row.createCell(0).setCellValue(order.getId());
                row.createCell(1).setCellValue(order.getCustomerName());
                row.createCell(2).setCellValue(order.getCarModel());
                row.createCell(3).setCellValue(order.getTotalPrice());

                // Chuyển đổi trạng thái số thành chữ
                String statusText;
                switch (order.getStatus()) {
                    case 0: statusText = "Chờ duyệt"; break;
                    case 1: statusText = "Đang thuê"; break;
                    case 2: statusText = "Đã hoàn thành"; break;
                    case 3: statusText = "Đã hủy"; break;
                    default: statusText = "Không xác định"; break;
                }
                row.createCell(4).setCellValue(statusText);
                row.createCell(5).setCellValue(order.getOrderDate() != null ? order.getOrderDate().toString() : "");
            }

            // 3. Tự động căn chỉnh độ rộng cột (Nên chạy sau khi đã đổ hết dữ liệu)
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }

            // 4. Ghi dữ liệu ra stream
            workbook.write(out);
        } catch (Exception e) {
            e.printStackTrace();
            throw e; // Ném lỗi ra ngoài để Controller xử lý nếu cần
        }
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

