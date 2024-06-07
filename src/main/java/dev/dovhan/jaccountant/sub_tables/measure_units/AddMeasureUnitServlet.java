package dev.dovhan.jaccountant.sub_tables.measure_units;

import dev.dovhan.jaccountant.sub_tables.EntryAddServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "addUnitateDeMasura", value = "/add_um")
public class AddMeasureUnitServlet extends EntryAddServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        addEntry(request, response, "unit_of_measure", new String[]{"name", "short"}, new String[]{"um", "ab_um"}, "unit_of_measure.jsp");
    }
}
