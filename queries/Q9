-- Q9: Repeat Purchase Interval
-- Business Question: How long does it take customers to make their next purchase?
-- Owner: Vibha P | Last updated: 2026-07-10
-- Sanity check:
-- 1. days_to_next_order should always be greater than or equal to 0.
-- 2. median_days_to_next_order should be less than or equal to p90_days_to_next_order.

-- 1. INCLUDING same-day repeat orders

with customer_order_date as (
    select
        o.customer_id
      , o.order_id
      , o.created_at::date as order_date
      , lead(o.created_at) over (
            partition by o.customer_id
            order by o.created_at
        )::date as next_order_date
      , lead(o.created_at) over (
            partition by o.customer_id
            order by o.created_at
        ) - o.created_at as days_to_next_order
    from ecom.orders o
)



SELECT
    COUNT(DISTINCT customer_id) AS customers_with_repeat_order,
    AVG(days_to_next_order) AS avg_days_to_next_order,
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY days_to_next_order) AS median_days_to_next_order,
    PERCENTILE_CONT(0.9)
        WITHIN GROUP (ORDER BY days_to_next_order) AS p90_days_to_next_order
FROM customer_order_date
WHERE next_order_date IS NOT NULL;

--- EXCLUDING same-day repeat orders

with customer_order_date as (
    select
        o.customer_id
      , o.order_id
      , o.created_at::date as order_date
      , lead(o.created_at) over (
            partition by o.customer_id
            order by o.created_at
        )::date as next_order_date
      , lead(o.created_at) over (
            partition by o.customer_id
            order by o.created_at
        ) - o.created_at as days_to_next_order
    from ecom.orders o
)



select
    count(distinct customer_id) as customers_with_repeat_order
  , avg(days_to_next_order) as avg_days_to_next_order
  , percentile_cont(0.5)
        within group (
            order by days_to_next_order
        ) as median_days_to_next_order
  , percentile_cont(0.9)
        within group (
            order by days_to_next_order
        ) as p90_days_to_next_order
from customer_order_date
where next_order_date is not null
  and days_to_next_order > interval '0 days';
  
--I calculated the repeat purchase interval both including and excluding same-day repeat orders. The summary metrics remained identical because the dataset contains no same-day repeat purchases (days_to_next_order = 0). Therefore, excluding same-day repeat orders does not affect the analysis for this dataset. For lifecycle marketing, I would still use the version excluding same-day repeat orders because multiple orders placed on the same day are generally part of the same shopping session rather than a customer returning after leaving. This approach would also be appropriate if same-day repeat purchases were present in future data..
