CREATE VIEW analytics_sales_valid AS
  (SELECT *
   FROM analytics_sales
   WHERE sale_date > launch_date)