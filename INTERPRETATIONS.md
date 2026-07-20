## Q3 — Funnel Conversion by Acquisition Channel

**What the query does (1 sentence):** Aggregates sessions through the
product-view → ATC → checkout → purchase funnel, split by acquisition channel.

**Pattern choice (1-2 sentences):** Used `count(distinct session_id) filter
(where ...)` per stage rather than 5 left joins — cleaner SQL, no row
explosion, single pass over `session_events`.

**Business interpretation (2-3 sentences):** Organic search has the highest
session-to-purchase rate at 4.2%, but paid social drives 3x the absolute
revenue despite a 1.1% rate — volume beats efficiency at the current spend
level. The "unknown" channel is 18% of sessions and 14% of revenue, which
means attribution is broken on roughly 1 in 6 orders.

**What I'd ask next:** Is the paid-social rate dropping over time? A stable
low rate is a CAC problem; a falling rate is a creative-fatigue problem.
```
Q1 - Daily Business Summary with DoD and Same-Weekday WoW

What the query does - The objective of this query is to monitor the business's daily performance by tracking revenue, refunds, order volume, Average Order Value (AOV), payment success, and cancellations, while comparing performance with the previous day and the same weekday of the previous week.

Pattern choice  - I created three CTEs to separate the order data, refund data, and the final business metrics, making the query easier to read and maintain. The final daily_metrics CTE performs all prerequisite calculations before the final output. DATE_TRUNC was used to aggregate data at a daily level, LAG was used to compare revenue with the previous day and the same weekday of the previous week, FILTER was used for conditional aggregations, and COALESCE/NULLIF ensured missing values and division operations were handled safely.

Business interpretation -  Revenue remained relatively strong during March and early April before declining through mid-April, May, and further into June. Order volumes peaked during April, which tapered down by June. However, the average AOV has been quite consistent. This suggests that customers continued spending a similar amount per order despite declining order volumes. Refunds have been higher during the periods of April and May, which could be because of higher sales rather than declining product quality. The day-over-day and week-over-week comparisons also show a generally declining revenue trend. Since Average Order Value remained relatively stable, the decline appears to be driven more by lower order volumes than by customers spending less per order.

What I'd ask next: I would investigate why there were more sales in March and April, and why Average Order Value remained stable despite declining revenue. I'd track the reason for returns- is it just because the sales were higher, higher returns, or was a particular category of product at fault? I'd also check why the weekly report trends negatively. I would investigate whether there was a consistent mix of products, pricing, or promotions that kept the AOV stable.

Q2 - Monthly Signup Cohort Retention

What the query does - The objective of this query is to measure how well customers acquired in a particular month are retained over the first three months after signing up. This helps evaluate customer retention and the quality of newly acquired customers over time.

Pattern choice  - I created a CTE named customer_first_order_month to ensure the retention analysis considered only customers with completed purchases rather than cancelled orders. I then created another CTE to calculate the required metrics, including cohort size and the number of customers retained in Months 1, 2, and 3. I used the month + interval '1 month' to compare customer activity across subsequent months, and CASE expressions in the final query to classify whether a customer was retained in each month.

Business interpretation - Cohort sizes in April and May were almost twice the size of those in March and June. Despite having a smaller cohort, March showed a higher retention rate than both April and May, suggesting that a larger cohort size does not necessarily lead to better retention. I also observed that retention declined with each passing month, with the highest retention occurring in Month 1. Since the later cohorts have not yet completed three months, I can only compare the retention rates for the periods where data is available.

What I'd ask next: I would investigate why the signups were higher in April and May, the quality of the customer, and whether there was a promotion. Pricing strategy? Were there any repeat customers signing up from the same medium for offers or inaugural deals?. I'd further investigate and find out if the origin of the signups in March was the reason for the higher retention rate.

Q3 - Funnel Conversion by Acquisition Channel
What the query does - The objective of this query is to find out exactly at what point in the view-to-purchase process the business is losing customers. This helps evaluate where the business is losing the interest of the customer and to find out at what rate we are losing/gaining customers.
Pattern choice  - I created a CTE named channels_per_session to filter out and categorize the number of distinct session_ids into direct if it has no value,product_view_sessions, add_to_cart_sessions,begin_checkout_sessions,purchase_sessions. The final select I used all of the above to keep it less cluttered and calculated the rate of each session conversion.
Business interpretation - The business has maximum customers through the organic channel followed by paid, referral,email, affiliate and direct respectively. view_to_cart_rate and cart_to_checkout_rate has been constant over all the mediums except for direct, checkout_to_purchase_rate has very low deviation with email being the highest. session_to_purchase_rate also shows the same trend as checkout_to_purchase_rate.
What I'd ask next: How is the conversion rate similar for every session?
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
