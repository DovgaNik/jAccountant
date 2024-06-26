<%@ page import="dev.dovhan.jaccountant.utilities.ConnectionProvider" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="dev.dovhan.jaccountant.utilities.Credentials" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>

<%!Connection connection;%>
<%!Credentials credentials;%>

<%
	try {
		connection = ConnectionProvider.getConnection();
	} catch (Exception e) {
		throw new RuntimeException(e);
	}
%>

<%
	try {
		credentials = new Credentials();
	} catch (Exception e) {
		throw new RuntimeException(e);
	}
%>

<html>
<head>
	<title>Roles</title>
	<link href="styles/role.css" rel="stylesheet" type="text/css">
	<link rel="icon" href="favicon.ico" />
	<script src="scripts/role.js"></script>
</head>
<body>
<div class="header">

	<h1>Roles</h1>

</div>
<div class="flex_container">
	<div class="main_table_container">
		<table class="main_table">
			<tr class="main_table_header_row">
				<th class="main_table_header">Role type</th>
				<th class="main_table_header">Sterge</th>
			</tr>
			<%
				try {

					Statement statement = connection.createStatement();
					ResultSet result = statement.executeQuery("SELECT type FROM roles");
					while (result.next()) {
						out.println(
								"<tr>" +
										"<form method=\"POST\" action=\"deleteRole\" name=\"deleteRole\" class=\"deleteRole\">" +
											"<td class=\"main_table_data\">" + result.getString("type") + "</td>" +
											"<td class=\"main_table_data\">" +
												"<input type=\"submit\" value=\"Sterge\"/>" +
												"<input type=\"hidden\" value=\"" + result.getString("type") + "\" name=\"role_to_delete\"/>" +
											"</td>" +
										"</form>" +
								"</tr>");
					}

				} catch (SQLException e) {
					System.out.println(e.getSQLState());
					System.out.println(e.getMessage());
				}
			%>

		</table>
	</div>

	<div class="sidebar">
		<form method="POST" action="addRole" name="add_form" class="add_form">
			<h1>Add role</h1>

			<label for="type">Role: </label>
			<input type="text" name="type" id="type"/> <br>

			<input type="reset" value="Reset">
			<input type="button" value="Submit" onclick="validateAndSubmit()"/> <br>
			<span id="output"></span>
		</form>
	</div>
</div>
</body>
</html>