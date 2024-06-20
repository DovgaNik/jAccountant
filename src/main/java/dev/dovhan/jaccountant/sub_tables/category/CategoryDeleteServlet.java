package dev.dovhan.jaccountant.sub_tables.category;

import dev.dovhan.jaccountant.sub_tables.EntryDeleteServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet (value = "/deleteCategory")
public class CategoryDeleteServlet extends EntryDeleteServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		deleteEntry(request, response, "category", "name", "category_to_delete", "category.jsp");
	}
}
