<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
<%
String a = request.getParameter("Email");
String b = request.getParameter("password");
boolean recordFound = false;

if (a == null || a.trim().isEmpty() || b == null || b.trim().isEmpty())
{
	out.println("<script>");
	out.println("window.alert('Enter details!');");
    out.println("window.history.back();");  
    out.println("</script>");	
}else{

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/servetogether1", "root", "");
    Statement s1 = con.createStatement();
    ResultSet rs = s1.executeQuery("select * from registration where email='" + a + "' AND new_password='" + b + "'");

    while (rs.next()) {
        String U = rs.getString("email");
        String P = rs.getString("new_password");
        if (U.equals(a) && P.equals(b)) {
            recordFound = true;
            out.println("<script>");
            out.println("window.alert('Login Successfully');");
            out.println("window.location.href='main.html';"); 
            out.println("</script>");
            break;
        }
    }

    if (!recordFound) {
        out.println("<script>");
        out.println("window.alert('Record Not Found ! Check your Mail or Password');");
        out.println("window.location.href='login.html';");
        out.println("</script>");
    }

    rs.close();
    s1.close();
    con.close();
} catch (Exception e) {
    e.printStackTrace();
    out.println("<script>");
    out.println("window.alert('Error: " + e.getMessage() + "');");
    out.println("window.location.href='login.html';");
    out.println("</script>");
}
}
%>
</body>
</html>