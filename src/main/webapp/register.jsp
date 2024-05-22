 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create an account</title>
</head>
<body>
    <h1>Please register</h1>
    <form action="register-servlet" method="post">
        User name:<input type="text" name="username"/><br/><br/>
        Password:<input type="password" name="password"/><br/><br/>
        <input type="submit" value="Create an account"/>
    </form>
</body>
</html>
