package dev.dovhan.jaccountant.sub_tables.role;

import dev.dovhan.jaccountant.sub_tables.EntryAddServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet (value = "/addRole")
public class RoleAddServlet extends EntryAddServlet {
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		addEntry(request, response, "roles", new String[]{"type"}, new String[]{"type"}, "role.jsp");
	}
}
