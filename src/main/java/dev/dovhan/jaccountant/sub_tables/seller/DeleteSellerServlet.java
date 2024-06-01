package dev.dovhan.jaccountant.sub_tables.seller;

import dev.dovhan.jaccountant.sub_tables.EntryDeleteServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "deleteSeller", value = "/sellerDeleteServlet")
public class DeleteSellerServlet extends EntryDeleteServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) {
        deleteEntry(request, response, "furnizor", "furnizor", "seller_to_delete", "seller.jsp");
    }

}
