SELECT
    CONCAT(id, 'C') AS id
FROM
    customerinvoice
UNION ALL
SELECT
    CONCAT(id, 'S')
FROM customerinvoice