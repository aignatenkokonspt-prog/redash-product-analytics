/* 
================================================================================
Project: E-Commerce Product Analytics (Karpov.Courses Dataset)
Query 05: Cohort Retention Rate Analysis

Task:
Calculate daily Cohort Retention Rates to track user return behavior over time.

Key Business Logic:
1. Cohort Assignment: Defines start_date for each user using the window function MIN() OVER (PARTITION BY user_id).
2. Active Days: Calculates day differences between user activity dates and their start date.
3. Cohort Retention: Divides active unique users on act_date by the initial cohort size (start_users).

SQL Tech Stack: CTE (WITH clause), Window Functions (MIN OVER PARTITION BY), Date Truncation (date_trunc), INNER JOIN, Aggregations.
================================================================================
*/


with 
days as 
  (select time::date as act_date, user_id, min(time) over (partition by user_id)::date  as start_date, 
  time::date-min(time)over (partition by user_id) ::date  as day_number from user_actions),
  
 start_cohorts as 
  (select start_date, count(distinct user_id ) as start_users from days group by 1)

select date_trunc('month',start_date)::date as start_month, 
  start_date, date_trunc('month',act_date)::date as action_month,
  act_date, count( distinct user_id) / max(start_users)::numeric as retention
  from days inner join start_cohorts using(start_date) 
  group by 1,2,3,4
  order by action_month, act_date


