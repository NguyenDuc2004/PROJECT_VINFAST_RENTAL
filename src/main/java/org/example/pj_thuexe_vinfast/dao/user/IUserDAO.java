package org.example.pj_thuexe_vinfast.dao.user;

import org.example.pj_thuexe_vinfast.modal.User;

public interface IUserDAO {
    User checkLogin(String email, String password);
}
