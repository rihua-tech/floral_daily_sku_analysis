# floral_daily_sku_analysis
data analytics project showcasing floral daily SKU analysis using python, SQL and Power BI.

Floral Daily-SKU Analytics

A compact, end-to-end analytics project for a grocery Floral department. It models daily SKU data, explores drivers of sales, margin, waste/shrink, markdowns, promos, and holiday windows, and publishes an interactive Power BI dashboard.

Tech: Python (EDA) · SQL (analysis views/queries) · Power BI (visuals & what-ifs)

1) What’s inside

Business Problem Statement (PDF) — scope, questions, and deliverables.

Power BI report (.pbix) — interactive dashboard for Units, Sales, Cost, Shrink, Waste %, Promo Uplift, with date/holiday/category/SKU slicers and quick “last N weeks” views. 

03_Floral-Analytics-Stack

Python notebook (.ipynb) — EDA, data quality checks, and feature engineering (e.g., waste rate, ISO week, weekend flags). 

03_Floral-Analytics-Stack

SQL script (.sql) — reusable queries for revenue, margin, category & SKU ranking, promo/holiday lift, markdown & waste rates, and under-stock day detection. 

05_Floral_ Department_ Analytics

Sample data (CSV) — DailySKU, DimDate, DimSKU (+ a raw CSV).

2) Data at a glance

Grain/Span: Daily by SKU, 2024–2025 (demo scale).

Signals: price, cost, on-hand, deliveries, sales, markdowns, waste, promo_flag, holiday_flag, plus engineered features (ISO week, weekend, waste %, etc.). 

03_Floral-Analytics-Stack

3) How the analysis works
Python (EDA & features)

Health checks: nulls, dtypes, duplicates, positive-quantity sanity.

Cleaning: outlier clipping, SKU harmonization, forward-fill of missing prices.

Feature engineering: waste rate, gross margin $, ISO week, weekend flags. 

03_Floral-Analytics-Stack

SQL (business analysis)

Prebuilt queries answer the key questions:

Totals (revenue, units, GM & GM%) and daily revenue trend.

Category/SKU leaders by revenue and GM%.

Promo vs non-promo average daily units; holiday vs non-holiday average daily revenue.

Markdown rate (markdown_qty ÷ sales_qty) and waste rate by category.

Under-stock days: count where on_hand_beg + delivery_qty < sales_qty. 

05_Floral_ Department_ Analytics

Power BI (decision dashboard)

Cards for Units, Sales, Cost, Shrink and slices for date (relative), category, SKU search, promo flag model, holiday window.

Pages highlight Sales $ vs Waste % (26 weeks) and Holiday Window: Units vs Baseline (6w), plus Waste $ by category and Promo Uplift % by SKU visuals for quick action. 

03_Floral-Analytics-Stack

4) Key takeaways (from the demo dataset)

Holiday spikes: units surge 5–10× around Valentine’s/Mother’s Day; demand is largely inelastic in those windows, with 2–2.5× typical price lift.

Category patterns: Bouquets dominate revenue & waste $; Plants carry higher unit margin but lower turnover.

Operational levers: markdowns at close help reduce waste post-holiday; focus under-stock monitoring on peak weeks. 

03_Floral-Analytics-Stack

5) Quick start

SQL (optional): Load CSVs to a local/Postgres schema as public.dailysku, public.dimdate, public.dimsku, then run the provided queries from 05_Floral_ Department_ Analytics.sql. 

05_Floral_ Department_ Analytics

Python: Open 04_Floral _ Department_ Analytics.ipynb to reproduce EDA/feature steps (paths may need minor edits). 

03_Floral-Analytics-Stack

Power BI: Open 06_Floral Daily SKU Analytics.pbix. If prompted, map data sources to your local CSVs or database.

6) Repo map
01_Business Problem Statement.pdf
02_Floral Daily SKU Analytics and Business Insight.pdf
03_Floral-Analytics-Stack.pptx
04_Floral _ Department_ Analytics.ipynb
05_Floral_ Department_ Analytics.sql
06_Floral Daily SKU Analytics.pbix
07_DailySKU_raw.csv   08_DailySKU.csv   09_DimDate.csv   10_DimSKU.csv
README.md

7) Notes & reuse

The project is template-friendly: swap in your store’s daily SKU feed and holiday calendar; the SQL and visuals are written to be portable.

For production, add a lightweight ETL (or Power Query) and schedule data refresh in the BI service.

Questions or ideas to extend (e.g., markdown optimization or forecast with MAPE tracking)? Open an issue or start a discussion.
