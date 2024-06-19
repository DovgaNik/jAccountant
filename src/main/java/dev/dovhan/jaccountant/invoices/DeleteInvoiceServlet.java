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

@WebServlet (name = "deleteEntry", value = "/deleteInvoice")
public class DeleteInvoiceServlet extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		Connection connection = null;
		List<Integer> transactionIDs = new ArrayList<Integer>();
		String type = request.getParameter("type_delete");
		int invoiceID = Integer.parseInt(request.getParameter("id_delete"));

		try {
			connection = ConnectionProvider.getConnection();
			PreparedStatement getTransaction = connection.prepareStatement("SELECT * FROM " + type + "_transaction WHERE invoice_id=?");
			getTransaction.setInt(1, invoiceID);
			ResultSet transactionIDsQuery = getTransaction.executeQuery();
			while (transactionIDsQuery.next()){
				transactionIDs.add(transactionIDsQuery.getInt("id"));
			}
		} catch (SQLException | ClassNotFoundException e) {
			out.println(e.getMessage());
		}

		for (int i : transactionIDs) {
			try {
				PreparedStatement preparedStmt = connection.prepareStatement("DELETE FROM " + type + "_transaction WHERE id = ?");
				preparedStmt.setInt(1, i);
				preparedStmt.execute();
			} catch (Exception e) {
				out.println(e.getMessage());
			}
		}

		try {
			PreparedStatement preparedStmt = connection.prepareStatement("DELETE FROM " + type + "invoice WHERE id = ?");
			preparedStmt.setInt(1, invoiceID);
			preparedStmt.execute();
			connection.close();
		} catch (Exception e) {
			out.println(e.getMessage());
		}

		response.sendRedirect("workbench.jsp");
	}
}
