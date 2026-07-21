# SQL Business Insights

## Project Overview

This project analyses an e-commerce dataset using PostgreSQL to answer ten business questions across sales, customer behaviour, marketing, operations, payments, retention, and customer lifetime value. The goal was to move beyond writing SQL queries and generate actionable business insights that can support data-driven decision-making.

---

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
