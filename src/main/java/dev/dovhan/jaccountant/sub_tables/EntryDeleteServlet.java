package dev.dovhan.jaccountant.sub_tables;

import dev.dovhan.jaccountant.utilities.ConnectionProvider;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class EntryDeleteServlet extends HttpServlet {

    protected void deleteEntry(HttpServletRequest request, HttpServletResponse response, String nameOfTable, String nameOfColumn, String parameter, String redirect){
        try {
            Connection connection = ConnectionProvider.getConnection();
            String sql = "DELETE FROM " + nameOfTable + " WHERE " + nameOfColumn + " = ?";
            PreparedStatement preparedStmt = connection.prepareStatement(sql);
            preparedStmt.setString(1, request.getParameter(parameter));
            preparedStmt.execute();
            connection.close();
            response.sendRedirect(redirect);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}