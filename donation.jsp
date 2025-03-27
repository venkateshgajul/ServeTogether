<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Donation page</title>
</head>
<body>
<%
   
    String a = request.getParameter("fullname");
    String b = request.getParameter("email");
    String c = request.getParameter("address");
    String d = request.getParameter("city");
    String e = request.getParameter("state");
    String f = request.getParameter("zip");
    String g = request.getParameter("country");
    String h = request.getParameter("cardname");
    String z = request.getParameter("cardnumber");
    String i = request.getParameter("expmonth");
    String j = request.getParameter("expyear");
    String k = request.getParameter("cvv");
    String l = request.getParameter("amount");

    
    if (a == null || b == null || c == null || d == null || e == null || f == null || g == null || h == null || z == null || i == null || j == null || k == null || l == null) {
        out.println("<script>alert('Please fill in all fields'); window.history.back();</script>");
    } else {
        Connection con = null;
        PreparedStatement ps = null;

        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/servetogether1", "root", "");

            
            String sql = "INSERT INTO donation_page (fullname, email, address, city, state, zip, country, cardname, cardnumber, expmonth, expyear, cvv, amount) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
            
            ps = con.prepareStatement(sql);
            
            
            ps.setString(1, a);
            ps.setString(2, b);
            ps.setString(3, c);
            ps.setString(4, d);
            ps.setString(5, e);
            ps.setString(6, f);
            ps.setString(7, g);
            ps.setString(8, h);
            ps.setString(9, z);
            ps.setString(10, i);
            ps.setString(11, j);
            ps.setString(12, k);
            ps.setString(13, l);
            

            
            int x = ps.executeUpdate();

            
            if (x != 0) {
                out.println("<script>");
                out.println("window.location.href='practice.html';");
                out.println("</script>");
            } else {
                out.println("<script>alert('Error: Could not insert record.');</script>");
            }
        } catch (Exception e1) {
            e1.printStackTrace();
            out.println("<script>alert('Error: " + e1.getMessage() + "');</script>");
        } finally {
            
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e2) {
                e2.printStackTrace();
            }
        }
    }
%>
</body>
</html>
