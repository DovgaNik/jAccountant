package dev.dovhan.jaccountant.invoices;

import dev.dovhan.jaccountant.utilities.ConnectionProvider;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet (name = "deleteTransaction", value = "/deleteTransaction")
public class DeleteTransactionServlet extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		Connection connection = null;
		int idToDelete = Integer.parseInt(request.getParameter("id_delete"));
		String type = request.getParameter("type_delete");

		try {
			connection = ConnectionProvider.getConnection();
			PreparedStatement preparedStmt = connection.prepareStatement("DELETE FROM " + type + "_transaction WHERE id = ?");
			preparedStmt.setInt(1, idToDelete);
			preparedStmt.execute();
			connection.close();
			response.sendRedirect("workbench.jsp");
		} catch (Exception e) {
			out.println(e.getMessage());
		}

	}
}
