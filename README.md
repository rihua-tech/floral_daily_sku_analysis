# floral_daily_sku_analysis
data analytics project showcasing floral daily SKU analysis using python, SQL and Power BI.

# Floral Daily-SKU Analytics

> End-to-end demo showing daily SKU analysis for a **Floral** department using **Python (EDA)**, **SQL (analysis)**, and **Power BI (dashboard)**.

<p align="center">
  <img src="docs/dashboard-cover.png" alt="Power BI dashboard preview" width="900">
</p>

## Table of Contents
- [Overview](#overview)
- [What’s in this repo](#whats-in-this-repo)
- [Data](#data)
- [How the analysis works](#how-the-analysis-works)
  - [Python (EDA & features)](#python-eda--features)
  - [SQL (business analysis)](#sql-business-analysis)
  - [Power BI (decision dashboard)](#power-bi-decision-dashboard)
- [Quick start](#quick-start)
- [Sample insights](#sample-insights)
- [Repo map](#repo-map)
- [Notes](#notes)

---

## Overview
A compact analytics project that models daily SKU data and answers:
- How are **Units, Sales, Cost, Shrink/Waste %** trending?
- What is **promo uplift** and **holiday** impact?
- Which **categories/SKUs** drive revenue, margin, waste?

**Tech:** Python · SQL · Power BI

---

## What’s in this repo
- **Business brief** – [`01_Business Problem Statement.pdf`](./01_Business%20Problem%20Statement.pdf)
- **Insights deck** – [`02_Floral Daily SKU Analytics and Business Insight.pdf`](./02_Floral%20Daily%20SKU%20Analytics%20and%20Business%20Insight.pdf)
- **Architecture slide** – [`03_Floral-Analytics-Stack.pptx`](./03_Floral-Analytics-Stack.pptx)
- **EDA notebook** – `04_Floral _ Department_ Analytics.ipynb` (Python)
- **Analysis queries** – [`05_Floral_ Department_ Analytics.sql`](./05_Floral_%20Department_%20Analytics.sql)
- **Power BI report** – `06_Floral Daily SKU Analytics.pbix`
- **Sample data** – `07_DailySKU_raw.csv`, `08_DailySKU.csv`, `09_DimDate.csv`, `10_DimSKU.csv`

> Tip: use **relative links** (`./file-name`) as above so links work in GitHub.

---

## Data
**Grain:** Daily by SKU (demo dates 2024–2025)

**Tables**
- `DailySKU`: price, cost, on_hand_beg, delivery_qty, sales_qty, markdown_qty, waste_qty, promo_flag, holiday_flag, weather_index
- `DimDate`: calendar + helpers (ISO week, weekend, holiday windows)
- `DimSKU`: sku, category, attributes

---

## How the analysis works

### Python (EDA & features)
- Data health checks: nulls, dtypes, duplicates, positive quantities  
- Cleaning: SKU name harmonization, mild outlier handling  
- Feature engineering: **waste rate**, **gross margin $**, **ISO week**, **weekend**, **holiday_window** flags

### SQL (business analysis)
Reusable queries for:
- **Totals & trends** (revenue, units, GM $ / GM%)
- **Category & SKU leaders** (revenue, GM%)
- **Promo vs non-promo**: average daily units
- **Holiday vs non-holiday**: average daily revenue
- **Markdown & waste rates** by category
- **Under-stock days**:
  ```sql
  -- under-stock when beginning on-hand + deliveries < sales
  SELECT date, sku
  FROM DailySKU
  WHERE on_hand_beg + delivery_qty < sales_qty;
