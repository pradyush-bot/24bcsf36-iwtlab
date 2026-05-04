<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.nothing.dao.DBConnection" %>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String address = request.getParameter("address");

    if (name == null || email == null || password == null || address == null ||
        name.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty() || address.trim().isEmpty()) {
        request.setAttribute("error", "All fields are required.");
        request.getRequestDispatcher("signup.jsp").forward(request, response);
        return;
    }

    String passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^a-zA-Z0-9]).{8,}$";
    if (!password.matches(passwordRegex)) {
        request.setAttribute("error", "Password must contain at least 8 characters, including uppercase, lowercase, a number, and a special character.");
        request.getRequestDispatcher("signup.jsp").forward(request, response);
        return;
    }

    try (Connection conn = DBConnection.getConnection()) {
        // Check if email already exists
        String checkSql = "SELECT * FROM users WHERE email = ?";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, email);
            try (ResultSet rs = checkStmt.executeQuery()) {
                if (rs.next()) {
                    request.setAttribute("error", "Email already exists.");
                    request.getRequestDispatcher("signup.jsp").forward(request, response);
                    return;
                }
            }
        }

        // Insert new user
        String insertSql = "INSERT INTO users (name, email, password, address) VALUES (?, ?, ?, ?)";
        try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
            insertStmt.setString(1, name);
            insertStmt.setString(2, email);
            insertStmt.setString(3, password);
            insertStmt.setString(4, address);
            insertStmt.executeUpdate();
            
            // Redirect to login with success
            request.setAttribute("success", "Account created successfully. Please log in.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    } catch (Exception e) {
        request.setAttribute("error", "Database error: " + e.getMessage());
        request.getRequestDispatcher("signup.jsp").forward(request, response);
    }
%>