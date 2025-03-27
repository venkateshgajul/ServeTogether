<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cleaning DRIVE</title>
</head>
<body>
<%
    
    String n = request.getParameter("name");
    String g = request.getParameter("email");
    String e = request.getParameter("phone");
    String w = request.getParameter("message");

    if (n == null || g == null || e == null || w == null || n.isEmpty() || g.isEmpty() || e.isEmpty() || w.isEmpty()) {
        out.println("<script>alert('Please fill out all fields.'); window.history.back();</script>");
    } else {
        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/servetogether1", "root", "");

            
            String query = "INSERT INTO river_cleaning_drive (Name, Email, Phone_number, Message) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, n);
            ps.setString(2, g);
            ps.setString(3, e);
            ps.setString(4, w);

            
            int i = ps.executeUpdate();
            if (i != 0) {
                out.println("<script>");
                out.println("window.location.href='campaign_joined.html';");
                out.println("</script>");
            } else {
                out.println("<script>alert('Failed to join the campaign. Please try again.');</script>");
            }

            
            ps.close();
            con.close();
        } catch (SQLException ex) {
            out.println("Error: " + ex.getMessage());
        } catch (ClassNotFoundException ex) {
            out.println("Error: " + ex.getMessage());
        }
    }
%>
</body>
</html>
