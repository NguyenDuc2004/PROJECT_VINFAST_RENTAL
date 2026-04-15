package org.example.pj_thuexe_vinfast.service;

import org.example.pj_thuexe_vinfast.dao.user.IUserDAO;
import org.example.pj_thuexe_vinfast.dao.user.UserDAO;
import org.example.pj_thuexe_vinfast.modal.User;

import java.util.List;

public class UserService {
    IUserDAO userDAO = new UserDAO();

    public User checkLogin(String email, String password) {
        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            return null;
        }
        User user = userDAO.checkLogin(email, password);
        if (user != null) {
            System.out.println("User " + user.getFullname() + " đăng nhập thành công!");
            return user;
        }
        return null;
    }
    public List<User> filterSearchListUser(String keyword,String role,String status){
        if (keyword != null) {
            keyword = keyword.trim();
        }
        if ("".equals(role) || "all".equalsIgnoreCase(role)) {
            role = null;
        }
        if ("".equals(status) || "all".equalsIgnoreCase(status)) {
            status = null;
        }
        return userDAO.filterSearchListUser(keyword,role,status);
    }
    public int getTotalUser(int role){
        return userDAO.countUser(role);
    }

    public User getDetailUser(int id) throws Exception {
        if (id <= 0) {
            throw new Exception("ID người dùng không hợp lệ!");
        }
        User user = userDAO.getUserById(id);
        if (user == null) {
            System.out.println("DEBUG: Khong tim thay User ID = " + id);
            throw new Exception("Người dùng này không tồn tại trên hệ thống!");
        }
        return user;
    }

    public boolean deleteUserById(int id) throws Exception {
        if (id <= 0) {
            throw new Exception("ID người dùng không hợp lệ!");
        }
        User user = userDAO.getUserById(id);
        if (user == null) {
            System.out.println("DEBUG: Khong tim thay User ID = " + id);
            throw new Exception("Người dùng này không tồn tại trên hệ thống!");
        }if (user.getStatus() == 0) {
            throw new Exception("Người dùng này đã bị xóa/khóa từ trước đó rồi!");
        }
        return userDAO.deletedUser(id);
    }

    public boolean editedUser(User user,int currentAdminId) throws Exception {
        if (user.getId() <= 0) throw new Exception("ID không hợp lệ!");
        User oldUser = userDAO.getUserById(user.getId());
        if (oldUser == null) throw new Exception("Người dùng không tồn tại!");
        //chan tu khoa chinh minh
        if (user.getId() == currentAdminId && user.getStatus() == 0) {
            throw new Exception("Bạn không thể tự khóa tài khoản của chính mình!");
        }
        if (user.getId() == currentAdminId && user.getRole() != 1) {
            throw new Exception("Bạn không thể tự hạ quyền Quản trị viên của chính mình!");
        }
        if (user.getFullname() == null || user.getFullname().trim().isEmpty()) {
            throw new Exception("Họ và tên không được để trống!");
        }
        String emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";

        if (user.getEmail() == null || !user.getEmail().matches(emailRegex)) {
            throw new Exception("Email không hợp lệ!");
        }

        if (!user.getEmail().equals(oldUser.getEmail())) {
            if (userDAO.checkEmailExists(user.getEmail())) {
                throw new Exception("Email này đã tồn tại");
            }
        }
        String phone = user.getPhone();
        if (phone != null && !phone.trim().isEmpty()) {
            if (!phone.matches("\\d{10,11}")) {
                throw new Exception("Số điện thoại không hợp lệ (phải là 10-11 chữ số)!");
            }
        }

        return userDAO.editedUser(user);
    }

    public boolean insertUser(User user) throws Exception {
        if (userDAO.checkEmailExists(user.getEmail())) {
            throw new Exception("Email này đã được đăng ký. Vui lòng sử dụng email khác!");
        }

        if (user.getPassword() == null || user.getPassword().length() < 6) {
            throw new Exception("Mật khẩu phải có ít nhất 6 ký tự!");
        }

        if (user.getFullname() == null || user.getFullname().isEmpty()) {
            throw new Exception("Vui lòng điền họ tên");
        }

        String phone = user.getPhone();
        if (phone != null && !phone.trim().isEmpty()) {
            if (!phone.matches("\\d{10,11}")) {
                throw new Exception("Số điện thoại không hợp lệ (phải là 10-11 chữ số)!");
            }
        }

        return userDAO.insertUser(user);
    }

}
