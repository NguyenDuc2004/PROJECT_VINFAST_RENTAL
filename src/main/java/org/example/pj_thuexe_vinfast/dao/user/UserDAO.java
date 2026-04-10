package org.example.pj_thuexe_vinfast.dao.user;

import org.example.pj_thuexe_vinfast.dbConnection.DbConnection;
import org.example.pj_thuexe_vinfast.modal.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO implements IUserDAO{
    public static final String CHECK_LOGIN = "SELECT u.id,u.fullname, u.email, u.role " +
            "FROM users u WHERE u.email = ? AND u.password = ? AND u.status = 1";
    @Override
    public User checkLogin(String email, String password) {
        try(Connection conn = DbConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(CHECK_LOGIN);
        ) {
            ps.setString(1,email);
            ps.setString(2,password);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                int id = rs.getInt("id");
                String fullname = rs.getString("fullname");
                String email_user = rs.getString("email");
                int role = rs.getInt("role");
                User user = new User(id,fullname,email_user,role);
                return user;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }
}
