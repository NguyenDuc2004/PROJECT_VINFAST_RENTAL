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

public class UserDAO implements IUserDAO {
    public static final String CHECK_LOGIN = "SELECT u.id,u.fullname, u.email, u.role " +
            "FROM users u WHERE u.email = ? AND u.password = ? AND u.status = 1";
    public static final String getCountUser = "select Count(*)from users where role = ? AND status = 1;";
    public static final String SELECT_USERS = "select *from users where 1=1";
    public static final String DELTE_USER = "UPDATE users SET status = 0 where id = ?;";
    public static final String GET_USER_BY_ID = "SELECT *FROM users WHERE id = ?";
    public static final String UPDATE_USER = "UPDATE users SET fullname = ?,email = ?,phone = ?,address = ?,role= ?,status = ? WHERE id = ?;";
    public static final String INSERT_USER = "INSERT INTO users (fullname, email, password, phone, role, address) VALUES (?, ?, ?, ?, ?, ?)";

    @Override
    public User checkLogin(String email, String password) {
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(CHECK_LOGIN);
        ) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                String fullname = rs.getString("fullname");
                String email_user = rs.getString("email");
                int role = rs.getInt("role");
                User user = new User(id, fullname, email_user, role);
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
        try(Connection conn = DbConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(GET_USER_BY_ID)
        ) {
            User user = null;
            ps.setInt(1,id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                int id_user = rs.getInt("id");
                String fullname = rs.getString("fullname");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                String createdAt = rs.getString("created_at");
                int role = rs.getInt("role");
                int status = rs.getInt("status");
                user = new User(id_user,fullname,email,phone ,address,role,status,createdAt);
            }
            return user;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public boolean insertUser(User user) {

        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_USER)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setInt(5, user.getRole());
            ps.setString(6, user.getAddress());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi DB: " + e.getMessage());
        }
    }

    //xoa mem
    @Override
    public boolean deletedUser(int id) {
        try(Connection conn = DbConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(DELTE_USER)
        ) {
            ps.setInt(1,id);
            int rowDeleted = ps.executeUpdate();
            return rowDeleted > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi SQL tại DAO: " + e.getMessage());
        }
    }

    @Override
    public boolean editedUser(User user) {
        try(Connection conn = DbConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(UPDATE_USER)
        ) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getAddress());
            ps.setInt(5, user.getRole());
            ps.setInt(6, user.getStatus());
            ps.setInt(7, user.getId());
            int rowUpdated = ps.executeUpdate();
            return rowUpdated > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi SQL tại DAO: " + e.getMessage());
        }
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

    @Override
    public boolean checkEmailExists(String email) {
        String sql = "SELECT id FROM users WHERE email = ? LIMIT 1";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            return false;
        }
    }

}
