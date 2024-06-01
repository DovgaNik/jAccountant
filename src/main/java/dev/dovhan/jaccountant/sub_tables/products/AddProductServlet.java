package dev.dovhan.jaccountant.sub_tables.products;

import dev.dovhan.jaccountant.sub_tables.EntryAddServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet (name="addProduct", value = "/add_product")
public class AddProductServlet extends EntryAddServlet {

    @Override
    public void doPost (HttpServletRequest request, HttpServletResponse response) {
        addEntry(request, response, "produs", new String[]{"produs"}, new String[]{"product"}, "product.jsp");
    }

}
