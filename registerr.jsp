<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration</title>
</head>
<body>
<%
    
    String u = request.getParameter("name");
    String e = request.getParameter("Email");
    String p = request.getParameter("password");
    
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/servetogether1", "root", "");

            PreparedStatement checkUser = con.prepareStatement("SELECT * FROM registration WHERE name = ? OR email = ?");
            checkUser.setString(1, u);
            checkUser.setString(2, e);
            ResultSet rs = checkUser.executeQuery();


            if (u == null || u.trim().isEmpty() || e == null || e.trim().isEmpty() || p == null || p.trim().isEmpty())
            {
            	out.println("<script>");
            	out.println("window.alert('Enter details!');");
                out.println("window.history.back();");  
                out.println("</script>");	
            }
            else if (rs.next())
            {
                
                out.println("<script>");
                out.println("window.alert('Username or Email already exists!');");
                out.println("window.history.back();");  
                out.println("</script>");
            }
            else 
            {
                
                PreparedStatement ps = con.prepareStatement("insert into registration (name,email, new_password) values (?, ?, ?)");
                
                ps.setString(1, u);
                ps.setString(2, e);
                ps.setString(3, p);
                

                int i = ps.executeUpdate();
                if (i != 0)
                {
                    out.println("<script>");
                    out.println("window.alert('Registered Successfully!!')");
                    out.println("window.location.href='login.html';");
                    out.println("</script>");
                }
            }
        } catch (Exception ex) {
            out.println("Error: " + ex.getMessage());
        }
    
%>
</body>
</html>