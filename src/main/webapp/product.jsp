<%@ page import="java.sql.Connection" %>
<%@ page import="dev.dovhan.jaccountant.utilities.ConnectionProvider" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <title>Produse</title>
    <link href="styles/product.css" rel="stylesheet" type="text/css">
    <script src="scripts/product.js"></script>
</head>
<body>
<h1>Produse</h1>
<div class="flex_container">
    <div class="table_container">
        <table class="product_table">
            <tr class="product_table_header_row">
                <th class="product_table_header">Produs</th>
                <th>Delete</th>
            </tr>
            <%
                try {
                    Connection connection = ConnectionProvider.getConnection();
                    String sql = "select * from  produs";
                    PreparedStatement preparedStmt = connection.prepareStatement(sql);
                    ResultSet result = preparedStmt.executeQuery();

                    while(result.next()){
                        String product = result.getString("produs");

                        out.println("<tr class=\"product_table_data_row\">" +
                                        "<form method=\"POST\" action=\"product_delete\">" +
                                            "<td class=\"product_table_data\">" + product + "</td>" +
                                            "<td class=\"product_table_data\">" +
                                                "<input type=\"submit\" value=\"Delete\", class=\"product_delete\"/>" +
                                                "<input type=\"hidden\" value=\"" + product +"\" name=\"product_to_delete\"/>" +
                                            "</td>" +
                                        "</form>" +
                                    "</tr>");
                    }

                    connection.close();
                } catch (Exception e){
                    out.println(e.getMessage());
                }

            %>
        </table>
    </div>
    <div class="add_container">
        <form action="add_product" method="POST" name="add_form">
            <label>
                Produs:
                <input type="text" name="product" id="product">
            </label>
            <br/><br/>
            <input type="button" value="Submit" onclick="validateAndSubmit()"/>
            <br>
            <span id="output"></span>
        </form>
    </div>
</div>
</body>
</html>
