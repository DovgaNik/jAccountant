package dev.dovhan.jaccountant.sub_tables.products;

import dev.dovhan.jaccountant.sub_tables.EntryAddServlet;
import dev.dovhan.jaccountant.utilities.ConnectionProvider;
import dev.dovhan.jaccountant.utilities.DBActions;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet (value = "/addProduct")
public class ProductAddServlet extends EntryAddServlet {
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			Connection connection = ConnectionProvider.getConnection();
			String name = request.getParameter("name");
			String description = request.getParameter("description");
			int category = DBActions.getIDByFK(connection, "category", "name", request.getParameter("category"));
			System.out.println(name + " " + description + " " + category);

		PreparedStatement statement = connection.prepareStatement("INSERT INTO products (name, description, category_id) VALUES (?, ?, ?)");
		statement.setString(1, name);
		statement.setString(2, description);
		statement.setInt(3, category);

		statement.execute();
		connection.close();
		response.sendRedirect("products.jsp");

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
}
