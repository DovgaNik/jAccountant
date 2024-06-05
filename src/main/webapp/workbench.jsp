<%@ page import="dev.dovhan.jaccountant.utilities.ConnectionProvider" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="dev.dovhan.jaccountant.utilities.DBActions" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!Connection connection;%>
<%!HashMap<Integer, String> furnizor_table;%>
<%!HashMap<Integer, String> produs_table;%>
<%!HashMap<Integer, String> um_table;%>

<%
	try {
		connection = ConnectionProvider.getConnection();
		furnizor_table = DBActions.getDbAsAMap("furnizor", connection, "furnizor");
		produs_table = DBActions.getDbAsAMap("produs", connection, "produs");
		um_table = DBActions.getDbAsAMap("unitat_de_masura", connection, "unitate_de_masura");
	} catch (Exception e) {
		throw new RuntimeException(e);
	}
%>

<html>
<head>
	<title>Workbench</title>
	<link href="styles/workbench.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="header">

	<h1>Contabilitate</h1>

	<a href="unitati_de_masura.jsp">Unitati de masura</a>
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
					String sql = "select * from  vanzare";
					PreparedStatement preparedStmt = connection.prepareStatement(sql);
					ResultSet result = preparedStmt.executeQuery();

					while(result.next()){
						int id = result.getInt(1);
						Date data = result.getDate(2);
						int furnizor = result.getInt(3); //FK
						int produs = result.getInt(4); //FK
						String caen = result.getString(5);
						int cantitate = result.getInt(6);
						int unitate_de_masura = result.getInt(7); //FK
						BigDecimal cheltuieli = result.getBigDecimal(8);
						BigDecimal venituri = result.getBigDecimal(9);
						int note = result.getInt(10);
						BigDecimal deductibil = result.getBigDecimal(11);
						BigDecimal profit = result.getBigDecimal(12);
						BigDecimal impozabil = result.getBigDecimal(13);
						BigDecimal impozit = result.getBigDecimal(14);

						String furnizor_name = furnizor_table.get(furnizor).toString();
						String produs_name = produs_table.get(produs).toString();
						String um_name = um_table.get(unitate_de_masura).toString();

						out.println(
								"<tr class=\"main_table_data_row\">" +
										"<form method=\"POST\" action=\"TODO\">" +
											"<td class=\"main_table_data\">" + data + "</td>" +
											"<td class=\"main_table_data\">" + furnizor_name + "</td>" +
											"<td class=\"main_table_data\">" + produs_name + "</td>" +
											"<td class=\"main_table_data\">" + caen + "</td>" +
											"<td class=\"main_table_data\">" + cantitate + "</td>" +
											"<td class=\"main_table_data\">" + um_name + "</td>" +
											"<td class=\"main_table_data\">" + cheltuieli + "</td>" +
											"<td class=\"main_table_data\">" + venituri + "</td>" +
											"<td class=\"main_table_data\">" + note + "</td>" +
											"<td class=\"main_table_data\">" + deductibil + "</td>" +
											"<td class=\"main_table_data\">" + profit + "</td>" +
											"<td class=\"main_table_data\">" + impozabil + "</td>" +
											"<td class=\"main_table_data\">" + impozit + "</td>" +
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
		<form method="POST" action="!!!TODO">
			<label for="date">Date of transaction: </label>
			<input type="date" name="date" id="date"/> <br>

			<label for="seller">Furnizor: </label>
			<select name="seller" id="seller">
				<%
					for (String i : furnizor_table.values()){
						out.println("<option value=\"" + i + "\">" + i + "</option>");
					}

				%>
			</select> <br>

			<label for="product">Produs: </label>
			<select name="product" id="product">
				<%
					for (String i : produs_table.values()){
						out.println("<option value=\"" + i + "\">" + i + "</option>");
					}
				%>
			</select> <br>

			<label for="caen">caen: </label>
			<input type="text" name="caen" id="caen"/> <br>

			<label for="quantity">Cantitate: </label>
			<input type="text" name="quantity" id="quantity"/> <br>

			<label for="um">Unitat de masura: </label>
			<select name="um" id="um">
				<%
					for (String i : um_table.values()){
						out.println("<option value=\"" + i + "\">" + i + "</option>");
					}
				%>
			</select> <br>

			<label for="cheltuieli">Cheltuieli: </label>
			<input type="text" name="cheltuieli" id="cheltuieli"/> <br>

			<label for="venituri">Venituri: </label>
			<input type="text" name="venituri" id="venituri"/> <br>

			<label for="note">Note: </label>
			<input type="text" name="note" id="note"/> <br>

			<label for="deductibil">Deductibil: </label>
			<input type="text" name="deductibil" id="deductibil"/> <br>

			<label for="profit">Profit: </label>
			<input type="text" name="profit" id="profit"/> <br>

			<label for="impozabil">Impozabil: </label>
			<input type="text" name="impozabil" id="impozabil"/> <br>

			<label for="impozit">Impozit: </label>
			<input type="text" name="impozit" id="impozit"/> <br>

		</form>
	</div>
</div>
</body>
</html>
