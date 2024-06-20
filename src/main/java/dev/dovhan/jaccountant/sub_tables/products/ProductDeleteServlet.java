package dev.dovhan.jaccountant.sub_tables.products;

import dev.dovhan.jaccountant.sub_tables.EntryDeleteServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet (value = "/deleteProduct")
public class ProductDeleteServlet extends EntryDeleteServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		deleteEntry(request, response, "products", "id", "product_to_delete", "products.jsp");
	}
}
