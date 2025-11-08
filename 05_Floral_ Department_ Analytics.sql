
--Q1. What is the total revenue, total units sold, and total gross margin for the whole period?
--Q1. (Total revenue, total units, and total gross margin)
WITH ds AS (
  SELECT (price*sales_qty) AS revenue,
         ((price - cost)*sales_qty) AS gm,
         sales_qty
  FROM public.dailysku
)
SELECT
  SUM(revenue)                               AS total_revenue,
  SUM(sales_qty)                             AS total_units,
  SUM(gm)                                    AS total_gross_margin,
  ROUND( (SUM(gm)::numeric / NULLIF(SUM(revenue),0)::numeric) * 100, 2) AS gm_pct
FROM ds;



--Q2. How does daily revenue trend over time (by date)?
--Q2. Daily revenue trend over time

WITH ds AS (
  SELECT date::date AS dt, (price*sales_qty) AS revenue
  FROM public.dailysku
)
SELECT dt, SUM(revenue) AS daily_revenue
FROM ds
GROUP BY dt
ORDER BY dt;



--Q3. Which categories generate the most revenue (ranked)?
--Q3. Categories ranked by total revenue
WITH ds AS (
  SELECT category, (price*sales_qty) AS revenue
  FROM public.dailysku
)
SELECT category, SUM(revenue) AS revenue
FROM ds
GROUP BY category
ORDER BY revenue DESC;



--Q4. Which 10 SKUs generate the most revenue?
--Q4. Top 10 SKUs by revenue

WITH ds AS (
  SELECT sku, (price*sales_qty) AS revenue
  FROM public.dailysku
)
SELECT sku, SUM(revenue) AS revenue
FROM ds
GROUP BY sku
ORDER BY revenue DESC
LIMIT 5;



--Q5. What is gross-margin % by category (ranked highest to lowest)?
--Q5. Gross-margin % by category (ranked high→low)
WITH ds AS (
  SELECT category,
         (price*sales_qty) AS revenue,
         ((price - cost)*sales_qty) AS gm
  FROM public.dailysku
)
SELECT
  category,
  SUM(gm) AS gross_margin,
  SUM(revenue) AS revenue,
  ROUND( (SUM(gm)::numeric / NULLIF(SUM(revenue),0)::numeric) * 100, 2) AS gm_pct
FROM ds
GROUP BY category
ORDER BY gm_pct DESC NULLS LAST;



--Q6. Do promos help? Compare average daily units on promo days vs non-promo days.
--Q6. Avg daily units on promo vs not
WITH base AS (
  SELECT date::date AS dt, promo_flag, sales_qty
  FROM public.dailysku
),
daily AS (
  SELECT dt, promo_flag, SUM(sales_qty) AS units
  FROM base
  GROUP BY dt, promo_flag
)
SELECT promo_flag, ROUND(AVG(units),2) AS avg_daily_units
FROM daily
GROUP BY promo_flag
ORDER BY promo_flag;



--Q7. Do holidays matter? Compare average daily revenue on holiday vs non-holiday days.
--Q7. Avg daily revenue on holiday vs not
WITH base AS (
  SELECT date::date AS dt, holiday_flag, (price * sales_qty) AS revenue
  FROM public.dailysku
),
daily AS (
  SELECT dt, holiday_flag, SUM(revenue) AS revenue
  FROM base
  GROUP BY dt, holiday_flag
)
SELECT
  holiday_flag,
  ROUND(AVG(revenue)::numeric, 2) AS avg_daily_revenue   -- cast AVG() result
FROM daily
GROUP BY holiday_flag
ORDER BY holiday_flag;



--Q8. Which SKUs have the highest markdown rate (markdown_qty ÷ sales_qty)?
--Q8. SKUs with highest markdown rate (markdown_qty / sales_qty)
WITH ds AS (
  SELECT sku, markdown_qty::numeric AS md, sales_qty::numeric AS units
  FROM public.dailysku
)
SELECT
  sku,
  SUM(md) AS markdown_qty,
  SUM(units) AS sales_qty,
  ROUND( (SUM(md) / NULLIF(SUM(units),0)) * 100, 2) AS markdown_rate_pct
FROM ds
GROUP BY sku
HAVING SUM(units) > 0
ORDER BY markdown_rate_pct DESC
LIMIT 10;


 
--Q9. Which categories have the highest waste rate (waste_qty ÷ sales_qty)?
--Q9. Categories with highest waste rate (waste_qty / sales_qty)
WITH ds AS (
  SELECT category, waste_qty::numeric AS waste, sales_qty::numeric AS units
  FROM public.dailysku
)
SELECT
  category,
  SUM(waste) AS waste_qty,
  SUM(units) AS sales_qty,
  ROUND( (SUM(waste) / NULLIF(SUM(units),0)) * 100, 2) AS waste_rate_pct
FROM ds
GROUP BY category
HAVING SUM(units) > 0
ORDER BY waste_rate_pct DESC;



--Q10. Where might we have been under-stocked? Count days per SKU where on_hand_beg was less than sales_qty.
--Q10. Under-stocked days per SKU (on_hand_beg + delivery_qty < sales_qty)

WITH ds AS (
  SELECT sku,
         COALESCE(on_hand_beg,0) AS oh,
         COALESCE(delivery_qty,0) AS deliv,
         COALESCE(sales_qty,0) AS sales
  FROM public.dailysku
)
SELECT
  sku,
  COUNT(*) FILTER (WHERE oh + deliv < sales) AS understock_days
FROM ds
GROUP BY sku
ORDER BY understock_days DESC, sku;
