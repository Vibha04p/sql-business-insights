-- ### Q5 — Category Health: Purchases → Returns
--**Category Manager question:** *"Which categories generate the most revenue, and which have the highest return rates?"*
--**Output:** `category, orders_with_category, units_sold, revenue, returns, return_rate_pct`
--**Sanity check:** `return_rate_pct ∈ [0, 100]`. `returns <= orders_with_category` for every category. `sum(revenue)` across categories equals `sum(line_total)` from `ecom.order_items` on paid orders, within 0.5%.
--**Pattern note:** Two CTEs (`category_sales`, `category_returns`) joined in the final select. Returns aggregate via `return_items → product_variants → products → categories`. Note the join chain — going through `product_variants` is required because `return_items` references variants, not products.
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
