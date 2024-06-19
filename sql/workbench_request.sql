SELECT
    invoice_app.supplierinvoice.invoice_date AS date,
    invoice_app.supplier.name AS name,
    invoice_app.products.name AS product,
    invoice_app.supplier_transaction.caen AS caen,
    invoice_app.supplier_transaction.quantity AS quantity,
    invoice_app.unit_of_measure.short AS um,
    invoice_app.supplierinvoice.price AS spendings,
    NULL AS revenue,
    invoice_app.supplier_transaction.notes AS notes,
    invoice_app.supplier_transaction.deductible AS deductible,
    invoice_app.supplier_transaction.taxable AS taxable
FROM
    invoice_app.supplierinvoice
        INNER JOIN
    invoice_app.supplier ON invoice_app.supplier.id = invoice_app.supplierinvoice.supplier_id
        INNER JOIN
    invoice_app.supplier_transaction ON invoice_app.supplier_transaction.invoice_id = invoice_app.supplierinvoice.id
        INNER JOIN
    invoice_app.unit_of_measure ON invoice_app.supplier_transaction.unit_of_measure_id = invoice_app.unit_of_measure.id
        INNER JOIN
    invoice_app.products ON invoice_app.supplier_transaction.product_id = invoice_app.products.id
UNION ALL SELECT
              invoice_app.customerinvoice.invoice_date AS date,
              CONCAT(invoice_app.person.name, ' ', invoice_app.person.surname) AS name,
              invoice_app.products.name AS product,
              invoice_app.customer_transaction.caen AS caen,
              invoice_app.customer_transaction.quantity AS quantity,
              invoice_app.unit_of_measure.short AS um,
              NULL AS spendings,
              invoice_app.customerinvoice.price AS revenue,
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
ORDER BY date DESC;