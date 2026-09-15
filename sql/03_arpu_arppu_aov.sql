/* 
================================================================================
Project: E-Commerce Product Analytics (Karpov.Courses Dataset)
Query 03: Monetization Metrics (ARPU, ARPPU, AOV)

Task:
Calculate daily monetization metrics: Average Revenue Per User (ARPU), 
Average Revenue Per Paying User (ARPPU), and Average Order Value (AOV).

Key Business Logic:
1. Revenue & Orders: Calculated for non-canceled orders only by joining order products.
2. User Segmentation: 
   - Total Users: Unique active users per day.
   - Paying Users: Unique users who created non-canceled orders on that day.
3. Monetization Formulas:
   - ARPU = Total Revenue / Total Active Users
   - ARPPU = Total Revenue / Paying Users
   - AOV = Total Revenue / Total non-canceled orders

SQL Tech Stack: CTE (WITH clause), UNNEST, COUNT FILTER (WHERE), INNER JOIN, LEFT JOIN, Aggregations.
================================================================================
*/


with orders as 
  (select  order_id, creation_time, 
  unnest(product_ids) as product_id from orders 
  where order_id not in (select order_id from user_actions where action='cancel_order' )),
  
revenue as (select date(creation_time) date, 
  sum(price) as revenue, count(distinct order_id) as orders
  from orders inner join products using(product_id)
  group by 1),

pay_users as 
  (select time::date as date, count(distinct user_id) filter (where action='create_order' and order_id not in 
  (select order_id from user_actions where action='cancel_order')) as paying_users , 
  count(distinct user_id) as total_users
  from user_actions
  group by 1)

select revenue.date, round((revenue/total_users::numeric),2) as arpu, 
  round((revenue/paying_users::numeric),2) as arppu, 
  round((revenue/orders::numeric),2) as aov
  from revenue left join pay_users using(date)
  order by 1

