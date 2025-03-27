<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ADMIN LOGIN</title>
</head>
<body>
<%
    String u, p, U, P;
    u = request.getParameter("username");
    p = request.getParameter("password");
    
    U = "Admin19";
    P = "Admin@19";
    
    if (u.equals(U) && p.equals(P)) {
        out.println("<script>");
        out.println("window.alert('Admin Login Successful!!');");
        out.println("window.location.href='admin.html';");
        out.println("</script>");
    } else {
        out.println("<script>");
        out.println("window.alert('Admin Login Unsuccessful');");
        out.println("window.location.href='adminlogin.html';");
        out.println("</script>");
    }   
%>

</body>
</html>