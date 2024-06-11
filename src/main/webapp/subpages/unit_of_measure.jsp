<%@ page import="java.sql.Connection" %>
<%@ page import="dev.dovhan.jaccountant.utilities.ConnectionProvider" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <title>Unitati de masura</title>
    <link href="../styles/unitati_de_masura.css" rel="stylesheet" type="text/css">
    <script src="../scripts/um.js"></script>
</head>
<body>
<h1>Unitati de masura</h1>
<div class="flex_container">
    <div class="table_container">
        <table class="um_table">
            <tr class="um_table_header_row">
                <th class="um_table_header">Unitate de masura</th>
                <th class="um_table_header">Unitate de masura abreviere</th>
                <th>Delete</th>
            </tr>
            <%
                try {
                    Connection connection = ConnectionProvider.getConnection();
                    String sql = "select * from  unit_of_measure";
                    PreparedStatement preparedStmt = connection.prepareStatement(sql);
                    ResultSet result = preparedStmt.executeQuery();

                    while(result.next()){
                        String um = result.getString("name");
                        String ab_um = result.getString("short");

                        out.println("<tr class=\"um_table_data_row\">" +
                                        "<form method=\"POST\" action=\"umDeleteServlet\">" +
                                            "<td class=\"um_table_data\">" + um + "</td>" +
                                            "<td class=\"um_table_data\">" + ab_um + "</td>" +
                                            "<td class=\"um_table_data\">" +
                                                "<input type=\"submit\" value=\"Delete\"/>" +
                                                "<input type=\"hidden\" value=\"" + um +"\" name=\"um_to_delete\"/>" +
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
        <form action="add_um" method="POST" name="add_form">
            <label>
                Unitate de masura:
                <input type="text" name="um" id="um">
            </label>
            <br/><br/>
            <label>
                Abreviare:
                <input type="text" name="ab_um" id="ab_um">
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
