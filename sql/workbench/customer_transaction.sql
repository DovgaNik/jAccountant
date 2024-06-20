SELECT
    invoice_app.customer_transaction.id AS id,
    invoice_app.customer_transaction.invoice_id AS invoice_id,
    invoice_app.customer_transaction.sale_date AS date,
    invoice_app.products.name AS product,
    invoice_app.customer_transaction.caen AS caen,
    invoice_app.customer_transaction.quantity AS quantity,
    invoice_app.unit_of_measure.short AS um,
    NULL AS spendings,
    invoice_app.customer_transaction.price AS revenue,
    invoice_app.customer_transaction.notes AS notes,
    invoice_app.customer_transaction.deductible AS deductible,
    invoice_app.customer_transaction.taxable AS taxable
FROM
    invoice_app.customerinvoice
        INNER JOIN
    invoice_app.person ON invoice_app.customerinvoice.person_id = invoice_app.person.id
        INNER JOIN
    invoice_app.customer_transaction ON invoice_app.customer_transaction.invoice_id = invoice_app.customerinvoice.id
        INNER JOIN
    invoice_app.unit_of_measure ON invoice_app.customer_transaction.unit_of_measure_id = invoice_app.unit_of_measure.id
        INNER JOIN
    invoice_app.products ON invoice_app.customer_transaction.product_id = invoice_app.products.id
WHERE invoice_app.customer_transaction.invoice_id = ?
ORDER BY date DESC;