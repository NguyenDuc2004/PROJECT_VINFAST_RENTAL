//package org.example.pj_thuexe_vinfast;
//
//import org.example.pj_thuexe_vinfast.dbConnection.DbConnection;
//
//import java.io.*;
//import java.sql.Connection;
//import javax.servlet.http.*;
//import javax.servlet.annotation.*;
//
//@WebServlet(name = "helloServlet", value = "/hello-servlet")
//public class HelloServlet extends HttpServlet {
//    private String message;
//
//    public void init() {
//        message = "Hello World!";
//    }
//
//    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        Connection conn = DbConnection.getConnection();
//        System.out.println("DB: " + conn);
//    }
//
//    public void destroy() {
//    }
//}