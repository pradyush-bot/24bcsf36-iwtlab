<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.nothing.dao.DBConnection, java.io.*" %>
<%
    String userName = (String) session.getAttribute("userName");
    
    // Send JSON response helper
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    
    if (userName == null) {
        response.setStatus(401);
        out.print("{\"success\": false, \"message\": \"User not logged in\"}");
        return;
    }

    // Read the JSON body from the request
    StringBuilder sb = new StringBuilder();
    BufferedReader reader = request.getReader();
    String line;
    while ((line = reader.readLine()) != null) {
        sb.append(line);
    }
    String orderDetails = sb.toString();
    
    if (orderDetails == null || orderDetails.trim().isEmpty() || orderDetails.equals("[]")) {
        response.setStatus(400);
        out.print("{\"success\": false, \"message\": \"Cart is empty\"}");
        return;
    }

    // Calculate total amount from the JSON string (a simple regex/string extraction for this basic impl)
    // Normally we'd use a JSON parser, but without libraries in this project, we can just do a basic extraction
    // Or simpler, we can receive total_amount as a query parameter or header to avoid parsing JSON in Java
    String totalAmountStr = request.getParameter("total");
    double totalAmount = 0.0;
    try {
        if (totalAmountStr != null) {
            totalAmount = Double.parseDouble(totalAmountStr);
        }
    } catch (NumberFormatException e) {
        // Handle error if needed
    }

    try (Connection conn = DBConnection.getConnection()) {
        String insertSql = "INSERT INTO orders (user_name, total_amount, order_data) VALUES (?, ?, ?)";
        try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
            insertStmt.setString(1, userName);
            insertStmt.setDouble(2, totalAmount);
            insertStmt.setString(3, orderDetails); // Store the raw JSON cart array
            insertStmt.executeUpdate();
            
            out.print("{\"success\": true, \"message\": \"Order placed successfully\"}");
        }
    } catch (Exception e) {
        response.setStatus(500);
        out.print("{\"success\": false, \"message\": \"Database error: " + e.getMessage().replace("\"", "\\\"") + "\"}");
    }
%>