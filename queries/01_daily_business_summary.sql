-- Q1: Daily Business Summary + DoD / Same-Weekday WoW Comparisons
-- Business Question: How is the business performing today compared to yesterday and the same weekday last week?
-- Owner: Vibha P | Last updated: 2026-06-08
-- Sanity check:
-- 1. paid_order_rate should always be between 0 and 1.
-- 2. Sum(orders) across all days should equal count(*) from ecom.orders for the same date range.

with daily_orders as(
    select
        date_trunc('day', o.created_at) :: date as order_date
        , sum(o.total) as revenue
        , count(*) as orders
        , count(*) filter (
            where
                o.payment_status = 'paid'
        ) as paid_orders
        , count(*) filter (
            where
                lower(o.status) = 'cancelled'
        ) as cancelled_orders
    from
        ecom.orders o
    group by
        1
) 

------- Grain: One row per order_date.
-- Aggregates daily revenue, orders, paid orders, and cancelled orders.

, daily_refunds as (
    select
        date_trunc('day', r.created_at) :: date as order_date
        , sum(r.amount) as refunds_amount
    from
        ecom.refunds r
    group by
        1
) 

----- -- Grain: One row per order_date.
-- Aggregates total refund amount per day.

, daily_metrics as(
    select
        d.order_date
        , d.revenue
        , d.orders
        , d.paid_orders
        , d.cancelled_orders
        , coalesce(dr.refunds_amount, 0) as refunds_amount
        , lag(d.revenue, 1) over(
            order by
                d.order_date
        ) as yesterday_revenue
        , lag(d.revenue, 7) over (
            order by
                d.order_date
        ) as last_week_revenue
    from
        daily_orders d
        left join daily_refunds dr on d.order_date = dr.order_date
) 

-----with this table we are just simplifying our calculations for better readabilty and to avoid repeating long formulas

select
    dm.order_date
    , dm.revenue
    , dm.orders
    , (dm.revenue * 1.0) / nullif(dm.orders, 0) as aov
    , (dm.paid_orders * 1.0) / nullif(dm.orders, 0) as paid_order_rate
    , (dm.cancelled_orders * 1.0) / nullif(dm.orders, 0) as cancelled_order_rate
    , dm.refunds_amount
    , (dm.revenue - dm.yesterday_revenue) / nullif(dm.yesterday_revenue, 0) * 100.0 as revenue_vs_yesterday_pct
    , (dm.revenue - dm.last_week_revenue) / nullif(dm.last_week_revenue, 0) * 100.0 as revenue_vs_last_weekday_pct
from
    daily_metrics dm

-- Interpretation Notes:
-- Positive percentage values indicate growth.
-- Negative percentage values indicate decline.
-- Percentage comparisons return NULL when the previous period has zero revenue.
