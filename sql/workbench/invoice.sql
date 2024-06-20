SELECT
    invoice_app.supplierinvoice.id AS id,
    'supplier' AS type,
    invoice_app.supplier.name AS name,
    invoice_app.supplierinvoice.invoice_date AS date,
    invoice_app.supplierinvoice.price AS price
FROM
    invoice_app.supplierinvoice
        INNER JOIN
    invoice_app.supplier on invoice_app.supplierinvoice.supplier_id = invoice_app.supplier.id
UNION ALL
SELECT
    invoice_app.customerinvoice.id AS id,
    'customer' AS type,
    CONCAT(invoice_app.person.surname, ' ', invoice_app.person.name) AS name,
    invoice_app.customerinvoice.invoice_date AS date,
    invoice_app.customerinvoice.price AS price
FROM
    invoice_app.customerinvoice
         INNER JOIN
    invoice_app.person on invoice_app.customerinvoice.person_id = invoice_app.person.id
ORDER BY date DESC;