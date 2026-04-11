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
//    public boolean deleteUserById(int id) {
//        User user = getUserById(id);
//        if (user == null) {
//            System.out.println("Nghiệp vụ: Người dùng không tồn tại để xóa.");
//            return false;
//        }
//
//        if (user.getRole() == 1) { // Giả sử 1 là ADMIN
//            System.out.println("Nghiệp vụ: Không thể xóa tài khoản Admin tối cao.");
//            return false;
//        }
//        return userDAO.deletedUser(id);
//    }
}
