-- Q7: Delivery SLA Breach by Carrier and Shipping Method
-- Business Question: Which carriers are missing the 5-day delivery SLA, and by how much?
-- Owner: Vibha P | Last updated:2026-07-10
-- Sanity check:
-- 1. avg_delivery_days should be less than or equal to p90_delivery_days.
-- 2. late_rate should be between 0 and 1.
-- 3. Delivered orders should have delivered_at >= shipped_at.

with carrier_orders as (
    SELECT
        c.carrier_name as carrier
        , sm.method_name as shipping_method
        , count(s.order_id) as delivered_orders
    from
        ecom.shipping_methods sm
        inner join ecom.shipments s on sm.shipping_method_id = s.shipping_method_id
        inner join ecom.shipping_carriers c on s.carrier_id = c.carrier_id
    WHERE
        delivered_at IS NOT NULL
    group by
        c.carrier_id
        , c.carrier_name
        , sm.method_name
)
, shipment_details as(
    SELECT
        c.carrier_name as carrier
        , sm.method_name as shipping_method
        , (s.delivered_at :: date - s.shipped_at :: date) as delivery_days
    from
        ecom.shipping_methods sm
        inner join ecom.shipments s on sm.shipping_method_id = s.shipping_method_id
        inner join ecom.shipping_carriers c on s.carrier_id = c.carrier_id
    WHERE
        delivered_at IS NOT NULL
)
select
    co.carrier
    , co.shipping_method
    , co.delivered_orders
    , avg(sd.delivery_days) as average_delivery_days
    , PERCENTILE_CONT(0.5) WITHIN GROUP (
        ORDER BY
            sd.delivery_days
    ) as median_delivery_days
    , PERCENTILE_CONT(0.9) WITHIN GROUP (
        ORDER BY
            sd.delivery_days
    ) as p90_delivery_days
    , COUNT(*) FILTER(
        where
            delivery_days > 5
    ) as late_deliveries
    ,COUNT(*) FILTER (
        WHERE
            delivery_days > 5
    ) * 1.0 / COUNT(*) as late_rate
from
    carrier_orders co
    left join shipment_details sd on co.shipping_method = sd.shipping_method
    AND co.carrier = sd.carrier
group by
    co.carrier
    , co.shipping_method
    , co.delivered_orders;

--No shipments were found where shipped_at > delivered_at, indicating no obvious timestamp inconsistencies.
SELECT
    COUNT(*)
FROM ecom.shipments
WHERE shipped_at > delivered_at;
