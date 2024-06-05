package dev.dovhan.jaccountant.invoices;

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
import java.util.List;

@WebServlet (name = "addEntryToInvoices", value = "/addInvoice")
public class AddInvoiceServlet extends EntryAddServlet {
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String[] columns = {"data", "furnizor", "produs", "caen", "cantitate", "unitate_de_masura", "cheltuieli", "venituri", "note", "deductibil", "profit", "impozabil", "impozit"};
		String[] parameters = {"date", "seller", "product", "caen", "quantity", "um", "cheltuieli", "venituri", "note", "deductibil", "profit", "impozabil", "impozit"};

		List<String> values = buildArrayOfParameters(request, parameters);
		System.out.println("bp");
		Connection connection = null;
		try {
			connection = ConnectionProvider.getConnection();
		} catch (ClassNotFoundException e) {
			throw new RuntimeException(e);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		values.set(1, Integer.toString(DBActions.getIDByFK(connection, "furnizor", "furnizor", values.get(1))));
		values.set(2, Integer.toString(DBActions.getIDByFK(connection, "produs", "produs", values.get(2))));
		values.set(5, Integer.toString(DBActions.getIDByFK(connection, "unitat_de_masura", "unitate_de_masura", values.get(5))));


		for(String i : values) {
			System.out.println(i);
		}

		try {
			PreparedStatement statement = buildStatement(connection, request, "vanzare", columns, values);
			statement.execute();
			connection.close();
			response.sendRedirect("workbench.jsp");
		} catch (Exception e) {
			throw new RuntimeException(e);
		}

	}
}
