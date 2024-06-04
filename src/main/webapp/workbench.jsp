<%@ page import="java.sql.Connection" %>
<%@ page import="dev.dovhan.jaccountant.utilities.ConnectionProvider" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="dev.dovhan.jaccountant.utilities.GetFK" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
				<th class="main_table_header">CAEN</th>
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
						int caen = result.getInt(5);
						int cantitate = result.getInt(6);
						int unitate_de_masura = result.getInt(7); //FK
						BigDecimal cheltuieli = result.getBigDecimal(8);
						BigDecimal venituri = result.getBigDecimal(9);
						int note = result.getInt(10);
						BigDecimal deductibil = result.getBigDecimal(11);
						BigDecimal profit = result.getBigDecimal(12);
						BigDecimal impozabil = result.getBigDecimal(13);
						BigDecimal impozit = result.getBigDecimal(14);

						String furnizor_name = GetFK.getFKStringByID(furnizor, "furnizor", "furnizor", connection);
						String produs_name = GetFK.getFKStringByID(produs, "produs", "produs", connection);
						String um_name = GetFK.getFKStringByID(unitate_de_masura, "unitat_de_masura", "unitate_de_masura_short", connection);

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

	</div>
</div>
</body>
</html>
