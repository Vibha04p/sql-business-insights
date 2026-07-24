-- Q10: Attribution Comparison - First-Touch vs Last-Touch Revenue by Channel
-- Business Question: How does channel revenue differ under first-touch and last-touch attribution models?
-- Owner: Vibha P | Last updated: 2026-07-11
-- Sanity check:
-- 1. Total revenue under first-touch and last-touch should match total non-cancelled revenue (within 0.5%).
-- 2. Orders with no attribution touch should be classified as 'direct'.

with order_sessions as (
    select distinct
        order_id,
        session_id
    from ecom.session_events
    where order_id is not null)


, touched_orders as (
    select
        o.order_id,
        o.total,
        at. channel,
        at.touched_at
    from ecom.orders o
    left join order_sessions os
        on o.order_id = os.order_id
    left join ecom.sessions s
        on os.session_id = s.session_id
    left join ecom.attribution_touches at
        on s.session_id = at.session_id
    where lower(o.status) != 'cancelled')


, first_touch as (
    select
        order_id
      , total
      , channel
      , row_number() over (
            partition by order_id
            order by touched_at asc
        ) as rn
    from touched_orders
)

, last_touch as (
    select
        order_id
      , total
      , channel
      , row_number() over (
            partition by order_id
            order by touched_at desc
        ) as rn
    from touched_orders)


select
    'first_touch' as attribution_model
  , coalesce(channel, 'direct') as channel
  , sum(total) as revenue
  , count(distinct order_id) as orders
  , sum(total) * 1.0
        / sum(sum(total)) over () as share_of_revenue
from first_touch
where rn = 1
group by 2

union all

select
    'last_touch' as attribution_model
  , coalesce(channel, 'direct') as channel
  , sum(total) as revenue
  , count(distinct order_id) as orders
  , sum(total) * 1.0
        / sum(sum(total)) over () as share_of_revenue
from last_touch
where rn = 1
group by 2

order by attribution_model, revenue desc;
