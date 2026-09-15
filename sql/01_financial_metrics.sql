
/* 
================================================================================
Project: E-Commerce Product Analytics (Karpov.Courses Simulator Dataset)
Query 01: Daily & Cumulative Unit Economics (P&L Breakdown)

Business Task:
Calculate daily and cumulative financial metrics to evaluate unit economics,
margin ratios, and cost efficiency shifts across different operational periods (Aug vs. Sept 2022).

Business Rules & Logic:
1. Revenue & VAT Calculation:
   - Includes only non-canceled orders.
   - Applies reduced VAT rate of 10% for essential goods list, 20% standard rate for others.
   - Formula for 10% VAT: price * 10/110.0; Formula for 20% VAT: price * 20/120.0.
     Note: ROUND() is kept inside SUM() to match the task logic. In production, it's better to round after aggregation.
   - Values rounded to 2 decimal places per product item.

2. Variable & Fixed Costs Mechanics:
   - Assembly Cost: Charged on order creation date (non-canceled). 140 RUB (Aug) -> 115 RUB (Sept).
   - Delivery Pay: 150 RUB per delivered order on actual delivery date.
   - Courier Bonus: Paid on delivery date for 5+ deliveries/day. 400 RUB (Aug) -> 500 RUB (Sept).
   - Fixed Costs (Warehouse Rent): 120,000 RUB/day (Aug) -> 150,000 RUB/day (Sept).

3. Margin Metrics & Window Functions:
   - Gross Profit = Revenue - Costs - VAT Tax.
   - Cumulative Running Totals calculated via SUM() OVER (ORDER BY date).
   - Daily & Cumulative Margin Ratio (%) calculated and rounded to 2 decimal places.

SQL Tech Stack: CTEs, Window Functions (SUM OVER), FULL OUTER JOINs, UNNEST, CASE WHEN, COALESCE.
================================================================================
*/



with revenue_nds as 
  (select date,  sum(price) as revenue,
    sum(case when name in ('сахар', 'сухарики', 'сушки', 'семечки', 
    'масло льняное', 'виноград', 'масло оливковое', 
    'арбуз', 'батон', 'йогурт', 'сливки', 'гречка', 
    'овсянка', 'макароны', 'баранина', 'апельсины', 
    'бублики', 'хлеб', 'горох', 'сметана', 'рыба копченая', 
    'мука', 'шпроты', 'сосиски', 'свинина', 'рис', 
    'масло кунжутное', 'сгущенка', 'ананас', 'говядина', 
    'соль', 'рыба вяленая', 'масло подсолнечное', 'яблоки', 
    'груши', 'лепешка', 'молоко', 'курица', 'лаваш', 'вафли', 'мандарины') then round(price::numeric *10/110.0,2)
    else round(price::numeric *20/120.0,2)
    end) as tax_pr 
  from(select creation_time::date as date, order_id, unnest(product_ids) as product_id from orders 
  where order_id not in ( select order_id from user_actions where action = 'cancel_order')) as orders
  inner join products using(product_id) 
  group by 1 order by 1 ),

collect_costs as 
  ( select time::date as date, count(distinct order_id) *
  (case when time::date<'2022-09-01' then 140 else 115 end) as col_costs
  from user_actions 
  where action='create_order' and order_id not in (select order_id from user_actions where action = 'cancel_order')
  group by 1 ), 

delivery_costs_ord as 
  (select time::date as date, (count(distinct order_id)*150) as ord_costs
  from courier_actions WHERE action = 'deliver_order' group by 1), 

delivery_costs_bonus as 
  (select date , COALESCE((count(distinct courier_id)*
  (case when date<'2022-09-01' then 400 else 500 end)),0) as bonus
  from 
  (select time::date as date, courier_id
  from courier_actions
  where action='deliver_order' group by 1,2
  having count(distinct order_id)>=5) as c_bonus
  group by 1),

costs as 
  (select collect_costs.date, round(col_costs+ord_costs+COALESCE(bonus,0)+
  (case when collect_costs.date<'2022-09-01' then 120000 else 150000 end),0) as costs
  from collect_costs full join delivery_costs_ord using(date) full join delivery_costs_bonus using(date))

select COALESCE(revenue_nds.date, costs.date) as date, revenue, costs, tax_pr as tax, 
  revenue-costs-tax_pr as gross_profit, 
  sum(revenue) over (order by date) as total_revenue, 
  sum(costs) over (order by date) as total_costs,
  sum(tax_pr) over (order by date) as total_tax, 
  sum(revenue-costs-tax_pr) over (order by date) as total_gross_profit, 
  round((revenue-costs-tax_pr)/revenue::numeric*100,2) as gross_profit_ratio, 
  round((sum(revenue-costs-tax_pr) over (order by date)) / sum(revenue) over (order by date)::numeric *100,2) 
  as total_gross_profit_ratio
from revenue_nds full join costs using(date) 
order by 1


