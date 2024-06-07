<%@ page import="dev.dovhan.jaccountant.utilities.ConnectionProvider" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="dev.dovhan.jaccountant.utilities.DBActions" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!Connection connection;%>
<%!HashMap<Integer, String> furnizor_table;%>
<%!HashMap<Integer, String> produs_table;%>
<%!HashMap<Integer, String> um_table;%>

<%
	try {
		connection = ConnectionProvider.getConnection();
		furnizor_table = DBActions.getDbAsAMap("supplier", connection, "name");
		produs_table = DBActions.getDbAsAMap("product", connection, "name");
		um_table = DBActions.getDbAsAMap("unit_of_measure", connection, "name");
	} catch (Exception e) {
		throw new RuntimeException(e);
	}
%>

<html>
<head>
	<title>Workbench</title>
	<link href="styles/workbench.css" rel="stylesheet" type="text/css">
	<script src="scripts/vanzare.js"></script>
</head>
<body>
<div class="header">

	<h1>Contabilitate</h1>

	<a href="unit_of_measure.jsp">Unitati de masura</a>
	<a href="seller.jsp">Furnizori</a>
	<a href="product.jsp">Produse</a>

</div>
<div class="flex_container">
	<div class="main_table_container">
		<table class="main_table">
			<tr class="main_table_header_row">
				<th class="main_table_header">Data</th>
				<th class="main_table_header">Furnizor</th>
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
				try {
					Connection connection = ConnectionProvider.getConnection();
					String sql = "select * from  sale";
					PreparedStatement preparedStmt = connection.prepareStatement(sql);
					ResultSet result = preparedStmt.executeQuery();

					while(result.next()){
						int id = result.getInt(1);
						Date data = result.getDate(2);
						int supplier_id = result.getInt(3); //FK
						int product_id = result.getInt(4); //FK
						String caen = result.getString(5);
						int quantity = result.getInt(6);
						int unit_of_measure_id = result.getInt(7); //FK
						BigDecimal expenses = result.getBigDecimal(8);
						BigDecimal revenue = result.getBigDecimal(9);
						int note = result.getInt(10);
						BigDecimal deducible = result.getBigDecimal(11);
						BigDecimal profit = result.getBigDecimal(12);
						BigDecimal taxable = result.getBigDecimal(13);
						BigDecimal tax = result.getBigDecimal(14);

						String supplier_name = furnizor_table.get(supplier_id).toString();
						String product_name = produs_table.get(product_id).toString();
						String unit_of_measure_name = um_table.get(unit_of_measure_id).toString();

						out.println(
								"<tr class=\"main_table_data_row\">" +
										"<form method=\"POST\" action=\"deleteInvoice\">" +
											"<td class=\"main_table_data\">" + data + "</td>" +
											"<td class=\"main_table_data\">" + supplier_name + "</td>" +
											"<td class=\"main_table_data\">" + product_name + "</td>" +
											"<td class=\"main_table_data\">" + caen + "</td>" +
											"<td class=\"main_table_data\">" + quantity + "</td>" +
											"<td class=\"main_table_data\">" + unit_of_measure_name + "</td>" +
											"<td class=\"main_table_data\">" + expenses + "</td>" +
											"<td class=\"main_table_data\">" + revenue + "</td>" +
											"<td class=\"main_table_data\">" + note + "</td>" +
											"<td class=\"main_table_data\">" + deducible + "</td>" +
											"<td class=\"main_table_data\">" + profit + "</td>" +
											"<td class=\"main_table_data\">" + taxable + "</td>" +
											"<td class=\"main_table_data\">" + tax + "</td>" +
											"<td class=\"main_table_data\">" +
												"<input type=\"submit\" value=\"Sterge\"/>" +
												"<input type=\"hidden\" value=\"" + id +"\" name=\"sell_to_delete\"/>" +
											"</td>" +
										"</form>"+
										"</tr>");
					}

					connection.close();
				} catch (Exception e){
					out.println(e.getMessage());
				}

			%>
		</table>
	</div>

	<div class="sidebar">
		<h1>Add entry</h1>
		<form method="POST" action="addInvoice" name="add_form">
			<label for="date">Date of transaction: </label>
			<input type="date" name="date" id="date"/> <br>

			<label for="seller">Furnizor: </label>
			<select name="seller" id="seller">
				<%
					try {
						for (String i : furnizor_table.values()) {
							out.println("<option value=\"" + i + "\">" + i + "</option>");
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
						for (String i : produs_table.values()){
							out.println("<option value=\"" + i + "\">" + i + "</option>");
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
						for (String i : um_table.values()){
							out.println("<option value=\"" + i + "\">" + i + "</option>");
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
			<input type="number" name="note" id="note"/> <br>

			<label for="deductibil">Deductibil: </label>
			<input type="number" name="deductibil" id="deductibil"/> <br>

			<label for="profit">Profit: </label>
			<input type="number" name="profit" id="profit"/> <br>

			<label for="impozabil">Impozabil: </label>
			<input type="number" name="impozabil" id="impozabil"/> <br>

			<label for="impozit">Impozit: </label>
			<input type="number" name="impozit" id="impozit"/> <br>

			<input type="reset" value="Reset">
			<input type="button" value="Submit" onclick="validateAndSubmit()"/> <br>
			<span id="output"></span>
		</form>
	</div>
</div>
</body>
</html>
