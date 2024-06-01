package dev.dovhan.jaccountant.users;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "loginServlet", value = "/login-servlet")
public class LoginServlet extends HttpServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            if (LoginUtils.login(request.getParameter("username"), request.getParameter("password")))
                response.sendRedirect("workbench.jsp");

        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e.getMessage());
        }

    }
}
