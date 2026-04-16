package org.example.pj_thuexe_vinfast.dbConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {
    public static final String JDBC_URL = "jdbc:mysql://localhost:3306/vinfast_rental?useSSL=false&allowPublicKeyRetrieval=true";
    public static final String USER = "root";
    public static final String PASSWORD = "123456";
    private static Connection conn;

    public static Connection getConnection(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            if(conn == null || conn.isClosed()){
                conn = DriverManager.getConnection(JDBC_URL, USER, PASSWORD);
                if(conn != null){
                    System.out.println("Connect success!");
                }
            }
            return conn;

        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
