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

@WebServlet(name = "addEntryToTransactions", value = "/addTransaction")
public class AddTransactionServlet extends HttpServlet {
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		PrintWriter out = response.getWriter();
		try {
			Connection connection = ConnectionProvider.getConnection();
			PreparedStatement statement;

			String type;
			String invoiceNum = request.getParameter("invoice");
			int digitPart = Integer.parseInt(invoiceNum.substring(0, invoiceNum.length() - 1));
			String letterPart = invoiceNum.substring(invoiceNum.length() - 1);
			float price = 0;
			if (Objects.equals(letterPart, "C")){
				type = "customer";
				price = Float.parseFloat(request.getParameter("venituri"));
			} else {
				type = "supplier";
				price = Float.parseFloat(request.getParameter("cheltuieli"));
			}

			String sql = "SELECT invoice_date FROM " + type + "invoice WHERE id = ?";

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, digitPart);
			System.out.println(ps);
			ResultSet dateRes = ps.executeQuery();
			dateRes.next();

			String invoice_date = dateRes.getString("invoice_date");
			int product_id = DBActions.getIDByFK(connection, "products", "name", request.getParameter("product"));
			String caen = request.getParameter("caen");
			float quantity = Float.parseFloat(request.getParameter("quantity"));
			int um = DBActions.getIDByFK(connection, "unit_of_measure", "name", request.getParameter("um"));
			String note = request.getParameter("note");
			float deductible = Float.parseFloat(request.getParameter("deductibil"));
			float taxable = Float.parseFloat(request.getParameter("impozabil"));

			int invoiceID = digitPart;

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
			statement.execute();

			connection.close();
			response.sendRedirect("workbench.jsp");
		} catch (Exception e) {
			out.println(e.getMessage());
		}
	}
}
