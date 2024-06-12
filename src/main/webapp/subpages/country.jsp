<%@ page import="java.sql.Connection" %>
<%@ page import="dev.dovhan.jaccountant.utilities.ConnectionProvider" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <title>jAccountant - Country</title>
    <link href="../styles/country.css" rel="stylesheet" type="text/css">
    <link rel="icon" href="../favicon.ico" />

    <script src="../scripts/country.js"></script>
</head>
<body>
<h1>Country</h1>
<div class="flex_container">
    <div class="table_container">
        <table class="country_table">
            <tr class="country_table_header_row">
                <th class="country_table_header">Code</th>
                <th class="country_table_header">Country</th>
                <th>Delete</th>
            </tr>
            <%
                try {
                    Connection connection = ConnectionProvider.getConnection();
                    String sql = "select * from  countries";
                    PreparedStatement preparedStmt = connection.prepareStatement(sql);
                    ResultSet result = preparedStmt.executeQuery();

                    while(result.next()){
                        String codeOfCountry = result.getString("codeOfCountry");
                        String country = result.getString("name");

                        out.println("<tr class=\"country_table_data_row\">" +
                                        "<form method=\"POST\" action=\"countryDeleteServlet\">" +
                                            "<td class=\"country_table_data\">" + codeOfCountry + "</td>" +
                                            "<td class=\"country_table_data\">" + country + "</td>" +
                                            "<td class=\"country_table_data\">" +
                                                "<input type=\"submit\" value=\"Delete\"/>" +
                                                "<input type=\"hidden\" value=\"" + country +"\" name=\"country_to_delete\"/>" +
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
        <form action="add_country" method="POST" name="add_form">
            <label>
                Code of the country:
                <input type="text" name="codeOfCountry" id="codeOfCountry">
            </label>
            <br/><br/>
            <label>
                Country:
                <input type="text" name="country" id="country">
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
