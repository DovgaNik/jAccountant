package dev.dovhan.jaccountant.sub_tables;

import dev.dovhan.jaccountant.utilities.ConnectionProvider;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class EntryAddServlet extends HttpServlet {
    protected void addEntry(HttpServletRequest request, HttpServletResponse response, String nameOfTable, String nameOfColumn1, String nameOfColumn2, String parameter1, String parameter2, String redirect) {
        try {
            Connection connection = ConnectionProvider.getConnection();
            String sql = "INSERT INTO " + nameOfTable + " (" + nameOfColumn1 + ", " + nameOfColumn2 + ") VALUES (?, ?)";
            PreparedStatement preparedStmt = connection.prepareStatement(sql);
            preparedStmt.setString(1, request.getParameter(parameter1));
            preparedStmt.setString(2, request.getParameter(parameter2));
            System.out.println(preparedStmt.toString());
            preparedStmt.execute();
            connection.close();
            response.sendRedirect(redirect);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
