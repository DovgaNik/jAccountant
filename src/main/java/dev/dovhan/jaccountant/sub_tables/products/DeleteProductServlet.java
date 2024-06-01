package dev.dovhan.jaccountant.sub_tables.products;

import dev.dovhan.jaccountant.sub_tables.EntryDeleteServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "delete_product", value="/product_delete")
public class DeleteProductServlet extends EntryDeleteServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) {
        deleteEntry(request, response, "produs", "produs", "product_to_delete", "product.jsp");
    }
}
