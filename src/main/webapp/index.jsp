<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
	<title>jAccountant</title>
</head>
<body>
<h1>Please log in</h1>
<form action="login-servlet" method="post">
	User name:<input type="text" name="username"/><br/><br/>
	Password:<input type="password" name="password"/><br/><br/>
	<input type="submit" value="login"/>
</form>
<a href="register.jsp">Register</a>
</body>
</html>