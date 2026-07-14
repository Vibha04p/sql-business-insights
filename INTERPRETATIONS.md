# Q10 – Attribution Comparison: First-Touch vs Last-Touch Revenue by Channel

## Business Question
Does our marketing channel mix look different under first-touch and last-touch attribution? Which channels are responsible for introducing customers versus driving the final conversion?

## SQL Pattern Used
Multiple CTEs, row_number() window function, Union all, COALESCE, window aggregation for revenue share.

## Interpretation
This analysis compares two attribution models by assigning each order's revenue to either the first marketing touch or the last marketing touch before purchase. First-touch attribution identifies channels that are effective at acquiring customers, while last-touch attribution highlights channels that are more effective at converting customers into buyers. Orders without any recorded marketing touch are classified as 'direct' to ensure no revenue is lost.

As expected, the total revenue under both attribution models exactly matched the total non-cancelled order revenue, confirming that attribution redistributes revenue across channels rather than changing the total revenue.

## What I'd investigate next
I would compare the revenue share of each marketing channel under both attribution models to identify channels that primarily generate awareness versus those that consistently drive conversions. This insight could help optimize marketing budget allocation across acquisition and conversion campaigns.
