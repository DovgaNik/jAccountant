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
            String sql = "insert into ? (?, ?) values (?, ?)";
            PreparedStatement preparedStmt = connection.prepareStatement(sql);
            preparedStmt.setString (1, request.getParameter(nameOfTable));
            preparedStmt.setString (2, request.getParameter(nameOfColumn1));
            preparedStmt.setString (3, request.getParameter(nameOfColumn2));
            preparedStmt.setString (4, request.getParameter(parameter1));
            preparedStmt.setString (5, request.getParameter(parameter2));
            preparedStmt.execute();
            connection.close();
            response.sendRedirect(redirect);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
