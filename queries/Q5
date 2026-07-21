-- Q5: Category Health - Purchases vs Returns
-- Business Question: Which product categories generate the most revenue, and which experience the highest returns?
-- Owner: Vibha P | Last updated: 2026-06-12
-- Sanity check:
-- 1. return_rate_pct should be between 0 and 100.
-- 2. Returns should never exceed orders_with_category.
-- 3. Sum(revenue) across categories should match paid-order revenue from ecom.order_items (within 0.5%).

with category_sales as (
    select
        c.category_id
        , c.category_name as category
        , SUM(oi.qty) as units_sold
        , COUNT(DISTINCT oi.order_id) as orders_with_category
        , SUM(oi.line_total) as revenue
    from
        ecom.orders o
        inner join ecom.order_items oi on o.order_id = oi.order_id
        inner join ecom.product_variants pv on oi.variant_id = pv.variant_id
        inner join ecom.products p on pv.product_id = p.product_id
        inner join ecom.categories c on p.category_id = c.category_id
    where
        lower(o.payment_status) = 'paid'
    group by
        c.category_name
        , c.category_id
)
,category_returns as(
    select
        c.category_id
        , c.category_name as category
        , SUM(r.qty) as returns
    from
        ecom.return_items r
        inner join ecom.product_variants pv on r.variant_id = pv.variant_id
        inner join ecom.products p on pv.product_id = p.product_id
        inner join ecom.categories c on p.category_id = c.category_id
    group by
        c.category_name
        , c.category_id
)
select
    cs.category
    , cs.orders_with_category
    , cs.units_sold
    , cs.revenue
    , cr.returns
    , (
        COALESCE(cr.returns, 0) * 1.0 / nullif(cs.units_sold, 0)
    ) * 100 as return_rate_pct
from
    category_sales cs
    left join category_returns cr on cs.category_id = cr.category_id;
