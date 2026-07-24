-- Q3: Funnel Conversion by Acquisition Channel
-- Business Question: Where does traffic from each acquisition channel drop off in the conversion funnel?
-- Owner: Vibha P | Last updated: 2026-06-08
-- Sanity check:
-- 1. All conversion rates should be between 0 and 1.
-- 2. Stage counts should satisfy:
--    sessions >= product_view_sessions >= add_to_cart_sessions >= begin_checkout_sessions >= purchase_sessions.

-- CTE 1: Channel Funnel Metrics
-- Grain: One row per acquisition channel.
-- Aggregates distinct sessions reaching each funnel stage
-- for every acquisition channel.

with channels_per_session as (
    select
        coalesce(sc.channel, 'direct') as channel
        ,count(distinct se.session_id) as sessions
        ,count(DISTINCT se.session_id) filter(
            where
                se.event_type = 'product_view'
        ) as product_view_sessions
        ,count(DISTINCT se.session_id) filter(
            where
                se.event_type = 'add_to_cart'
        ) as add_to_cart_sessions
        ,count(DISTINCT se.session_id) filter(
            where
                se.event_type = 'begin_checkout'
        ) as begin_checkout_sessions
        ,count(DISTINCT se.session_id) filter(
            where
                se.event_type = 'purchase'
        ) as purchase_sessions
    from
    ecom.session_events se
    left join ecom.session_channels sc
        on se.session_id = sc.session_id
    where
        se.occurred_at >= date '2026-04-19'
    group by
        1
) 

-- Final Output
-- Calculates conversion rates between consecutive funnel stages
-- and the overall session-to-purchase conversion rate.
select
    ps.channel
    ,ps.sessions
    ,ps.product_view_sessions
    ,ps.add_to_cart_sessions
    ,ps.begin_checkout_sessions
    ,ps.purchase_sessions
    ,ps.add_to_cart_sessions * 1.0 / nullif(ps.product_view_sessions, 0) as view_to_cart_rate
    ,ps.begin_checkout_sessions * 1.0 / nullif(ps.add_to_cart_sessions, 0) as cart_to_checkout_rate
    ,ps.purchase_sessions * 1.0 / nullif(ps.begin_checkout_sessions, 0) as checkout_to_purchase_rate
    ,ps.purchase_sessions * 1.0 / nullif(ps.sessions, 0) as session_to_purchase_rate
from
    channels_per_session ps;

-- Funnel stage metrics are calculated in a single aggregation using
-- FILTER clauses to avoid row duplication from multiple joins.
-- Sessions before 2026-04-19 are excluded because event
-- instrumentation was not available before that date.
