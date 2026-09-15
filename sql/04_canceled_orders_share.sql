/* 
================================================================================
Project: E-Commerce Product Analytics (Karpov.Courses Dataset)
Query 04: Order Cancellation Rate Analytics

Task:
Calculate total daily orders, canceled orders, and the share of canceled orders (%).

Key Business Logic:
1. Operational Monitoring: Tracks the percentage of canceled orders over time 
   to detect potential logistics, app, or stock failures.
2. Direct Aggregation: Uses PostgreSQL FILTER clause for clean count of cancel actions.
3. Share Formula: (Canceled Orders / Total Orders) * 100, rounded to 2 decimal places.

SQL Tech Stack: COUNT(DISTINCT) FILTER (WHERE), Type Casting (::numeric), GROUP BY, ORDER BY.
================================================================================
*/


select time::date as date, 
count(distinct order_id) as total_orders, 
count(distinct order_id) filter (where action='cancel_order') as canceled_orders, 
round(count(distinct order_id) filter (where action='cancel_order')/
count(distinct order_id)::numeric *100,2) as cancel_order_share

from user_actions
group by 1
order by 1
