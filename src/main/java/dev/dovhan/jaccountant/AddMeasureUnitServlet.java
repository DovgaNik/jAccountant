package dev.dovhan.jaccountant;

import com.mysql.cj.jdbc.ConnectionImpl;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "addUnitateDeMasura", value = "/add_um")
public class AddMeasureUnitServlet extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            Connection connection = ConnectionProvider.getConnection();
            String sql = "insert into unitat_de_masura (unitate_de_masura, unitate_de_masura_short) values (?, ?)";
            PreparedStatement preparedStmt = connection.prepareStatement(sql);
            preparedStmt.setString (1, request.getParameter("um"));
            preparedStmt.setString (2, request.getParameter("ab_um"));
            preparedStmt.execute();
            connection.close();
            response.sendRedirect("unitati_de_masura.jsp");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
