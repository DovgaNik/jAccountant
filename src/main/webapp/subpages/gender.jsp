<%@ page import="java.sql.Connection" %>
<%@ page import="dev.dovhan.jaccountant.utilities.ConnectionProvider" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <title>Gender</title>
    <link href="../styles/gender.css" rel="stylesheet" type="text/css">
    <link rel="icon" href="../favicon.ico" />

    <script src="../scripts/gender.js"></script>
</head>
<body>
<h1>Gender</h1>
<div class="flex_container">
    <div class="table_container">
        <table class="gender_table">
            <tr class="gender_table_header_row">
                <th class="gender_table_header">Gender</th>
                <th>Delete</th>
            </tr>
            <%
                try {
                    Connection connection = ConnectionProvider.getConnection();
                    String sql = "select * from  gender";
                    PreparedStatement preparedStmt = connection.prepareStatement(sql);
                    ResultSet result = preparedStmt.executeQuery();

                    while(result.next()){
                        String gender = result.getString("gender");

                        out.println("<tr class=\"gender_table_data_row\">" +
                                        "<form method=\"POST\" action=\"genderDeleteServlet\">" +
                                            "<td class=\"gender_table_data\">" + gender + "</td>" +
                                            "<td class=\"gender_table_data\">" +
                                                "<input type=\"submit\" value=\"Delete\"/>" +
                                                "<input type=\"hidden\" value=\"" + gender +"\" name=\"gender_to_delete\"/>" +
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
        <form action="add_gender" method="POST" name="add_form">
            <label>
                Gender:
                <input type="text" name="gender" id="gender">
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
