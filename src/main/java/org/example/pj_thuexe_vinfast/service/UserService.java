package org.example.pj_thuexe_vinfast.service;

import org.example.pj_thuexe_vinfast.dao.user.IUserDAO;
import org.example.pj_thuexe_vinfast.dao.user.UserDAO;
import org.example.pj_thuexe_vinfast.modal.User;

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
}
