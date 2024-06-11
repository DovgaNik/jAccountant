package dev.dovhan.jaccountant.invoices;

import dev.dovhan.jaccountant.sub_tables.EntryDeleteServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet (name = "deleteEntry", value = "/deleteInvoice")
public class DeleteInvoiceServlet extends EntryDeleteServlet {
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		deleteEntry(request, response, "vanzare", "id", "sell_to_delete", "workbench.jsp");
	}
}
