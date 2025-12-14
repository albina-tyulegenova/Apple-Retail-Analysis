WITH invalid_sales AS
  (SELECT s.sale_id,
          s.sale_date,
          p.product_id,
          p.launch_date
   FROM sales s
   JOIN products p ON s.product_id = p.product_id
   WHERE s.sale_date < p.launch_date)
SELECT COUNT(*) AS invalid_sales ,
       ROUND(COUNT(*) * 100.0 /
               (SELECT COUNT(*)
                FROM sales), 2) AS invalid_sales_percent
FROM invalid_sales;