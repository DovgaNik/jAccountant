<%@ page import="java.sql.Connection" %>
<%@ page import="dev.dovhan.jaccountant.ConnectionProvider" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <title>Unitati de masura</title>
    <link href="styles/unitati_de_masura.css" rel="stylesheet" type="text/css">
</head>
<body>
<h1>Unitati de masura</h1>
<div class="flex_container">
    <div class="table_container">
        <table class="um_table">
            <tr class="um_table_header_row">
                <th class="um_table_header">Unitate de masura</th>
                <th class="um_table_header">Unitate de masura abreviere</th>
            </tr>
            <%
                try {
                    Connection connection = ConnectionProvider.getConnection();
                    String sql = "select * from  unitat_de_masura";
                    PreparedStatement preparedStmt = connection.prepareStatement(sql);
                    ResultSet result = preparedStmt.executeQuery();

                    while(result.next()){
                        String um = result.getString("unitate_de_masura");
                        String ab_um = result.getString("unitate_de_masura_short");
                        out.println("<tr class=\"um_table_data_row\"><td class=\"um_table_data\">" + um + "</td><td class=\"um_table_data\">" + ab_um + "</td>");
                    }

                    connection.close();
                } catch (Exception e){
                    out.println(e.getMessage());
                }

            %>
        </table>
    </div>
    <div class="add_container">
        <form action="add_um" method="POST">
            <label>
                Unitate de masura:
                <input type="text" name="um">
            </label>
            <br/><br/>
            <label>
                Abreviare:
                <input type="text" name="ab_um" >
            </label>
            <br/><br/>
            <input type="submit" value="Submit"/>
        </form>
    </div>
</div>
</body>
</html>
