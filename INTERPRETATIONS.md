Q7 – Delivery SLA Breach by Carrier × Shipping Method
Business Question

Which shipping carriers and shipping methods are meeting the 5-day delivery SLA, and which combinations have the highest percentage of late deliveries?

SQL Pattern Used

Multiple CTEs, aggregate functions, PERCENTILE_CONT() for median and 90th percentile calculations, FILTER clause for conditional aggregation, and joins across shipment, carrier, and shipping method tables.

Interpretation

This analysis evaluates delivery performance by carrier and shipping method using a 5-day delivery SLA. For each carrier and shipping method combination, it calculates the average delivery time, median delivery time, 90th percentile delivery time, number of late deliveries, and late delivery rate.

The use of the 90th percentile helps identify worst-case delivery performance that may not be visible from the average alone. While average delivery times remained lower than the 90th percentile across all groups, the late delivery rate highlighted the proportion of shipments exceeding the SLA.

As part of the analysis, shipments with delivered_at IS NULL were excluded because they are still in transit and cannot be evaluated against the SLA. A separate data quality check confirmed that no shipments had shipped_at later than delivered_at, indicating there were no obvious timestamp inconsistencies in the shipment data.

What I'd Investigate Next

I would investigate whether late deliveries are concentrated within specific regions, warehouses, or product categories rather than carrier performance alone. Understanding these underlying factors would help determine whether SLA breaches are caused by logistics partners, operational bottlenecks, or fulfilment delays.

Q8 – Customer Lifetime Value (LTV) + Bucket Share of Revenue
Business Question

Who are the highest-value customers, and what share of total revenue does each LTV bucket contribute?

SQL Pattern Used

CTEs, CASE WHEN for LTV bucketing, window functions SUM() OVER) to calculate each bucket's share of total revenue, and aggregate functions (SUM, COUNT, MIN, MAX).

Interpretation

This analysis calculates the lifetime value (LTV) of every customer based on their total revenue from non-cancelled orders. Customers are grouped into four LTV buckets (0–999, 1000–4999, 5000–19999, and 20000+) to understand how revenue is distributed across different customer segments.

The analysis showed that the ₹20,000+ LTV bucket contributed approximately 88% of total revenue, indicating that a relatively small group of high-value customers generates the majority of the business's revenue. This suggests that customer retention and loyalty initiatives targeting these customers could have a significant impact on overall revenue.

The window function was used to calculate each bucket's share of total revenue, allowing customer-level metrics and bucket-level insights to be presented in the same result set.

What I'd Investigate Next

I would analyse the characteristics of high-LTV customers by comparing their acquisition channels, purchase frequency, product preferences, and repeat purchase behaviour. Understanding what differentiates these customers would help design targeted retention campaigns and identify opportunities to move lower-value customers into higher-value segments

Q9 – Repeat Purchase Interval
Business Question

How long does it take for a customer to place another order, and when should the business consider sending a win-back email?

SQL Pattern Used

CTE, LEAD() window function, PERCENTILE_CONT() for median and 90th percentile, aggregate functions.

Interpretation

I calculated the repeat purchase interval in two ways: one including same-day repeat orders and another excluding them.

For lifecycle marketing, I would use the version excluding same-day repeat orders, because multiple orders placed on the same day are more likely to represent purchases made within the same shopping session rather than a customer returning after leaving. Excluding these near-zero intervals provides a more realistic estimate of customer return behaviour and helps determine a more appropriate timing for win-back email campaigns.
What I'd investigate next

I would segment repeat purchase intervals by acquisition channel, customer lifecycle stage, and product category to determine whether different customer segments require different win-back timings instead of using a single reminder schedule for everyone.

Q10 – Attribution Comparison: First-Touch vs Last-Touch Revenue by Channel

Business Question
Does our marketing channel mix look different under first-touch and last-touch attribution? Which channels are responsible for introducing customers versus driving the final conversion?

SQL Pattern Used
Multiple CTEs, row_number() window function, Union all, COALESCE, window aggregation for revenue share.

Interpretation
This analysis compares two attribution models by assigning each order's revenue to either the first marketing touch or the last marketing touch before purchase. First-touch attribution identifies channels that are effective at acquiring customers, while last-touch attribution highlights channels that are more effective at converting customers into buyers. Orders without any recorded marketing touch are classified as 'direct' to ensure no revenue is lost.

As expected, the total revenue under both attribution models exactly matched the total non-cancelled order revenue, confirming that attribution redistributes revenue across channels rather than changing the total revenue.

What I'd investigate next
I would compare the revenue share of each marketing channel under both attribution models to identify channels that primarily generate awareness versus those that consistently drive conversions. This insight could help optimize marketing budget allocation across acquisition and conversion campaigns.
