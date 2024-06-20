package dev.dovhan.jaccountant.sub_tables.gender;

import dev.dovhan.jaccountant.sub_tables.EntryDeleteServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet (value = "/deleteGender")
public class GenderDeleteServlet extends EntryDeleteServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		deleteEntry(request, response, "gender", "gender", "gender_to_delete", "gender.jsp");
	}
}
