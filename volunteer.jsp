<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Volunteer Register</title>
</head>
<body>
<%
    String n, g, e, w, d, p, l;
    n = request.getParameter("name");
    g = request.getParameter("gender");
    e = request.getParameter("email");
    w = request.getParameter("availability_weekend") != null ? "Yes" : "No";
    d = request.getParameter("availability_day") != null ? "Yes" : "No";
    p = request.getParameter("date");
    l = request.getParameter("location");

    if (n == null || n.trim().isEmpty() || g == null || g.trim().isEmpty() || e == null || e.trim().isEmpty() || p == null || p.trim().isEmpty() || l == null || l.trim().isEmpty()) {
        out.println("<script>");
        out.println("window.alert('Enter details!');");
        out.println("window.history.back();");
        out.println("</script>");
    } else {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/servetogether1", "root", "");
            PreparedStatement ps = con.prepareStatement("INSERT INTO referral (name, Gender, Email, AvailabilityWeekends, AvailabilityDays, PreferredDatee, PreferredLocation) VALUES (?, ?, ?, ?, ?, ?, ?)");
            ps.setString(1, n);
            ps.setString(2, g);
            ps.setString(3, e);
            ps.setString(4, w);
            ps.setString(5, d);
            ps.setString(6, p);
            ps.setString(7, l);

            int i = ps.executeUpdate();
            if (i != 0) {
                out.println("<script>");
                out.println("window.location.href='campaign_joined.html';"); 
                out.println("</script>");
            }
        } catch (Exception ex) {
            out.println("Error: " + ex.getMessage());
        }
    }
%>
</body>
</html>
