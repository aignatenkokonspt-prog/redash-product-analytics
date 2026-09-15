/* 
================================================================================
Project: E-Commerce Product Analytics (Karpov.Courses Dataset)
Query 02: DAU Breakdown (New vs Returning Users)

Task:
Calculate Daily Active Users (DAU) and split them into new users and returning (old) users.

Key Business Logic:
1. New Users: Users who performed their very first action on that specific date.
2. Total Users: Total unique active users on that date.
3. Old (Returning) Users: Calculated as Total Users minus New Users.

SQL Tech Stack: CTE (WITH clause), Subqueries, Date Functions (date_part, to_char), LEFT JOIN, Aggregations (COUNT DISTINCT).
================================================================================
*/

with users_list as 
  (select date, count(distinct user_id) as new_users from(
  select user_id,  min(time::date) as date 
  from user_actions
  group by 1) as t1 group by 1),

total as 
  (select time::date as date, 
  count(distinct user_id) as total_users from user_actions
  group by 1)

select date_part('month',date) as month,
to_char(date, 'Dy'),
date,total_users, 
new_users,total_users-new_users as old_users
from total left join users_list using(date)
order by 3
