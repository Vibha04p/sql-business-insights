Q1 - Daily Business Summary with DoD and Same-Weekday WoW

What the query does - The objective of this query is to monitor the business's daily performance by tracking revenue, refunds, order volume, Average Order Value (AOV), payment success, and cancellations, while comparing performance with the previous day and the same weekday of the previous week.

Pattern choice  - I created three CTEs to separate the order data, refund data, and the final business metrics, making the query easier to read and maintain. The final daily_metrics CTE performs all prerequisite calculations before the final output. DATE_TRUNC was used to aggregate data at a daily level, LAG was used to compare revenue with the previous day and the same weekday of the previous week, FILTER was used for conditional aggregations, and COALESCE/NULLIF ensured missing values and division operations were handled safely.

Business interpretation -  Revenue remained relatively strong during March and early April before declining through mid-April, May, and further into June. Order volumes peaked during April, which tapered down by June. However, the average AOV has been quite consistent. This suggests that customers continued spending a similar amount per order despite declining order volumes. Refunds have been higher during the periods of April and May, which could be because of a higher number of orders. The day-over-day and week-over-week comparisons also show a generally declining revenue trend. Since Average Order Value remained relatively stable, the decline appears to be driven more by lower order volumes than by customers spending less per order.

What I'd ask next: I would investigate why there were more sales in March and April, based on the reason of higher sales why Average Order Value remaining stable despite having higher sales. I'd track the reason for returns- is it just because the sales were higher which means higher returns, or was a particular category of product at fault? I'd also check why the weekly report trends negatively. I would investigate whether there was a consistent mix of products, pricing, or promotions that kept the AOV stable.

Q2 - Monthly Signup Cohort Retention

What the query does - The objective of this query is to measure how well customers acquired in a particular month are retained over the first three months after signing up. This helps evaluate customer retention and the quality of newly acquired customers over time.

Pattern choice  - I created a CTE named customer_first_order_month to ensure the retention analysis considered only customers with completed purchases rather than cancelled orders. I then created another CTE to calculate the required metrics, including cohort size and the number of customers retained in Months 1, 2, and 3. I used the month + interval '1 month' to compare customer activity across subsequent months, and CASE expressions in the final query to classify whether a customer was retained in each month.

Business interpretation - Cohort sizes in April and May were almost twice the size of those in March and June. Despite having a smaller cohort, March showed a higher retention rate than both April and May, suggesting that a larger cohort size does not necessarily lead to better retention. I also observed that retention declined with each passing month, with the highest retention occurring in Month 1. Since the later cohorts have not yet completed three months, I can only compare the retention rates for the periods where data is available.

What I'd ask next: I would investigate why the signups were higher in April and May, the quality of the customer, and whether there was a promotion. Pricing strategy? Were there any repeat customers signing up from the same medium for offers or inaugural deals?. I'd further investigate and find out if the origin of the signups in March was the reason for the higher retention rate.

Q3 - Funnel Conversion by Acquisition Channel
What the query does - The objective of this query is to identify where customers drop off in the purchase funnel and compare how efficiently each acquisition channel moves customers from one stage to the next. This helps identify where the business is losing potential customers during the purchase journey and measure the conversion rate at each stage of the funnel.

Pattern choice  -I created a CTE named channels_per_session to aggregate the number of distinct session IDs by acquisition channel, classifying sessions with no attribution as direct while calculating the number of product view, add-to-cart, begin-checkout, and purchase sessions. I used COUNT(DISTINCT session_id) FILTER (...) to calculate all funnel stages in a single pass over session_events, avoiding multiple joins and preventing row duplication. A single LEFT JOIN to session_channels was used to assign each session to its acquisition channel. The final SELECT uses these metrics to calculate the conversion rate at each stage of the funnel.

Business interpretation - Organic generated the highest number of sessions, followed by Paid, Referral, Email, Affiliate, and Direct. The view-to-cart and cart-to-checkout conversion rates remained remarkably consistent across all acquisition channels, with Direct being the only noticeable exception; Checkout-to-purchase and overall session-to-purchase conversion rates also showed very little variation across channels, with Email recording the highest checkout-to-purchase conversion rate. Further investigation is required to understand why the conversion rates are so similar across acquisition channels.

What I'd ask next: Why are funnel conversion rates so similar across acquisition channels? Is this because customers behave similarly after entering the funnel, or because the website experience is consistent across all acquisition channels? 

Q4- Top Products by Net Revenue (After Refunds)
What the query does - The objective of this query is to identify the products generating the highest net revenue after accounting for refunds. It also compares product performance across categories using gross revenue, units sold, returns, refund amounts, and net revenue. This helps identify high-performing products as well as products that may require further investigation due to high returns or low net revenue.

Pattern choice  - I created four CTEs: product_revenue, product_returns, order_return_qty, and product_refunds to separate revenue, returns, and refund calculations into independent steps, preventing double counting and improving readability. product_revenue calculates revenue, orders, and units sold for paid orders. product_returns aggregates returned quantities by product, while order_return_qty calculates the total returned quantity for each order so that order-level refunds can be allocated proportionally among returned products. product_refunds calculates refund amounts for each product. The final SELECT combines these metrics to calculate return rate and net revenue.

Business interpretation -The products are ranked by gross revenue, allowing us to compare revenue generation, returns, refunds, and net revenue across products. The table also highlights products with no returns as well as those with the highest return volumes.
The data does not show a direct relationship between units sold and returns. Higher sales do not necessarily result in proportionally higher return volumes. A few products belonging to categories such as Kitchen, Shoes, Makeup, and Decor have very low or even negative net revenue after refunds.
Categories such as Kitchen, Makeup, Shoes, Skincare, and Tops recorded very few returns during the analysis period. The reason cannot be determined from this dataset alone.
Products in the Smartwatch, Speakers, and Headphones categories generate a substantial portion of total revenue and also account for higher refund amounts. This is likely influenced by their higher sales volume rather than unusually high return rates. The sales volume of these categories is also considerably higher than categories such as Kitchen, Makeup, Shoes, Skincare, and Haircare, which contribute relatively less revenue overall.

What I'd ask next: Which products have both high sales volume and high return volume, and are the returns associated with product quality, shipping issues, incorrect sizing, or customer expectations? Why do some products record no returns? Is it because these products are non-returnable, or because customers are genuinely satisfied with them?Why do a few products generate negative net revenue? Although their contribution to overall revenue is small, understanding the underlying cause could help reduce future losses.

Q5- Category Health: Purchases → Returns
What the query does - The objective of this query is to understand category-wise performance by analysing sales, sales volume, returns, and refunds. It helps identify which categories generate the highest revenue, which have the highest sales volume, and which experience the most returns. The query also calculates the return_rate_pct to understand the proportion of returned units for each category.

Pattern choice  - I created two CTEs: category_sales (paid orders) and category_returns, by joining the required tables to calculate sales and returns separately. Separating these calculations improves readability and prevents double counting. The final SELECT combines the information from both CTEs to calculate the return_rate_pct and present all category-level performance metrics in one place.

Business interpretation - The data does not show a direct relationship between sales revenue and returns, indicating that higher revenue does not necessarily result in higher return rates. Smartwatches, Headphones, and Speakers generate the highest revenue, followed by Jackets and the remaining categories.
Skincare records the highest number of units sold but contributes relatively low revenue, suggesting that products in this category are lower priced compared to the top revenue-generating categories. Similarly, Haircare contributes one of the lowest revenues despite having comparatively high sales volume.
The Accessories category records the highest number of returns, which is likely influenced by its higher sales volume. However, the return_rate_pct does not appear to be directly influenced by category revenue, as categories generating higher revenue have return rates comparable to several lower-revenue categories.

What I'd ask next: Why do some low-revenue categories have relatively high return rates?
How can revenue be increased in the lower-performing categories without increasing return rates?
Why do high-value product categories such as Smartwatches, Headphones, and Speakers maintain relatively stable return rates despite generating the highest revenue?

Q6- Payment Failure Analysis (Method × Top Error Code)
What the query does - The objective of this query is to analyse payment methods and their failure rates along with the most common error codes and error messages. It helps identify which payment methods experience the highest number of failures and the primary reasons behind those failures. This analysis can help the business identify areas where the payment process can be improved.

Pattern choice  - I created three CTEs: payments, failed_order_details, and errors. The payments CTE calculates the total payment attempts for each payment method, while failed_order_details filters failed payment attempts and captures the associated error details. In the errors CTE, I used the ROW_NUMBER() window function partitioned by payment_method to rank error codes based on their frequency within each payment method. The final SELECT combines these CTEs and calculates the top_error_share_of_failures, allowing us to identify the most common failure reason for each payment method.

Business interpretation - Card has the highest number of payment attempts but not the highest number of failures. Although UPI has the second-highest number of payment attempts, it records the highest number of failures. There is a significant gap between the number of attempts made through Card and UPI compared to the remaining payment methods.
Netbanking records the highest top_error_share_of_failures, indicating that a single error code contributes to a large proportion of its payment failures.
The most common error code for Card payments is FRAUD. This suggests that the business should investigate whether these are genuine fraudulent transactions or false positives, as incorrectly blocked transactions could lead to lost sales.
For UPI, the most common error is UPI_TIMEOUT. Since this appears to be a gateway or system-related issue rather than a customer action, further investigation is required to determine whether timeout settings or gateway performance can be improved to reduce payment failures.
COD also records UPI_TIMEOUT as its top error code. This is an unexpected observation and requires further investigation, as the available data does not provide enough information to explain why this error appears for Cash on Delivery.

What I'd ask next: Why does COD have UPI_TIMEOUT as its most common error code?
What other error codes contribute significantly to payment failures apart from the top-ranked error?
Why does the Wallet payment method show BANK_DECLINED as its top error? Is it primarily due to insufficient balance, bank-side issues, or technical problems?
Are certain payment methods more likely to fail during specific times of the day or during peak traffic periods?


Q7 – Delivery SLA Breach by Carrier × Shipping Method
What the query does - The objective of this query is to understand which carriers and shipping methods are meeting or missing their delivery SLAs and by how many days. It also helps identify the median delivery time and the 90th percentile (p90_delivery_days) for each carrier and shipping method. This provides an overview of delivery performance and helps identify carriers or shipping methods that require operational improvements.

Pattern choice  - I created two CTEs: carrier_orders and shipment_details. The carrier_orders CTE calculates the shipping method, carrier, and the count of delivered orders while filtering out records with NULL values. The shipment_details CTE calculates the delivery duration by subtracting the shipped date from the delivered date. The final SELECT combines these CTEs to calculate the average delivery days, median delivery days, and the p90_delivery_days using the PERCENTILE_CONT window function. It also filters deliveries that took more than five days and calculates the number of late deliveries for each carrier and shipping method.

Business interpretation - EcomExpress completed the highest number of deliveries, followed by Delhivery and BlueDart. Although there is no significant difference in the total number of deliveries handled by each carrier, EcomExpress records the highest number of SLA breaches across most shipping methods.
The median delivery time for EcomExpress is 4 days across all shipping methods, whereas Delhivery and BlueDart have a median delivery time of 3 days. Based on the available data, Delhivery appears to be the best-performing carrier across shipping methods, followed by BlueDart and then EcomExpress.
While the higher number of deliveries handled by EcomExpress may contribute to the higher number of late deliveries, the difference in delivery volume between the carriers is not substantial enough to fully explain the gap. This suggests that other operational factors may also be contributing to the higher SLA breach count.
It can also be observed that Standard Shipping through EcomExpress records fewer late deliveries than its Express and Same-Day shipping services. A similar pattern is visible for Delhivery and BlueDart, indicating that Standard Shipping performs more consistently across all three carriers.

What I'd ask next: Why does EcomExpress record significantly more late deliveries than the other carriers?
Why does Standard Shipping consistently record fewer SLA breaches across all three carriers? Is this due to more realistic delivery commitments or better operational performance?
Why do Express and Same-Day shipping show comparatively higher late delivery counts despite having shorter delivery commitments?
Are the SLA breaches concentrated in specific regions, warehouses, or time periods?

Q8 - Customer Lifetime Value (LTV) + Bucket Share of Revenue
What the query does - The objective of this query is to calculate the Lifetime Value (LTV) of customers to identify the most valuable customers and categorize them into different spending buckets. This helps us understand how much each customer segment contributes to the overall revenue and identify the customer groups that drive the business.

Pattern choice  -I created two CTEs: customer_metrics and buckets. The customer_metrics CTE calculates customer-level metrics such as first order date, last order date, total orders, Average Order Value (AOV), and total revenue generated by each customer. Cancelled orders were excluded to ensure that only completed purchases contributed to the calculations. The buckets CTE categorizes customers into different LTV buckets using a CASE WHEN statement based on the revenue they generated. The final SELECT combines these details and calculates the ltv_bucket_share_of_revenue.

Business interpretation - Out of 8,438 customers, 3,349 customers fall into the ₹20,000+ bucket, 498 customers fall into the ₹0–999 bucket, 2,047 customers fall into the ₹1,000–4,999 bucket, and 2,544 customers fall into the ₹5,000–20,000 bucket.
The ₹0–999 bucket contains the smallest number of customers, and many of them have placed only a single order. A similar pattern is observed in the ₹1,000–4,999 bucket, where many customers also have only one recorded purchase.
Customers in the ₹5,000–20,000 bucket show a mix of single-order and repeat customers, with order counts ranging from 1 to 8. Based on the available data, it cannot be concluded that all customers in this bucket are long-term customers, as some have relatively few orders.
Customers in the ₹20,000+ bucket represent the largest customer segment and contribute approximately 0.88 of the ltv_bucket_share_of_revenue. Many customers in this bucket have placed multiple orders, with order counts ranging from 6 to 168, indicating that repeat purchasing behaviour contributes significantly to the overall revenue.

What I'd ask next: What strategies can be implemented to increase revenue from customers in the lower LTV buckets?
Why do many customers in the lower LTV buckets make only one purchase? Are there opportunities to improve customer retention through loyalty programs, follow-up campaigns, or personalized offers?
What factors encourage customers in the ₹20,000+ bucket to make repeat purchases, and can those strategies be applied to customers in the lower LTV buckets?
Did any promotions, membership benefits, or marketing campaigns contribute to the high repeat purchase behaviour observed in the highest LTV bucket?
Why did the other bucket share people disappear after the first order? Are we giving out first order discount/benefits?

Q9- Repeat Purchase Interval

What the query does - The objective of this query is to understand how many customers return to place another order and the average, median, and 90th percentile (p90_days_to_next_order) of the time they take to come back. This helps us understand customer repeat purchase behaviour and estimate an appropriate time to send a win-back email to customers who have not returned.

Pattern choice  - I wrote two versions of the query: one including same-day repeat orders and another excluding them. I created a CTE named customer_order_date, where I collated all the customer order details and calculated the next order date using the LEAD() window function. I used PERCENTILE_CONT() to calculate the median and 90th percentile of the repeat purchase interval and filtered out records where the next order date was NULL, as those customers did not have a repeat purchase. The second query follows the same approach but additionally filters records using days_to_next_order > INTERVAL '0 days' to exclude same-day repeat orders.

Business interpretation - The summary metrics remained identical because the dataset contains no same-day repeat purchases (days_to_next_order = 0). Therefore, excluding same-day repeat orders does not affect the analysis for this dataset.
The results show that the median time to the next purchase is approximately 1 day, indicating that at least half of the repeat customers return within a very short period. The 90th percentile is approximately 19 days, which means that 90% of repeat purchases occur within this time frame.
Based on this analysis, the business could consider sending win-back emails after the p90_days_to_next_order period, as customers who have not returned by then are less likely to come back without additional engagement.

What I'd ask next: Why do some customers take significantly longer to return compared to those who repurchase within the first two days?
Is there a seasonal or periodic pattern in repeat purchases?

Q10- Attribution Comparison: First-Touch vs Last-Touch Revenue by Channel

What the query does - The objective of this query is to compare first-touch and last-touch attribution to understand which marketing channels introduce customers to the business and which channels drive conversions. The report provides the marketing channel, revenue generated, number of orders, and share of total revenue under both attribution models.

Pattern choice  - I wrote four CTEs: order_sessions, touched_orders, first_touch, and last_touch.
order_sessions maps orders to their corresponding sessions. touched_orders combines order, session, and attribution information while excluding cancelled orders. The first_touch CTE assigns a rank using the ROW_NUMBER() window function, ordered by touched_at in ascending order so that the earliest marketing touch receives rank 1. Similarly, the last_touch CTE ranks touches in descending order so that the latest marketing touch receives rank 1.
In the final query, I selected only records with rn = 1 from both attribution models, combined the results using UNION ALL, categorised them using the attribution_model column, replaced NULL channels with Direct using COALESCE(), and calculated each channel's share of total revenue.

Business interpretation -The first-touch and last-touch attribution models produced identical results across all channels. Revenue, number of orders, and share of revenue remained the same for both attribution models, indicating that the first and last recorded marketing touch belonged to the same channel for every order in this dataset.
Among all channels, Direct generated the highest revenue and the largest share of revenue, followed by Organic, Paid, Referral, Email, and Affiliate.
Since both attribution models produced identical results, this analysis does not identify separate channels responsible for customer acquisition and conversion. This suggests that the dataset either records a single attribution touch per order or does not capture multi-touch customer journeys.

What I'd ask next: Why does every order have the same first-touch and last-touch channel? Is the attribution data limited to a single touchpoint?
Why does the Paid channel contribute less revenue than Direct and Organic despite marketing investment?
What strategies can further strengthen Direct and Organic traffic?
Can improvements in Email, Referral, or Affiliate campaigns increase their contribution to revenue?
What the query does - The objective of this query is 

