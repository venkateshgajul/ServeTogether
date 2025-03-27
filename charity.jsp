<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Charity Page</title>
</head>
<body>
<%
    String a = request.getParameter("charity-name");
    String b = request.getParameter("email");
    String c = request.getParameter("location");
    String d = request.getParameter("reason");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection to the database
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/servetogether1", "root", "");

        // Check if the email already exists
        String checkQuery = "SELECT * FROM charity WHERE email = ?";
        PreparedStatement checkStmt = con.prepareStatement(checkQuery);
        checkStmt.setString(1, b);

        ResultSet rs = checkStmt.executeQuery();

        if (rs.next()) {
            // If the email already exists, show an alert
            out.println("<script>");
            out.println("window.alert('Email already exists. Please use another email.');");
            out.println("window.location.href='charity.html';");
            out.println("</script>");
        } else {
            // If the email does not exist, insert the new record
            String insertQuery = "INSERT INTO charity (charity_name, email, location, reason) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(insertQuery);

            ps.setString(1, a);  
            ps.setString(2, b);  
            ps.setString(3, c);  
            ps.setString(4, d);  

            int i = ps.executeUpdate();

            if (i != 0) {
                out.println("<script>");
                out.println("window.location.href='campaign_joined.html';"); 
                out.println("</script>");
            } else {
                out.println("<script>");
                out.println("window.alert('Application Update Failed. Please Try Again.');");
                out.println("</script>");
            }

            ps.close();
        }

        checkStmt.close();
        con.close();
    } catch (Exception e) {
        out.println("<script>");
        out.println("window.alert('Error: " + e.getMessage() + "');");
        out.println("</script>");
    }
%>
</body>
</html>
