package dev.dovhan.jaccountant.sub_tables;

import dev.dovhan.jaccountant.utilities.ConnectionProvider;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

public class EntryAddServlet extends HttpServlet {
    protected void addEntry(HttpServletRequest request, HttpServletResponse response, String nameOfTable, String[] columns, String[] parameters, String redirect) {
        try {
            Connection connection = ConnectionProvider.getConnection();
            PreparedStatement preparedStmt = buildStatement(connection, request, nameOfTable, columns, parameters);

            preparedStmt.execute();
            connection.close();
            response.sendRedirect(redirect);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    private PreparedStatement buildStatement(Connection connection, HttpServletRequest request, String tableName, String[] columns, String[] parameters) throws Exception {

        if (columns.length != parameters.length)
            throw new Exception("Amount of columns and values doesn't match");

        StringBuilder sql = new StringBuilder("INSERT INTO " + tableName + " (");

        for (int i = 0; i < columns.length - 1; i++)
            sql.append(columns[i]).append(", ");

        sql.append(columns[columns.length - 1]).append(") VALUES (");

        for (int i = 0; i < parameters.length - 1; i++)
            sql.append("?, ");

        sql.append(" ?)");

        PreparedStatement preparedStmt = connection.prepareStatement(sql.toString());

        List<String> values = buildArrayOfParameters(request, parameters);
        for(int i = 0; i < values.size(); i++){

            preparedStmt.setString(i + 1, values.get(i));

        }

        return preparedStmt;
    }

    private List<String> buildArrayOfParameters(HttpServletRequest request, String[] parameters) {
        List<String> values = new ArrayList<>();

        for (String parameter : parameters)
            values.add(request.getParameter(parameter));

        return values;
    }
}
