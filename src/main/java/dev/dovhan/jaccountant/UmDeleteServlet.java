package dev.dovhan.jaccountant;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "umDeleteServlet", value = "/umDeleteServlet")
public class UmDeleteServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) {
        try {
            Connection connection = ConnectionProvider.getConnection();
            String sql = "DELETE FROM unitat_de_masura WHERE unitate_de_masura = ?";
            PreparedStatement preparedStmt = connection.prepareStatement(sql);
            preparedStmt.setString (1, request.getParameter("um_to_delete"));
            preparedStmt.execute();
            connection.close();
            response.sendRedirect("unitati_de_masura.jsp");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
