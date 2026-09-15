
# E-Commerce Product & Financial Analytics (Redash)

## Project Overview
This project presents an Executive Health Check Dashboard built in Redash using PostgreSQL. The goal is to monitor daily product health, unit economics, audience growth, monetization, and user retention for an e-commerce delivery service.

## Dashboard Preview
*(Upload your dashboard screenshot to GitHub and link it here)*

---

## SQL Queries & Dashboard Structure

### 1. Financial Metrics & Unit Economics (P&L)
* **Dashboard Widgets:** Total Metrics (Revenue, Costs, Gross Profit) & Profit Trend.
* **SQL Query:** [01_financial_metrics.sql](sql/01_financial_metrics.sql)
* **What it shows:** Daily revenue, variable costs (assembly, delivery, courier bonuses), VAT tax, and gross margin %.

### 2. User Growth & Audience Breakdown
* **Dashboard Widget:** DAU (New vs. Returning Users).
* **SQL Query:** [02_dau_new_old_users.sql](sql/02_dau_new_old_users.sql)
* **What it shows:** Daily Active Users split by first-time users (New) and returning users (Old) to track acquisition and user activity.

### 3. Monetization & Average Order Values
* **Dashboard Widget:** ARPU, ARPPU, AOV Trends.
* **SQL Query:** `sql/03_arpu_arppu_aov.sql` *(Add link when uploaded)*
* **What it shows:** Average Revenue Per User (ARPU), Average Revenue Per Paying User (ARPPU), and Average Order Value (AOV) over time.

### 4. Operations & Order Cancellations
* **Dashboard Widget:** Canceled Orders Share (%).
* **SQL Query:** `sql/04_canceled_orders_share.sql` *(Add link when uploaded)*
* **What it shows:** Percentage of canceled orders per day to monitor operational issues or delivery delays.

### 5. User Retention & Cohort Analysis
* **Dashboard Widget:** Retention Pivot Table (Cohorts).
* **SQL Query:** `sql/05_retention_cohorts.sql` *(Add link when uploaded)*
* **What it shows:** Cohort retention matrix tracking user return rates on Day 1, Day 2, etc., from their first order date.

---

## Tech Stack
* **Database:** PostgreSQL
* **BI & Visualization:** Redash
* **SQL Features Used:** CTEs, Window Functions (`SUM OVER`, `COUNT DISTINCT OVER`), Aggregations, `CASE WHEN`, `UNNEST`, `FULL OUTER JOIN`, Pivot Data Structures.
