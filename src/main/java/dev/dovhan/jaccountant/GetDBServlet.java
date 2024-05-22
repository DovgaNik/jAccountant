package dev.dovhan.jaccountant;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet (name = "getDBServlet", value = "/get-db-servlet")
public class GetDBServlet extends HttpServlet {

    @Override
    protected void doGet (HttpServletRequest request, HttpServletResponse response) throws IOException {
        String url = "jdbc:mysql://localhost:3306/jaccountant";
        Credentials credentials = new Credentials();
        String username = credentials.dbUsername;
        String password = credentials.dbPassword;
        PrintWriter out = response.getWriter();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url, username, password);
            String sql = "select * from  vanzare";
            PreparedStatement preparedStmt = connection.prepareStatement(sql);
            ResultSet result = preparedStmt.executeQuery();


            while(result.next()){
                out.println("<tr>");

                out.println("<th>" + result.getInt("id") + "</th>");
                out.println("<th>" + result.getString("data") + "</th>");
                out.println("<th>" + result.getString("furnizor") + "</th>");

                out.println("</tr>");
            }

            connection.close();
        } catch (Exception e) {
            out.println("<br/>" + e.getMessage());
        }
    }
}
