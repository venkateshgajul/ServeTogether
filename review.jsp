<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Review Page</title>
</head>
<body>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String message = request.getParameter("message");
    String rating = request.getParameter("rating");

    Connection con = null;
    PreparedStatement ps = null;

    try {
        
        Class.forName("com.mysql.cj.jdbc.Driver");

        
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/servetogether1", "root", "");

        
        String query = "INSERT INTO review_msg (name, email, message, rating) VALUES (?, ?, ?, ?)";
        ps = con.prepareStatement(query);
        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, message);
        ps.setString(4, rating);

        
        int result = ps.executeUpdate();

        if (result > 0) {
            out.println("<script>");
            out.println("alert('Thank you for your feedback!');");
            out.println("window.location.href='main.html';");
            out.println("</script>");
        } else {
            out.println("<script>");
            out.println("alert('Feedback submission failed. Please try again.');");
            out.println("window.history.back();");
            out.println("</script>");
        }

    } catch (SQLException e) {
        out.println("<script>alert('Database error: " + e.getMessage() + "');</script>");
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        out.println("<script>alert('JDBC Driver not found: " + e.getMessage() + "');</script>");
        e.printStackTrace();
    } finally {
        
        try {
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>
