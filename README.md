
# E-Commerce Product & Financial Analytics (Redash)

## Project Overview
This project presents an Executive Health Check Dashboard built in Redash using PostgreSQL. The goal is to monitor daily product health, unit economics, audience growth, monetization, and user retention for an e-commerce delivery service.

## Dashboard Preview
![Executive Health Check - Part 1](total_metrics_screen1.png)

![Executive Health Check - Part 2](total_metrics_screen2.png)

> **Live Dashboard Link:** [View Interactive Dashboard in Redash](https://redash.public.karpov.courses/dashboards/10958-total_metrics)
---

## SQL Queries & Dashboard Structure

### 1. Financial Metrics & Unit Economics (P&L)
* **Dashboard Widgets:** Total Metrics (Revenue, Costs, Gross Profit) & Profit Trend.
* **SQL Query:** [01_financial_metrics.sql](sql/01_financial_metrics.sql)
* **Key Takeaways:**
  * **Revenue Growth:** Revenue shows a strong positive trend because the service is new and growing. 
  * **Weekend Effect:** Growth peaks on Friday–Sunday when food delivery demand is highest.From Sep 2 to 4, revenue increased from
     1.4M to 2.3M RUB.
  * **Mid-week Dip:** A temporary drop occurs around Sep 6 (1.3M RUB), showing probable weekly seasonality.
  * **Cost Optimization:** Initially, costs exceeded revenue. After Sep 1, revenue outgrew costs due to changes in fixed/variable cost logic.

### 2. User Growth & Audience Breakdown
* **Dashboard Widget:** DAU (New vs. Returning Users).
* **SQL Query:** [02_dau_new_old_users.sql](sql/02_dau_new_old_users.sql)
* **What it shows:** Daily Active Users split by first-time users (New) and returning users (Old) to track acquisition and user activity.

### 3. Monetization & Average Order Values
* **Dashboard Widget:** ARPU, ARPPU, AOV Trends.
* **SQL Query:** [03_arpu_arppu_aov.sql](sql/03_arpu_arppu_aov.sql)
* **What it shows:** Average Revenue Per User (ARPU), Average Revenue Per Paying User (ARPPU), and Average Order Value (AOV) over time.

### 4. Operations & Order Cancellations
* **Dashboard Widget:** Canceled Orders Share (%).
* **SQL Query:** [04_canceled_orders_share.sql](sql/04_canceled_orders_share.sql)
* **What it shows:** Percentage of canceled orders per day to monitor operational issues or delivery delays.

### 5. User Retention & Cohort Analysis
* **Dashboard Widget:** Retention Pivot Table (Cohorts).
* **SQL Query:** [05_retention_cohorts.sql](sql/05_retention_cohorts.sql)
* **What it shows:** Cohort retention matrix tracking user return rates on Day 1, Day 2, etc., from their first order date.

---

## Tech Stack
* **Database:** PostgreSQL
* **BI & Visualization:** Redash
* **SQL Features Used:** CTEs, Window Functions (`SUM OVER`, `COUNT DISTINCT OVER`), Aggregations, `CASE WHEN`, `UNNEST`, `FULL OUTER JOIN`, Pivot Data Structures.
