package dev.dovhan.jaccountant.sub_tables.seller;

import dev.dovhan.jaccountant.sub_tables.EntryAddServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "addSeller", value = "/add_seller")
public class AddSellerServlet extends EntryAddServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        addEntry(request, response, "supplier", new String[]{"name", "unique_code"}, new String[]{"seller", "uniqueCode"}, "seller.jsp");
    }
}
