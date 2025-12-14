--Check the number of rows

SELECT COUNT(*)
FROM category;


SELECT COUNT(*)
FROM products;


SELECT COUNT(*)
FROM sales;


SELECT COUNT(*)
FROM stores;


SELECT COUNT(*)
FROM warranty;

--Check for missing VALUES

SELECT *
FROM category
WHERE category_id IS NULL
  OR category_name IS NULL;


SELECT *
FROM products
WHERE product_id IS NULL
  OR product_name IS NULL
  OR category_id IS NULL
  OR launch_date IS NULL
  OR price IS NULL;


SELECT *
FROM sales
WHERE sale_id IS NULL
  OR sale_date IS NULL
  OR store_id IS NULL
  OR product_id IS NULL
  OR quantity IS NULL;


SELECT *
FROM stores
WHERE store_id IS NULL
  OR store_name IS NULL
  OR city IS NULL
  OR country IS NULL;


SELECT *
FROM warranty
WHERE claim_id IS NULL
  OR claim_date IS NULL
  OR sale_id IS NULL
  OR repair_status IS NULL;

--Check formats

SELECT category_id
FROM category
WHERE category_id NOT LIKE 'CAT-%';


SELECT *
FROM products
WHERE product_id NOT LIKE 'P-%'
  OR category_id NOT LIKE 'CAT-%'
  OR launch_date > CURRENT_DATE
  OR launch_date < '2000-01-01'
  OR price < 0;


SELECT *
FROM sales
WHERE sale_id NOT LIKE '__-%'
  OR sale_date > CURRENT_DATE
  OR sale_date < '2000-01-01'
  OR product_id NOT LIKE 'P-%'
  OR quantity < 0;


SELECT *
FROM stores
WHERE store_id NOT LIKE 'ST-%';


SELECT *
FROM warranty
WHERE claim_id NOT LIKE 'CL-%'
  OR claim_date > CURRENT_DATE
  OR claim_date < '2000-01-01'
  OR sale_id NOT LIKE '__-%'
  OR repair_status NOT IN ('Completed',
                           'Pending',
                           'Rejected',
                           'In Progress');

--Check foreign KEY

SELECT s.product_id
FROM sales s
LEFT JOIN products p ON p.product_id = s.product_id
WHERE p.product_id IS NULL;


SELECT p.category_id
FROM products p
LEFT JOIN category c ON c.category_id = p.category_id
WHERE c.category_id IS NULL;


SELECT s.store_id
FROM sales s
LEFT JOIN stores st ON st.store_id = s.store_id
WHERE st.store_id IS NULL;


SELECT w.sale_id
FROM warranty w
LEFT JOIN sales s ON s.sale_id = w.sale_id
WHERE s.sale_id IS NULL;