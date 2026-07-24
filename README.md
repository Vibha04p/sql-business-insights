# SQL Business Insights

## Project Overview

This project analyses an e-commerce dataset using PostgreSQL to answer ten business questions across sales, customer behaviour, marketing, operations, payments, retention, and customer lifetime value. The goal was to move beyond writing SQL queries and generate actionable business insights that can support data-driven decision-making.

---

## Executive Summary

This project analyses an e-commerce dataset using PostgreSQL to answer ten business questions covering sales, customer behaviour, marketing, payments, operations, and logistics. The objective was to use SQL to identify business trends, measure performance, and generate actionable recommendations that support data-driven decision-making.

### Key Findings

- Revenue declined because order volume decreased while average order value remained relatively stable, indicating that growth depends on increasing customer acquisition and repeat purchases.
- Customers in the ₹20,000+ lifetime value bucket contribute the majority of total revenue, highlighting the importance of customer retention and loyalty.
- Organic and Direct channels generated the highest revenue, while Email showed the strongest checkout-to-purchase conversion, suggesting opportunities to optimise marketing investments.
- Delivery performance varied across carriers, and payment failures showed recurring error patterns across payment methods, highlighting opportunities to improve operational efficiency and customer experience.

## Query Summary

| Query | SQL File                                                                                                                                                               | Stakeholder         | Business Question                                                                         | SQL Concepts Used                                         |
| ----- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------- | ----------------------------------------------------------------------------------------- | --------------------------------------------------------- |
| Q1    | [01_daily_business_summary.sql](https://github.com/Vibha04p/sql-business-insights/blob/main/queries/01_daily_business_summary.sql)                                     | CEO / Business Head | How is the business performing daily and compared to previous periods?                    | CTEs, Window Functions, Conditional Aggregation           |
| Q2    | [02_monthly_signup_cohort_retention.sql](https://github.com/Vibha04p/sql-business-insights/blob/main/queries/02_monthly_signup_cohort_retention.sql)                   | Growth / CRM        | How well are customers retained after signing up?                                         | Cohort Analysis, Date Arithmetic, Conditional Aggregation |
| Q3    | [03_funnel_conversion_by_acquisition_channel.sql](https://github.com/Vibha04p/sql-business-insights/blob/main/queries/03_funnel_conversion_by_acquisition_channel.sql) | CMO                 | Where do customers drop off in the conversion funnel?                                     | FILTER clause, Conditional Aggregation, CTEs              |
| Q4    | [04_top_products_net_revenue.sql](https://github.com/Vibha04p/sql-business-insights/blob/main/queries/04_top_products_net_revenue.sql)                                 | Merchandising       | Which products generate the highest net revenue after refunds?                            | CTEs, Proportional Refund Allocation, Aggregations        |
| Q5    | [05_category_health.sql](https://github.com/Vibha04p/sql-business-insights/blob/main/queries/05_category_health.sql)                                                   | Category Manager    | Which product categories generate the highest revenue and experience the most returns?    | Joins, Conditional Aggregation, Window Functions          |
| Q6    | [06_payment_failure_analysis.sql](https://github.com/Vibha04p/sql-business-insights/blob/main/queries/06_payment_failure_analysis.sql)                                 | Payments Team       | Which payment methods fail the most and what are the most common failure reasons?         | CTEs, `ROW_NUMBER()`, Aggregations                        |
| Q7    | [07_delivery_sla_breach.sql](https://github.com/Vibha04p/sql-business-insights/blob/main/queries/07_delivery_sla_breach.sql)                                           | Operations          | Which carriers are missing delivery SLAs?                                                 | Percentiles, Date Arithmetic, Aggregations                |
| Q8    | [08_customer_lifetime_value.sql](https://github.com/Vibha04p/sql-business-insights/blob/main/queries/08_customer_lifetime_value.sql)                                   | CRM / Marketing     | Who are the highest-value customers and how much revenue does each LTV bucket contribute? | Window Functions, CASE Expressions, Aggregations          |
| Q9    | [09_repeat_purchase_interval.sql](https://github.com/Vibha04p/sql-business-insights/blob/main/queries/09_repeat_purchase_interval.sql)                                 | Retention Team      | How long does it take customers to place another order?                                   | `LEAD()`, Date Arithmetic, Window Functions               |
| Q10   | [10_attribution_comparison.sql](https://github.com/Vibha04p/sql-business-insights/blob/main/queries/10_attribution_comparison.sql)                                     | Marketing           | How does revenue differ under first-touch and last-touch attribution models?              | CTEs, Window Functions, Conditional Aggregation           |

## Sample Dashboards

The following dashboards highlight a few of the key analyses performed during this project. Interactive versions are available in the shared Metabase collection.

### Daily Business Summary (Q1)

![Daily Business Summary](images/q1_daily_business_summary.png)

*Tracks daily revenue, order volume, average order value, and period-over-period performance.*

---

### Delivery SLA Breach Analysis (Q7)

![Delivery SLA Breach Analysis](images/q7_delivery_sla_breach.png)

*Compares carrier performance, delivery timelines, and SLA compliance to identify operational bottlenecks.*

---

### Customer Lifetime Value Analysis (Q8)

![Customer Lifetime Value](images/q8_customer_lifetime_value.png)

*Segments customers by lifetime value to understand revenue contribution and support retention strategies.*


## Repository Structure

```
queries/
│── 01_daily_business_summary.sql
│── 02_monthly_signup_cohort_retention.sql
│── 03_funnel_conversion_by_acquisition_channel.sql
│── 04_top_products_net_revenue.sql
│── 05_category_health.sql
│── 06_payment_failure_analysis.sql
│── 07_delivery_sla_breach.sql
│── 08_customer_ltv.sql
│── 09_repeat_purchase_interval.sql
│── 10_attribution_comparison.sql

notes/
│── ecom_schema.md

INTERPRETATIONS.md
README.md
case_study_link.md
```

---

## Business Questions Answered

- Daily business performance
- Monthly customer retention
- Marketing funnel conversion
- Product profitability after refunds
- Category performance
- Payment failures
- Delivery SLA performance
- Customer lifetime value
- Repeat purchase behaviour
- Marketing attribution

---

## Tech Stack

- PostgreSQL
- Metabase
- GitHub
- Notion

---

## How to Run

The SQL queries were written for the internal Metabase environment using the ecom PostgreSQL schema. Each query can be executed independently in Metabase or any PostgreSQL environment containing the same schema. The queries are designed to answer specific business questions and can be run individually without dependencies on one another.

---

## Notion Case Study

🔗https://acidic-green-d92.notion.site/What-10-SQL-Queries-Told-Me-About-This-Business-3a46d0d6f119809e9a99d09eaab56736?pvs=143

---

## LinkedIn

🔗 https://www.linkedin.com/in/vibha-p/

---

## Reflection

Working on this project strengthened both my SQL skills and my ability to think like a business analyst. I became more confident using CTEs, window functions, conditional aggregation, and percentile calculations to solve real business problems. More importantly, I learned to translate SQL outputs into actionable insights rather than simply reporting numbers. I also gained experience validating results through sanity checks and documenting assumptions. If I continued this project, I would explore customer segmentation, predictive modelling, and operational optimisation using additional datasets.
