-- Q8: Customer Lifetime Value and Revenue Share
-- Business Question: Who are the highest-value customers, and how much revenue does each LTV bucket contribute?
-- Owner: Vibha P | Last updated:2026-07-10
-- Sanity check:
-- 1. Sum(total_revenue) across customers should equal non-cancelled order revenue (within 0.5%).
-- 2. Revenue share across all LTV buckets should sum to 1.

with customer_metrics as (
    select
        o.customer_id
        ,min(o.created_at)::date as first_order_date
        ,max(o.created_at)::date as last_order_date
        ,sum(o.total) as total_revenue
        ,count(*) as total_orders
        ,sum(o.total) * 1.0 / nullif(count(*), 0) as aov
    from
        ecom.orders o
    where
        lower(o.status) != 'cancelled'
    group by
        o.customer_id
),
buckets as (
    select
        cm.*
        ,case
            when cm.total_revenue < 1000 then '0-999'
            when cm.total_revenue between 1000 and 4999 then '1000-4999'
            when cm.total_revenue between 5000 and 19999 then '5000-19999'
            else '20000+'
        end as ltv_bucket
    from
        customer_metrics cm
)
select
    customer_id
    ,first_order_date
    ,last_order_date
    ,total_orders
    ,total_revenue
    ,aov
    ,ltv_bucket
    ,sum(total_revenue) over (partition by ltv_bucket)
        / sum(total_revenue) over () as ltv_bucket_share_of_revenue
from
    buckets
order by
    total_revenue desc;
