package dev.dovhan.jaccountant.sub_tables.products;

import dev.dovhan.jaccountant.sub_tables.EntryDeleteServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "delete_product", value="/product_delete")
public class DeleteProductServlet extends EntryDeleteServlet {
    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        deleteEntry(request, response, "product", "product", "product_to_delete", "product.jsp");
    }
}
