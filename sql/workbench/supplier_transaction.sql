SELECT
    invoice_app.supplier_transaction.id AS id,
    invoice_app.supplier_transaction.invoice_id AS invoice_id,
    invoice_app.supplier_transaction.sale_date AS date,
    invoice_app.products.name AS product,
    invoice_app.supplier_transaction.caen AS caen,
    invoice_app.supplier_transaction.quantity AS quantity,
    invoice_app.unit_of_measure.short AS um,
    NULL AS spendings,
    invoice_app.supplierinvoice.price AS revenue,
    invoice_app.supplier_transaction.notes AS notes,
    invoice_app.supplier_transaction.deductible AS deductible,
    invoice_app.supplier_transaction.taxable AS taxable
FROM
    invoice_app.supplierinvoice
        INNER JOIN
    invoice_app.supplier ON invoice_app.supplierinvoice.supplier_id = invoice_app.supplier.id
        INNER JOIN
    invoice_app.supplier_transaction ON invoice_app.supplier_transaction.invoice_id = invoice_app.supplierinvoice.id
        INNER JOIN
    invoice_app.unit_of_measure ON invoice_app.supplier_transaction.unit_of_measure_id = invoice_app.unit_of_measure.id
        INNER JOIN
    invoice_app.products ON invoice_app.supplier_transaction.product_id = invoice_app.products.id
WHERE invoice_app.supplier_transaction.invoice_id = ?
ORDER BY date DESC;