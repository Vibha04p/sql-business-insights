-- Q2: Monthly Signup Cohort Retention
-- Business Question: For each month's new signups, how many customers returned to place their first successful order in Month 1, Month 2, and Month 3 after signup?
-- Owner: Vibha P | Last updated: 2026-06-08
-- Sanity check:
-- 1. cohort_size should equal count(distinct customer_id) from ecom.customers for each cohort_month.
-- 2. All retention rates should be between 0 and 1.
-- 3. Customers with only cancelled orders should not be counted as retained.
-- 4. Censored months should return NULL, not 0.




-- CTE 1: Customer First Order Month
-- Grain: One row per customer.
-- Calculates each customer's signup cohort and the month of their
-- first successful (non-cancelled) order.
with customer_first_order_month as (
    select
        c.customer_id,
        date_trunc('month', c.created_at) :: date as cohort_month,
        min(date_trunc('month', o.created_at) :: date) filter (
            where
                lower(o.status) != 'cancelled'
        ) as first_order_month
    from
        ecom.customers c
        left join ecom.orders o on c.customer_id = o.customer_id
    group by
        1,
        2
)
  
-- CTE 2: Cohort Metrics
-- Grain: One row per cohort_month.
-- Aggregates cohort size and counts customers whose first successful
-- order occurred in Month 1, Month 2 and Month 3 after signup.
,
cohort_metrics as (
    select
        cf.cohort_month,
        count(distinct cf.customer_id) as cohort_size,
        count(distinct cf.customer_id) filter (
            where
                cf.first_order_month = cf.cohort_month + interval '1 month'
        ) as m1_retained,
        count(distinct cf.customer_id) filter (
            where
                cf.first_order_month = cf.cohort_month + interval '2 months'
        ) as m2_retained,
        count(distinct cf.customer_id) filter (
            where
                cf.first_order_month = cf.cohort_month + interval '3 months'
        ) as m3_retained
    from
        customer_first_order_month cf
    group by
        1
) -- Retention metrics beyond the latest observable order month are shown
-- as NULL instead of 0 to distinguish unavailable data from zero retention.
select
    cm.cohort_month,
    cm.cohort_size,
    case
        when cm.cohort_month + interval '1 month' > (
            select
                date_trunc('month', max(created_at))
            from
                ecom.orders
        ) then null
        else cm.m1_retained
    end as m1_retained,
    case
        when cm.cohort_month + interval '2 months' > (
            select
                date_trunc('month', max(created_at))
            from
                ecom.orders
        ) then null
        else cm.m2_retained
    end as m2_retained,
    case
        when cm.cohort_month + interval '3 months' > (
            select
                date_trunc('month', max(created_at))
            from
                ecom.orders
        ) then null
        else cm.m3_retained
    end as m3_retained,
    case
        when cm.cohort_month + interval '1 month' > (
            select
                date_trunc('month', max(created_at))
            from
                ecom.orders
        ) then null
        else (cm.m1_retained * 1.0) / nullif(cm.cohort_size, 0)
    end as m1_retention_rate,
    case
        when cm.cohort_month + interval '2 months' > (
            select
                date_trunc('month', max(created_at))
            from
                ecom.orders
        ) then null
        else (cm.m2_retained * 1.0) / nullif(cm.cohort_size, 0)
    end as m2_retention_rate,
    case
        when cm.cohort_month + interval '3 months' > (
            select
                date_trunc('month', max(created_at))
            from
                ecom.orders
        ) then null
        else (cm.m3_retained * 1.0) / nullif(cm.cohort_size, 0)
    end as m3_retention_rate
from
    cohort_metrics cm
order by
    cm.cohort_month;

-- Interpretation Notes:
-- Higher retention indicates faster customer activation after signup.
-- NULL retention values indicate insufficient observation period,
-- not zero retained customers.
-- Retention rates are expressed as percentages of the original cohort.
-- All retention rates are valid.
