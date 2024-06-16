USE invoice_app;

SELECT 
    supplierinvoice.invoice_date AS date,
    supplier.name AS name,
    products.name AS product,
    supplier_transaction.caen AS caen,
    supplier_transaction.quantity AS quantity,
    unit_of_measure.short AS um,
    supplierinvoice.price AS spendings,
    NULL AS revenue,
    supplier_transaction.notes AS notes
FROM
    supplierinvoice
        INNER JOIN
    supplier ON supplierinvoice.id = supplier.id
        INNER JOIN
    supplier_transaction ON supplier_transaction.invoice_id = supplierinvoice.id
        INNER JOIN
    unit_of_measure ON supplier_transaction.unit_of_measure_id = unit_of_measure.id
        INNER JOIN
    products ON supplier_transaction.product_id = products.id 
UNION ALL SELECT 
    customerinvoice.invoice_date AS date,
    person.name AS name,
    products.name AS product,
    customer_transaction.caen AS caen,
    customer_transaction.quantity AS quantity,
    unit_of_measure.short AS um,
    NULL AS spendings,
    customerinvoice.price AS revenue,
    customer_transaction.notes AS notes
FROM
    customerinvoice
        INNER JOIN
    person ON customerinvoice.id = person.id
        INNER JOIN
    customer_transaction ON customer_transaction.invoice_id = customerinvoice.id
        INNER JOIN
    unit_of_measure ON customer_transaction.unit_of_measure_id = unit_of_measure.id
        INNER JOIN
    products ON customer_transaction.product_id = products.id
ORDER BY date;