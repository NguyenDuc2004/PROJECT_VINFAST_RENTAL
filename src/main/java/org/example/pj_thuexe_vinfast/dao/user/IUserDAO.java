package org.example.pj_thuexe_vinfast.dao.user;

import org.example.pj_thuexe_vinfast.modal.User;

import java.util.List;

public interface IUserDAO {
    User checkLogin(String email, String password);
    List<User> filterSearchListUser(String keyword,String role,String status, int page, int pageSize);
    User getUserById(int id);
    boolean insertUser(User user);
    boolean deletedUser(int id);
    boolean editedUser(User user);
    int countUser(int role);
    public boolean checkEmailExists(String email);
    public boolean register(String fullname, String email, String password, String phone);
    public int countFilterUsers(String keyword, String role, String status);
}
