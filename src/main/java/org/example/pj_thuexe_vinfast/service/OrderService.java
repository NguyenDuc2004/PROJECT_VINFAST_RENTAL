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

    // HÀM MỚI: Dùng cho OrderClientServlet khi khách đặt xe
    public boolean createOrder(Order order) {
        try {
            // Anh có thể thêm logic kiểm tra xe có còn trống trong thời gian này không ở đây
            orderDAO.insertOrder(order);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void exportOrdersToExcel(List<Order> orders, OutputStream out) throws IOException {
        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Danh sách đơn hàng");

            // 1. Tạo Header (Cập nhật thêm các cột mới)
            String[] headers = {"ID", "Khách hàng", "SĐT", "ID Xe", "Ngày nhận", "Ngày trả", "Tổng tiền", "Trạng thái", "Ngày đặt"};
            Row headerRow = sheet.createRow(0);

            CellStyle headerStyle = workbook.createCellStyle();
            Font font = workbook.createFont();
            font.setBold(true);
            headerStyle.setFont(font);
            headerStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }

            // 2. Đổ dữ liệu
            int rowIdx = 1;
            for (Order order : orders) {
                Row row = sheet.createRow(rowIdx++);
                row.createCell(0).setCellValue(order.getId());
                row.createCell(1).setCellValue(order.getCustomerName());
                row.createCell(2).setCellValue(order.getPhone());
                row.createCell(3).setCellValue(order.getCarId());
                row.createCell(4).setCellValue(order.getStartDate().toString());
                row.createCell(5).setCellValue(order.getEndDate().toString());

                // Định dạng tiền tệ đơn giản
                row.createCell(6).setCellValue(order.getTotalPrice());

                String statusText;
                switch (order.getStatus()) {
                    case 0: statusText = "Chờ duyệt"; break;
                    case 1: statusText = "Đang thuê"; break;
                    case 2: statusText = "Đã hoàn thành"; break;
                    case 3: statusText = "Đã hủy"; break;
                    default: statusText = "N/A"; break;
                }
                row.createCell(7).setCellValue(statusText);
                row.createCell(8).setCellValue(order.getOrderDate() != null ? order.getOrderDate().toString() : "");
            }

            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }

            workbook.write(out);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    public boolean deleteOrder(int id) {
        Order order = orderDAO.getOrderById(id);
        if (order != null && (order.getStatus() == 0 || order.getStatus() == 3)) {
            return orderDAO.deleteOrder(id);
        }
        return false;
    }

    public void addOrder(Order order) {
        orderDAO.insertOrder(order);
    }
}