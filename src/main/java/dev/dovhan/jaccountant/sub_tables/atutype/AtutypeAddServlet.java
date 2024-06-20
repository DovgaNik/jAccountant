package dev.dovhan.jaccountant.sub_tables.atutype;

import dev.dovhan.jaccountant.sub_tables.EntryAddServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet (value = "/addatutype")
public class AtutypeAddServlet extends EntryAddServlet {
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		addEntry(request, response, "atutype", new String[]{"type"}, new String[]{"type"}, "atutype.jsp");
	}
}
