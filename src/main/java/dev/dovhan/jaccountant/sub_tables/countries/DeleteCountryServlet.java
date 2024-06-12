package dev.dovhan.jaccountant.sub_tables.countries;

import dev.dovhan.jaccountant.sub_tables.EntryDeleteServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(value = "/subpages/countryDeleteServlet")
public class DeleteCountryServlet extends EntryDeleteServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        deleteEntry(request, response, "countries", "name", "country_to_delete", "country.jsp");
    }

}
