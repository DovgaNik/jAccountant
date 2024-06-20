<%@ page import="dev.dovhan.jaccountant.utilities.ConnectionProvider" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="dev.dovhan.jaccountant.utilities.Credentials" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Paths" %>
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
	<title>Products</title>
	<link href="styles/products.css" rel="stylesheet" type="text/css">
	<link rel="icon" href="favicon.ico" />
	<script src="scripts/products.js"></script>
</head>
<body>
<div class="header">

	<h1>Products</h1>

</div>
<div class="flex_container">
	<div class="main_table_container">
		<table class="main_table">
			<tr class="main_table_header_row">
				<th class="main_table_header">Name</th>
				<th class="main_table_header">Description</th>
				<th class="main_table_header">Category</th>
				<th class="main_table_header">Sterge</th>
			</tr>
			<%
				try {
					String sql = Files.readString(Paths.get(credentials.pathToSQL, "products_page.sql"));
					Statement statement = connection.createStatement();
					ResultSet result = statement.executeQuery(sql);
					while (result.next()) {
						out.println(
								"<tr>" +
										"<form method=\"POST\" action=\"deleteProduct\" name=\"deleteProduct\" class=\"deleteProduct\">" +
											"<td class=\"main_table_data\">" + result.getString("name") + "</td>" +
											"<td class=\"main_table_data\">" + result.getString("description") + "</td>" +
											"<td class=\"main_table_data\">" + result.getString("category") + "</td>" +

											"<td class=\"main_table_data\">" +
												"<input type=\"submit\" value=\"Sterge\"/>" +
												"<input type=\"hidden\" value=\"" + result.getString("id") + "\" name=\"product_to_delete\"/>" +
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
		<form method="POST" action="addProduct" name="add_form" class="add_form">
			<h1>Add product</h1>

			<label for="name">Name: </label>
			<input type="text" name="name" id="name"/> <br>
			<label for="description">Description: </label>
			<input type="text" name="description" id="description"/> <br>

			<label for="category">Category: </label>
			<select name="category" id="category">
				<%
					try {
						String sql = Files.readString(Paths.get(credentials.pathToSQL, "category_dropdown.sql"));
						Statement statement = connection.createStatement();
						ResultSet result = statement.executeQuery(sql);

						while (result.next()) {
							String option = result.getString("name");
							out.println("<option value=\""  + option + "\">" + option + "</option>");
						}
					} catch (Exception e) {
						out.println(e.getMessage());
					}
				%>
			</select> <br>

			<input type="reset" value="Reset">
			<input type="button" value="Submit" onclick="validateAndSubmit()"/> <br>
			<span id="output"></span>
		</form>
	</div>
</div>
</body>
</html>