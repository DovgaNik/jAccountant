package dev.dovhan.jaccountant.sub_tables.measure_units;

import dev.dovhan.jaccountant.sub_tables.EntryDeleteServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "umDeleteServlet", value = "/umDeleteServlet")
public class UmDeleteServlet extends EntryDeleteServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        deleteEntry(request, response, "unit_of_measure", "name", "um_to_delete", "unit_of_measure.jsp");
    }

}
