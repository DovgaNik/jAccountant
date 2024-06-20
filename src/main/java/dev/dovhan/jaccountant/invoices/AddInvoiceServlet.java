package dev.dovhan.jaccountant.invoices;

import dev.dovhan.jaccountant.utilities.ConnectionProvider;
import dev.dovhan.jaccountant.utilities.DBActions;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Objects;

@WebServlet (name = "addEntryToInvoices", value = "/addInvoice")
public class AddInvoiceServlet extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		try {
			Connection connection = ConnectionProvider.getConnection();
			PreparedStatement statement;

			int entity_id;
			String type;
			String idColumn;

			if (Objects.equals(request.getParameter("type_of_invoice"), "customer")) {
				String[] name = request.getParameter("customer").split(" ");
				entity_id = DBActions.getIDBy2FK(connection, "person", "surname", "name", name[0], name[1]);
				type = "customer";
				idColumn = "person_id";
			} else {
				String name = request.getParameter("supplier");
				entity_id = DBActions.getIDByFK(connection, "supplier", "name", name);
				type = "supplier";
				idColumn = "supplier_id";
			}

			String invoice_date = request.getParameter("date");
			float price = 0; //Float.parseFloat(request.getParameter("cheltuieli"));

			statement = connection.prepareStatement("INSERT INTO " + type + "invoice" + " (" + idColumn + ", invoice_date, price) VALUES (?, ?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);
			statement.setInt(1, entity_id);
			statement.setString(2, invoice_date);
			statement.setFloat(3, price);
			statement.executeUpdate();

			connection.close();
			response.sendRedirect("workbench.jsp");
		} catch (Exception e) {
			out.println(e.getMessage());
		}
	}
}
