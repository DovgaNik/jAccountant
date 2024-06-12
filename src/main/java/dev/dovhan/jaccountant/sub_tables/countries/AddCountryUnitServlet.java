package dev.dovhan.jaccountant.sub_tables.countries;

import dev.dovhan.jaccountant.sub_tables.EntryAddServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(value = "/subpages/add_country")
public class AddCountryUnitServlet extends EntryAddServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        addEntry(request, response, "countries", new String[]{"codeOfCountry", "name"}, new String[]{"codeOfCountry", "country"}, "country.jsp");
    }
}
