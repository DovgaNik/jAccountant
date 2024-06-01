<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Workbench</title>
    <link href="styles/workbench.css" rel="stylesheet" type="text/css">
</head>
<body>
    <h1>Contabilitate</h1>
    <div class="flex_container">
        <div class="main_table_container">
            <table class="main_table">
                <tr class="main_table_header_row">
                    <th class="main_table_header">Data</th>
                    <th class="main_table_header">Furnizor</th>
                    <th class="main_table_header">Produs</th>
                    <th class="main_table_header">CAEN</th>
                    <th class="main_table_header">Cantitate</th>
                    <th class="main_table_header">UM</th>
                    <th class="main_table_header">Cheltuieli</th>
                    <th class="main_table_header">Venituri</th>
                    <th class="main_table_header">Note</th>
                    <th class="main_table_header">Deductibil</th>
                    <th class="main_table_header">Profit</th>
                    <th class="main_table_header">Impozabil</th>
                    <th class="main_table_header">Impozit</th>
                </tr>

                <tr class="main_table_data_row">
                    <td class="main_table_data">2024.05.26</td>
                    <td class="main_table_data">Altex SRL</td>
                    <td class="main_table_data">TV 45" cu smartTV</td>
                    <td class="main_table_data">1234</td>
                    <td class="main_table_data">1</td>
                    <td class="main_table_data">buc</td>
                    <td class="main_table_data">100</td>
                    <td class="main_table_data">100</td>
                    <td class="main_table_data">15</td>
                    <td class="main_table_data">100</td>
                    <td class="main_table_data">100</td>
                    <td class="main_table_data">100</td>
                    <td class="main_table_data">100</td>
                </tr>
            </table>
        </div>

        <div class="sidebar">
            <a href="unitati_de_masura.jsp">Unitati de masura</a>
            <a href="seller.jsp">Furnizori</a>
            <a href="product.jsp">Produse</a>
        </div>
    </div>
</body>
</html>
