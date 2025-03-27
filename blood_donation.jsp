<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BLOOD DONATION DRIVE </title>
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
            
            
            String query = "INSERT INTO blood_donation_drive  (Name, Email, Phone_number, Message) VALUES (?, ?, ?, ?)";
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
                out.println("<script>");
                out.println("alert('Failed to join the campaign. Please try again.');");
                out.println("window.history.back();");
                out.println("</script>");
            }

           
            ps.close();
            con.close();
        } catch (SQLException ex) {
            
            out.println("<script>alert('SQL Error: " + ex.getMessage() + "'); window.history.back();</script>");
        } catch (ClassNotFoundException ex) {
            
            out.println("<script>alert('Class Error: " + ex.getMessage() + "'); window.history.back();</script>");
        }
    }
%>
</body>
</html>
