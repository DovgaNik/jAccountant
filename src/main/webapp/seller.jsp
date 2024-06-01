<%@ page import="java.sql.Connection" %>
<%@ page import="dev.dovhan.jaccountant.utilities.ConnectionProvider" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <title>Furnizori</title>
    <link href="styles/sellers.css" rel="stylesheet" type="text/css">
    <script src="scripts/sellers.js"></script>
</head>
<body>
<h1>Furnizori</h1>
<div class="flex_container">
    <div class="table_container">
        <table class="seller_table">
            <tr class="seller_table_header_row">
                <th class="seller_table_header">Furnizor</th>
                <th class="seller_table_header">Cod unic</th>
                <th>Delete</th>
            </tr>
            <%
                try {
                    Connection connection = ConnectionProvider.getConnection();
                    String sql = "select * from  furnizor";
                    PreparedStatement preparedStmt = connection.prepareStatement(sql);
                    ResultSet result = preparedStmt.executeQuery();

                    while(result.next()){
                        String seller = result.getString("furnizor");
                        String uniqueCode = result.getString("cod_unic");

                        out.println("<tr class=\"seller_table_data_row\">" +
                                        "<form method=\"POST\" action=\"sellerDeleteServlet\">" +
                                            "<td class=\"seller_table_data\">" + seller + "</td>" +
                                            "<td class=\"seller_table_data\">" + uniqueCode + "</td>" +
                                            "<td class=\"seller_table_data\">" +
                                                "<input type=\"submit\" value=\"Delete\", class=\"seller_delete\"/>" +
                                                "<input type=\"hidden\" value=\"" + seller +"\" name=\"seller_to_delete\"/>" +
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
        <form action="add_seller" method="POST" name="add_form">
            <label>
                Furnizor:
                <input type="text" name="seller" id="seller">
            </label>
            <br/><br/>
            <label>
                Cod unic:
                <input type="text" name="uniqueCode" id="uniqueCode">
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
