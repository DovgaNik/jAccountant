SELECT
    products.id AS id,
    products.name AS name,
    products.description AS description,
    c.name AS category
FROM invoice_app.products
    INNER JOIN invoice_app.category c on products.category_id = c.id