package dev.dovhan.jaccountant.sub_tables.atutype;

import dev.dovhan.jaccountant.sub_tables.EntryDeleteServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet (value = "/deleteAtutype")
public class AtutypeDeleteServlet extends EntryDeleteServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		deleteEntry(request, response, "atutype", "type", "atutype_to_delete", "atutype.jsp");
	}
}
