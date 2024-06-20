package dev.dovhan.jaccountant.sub_tables.role;

import dev.dovhan.jaccountant.sub_tables.EntryDeleteServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet (value = "/deleteRole")
public class RoleDeleteServlet extends EntryDeleteServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		deleteEntry(request, response, "roles", "type", "role_to_delete", "role.jsp");
	}
}
