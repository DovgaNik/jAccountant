package dev.dovhan.jaccountant.sub_tables.category;

import dev.dovhan.jaccountant.sub_tables.EntryAddServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet (value = "/addCategory")
public class CategoryAddServlet extends EntryAddServlet {
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		addEntry(request, response, "category", new String[]{"name"}, new String[]{"category"}, "category.jsp");
	}
}
