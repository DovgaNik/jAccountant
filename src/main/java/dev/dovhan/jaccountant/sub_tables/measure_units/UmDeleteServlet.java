package dev.dovhan.jaccountant.sub_tables.measure_units;

import dev.dovhan.jaccountant.sub_tables.EntryDeleteServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "umDeleteServlet", value = "/umDeleteServlet")
public class UmDeleteServlet extends EntryDeleteServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) {
        deleteEntry(request, response, "unitat_de_masura", "unitate_de_masura", "um_to_delete", "unitati_de_masura.jsp");
    }

}
