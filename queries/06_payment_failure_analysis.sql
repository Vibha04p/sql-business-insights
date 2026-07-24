-- Q6: Payment Failure Analysis
-- Business Question: Which payment methods fail the most, and what are the most common failure reasons?
-- Owner: Vibha P | Last updated: 2026-06-13
-- Sanity check:
-- 1. failure_rate should be between 0 and 1.
-- 2. top_error_share_of_failures should be between 0 and 1.

with payments as (
    select
        p.method_name as payment_method
        , COUNT(pi.order_id) as attempts
        ,COUNT(pi.order_id) filter(
            where
                lower(pi.status) = 'failed'
        ) as failures,
        COALESCE(
            COUNT(pi.order_id) filter(
                where
                    lower(pi.status) = 'failed'
            ),
            0
        ) * 1.0 / NULLIF(COUNT(pi.order_id), 0) as failure_rate
    from
        ecom.payment_intents pi
        left join ecom.payment_methods p on pi.payment_method_id = p.payment_method_id
    group by
        p.payment_method_id
        , p.method_name
)
, errors as(
    SELECT
        p.method_name AS payment_method
        , pt.error_code
        , pt.error_message
        , COUNT(pt.error_code) AS error_count
        , ROW_NUMBER() OVER (
            PARTITION BY p.method_name
            ORDER BY
                COUNT(pt.error_code) DESC
        ) AS rn
    FROM
        ecom.payment_transactions pt
        LEFT JOIN ecom.payment_intents pi ON pt.payment_intent_id = pi.payment_intent_id
        LEFT JOIN ecom.payment_methods p ON pi.payment_method_id = p.payment_method_id
    GROUP BY
        p.method_name
        , pt.error_code
        , pt.error_message
)
, ranked_orders as (
    SELECT
        *
    FROM
        errors
    WHERE
        rn = 1
)
SELECT
    py.payment_method
    , py.attempts
    , py.failures
    , py.failure_rate
    , ro.error_code as top_error_code
    , ro.error_message as top_error_message
    , COALESCE(ro.error_count, 0) * 1.0 / NULLIF(py.failures, 0) as top_error_share_of_failures
FROM
    payments py
    left join ranked_orders ro on py.payment_method = ro.payment_method;
