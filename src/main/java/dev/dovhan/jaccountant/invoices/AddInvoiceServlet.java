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

			if (Objects.equals(request.getParameter("type_of_invoice"), "customer")) {
				String[] name = request.getParameter("customer").split(" ");
				entity_id = DBActions.getIDBy2FK(connection, "person", "surname", "name", name[0], name[1]);
				type = "customer";
			} else {
				String name = request.getParameter("supplier");
				entity_id = DBActions.getIDByFK(connection, "supplier", "name", name);
				type = "supplier";
			}

			String invoice_date = request.getParameter("date");
			float price = Float.parseFloat(request.getParameter("cheltuieli"));
			int product_id = DBActions.getIDByFK(connection, "products", "name", request.getParameter("product"));
			String caen = request.getParameter("caen");
			float quantity = Float.parseFloat(request.getParameter("quantity"));
			int um = DBActions.getIDByFK(connection, "unit_of_measure", "name", request.getParameter("um"));
			//float spendings = Float.parseFloat(request.getParameter("cheltuieli"));
			//float revenue = Float.parseFloat(request.getParameter("venituri"));
			String note = request.getParameter("note");
			float deductible = Float.parseFloat(request.getParameter("deductibil"));
			//float profit = Float.parseFloat(request.getParameter("profit"));
			float taxable = Float.parseFloat(request.getParameter("impozabil"));
			//float tax = Float.parseFloat(request.getParameter("impozit"));

			statement = connection.prepareStatement("INSERT INTO " + type + "invoice" + " (" + type + "_id, invoice_date, price) VALUES (?, ?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);
			statement.setInt(1, entity_id);
			statement.setString(2, invoice_date);
			statement.setFloat(3, price);
			statement.executeUpdate();

			int invoiceID = 0;
			try (ResultSet result = statement.getGeneratedKeys()) {
				if (result.next()) {
					invoiceID = result.getInt(1);
				}
			}

			statement = connection.prepareStatement("INSERT INTO " + type + "_transaction" + " (sale_date, product_id, caen, quantity, unit_of_measure_id, price, notes, deductible, taxable, invoice_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
			statement.setString(1, invoice_date);
			statement.setInt(2, product_id);
			statement.setString(3, caen);
			statement.setFloat(4, quantity);
			statement.setInt(5, um);
			statement.setFloat(6, price);
			statement.setString(7, note);
			statement.setFloat(8, deductible);
			statement.setFloat(9, taxable);
			statement.setInt(10, invoiceID);
			out.println(statement);
			statement.execute();
		} catch (Exception e) {
			out.println(e.getMessage());
		}
	}
}
