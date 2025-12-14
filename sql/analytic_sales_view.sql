CREATE VIEW analytics_sales AS
SELECT s.sale_id,
       s.sale_date,
       p.product_name,
       c.category_name,
       p.launch_date,
       p.price,
       s.quantity,
       (p.price * s.quantity) AS revenue,
       st.store_name,
       st.city,
       st.country,
       w.repair_status
FROM sales s
LEFT JOIN products p ON s.product_id = p.product_id
LEFT JOIN category c ON p.category_id = c.category_id
LEFT JOIN stores st ON s.store_id = st.store_id
LEFT JOIN warranty w ON s.sale_id = w.sale_id