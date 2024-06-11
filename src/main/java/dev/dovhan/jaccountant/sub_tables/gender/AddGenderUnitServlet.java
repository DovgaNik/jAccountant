package dev.dovhan.jaccountant.sub_tables.gender;

import dev.dovhan.jaccountant.sub_tables.EntryAddServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(value = "/subpages/add_gender")
public class AddGenderUnitServlet extends EntryAddServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        addEntry(request, response, "gender", new String[]{"gender"}, new String[]{"gender"}, "gender.jsp");
    }
}
