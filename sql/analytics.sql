--ТОП-10 самых продаваемых товаров по количеству продаж
WITH
  total_quantity AS (
    SELECT
      product_name,
      SUM(quantity) AS total_quantity,
      ROW_NUMBER() OVER (
        ORDER BY
          SUM(quantity) DESC
      ) AS RANK
    FROM
      analytics_sales_valid
    GROUP BY
      product_name
  )
SELECT
  *
FROM
  total_quantity
WHERE
  RANK <= 10;


--Средняя цена и средняя выручка по категориям
SELECT
  category_name,
  ROUND(AVG(price)) AS avg_price,
  ROUND(AVG(revenue)) AS avg_revenue
FROM
  analytics_sales_valid
GROUP BY
  category_name
ORDER BY
  category_name;


--ТОП-5 стран по выручке
WITH
  top_country AS (
    SELECT
      country,
      SUM(revenue) AS total_revenue,
      ROW_NUMBER() OVER (
        ORDER BY
          SUM(revenue) DESC
      ) AS RANK
    FROM
      analytics_sales_valid
    GROUP BY
      country
  )
SELECT
  *
FROM
  top_country
WHERE
  RANK <= 5;


--Средний чек по магазинам
SELECT
  store_name,
  city,
  country,
  ROUND(AVG(revenue)) AS avg_revenue
FROM
  analytics_sales_valid
GROUP BY
  store_name,
  city,
  country
ORDER BY
  AVG(revenue) DESC;


--ТОП-5 магазинов по выручке
WITH
  top_store AS (
    SELECT
      store_name,
      city,
      country,
      SUM(revenue) AS total_revenue,
      ROW_NUMBER() OVER (
        ORDER BY
          SUM(revenue) DESC
      ) AS RANK
    FROM
      analytics_sales_valid
    GROUP BY
      store_name,
      city,
      country
  )
SELECT
  *
FROM
  top_store
WHERE
  RANK <= 5;


--Количество продаж по магазинам
SELECT
  store_name,
  city,
  country,
  COUNT(sale_id) AS total_sales,
  SUM(quantity) AS total_quantity
FROM
  analytics_sales_valid
GROUP BY
  store_name,
  city,
  country;


--Выручка по годам, рост год-к-году
WITH
  revenue_by_year AS (
    SELECT
      EXTRACT(
        YEAR
        FROM
          sale_date
      ) AS YEAR,
      SUM(revenue) AS revenue
    FROM
      analytics_sales_valid
    GROUP BY
      YEAR
  )
SELECT
  YEAR,
  revenue,
  CASE
    WHEN LAG(revenue) OVER (
      ORDER BY
        YEAR
    ) IS NULL THEN 0
    ELSE ROUND(
      100 * (
        revenue - LAG(revenue) OVER (
          ORDER BY
            YEAR
        )
      ) / LAG(revenue) OVER (
        ORDER BY
          YEAR
      ),
      2
    )
  END AS yoy_growth_percent
FROM
  revenue_by_year
ORDER BY
  YEAR;


--Кумулятивная выручка
WITH
  revenue_by_month AS (
    SELECT
      DATE_TRUNC('month', sale_date)::date AS MONTH,
      SUM(revenue) AS monthly_revenue
    FROM
      analytics_sales_valid
    GROUP BY
      DATE_TRUNC('month', sale_date)
  )
SELECT
  MONTH,
  monthly_revenue,
  SUM(monthly_revenue) OVER (
    ORDER BY
      MONTH ROWS BETWEEN UNBOUNDED PRECEDING
      AND CURRENT ROW
  ) AS cumulative_revenue
FROM
  revenue_by_month
ORDER BY
  MONTH;


--Продукты с высокой ценой(>1000), но низким объемом продаж (<10000)
SELECT
  product_name,
  category_name,
  price,
  SUM(quantity) AS total_quantity
FROM
  analytics_sales_valid
GROUP BY
  product_name,
  category_name,
  price
HAVING
  SUM(quantity) < 10000
  AND price > 1000
ORDER BY
  total_quantity DESC;


--Количество гарантийных случаев по странам
SELECT
  country,
  COUNT(repair_status) AS warranty_cases
FROM
  analytics_sales_valid
WHERE
  repair_status IN ('Completed', 'In Progress')
GROUP BY
  country
ORDER BY
  warranty_cases DESC;


--Товары с частыми гарантийными случаями
SELECT
  product_name,
  category_name,
  COUNT(repair_status) AS warranty_cases
FROM
  analytics_sales_valid
WHERE
  repair_status IN ('Completed', 'In Progress')
GROUP BY
  product_name,
  category_name
HAVING
  COUNT(repair_status) > 150
ORDER BY
  warranty_cases DESC;