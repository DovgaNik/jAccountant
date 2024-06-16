<%@ page import="dev.dovhan.jaccountant.utilities.ConnectionProvider" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="dev.dovhan.jaccountant.utilities.DBActions" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!Connection connection;%>

<%
	try {
		connection = ConnectionProvider.getConnection();
	} catch (Exception e) {
		throw new RuntimeException(e);
	}
%>

<html>
<head>
	<title>Workbench</title>
	<link href="styles/workbench.css" rel="stylesheet" type="text/css">
	<link rel="icon" href="favicon.ico" />
	<script src="scripts/vanzare.js"></script>
</head>
<body>
<div class="header">

	<h1>Contabilitate</h1>

</div>
<div class="flex_container">
	<div class="main_table_container">
		<table class="main_table">
			<tr class="main_table_header_row">
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
				String sql =
						"SELECT \n" +
						"    supplierinvoice.invoice_date AS date,\n" +
						"    supplier.name AS name,\n" +
						"    products.name AS product,\n" +
						"    supplier_transaction.caen AS caen,\n" +
						"    supplier_transaction.quantity AS quantity,\n" +
						"    unit_of_measure.short AS um,\n" +
						"    supplierinvoice.price AS spendings,\n" +
						"    NULL AS revenue,\n" +
						"    supplier_transaction.notes AS notes\n" +
						"FROM\n" +
						"    supplierinvoice\n" +
						"        INNER JOIN\n" +
						"    supplier ON supplierinvoice.id = supplier.id\n" +
						"        INNER JOIN\n" +
						"    supplier_transaction ON supplier_transaction.invoice_id = supplierinvoice.id\n" +
						"        INNER JOIN\n" +
						"    unit_of_measure ON supplier_transaction.unit_of_measure_id = unit_of_measure.id\n" +
						"        INNER JOIN\n" +
						"    products ON supplier_transaction.product_id = products.id \n" +
						"UNION ALL SELECT \n" +
						"    customerinvoice.invoice_date AS date,\n" +
						"    person.name AS name,\n" +
						"    products.name AS product,\n" +
						"    customer_transaction.caen AS caen,\n" +
						"    customer_transaction.quantity AS quantity,\n" +
						"    unit_of_measure.short AS um,\n" +
						"    NULL AS spendings,\n" +
						"    customerinvoice.price AS revenue,\n" +
						"    customer_transaction.notes AS notes\n" +
						"FROM\n" +
						"    customerinvoice\n" +
						"        INNER JOIN\n" +
						"    person ON customerinvoice.id = person.id\n" +
						"        INNER JOIN\n" +
						"    customer_transaction ON customer_transaction.invoice_id = customerinvoice.id\n" +
						"        INNER JOIN\n" +
						"    unit_of_measure ON customer_transaction.unit_of_measure_id = unit_of_measure.id\n" +
						"        INNER JOIN\n" +
						"    products ON customer_transaction.product_id = products.id\n" +
						"ORDER BY date;";
				PreparedStatement statement = connection.prepareStatement(sql);
				ResultSet result = statement.executeQuery();
				while (result.next()) {
					try {
						out.println(
								"<tr class=\"main_table_data_row\">" +
										"<form method=\"POST\" action=\"deleteInvoice\">" +
										"<td class=\"main_table_data\">" + result.getDate("date") + "</td>" +
										"<td class=\"main_table_data\">" + result.getString("name") + "</td>" +
										"<td class=\"main_table_data\">" + result.getString("product") + "</td>" +
										"<td class=\"main_table_data\">" + result.getString("caen") + "</td>" +
										"<td class=\"main_table_data\">" + result.getInt("quantity") + "</td>" +
										"<td class=\"main_table_data\">" + result.getString("um") + "</td>" +
										"<td class=\"main_table_data\">" + result.getInt("spendings") + "</td>" +
										"<td class=\"main_table_data\">" + result.getInt("revenue") + "</td>" +
										"<td class=\"main_table_data\">" + result.getString("notes") + "</td>" +
										"<td class=\"main_table_data\">" + 0 + "</td>" +
										"<td class=\"main_table_data\">" + (result.getInt("revenue") - result.getInt("spendings")) + "</td>" +
										"<td class=\"main_table_data\">" + 0 + "</td>" +
										"<td class=\"main_table_data\">" + ((result.getInt("revenue") - result.getInt("spendings")) * 0.2) + "</td>" +
										"<td class=\"main_table_data\">" +
										"<input type=\"submit\" value=\"Sterge\"/>" +
										"<input type=\"hidden\" value=\"" + result.getString("name") +"\" name=\"sell_to_delete\"/>" +
										"</td>" +
										"</form>"+
										"</tr>");
					} catch (SQLException e) {
						throw new RuntimeException(e);
					}
				}
			%>

		</table>
	</div>

	<div class="sidebar">
		<h1>Add entry</h1>
		<form method="POST" action="addInvoice" name="add_form">

		</form>
	</div>
</div>
</body>
</html>
