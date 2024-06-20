<%@ page import="dev.dovhan.jaccountant.utilities.ConnectionProvider" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.Paths" %>
<%@ page import="dev.dovhan.jaccountant.utilities.Credentials" %>
<%@ page import="java.util.Objects" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<title>Workbench</title>
	<link href="styles/workbench.css" rel="stylesheet" type="text/css">
	<link rel="icon" href="favicon.ico" />
	<script src="scripts/workbench.js"></script>
</head>
<body>
<div class="header">

	<h1>Contabilitate</h1>
	<a href="gender.jsp">Genders</a>

</div>
<div class="flex_container">
	<div class="main_table_container">
		<table class="main_table">
			<tr class="main_table_header_row">
				<th class="main_table_header">ID</th>
				<th class="main_table_header">Data</th>
				<th class="main_table_header">Furnizor/Persoana</th>
				<th class="main_table_header">Produs</th>
				<th class="main_table_header">caen</th>
				<th class="main_table_header">Cantitate</th>
				<th class="main_table_header">UM</th>
				<th class="main_table_header">Cheltuieli</th>
				<th class="main_table_header">Venituri</th>
				<th class="main_table_header">Note</th>
				<th class="main_table_header">Deductibil</th>
				<th class="main_table_header">Profit</th>
				<th class="main_table_header">Impozabil</th>
				<th class="main_table_header">Impozit</th>
				<th class="main_table_header">Sterge</th>
			</tr>
			<%
				//Data 	Furnizor/Persoana 	Produs 	caen 	Cantitate 	UM 	Cheltuieli 	Venituri 	Note 	Deductibil 	Profit 	Impozabil 	Impozit
				try {
					String sql = Files.readString(Paths.get(credentials.pathToSQL, "workbench", "invoice.sql"));
					Statement statement = connection.createStatement();
					ResultSet result = statement.executeQuery(sql);
					while (result.next()) {
						String type = result.getString("type");
						int invoiceID = result.getInt("id");
						out.println(
							"<tr class=\"main_table_data_row\">" +
								"<form method=\"POST\" action=\"deleteInvoice\">" +
									"<td class=\"main_table_data\">" + invoiceID + (Objects.equals(type, "customer")?"C":"S") + "</td>" +
									"<td class=\"main_table_data\">" + result.getDate("date") + "</td>" + //Data
									"<td class=\"main_table_data\">" + result.getString("name") + "</td>" + //Furnizor/Persoana
									"<td class=\"main_table_data\"></td>" + //Produs
									"<td class=\"main_table_data\"></td>" + //caen
									"<td class=\"main_table_data\"></td>" + //Cantitate
									"<td class=\"main_table_data\"></td>" + //UM
									"<td class=\"main_table_data\"></td>" + //Cheltuieli
									"<td class=\"main_table_data\"></td>" + //Venituri
									"<td class=\"main_table_data\"></td>" + //Note
									"<td class=\"main_table_data\"></td>" + //Deductibil
									"<td class=\"main_table_data\"></td>" + //Profit
									"<td class=\"main_table_data\"></td>" + //Impozabil
									"<td class=\"main_table_data\"></td>" + //Impozit

									"<td class=\"main_table_data\">" +
										"<input type=\"submit\" value=\"Sterge\"/>" +
										"<input type=\"hidden\" value=\"" + result.getString("id") +"\" name=\"id_delete\"/>" +
										"<input type=\"hidden\" value=\"" + type +"\" name=\"type_delete\"/>" +
									"</td>" +
								"</form>"+
							"</tr>");

						String transactionSQL;
						if (Objects.equals(type, "customer")) {
							transactionSQL = Files.readString(Paths.get(credentials.pathToSQL, "workbench", "customer_transaction.sql"));
						} else {
							transactionSQL = Files.readString(Paths.get(credentials.pathToSQL, "workbench", "supplier_transaction.sql"));
						}
						PreparedStatement transactionStatement = connection.prepareStatement(transactionSQL);
						transactionStatement.setInt(1, invoiceID);
						ResultSet transaction = transactionStatement.executeQuery();
						while (transaction.next()){
							out.println(
								"<tr class=\"main_table_data_row\">" +
									"<form method=\"POST\" action=\"deleteTransaction\">" +
										"<td class=\"main_table_data\"></td>" +
										"<td class=\"main_table_data\">" + transaction.getDate("date") + "</td>" + //Data
										"<td class=\"main_table_data\"></td>" + //Furnizor/Persoana
										"<td class=\"main_table_data\">" + transaction.getString("product") + "</td>" + //Produs
										"<td class=\"main_table_data\">" + transaction.getString("caen") + "</td>" + //caen
										"<td class=\"main_table_data\">" + transaction.getInt("quantity") + "</td>" + //Cantitate
										"<td class=\"main_table_data\">" + transaction.getString("um") + "</td>" + //UM
										"<td class=\"main_table_data\">" + transaction.getInt("spendings") + "</td>" + //Cheltuieli
										"<td class=\"main_table_data\">" + transaction.getInt("revenue") + "</td>" + //Venituri
										"<td class=\"main_table_data\">" + transaction.getString("notes") + "</td>" + //Note
										"<td class=\"main_table_data\">" + transaction.getString("deductible") + "</td>" + //Deductibil
										"<td class=\"main_table_data\">" + "C" + (transaction.getInt("revenue") - transaction.getInt("spendings")) + "</td>" + //Profit
										"<td class=\"main_table_data\">" + transaction.getString("taxable") + "</td>" + //Impozabil
										"<td class=\"main_table_data\">" + "C" + ((transaction.getInt("revenue") - transaction.getInt("spendings")) * 0.2) + "</td>" + //Impozit

										"<td class=\"main_table_data\">" +
											"<input type=\"submit\" value=\"Sterge\"/>" +
											"<input type=\"hidden\" value=\"" + transaction.getString("id") +"\" name=\"id_delete\"/>" +
											"<input type=\"hidden\" value=\"" + type +"\" name=\"type_delete\"/>" +
										"</td>" +
									"</form>"+
								"</tr>");
						}
					}
				} catch (SQLException e) {
					System.out.println(e.getSQLState());
					System.out.println(e.getMessage());
				}
			%>

		</table>
	</div>

	<div class="sidebar">
		<form method="POST" action="addInvoice" name="add_form" class="add_form">
			<h1>Add Invoice</h1>
			<span>Type of invoice:</span><br>
			<label for="customer_radio">Customer</label>
			<input type="radio" id="customer_radio" name="type_of_invoice" value="customer" onclick="switchType(this)"><br>

			<label for="business_radio">Business</label>
			<input type="radio" id="business_radio" name="type_of_invoice" value="business" onclick="switchType(this)"><br>


			<label for="date">Date of transaction: </label>
			<input type="date" name="date" id="date"/> <br>


			<div id="customer_container" style="display: none">
				<label for="customer">Persoana: </label>
				<select name="customer" id="customer">
					<%
						try {
							String sql = Files.readString(Paths.get(credentials.pathToSQL + "/customers.sql"));
							Statement statement = connection.createStatement();
							ResultSet result = statement.executeQuery(sql);

							while (result.next()) {
								String option = result.getString("surname") + " " + result.getString("name");
								out.println("<option value=\""  + option + "\">" + option + "</option>");
							}
						} catch (Exception e) {
							out.println(e.getMessage());
						}
					%>
				</select> <br>
			</div>

			<div id="supplier_container" style="display: none">
				<label for="supplier">Furnizor: </label>
				<select name="supplier" id="supplier">
					<%
						try {
							String sql = Files.readString(Paths.get(credentials.pathToSQL + "/suppliers.sql"));
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
			</div>
			<input type="reset" value="Reset">
			<input type="button" value="Submit" onclick="validateAndSubmit()"/> <br>
			<span id="output"></span>
		</form>

		<form method="POST" action="addTransaction" name="add_transaction" class="add_form">
			<h1>Add transaction</h1>

			<label for="product">Factura: </label>
			<select name="invoice" id="invoice">
				<%
					try {
						String sql = Files.readString(Paths.get(credentials.pathToSQL, "workbench", "invoice_dropdown.sql"));
						Statement statement = connection.createStatement();
						ResultSet result = statement.executeQuery(sql);

						while (result.next()) {
							String option = result.getString("id");
							out.println("<option value=\""  + option + "\">" + option + "</option>");
						}
					} catch (Exception e) {
						out.println(e.getMessage());
					}
				%>
			</select> <br>


			<label for="product">Produs: </label>
			<select name="product" id="product">
				<%
					try {
						String sql = Files.readString(Paths.get(credentials.pathToSQL + "/products.sql"));
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


			<label for="caen">caen: </label>
			<input type="number" name="caen" id="caen"/> <br>


			<label for="quantity">Cantitate: </label>
			<input type="number" name="quantity" id="quantity"/> <br>


			<label for="um">Unitat de masura: </label>
			<select name="um" id="um">
				<%
					try {
						String sql = Files.readString(Paths.get(credentials.pathToSQL + "/units_of_measure.sql"));
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


			<label for="cheltuieli">Cheltuieli: </label>
			<input type="number" name="cheltuieli" id="cheltuieli"/> <br>


			<label for="venituri">Venituri: </label>
			<input type="number" name="venituri" id="venituri"/> <br>


			<label for="note">Note: </label>
			<input type="text" name="note" id="note"/> <br>


			<label for="deductibil">Deductibil: </label>
			<input type="number" name="deductibil" id="deductibil"/> <br>


			<label for="profit">Profit: </label>
			<input type="number" name="profit" id="profit"/> <br>


			<label for="impozabil">Impozabil: </label>
			<input type="number" name="impozabil" id="impozabil"/> <br>


			<label for="impozit">Impozit: </label>
			<input type="number" name="impozit" id="impozit"/> <br>

			<input type="hidden">
			<input type="reset" value="Reset">
			<input type="button" value="Submit" onclick="submitTransaction()"/> <br>
			<span id="output_transaction"></span>
		</form>

	</div>
</div>
</body>
</html>
