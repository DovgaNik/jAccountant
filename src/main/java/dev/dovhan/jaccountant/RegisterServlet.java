package dev.dovhan.jaccountant;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

@WebServlet(name = "registerServlet", value = "/register-servlet")
public class RegisterServlet extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println(request.getParameter("username") + "<br/>");
        out.println(request.getParameter("password") + "<br/>");
        try {
            LoginUtils.register(request.getParameter("username"), request.getParameter("password"));
        } catch (SQLException e) {
            out.println(e.getMessage());
        } catch (ClassNotFoundException e) {
            out.println(e.getMessage());
        }
    }
}
