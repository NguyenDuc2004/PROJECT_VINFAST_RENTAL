package org.example.pj_thuexe_vinfast.dao.user;

import org.example.pj_thuexe_vinfast.dbConnection.DbConnection;
import org.example.pj_thuexe_vinfast.modal.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class UserDAO implements IUserDAO{
    public static final String CHECK_LOGIN = "SELECT u.id,u.fullname, u.email, u.role " +
            "FROM users u WHERE u.email = ? AND u.password = ? AND u.status = 1";
    public static final String getCountUser = "select Count(*)from users where role = ?;";
    public static final String SELECT_USERS = "select *from users where 1=1";
    public static final String DELTE_USER = "DELETE from users where id = ?;";

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

    @Override
    public List<User> filterSearchListUser(String keyword,String role,String status) {
        List<User> users = new ArrayList<>();
        StringBuilder sql = new StringBuilder(SELECT_USERS);
        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (fullname LIKE ? OR email LIKE ?) ");
        }
        if(role != null && !role.isEmpty()){
            sql.append(" AND role = ? ");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ? ");
        } else {
            sql.append(" AND status = 1 ");
        }
        try(Connection conn = DbConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql.toString())
        ) {
            int paramIndex = 1;
            if (keyword != null && !keyword.isEmpty()) {
                String pattern = "%" + keyword + "%";
                ps.setString(paramIndex++, pattern);
                ps.setString(paramIndex++, pattern);
            }
            if (role != null && !role.isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(role));
            }
            if (status != null && !status.isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(status));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String fullname = rs.getString("fullname");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                int getRole = rs.getInt("role");
                String createAt = rs.getString("created_at");
                int uStatus = rs.getInt("status");
                User user = new User(id,fullname, email, phone, address, getRole,uStatus,createAt);
                users.add(user);
            }
            return users;
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi truy vấn UserDAO: " + e.getMessage());
        }
    }

    @Override
    public User getUserById(int id) {
        return null;
    }

    @Override
    public boolean deletedUser(int id) {
        try(Connection conn = DbConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(DELTE_USER)
        ) {
            ps.setInt(1,id);
            int rowDeleted = ps.executeUpdate();
            return rowDeleted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("LOI USER DAO");
            return false;
        }
    }

    @Override
    public boolean editedUser(User user) {
        return false;
    }

    @Override
    public int countUser(int role) {
        try(Connection conn = DbConnection.getConnection();
        PreparedStatement ps = conn.prepareStatement(getCountUser)
        ) {
            ps.setInt(1,role);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }
}
