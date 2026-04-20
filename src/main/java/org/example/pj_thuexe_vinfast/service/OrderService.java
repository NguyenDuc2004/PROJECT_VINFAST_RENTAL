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
   IOrderDAO orderDAO = new OrderDAO();

    public List<Order> getAllOrders() {
        return orderDAO.selectAllOrders();
    }

    public List<Order> getAllOrdersByUserId(int userId) {
        return orderDAO.selectOrdersByUserId(userId);
    }

    public Order getOrderById(int id) {
        return orderDAO.getOrderById(id);
    }

    public void updateStatus(int id, int status) throws Exception {
        // 1. Kiểm tra đơn hàng có tồn tại không
        Order order = orderDAO.getOrderById(id);
        if (order == null) {
            throw new Exception("Đơn hàng mã #" + id + " không tồn tại!");
        }

        int currentStatus = order.getStatus();

        // 2. Chặn các nghiệp vụ phi lý
        if (currentStatus == 2) {
            throw new Exception("Thao tác thất bại: Đơn hàng này đã hoàn thành, không thể sửa đổi.");
        }

        if (currentStatus == 3) {
            throw new Exception("Thao tác thất bại: Đơn hàng này đã bị hủy, không thể cập nhật.");
        }

        // Ví dụ: Đang chờ duyệt (0) mà nhảy thẳng lên Hoàn thành (2) là vô lý
        if (currentStatus == 0 && status == 2) {
            throw new Exception("Quy trình sai: Bạn phải duyệt cho thuê xe trước khi xác nhận hoàn thành.");
        }

        boolean isSuccess = orderDAO.updateStatus(id, status);

        if (!isSuccess) {
            throw new Exception("Lỗi Database: Không thể cập nhật trạng thái đơn hàng lúc này.");
        }
    }

    // Dùng cho OrderClientServlet khi khách đặt xe
    public void createOrder(Order order) throws Exception {
        // 1. Kiểm tra NULL/Rỗng trước khi Match
        if (order.getPhone() == null || order.getPhone().trim().isEmpty()) {
            throw new Exception("Đặt xe thất bại: Số điện thoại không được để trống!");
        }

        // 2. Kiểm tra định dạng (Regex)
        if (!order.getPhone().matches("^\\d{10}$")) {
            throw new Exception("Đặt xe thất bại: Số điện thoại phải bao gồm đúng 10 chữ số!");
        }

        // 3. Thực hiện lưu vào DB
        boolean isSaved = orderDAO.insertOrder(order);

        if (!isSaved) {
            throw new Exception("Lỗi hệ thống: Không thể ghi nhận đơn hàng vào cơ sở dữ liệu.");
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

    public String deleteOrder(int id) {
        try {
            Order order = orderDAO.getOrderById(id);

            if (order == null) {
                return "Đơn hàng không tồn tại trên hệ thống!";
            }

            if (order.getStatus() == 1) {
                return "Không thể xóa: Xe đang được khách hàng sử dụng!";
            }
            if (order.getStatus() == 2) {
                return "Không thể xóa: Đơn hàng đã hoàn thành, cần giữ lại để đối soát doanh thu!";
            }

            boolean isDeleted = orderDAO.deleteOrder(id);

            if (isDeleted) {
                return "SUCCESS";
            } else {
                return "Lỗi: Không thể xóa dữ liệu trong cơ sở dữ liệu.";
            }

        } catch (Exception e) {
            e.printStackTrace();
            return "Lỗi hệ thống: " + e.getMessage();
        }
    }

    public void addOrder(Order order) {
        orderDAO.insertOrder(order);
    }
}