**Block 1 — Inventory:**

```sql
select table_name, column_name, data_type, is_nullable, column_default
from information_schema.columns
where table_schema = 'ecom'
order by table_name, ordinal_position;
```
There are 48 total tables in ecom.  
Datatypes used:
| Data Type                  | Description                                    | Example                                             |
| -------------------------- | ---------------------------------------------- | --------------------------------------------------- |
| `bigint`                   | Large integer, typically used for IDs          | `customer_id`, `order_id`, `product_id`             |
| `integer`                  | Whole numbers                                  | `qty`, `position`, `rating`, `max_uses`             |
| `text`                     | Variable-length text                           | `first_name`, `status`, `city`, `sku`               |
| `numeric`                  | Decimal numbers                                | `price`, `discount`, `amount`, `budget`             |
| `boolean`                  | True/False values                              | `is_active`, `is_control`, `marketing_opt_in`       |
| `date`                     | Date only (no time)                            | `dob`                                               |
| `timestamp with time zone` | Date and time with timezone information        | `created_at`, `updated_at`, `starts_at`, `txn_time` |

I have never used these before

| `uuid`                     | **Universally Unique Identifier**                  | `session_id`, `cart_id`, `anonymous_id`             |
| `jsonb`                    | JSON data stored in binary format (PostgreSQL) | `attributes`                                        |
| `inet`                     | IP address data type (PostgreSQL)              | `ip_address`                                        |


# Table Name: attribution_campaigns

Columns:

* touch_id (bigint)
* campaign_id (text)
* ad_cost_attributed (numeric)

# Table Name: attribution_touches

Columns:

* touch_id (bigint)
* session_id (uuid)
* touched_at (timestamp with time zone)
* utm_source (text)
* utm_medium (text)
* utm_campaign (text)
* utm_term (text)
* utm_content (text)
* channel (text)
* referrer (text)

# Table Name: brands

Columns:

* brand_id (bigint)
* brand_name (text)

# Table Name: categories

Columns:

* category_id (bigint)
* category_name (text)
* parent_id (bigint)

# Table Name: collection_products

Columns:

* collection_id (bigint)
* product_id (bigint)
* position (integer)

# Table Name: collections

Columns:

* collection_id (bigint)
* collection_name (text)
* created_at (timestamp with time zone)

# Table Name: consents

Columns:

* consent_id (bigint)
* customer_id (bigint)
* consent_type (text)
* status (text)
* updated_at (timestamp with time zone)

# Table Name: coupons

Columns:

* coupon_id (bigint)
* code (text)
* discount_type (text)
* discount_value (numeric)
* max_uses (integer)
* max_uses_per_customer (integer)
* starts_at (timestamp with time zone)
* ends_at (timestamp with time zone)
* is_active (boolean)

# Table Name: customer_addresses

Columns:

* customer_id (bigint)
* address_id (bigint)
* address_type (text)
* is_default (boolean)
* created_at (timestamp with time zone)

# Table Name: customer_segments

Columns:

* segment_id (bigint)
* segment_name (text)

# Table Name: customers

Columns:

* customer_id (bigint)
* created_at (timestamp with time zone)
* first_name (text)
* last_name (text)
* dob (date)
* gender (text)
* primary_email (text)
* primary_phone (text)
* country (text)
* state (text)
* city (text)
* is_email_verified (boolean)
* is_phone_verified (boolean)
* marketing_opt_in (boolean)
* lifecycle_stage (text)
* acquisition_channel (text)
* source (text)
* utm_campaign (text)
* utm_medium (text)
* utm_source (text)

# Table Name: devices

Columns:

* device_id (bigint)
* device_type (text)
* os (text)
* browser (text)
* model (text)

# Table Name: experiment_assignments

Columns:

* experiment_id (bigint)
* exp_variant_id (bigint)
* session_id (uuid)
* assigned_at (timestamp with time zone)
* customer_id (bigint)
* assignment_source (text)

# Table Name: experiment_variants

Columns:

* variant_id (bigint)
* experiment_id (bigint)
* variant_name (text)
* allocation_pct (numeric)
* is_control (boolean)

# Table Name: experiments

Columns:

* experiment_id (bigint)
* name (text)
* starts_at (timestamp with time zone)
* ends_at (timestamp with time zone)
* hypothesis (text)
* owner (text)
* status (text)
* primary_metric (text)

# Table Name: inventory_items

Columns:

* warehouse_id (bigint)
* variant_id (bigint)
* on_hand (integer)
* reserved (integer)

# Table Name: inventory_movements

Columns:

* movement_id (bigint)
* movement_time (timestamp with time zone)
* warehouse_id (bigint)
* variant_id (bigint)
* direction (text)
* qty (integer)
* reason (text)
* reference (text)

# Table Name: loyalty_accounts

Columns:

* customer_id (bigint)
* created_at (timestamp with time zone)
* tier (text)

# Table Name: loyalty_transactions

Columns:

* loyalty_txn_id (bigint)
* customer_id (bigint)
* txn_time (timestamp with time zone)
* points_delta (integer)
* reason (text)
* order_id (bigint)

# Table Name: marketing_campaigns

Columns:

* campaign_id (text)
* name (text)
* channel (text)
* budget (numeric)
* starts_at (timestamp with time zone)
* ends_at (timestamp with time zone)
* created_at (timestamp with time zone)

# Table Name: notifications

Columns:

* notification_id (bigint)
* customer_id (bigint)
* created_at (timestamp with time zone)
* channel (text)
* template (text)
* status (text)
* related_session_id (uuid)
* opened_at (timestamp with time zone)
* clicked_at (timestamp with time zone)

# Table Name: order_items

Columns:

* order_id (bigint)
* variant_id (bigint)
* qty (integer)
* unit_price (numeric)
* line_discount (numeric)
* line_total (numeric)

# Table Name: order_refunds

Columns:

* order_id (bigint)
* refund_amount (numeric)

# Table Name: order_status_history

Columns:

* order_id (bigint)
* status (text)
* changed_at (timestamp with time zone)
* reason (text)

# Table Name: orders

Columns:

* order_id (bigint)
* order_number (text)
* created_at (timestamp with time zone)
* customer_id (bigint)
* session_id (uuid)
* cart_id (uuid)
* price_list_id (bigint)
* status (text)
* subtotal (numeric)
* discount (numeric)
* tax (numeric)
* shipping_fee (numeric)
* total (numeric)
* payment_status (text)
* shipping_address_id (bigint)
* billing_address_id (bigint)
* applied_coupon_id (bigint)
* applied_promo_id (bigint)

# Table Name: payment_intents

Columns:

* payment_intent_id (bigint)
* order_id (bigint)
* created_at (timestamp with time zone)
* payment_method_id (bigint)
* amount (numeric)
* status (text)

# Table Name: payment_methods

Columns:

* payment_method_id (bigint)
* method_name (text)

# Table Name: payment_transactions

Columns:

* txn_id (bigint)
* payment_intent_id (bigint)
* txn_time (timestamp with time zone)
* gateway (text)
* status (text)
* error_code (text)
* error_message (text)

# Table Name: price_lists

Columns:

* price_list_id (bigint)
* name (text)
* currency (text)

# Table Name: prices

Columns:

* price_list_id (bigint)
* variant_id (bigint)
* list_price (numeric)
* sale_price (numeric)
* valid_from (timestamp with time zone)
* valid_to (timestamp with time zone)

# Table Name: product_images

Columns:

* image_id (bigint)
* product_id (bigint)
* image_url (text)
* position (integer)

# Table Name: product_reviews

Columns:

* review_id (bigint)
* customer_id (bigint)
* product_id (bigint)
* order_id (bigint)
* rating (integer)
* title (text)
* body (text)
* created_at (timestamp with time zone)

# Table Name: product_variants

Columns:

* variant_id (bigint)
* product_id (bigint)
* sku (text)
* color (text)
* size (text)
* attributes (jsonb)
* is_active (boolean)

# Table Name: products

Columns:

* product_id (bigint)
* created_at (timestamp with time zone)
* product_name (text)
* brand_id (bigint)
* category_id (bigint)
* description (text)
* is_active (boolean)

# Table Name: promotion_rules

Columns:

* rule_id (bigint)
* promo_id (bigint)
* min_cart_value (numeric)
* category_id (bigint)
* product_id (bigint)

# Table Name: promotions

Columns:

* promo_id (bigint)
* promo_name (text)
* promo_type (text)
* discount_type (text)
* discount_value (numeric)
* starts_at (timestamp with time zone)
* ends_at (timestamp with time zone)
* is_active (boolean)

# Table Name: refunds

Columns:

* refund_id (bigint)
* order_id (bigint)
* created_at (timestamp with time zone)
* amount (numeric)
* reason (text)
* status (text)

# Table Name: return_items

Columns:

* return_id (bigint)
* variant_id (bigint)
* qty (integer)
* reason_id (bigint)

# Table Name: return_reasons

Columns:

* reason_id (bigint)
* reason_text (text)

# Table Name: return_requests

Columns:

* return_id (bigint)
* order_id (bigint)
* customer_id (bigint)
* requested_at (timestamp with time zone)
* status (text)

# Table Name: segment_memberships

Columns:

* segment_id (bigint)
* customer_id (bigint)
* valid_from (timestamp with time zone)
* valid_to (timestamp with time zone)

# Table Name: session_channels

Columns:

* session_id (uuid)
* channel (text)

# Table Name: session_events

Columns:

* event_id (bigint)
* session_id (uuid)
* customer_id (bigint)
* event_type (text)
* occurred_at (timestamp with time zone)
* product_id (bigint)
* variant_id (bigint)
* quantity (integer)
* unit_price (numeric)
* order_id (bigint)

# Table Name: sessions

Columns:

* session_id (uuid)
* started_at (timestamp with time zone)
* ended_at (timestamp with time zone)
* customer_id (bigint)
* anonymous_id (uuid)
* device_id (bigint)
* ip_address (inet)
* country (text)
* region (text)
* city (text)
* landing_page (text)
* referrer (text)

# Table Name: shipments

Columns:

* shipment_id (bigint)
* order_id (bigint)
* carrier_id (bigint)
* shipping_method_id (bigint)
* shipped_at (timestamp with time zone)
* delivered_at (timestamp with time zone)
* tracking_number (text)
* status (text)

# Table Name: shipping_carriers

Columns:

* carrier_id (bigint)
* carrier_name (text)

# Table Name: shipping_methods

Columns:

* shipping_method_id (bigint)
* method_name (text)
* base_fee (numeric)

**Block 2 — Row counts:**

```sql
select relname as table_name, n_live_tup as approx_row_count
from pg_stat_user_tables
where schemaname = 'ecom'
order by n_live_tup desc;
```

| Table Name             | Approx. Row Count |
| ---------------------- | ----------------: |
| session_events         |           292,903 |
| order_status_history   |           158,414 |
| experiment_assignments |           140,670 |
| attribution_touches    |           100,000 |
| sessions               |           100,000 |
| devices                |            85,168 |
| order_items            |            81,806 |
| payment_transactions   |            40,034 |
| orders                 |            40,000 |
| payment_intents        |            40,000 |
| attribution_campaigns  |            38,405 |
| shipments              |            32,089 |
| inventory_movements    |            30,207 |
| prices                 |            24,180 |
| loyalty_transactions   |            21,475 |
| segment_memberships    |            16,461 |
| addresses              |            16,000 |
| customer_addresses     |            16,000 |
| product_variants       |            12,090 |
| customers              |            10,000 |
| product_reviews        |             8,000 |
| product_images         |             7,188 |
| notifications          |             6,856 |
| products               |             4,000 |
| loyalty_accounts       |             3,000 |
| return_items           |             2,004 |
| inventory_items        |             2,000 |
| return_requests        |             1,603 |
| refunds                |               260 |
| brands                 |               120 |
| marketing_campaigns    |               100 |
| coupons                |                50 |
| promotion_rules        |                30 |
| promotions             |                20 |
| categories             |                18 |
| experiment_variants    |                12 |
| customer_segments      |                10 |
| return_reasons         |                 8 |
| experiments            |                 6 |
| payment_methods        |                 5 |
| shipping_methods       |                 3 |
| shipping_carriers      |                 3 |
| price_lists            |                 2 |

**These tables have no data at all**

| collections            |                 0 |
| collection_products    |                 0 |
| consents               |                 0 |

**Block 3 — Declared foreign keys:**

```sql
select tc.table_name, kcu.column_name,
       ccu.table_name as foreign_table, ccu.column_name as foreign_column
from information_schema.table_constraints tc
join information_schema.key_column_usage    kcu on tc.constraint_name = kcu.constraint_name
join information_schema.constraint_column_usage ccu on ccu.constraint_name = tc.constraint_name
where tc.constraint_type = 'FOREIGN KEY' and tc.table_schema = 'ecom';
```
Gave me no foreign keys, or the result was nothing
Explored logical relationships between tables. Ran the following query for every relationship I could find between tables:

SELECT COUNT(*) AS unmatched_orders
FROM ecom.orders o
LEFT JOIN ecom.customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

1.orders.customer_id → customers.customer_id

2.addresses.address_id -> customer_addresses.address_id

3.brands.brand_id -> products.brand_id

4. collections.collection_id ->collection_products.collection_id
5. customer_segments.segment_id -> segment_memberships.segment_id
6. return_requests.customer_id ->customers.customer_id
7. customer.customer_id ->segment_memberships.customer_id
8. devices.device_id ->sessions.device_id
9. experiment_variants.experiment_id -> experiment_assignments.experiment_id
10. experiments.experiment_id ->experiment_assignments.experiment_id
11. experiments.experiment_id -> experiment_variants.experiment_id
12. orders.order_id -> order_items.order_id
13. orders.order_id -> order_status_history.order_id
14. orders.order_id -> payment_intents.order_id
15. payment_intents.payment_intent_id ->payment_transactions.payment_intent_id
16. payment_methods.payment_method_id ->payment_intents.payment_method_id
17. price_lists.price_list_id ->orders.price_list_id
18. price_lists.price_list_id ->prices.price_list_id
19. product_variants.variant_id ->prices.variant_id
20. product_variants.variant_id ->return_items.variant_id
21. products.product_id -> product_images.product_id
22. products.product_id -> product_variants.product_id
23. products.category_id -> promotion_rules.category_id
24. promotions.promo_id ->orders.applied_promo_id
25. return_reasons.reason_id -> return_items.reason_id
26. return_requests.return_id -> return_items.return_id
27. sessions.session_id -> attribution_touches.session_id
28. sessions.session_id -> experiment_assignments.session_id
29. shipping_carriers.carrier_id -> shipments.carrier_id
30. shipping_methods.shipping_method_id -> shipments.shipping_method_id
31. experiments.experiment_id → experiment_assignments.experiment_id
32. experiment_variants.experiment_id → experiment_assignments.experiment_id



**Block 4 — Distinct value distributions on every categorical text column** (`status`, `payment_method`, `channel`, `country`):

```sql
select status, count(*) as n from ecom.orders group by 1 order by n desc;
```
I have identified the following key tables that could be interconnected and may add value to further analysis:

1. Customers
   The categorical columns are as follows:
   1. Gender
      The dataset contains 3 categories:
      Male: 4824
      Female: 4736
      Others: 227
      NULL: 213

      We can see that the distribution is close to equal but a little higher on the men's side.

   2. Country
      The dataset contains 4 major categories
      India:7641
      United States:1359
      N/A:300
      NULL:200
      Empty string Values: 500
      Most customers are from India
      second largest pool of customers is from the United States.
      However, there are a few Null values or missing values, which are again categorised into N/A, NULL, and empty string values

   3.lifecycle_stage
    The dataset contains 4 categories
    active: 4869
    at_risk: 3903
    new:1200
    churned:28
   This shows the distribution of active customers, at-risk customers, new customers, and churned (inactive customers). Observe that at_risk customers are almost as many as active customers.
   New customer count is good, but with the at_risk customers at such a high count, analysis must be done to know why/ when did the trend start.
   No NULL values/missing values are observed here
   
   4. acquisition_channel
      organic	4,023
      paid	3,490
      referral	1,192
      email	708
      affiliate	587
      The distribution shows that the maximum number of acquisitions has happened organically, followed by the rest.
      No null/missing values observed.

   5. Source
      source	n
       linkedin	1,496
       affiliate	1,446
      direct	1,424
       newsletter	1,422
       meta	1,421
       youtube	1,396
       google	1,395
      Almost a good equal distribution has happened here. 7 sources present.
       No null/missing values observed.
    
    6. utm_campaign
       utm_campaign	n
       clearance	1,734
       retargeting	1,726
       new_user	1,709
       diwali_sale	1,638
       winter_drop	1,601
       brand_push	1,592

       Again, a good distribution almost similar for all campaign types. Total of 6 campaigns.
        No null/missing values observed.

2. Orders:
   1. Status
      status	n
       delivered	19,779
       shipped	7,715
       paid	3,946
       packed	3,887
       cancelled	2,178
       placed	1,897
      SHIPPED	248
       DELIVERED	200
       Shipped	150

   Most of the orders have the status as delivered, followed by shipped. There is an inconsistency with the values being entered, which have to be standardised before analysis. i.e., shipped has been repeated 3 times and delivered 2 times. There are only 6 categories otherwise.
   No null/missing values observed.

 2.payment_status
       payment_status	n
       paid	37,822
       failed	2,178
   There are only two categories here where the customers' paid status is clearly more than the failed status.
   No null/missing values observed.

3. Addresses
  1. country	n
       India	13,929
       United States	2,071

There are no NULL/missing values in the data. There is a clear distribution between the 2 categories i.e., India and the US. Indian customers are in the majority here.
In the customers. country column, there were missing/null values. Maybe we could do something with this data here, compare, and conclude.

4. order_status_history
   1. status	n
       placed	40,000
       paid	36,055
       packed	32,089
       shipped	28,183
       delivered	20,043
       cancelled	2,044
       Compare with Orders. Status, this is clearer.
   No null/missing values observed.

5. Devices
   1.device_type
   device_type	n
       mobile	61,466
       desktop	21,168
       tablet	2,534
   Device type shows that they sell mobiles, desktops, and tablets. They have the highest number of mobile collections.
    No null/missing values observed.

6. session_channels
   channel	n
        organic	39,924
       paid	34,905
       referral	12,146
       email	6,995
       affiliate	6,030

   The highest is through organic sessions, followed by the rest.
   No null/missing values observed.

7.payment_transactions
   gateway
   gateway	n
razorpay	18,072
payu	9,948
stripe	7,239
cash	4,775

The maximum number of transactions go through Razorpay, followed by the rest.
 No null/missing values observed.

8. price_lists
   currency
   currency	n
USD	1
INR	1

Only USD or INR transactions are happening.
 No null/missing values observed.

9. shipping_carriers
    carrier_name
   carrier_name	n
Delhivery	1
EcomExpress	1
Bluedart	1

Three different carriers are used for shipping

10. shipping_methods
    method_name
    method_name	n
same_day	1
standard	1
express	1

Three different methods of shipping are available.

11. Refunds.
    Refund status
    method_name	n
succeeded	227
initiated	20
failed	13

The maximum number of refunds has succeeded.


Block 5:

Ran the following 

SELECT COUNT(*)
FROM ecom.collections;

On collections, consents,collection_products --- all of them returned zero, which means the tables are actually empty. I had pointed out previously that the row count was zero, but will use this method to verify.


**TABLES AT A GLANCE:**

session_events

Each row shows us what type of session is going on, most likely whether the customer is browsing or at checkout, what the product is, at what time the event occurred, and what the cost of the cart/product is based on the customer ID.

Rows: 292,903

order_status_history

Each row shows us which order ID has what status (i.e., paid, packed, shipped, delivered, or cancelled), at what time the status changed, and if cancelled, the reason for cancellation.

Rows: 158,414

sessions

Each row shows which customer from which part of the world (country, region, city) started browsing, at what time the session started and ended. It also stores the IP address and the device ID used for shopping.

Rows: 100,000

devices

Each row shows us information about the device used for shopping, including the device type, operating system, browser, and model.

Rows: 85,168

order_items

Each row shows us, based on the order ID, which product variant was bought, the quantity purchased, and the total cost.

Rows: 81,806

payment_transactions

Each row shows us which payment gateway was used and whether the payment transaction was successful or failed.

Rows: 40,034

orders

Each row shows complete information about an order, from the order ID and customer who placed it to the payment status, shipping details, total amount, and any applied promo code or coupon.

Rows: 40,000

payment_intents

Each row shows whether the payment for an order has been completed or not, along with the payment method used and the total bill amount.

Rows: 40,000

attribution_campaigns

Each row shows the advertising cost attributed to each marketing campaign.

Rows: 38,405

shipments

Each row shows the shipping method used, the shipping carrier, whether the order was delivered or not, based on the order ID, along with when the order was shipped and delivered.

Rows: 32,089

inventory_movements

Each row shows at what time, how many units of a particular product variant moved into or out of a warehouse. It tells us about the product inventory movement in a particular warehouse.

Rows: 30,207

prices

Each row shows the current list price and sale price of each product variant, along with the validity period for that pricing.

Rows: 24,180

loyalty_transactions

Each row shows a passbook for customer loyalty points, where every row records one change in a customer's points balance.

Rows: 21,475

segment_memberships

Each row shows us from when to when a customer's segment membership is valid.

Rows: 16,461

addresses

Each row shows us the complete address details of a customer based on the address ID.

Rows: 16,000

customer_addresses

Each row shows links the customer ID to the address ID, along with the address type, and mentions whether it is the default address or not.

Rows: 16,000

product_variants

Each row shows the complete details of every product variant, including the size, colour, SKU, and other attributes.

Rows: 12,090

customers

Each row shows the complete details of each customer.

Rows: 10,000

product_reviews

Each row shows details of which product was reviewed, the review itself, the rating, when it was reviewed, along with the associated order ID.

Rows: 8,000

notifications

Each row shows what kind of notification was sent to a particular customer and through which channel.

Rows: 6,856

products

Each row shows complete product details, including the brand, category, description, and product name.

Rows: 4,000

loyalty_accounts

Each row shows the customer ID, when the loyalty account was created, and the customer's loyalty tier (such as Bronze, Silver, or Gold).

Rows: 3,000

return_items

Each row shows which item was returned, the quantity returned, and the associated reason code.

Rows: 2,004

inventory_items

Each row shows the quantity of each product variant currently in stock and how much inventory is reserved.

Rows: 2,000

return_requests

Each row shows which customer requested a return for which order and the current status of the return request.

Rows: 1,603

refunds

Each row shows the refund details for an order, including the refund amount, reason, status, and creation date.

Rows: 260

brands

Each row shows us the brand ID and the corresponding brand name.

Rows: 120

marketing_campaigns

Each row shows us the budget, marketing channel, and when the campaign starts and ends.

Rows: 100

coupons

Each row shows us the coupon code, discount value, usage limit per customer, validity period, and whether the coupon is active.

Rows: 50

promotion_rules

Each row shows the rules for applying a promotion, such as the minimum cart value and any applicable product or category restrictions.

Rows: 30

promotions

Each row shows the promotion details, including the promotion type, discount type, discount value, validity period, and whether the promotion is active.

Rows: 20

experiment_variants

Each row shows the different versions of an A/B test, the percentage of users allocated to each version, and identifies whether the variant is the control or the test version.

Rows: 12

customer_segments

Each row shows which customer segment a customer belongs to, such as new, active, at-risk, or churned.

Rows: 10

return_reasons

Each row shows the predefined reasons for product returns.

Rows: 8

experiments

Each row shows the details of the A/B experiments conducted to test different features or experiences.

Rows: 6

payment_methods

Each row shows the different payment methods available for customers to use.

Rows: 5

shipping_methods

Each row shows the different shipping methods available for delivering orders.

Rows: 3

shipping_carriers

Each row shows the different shipping carriers used for order deliveries.

Rows: 3

price_lists

Shows the available price lists and the currency used (INR or USD).

Rows: 2


May be useful later:

Customer --->> orders, order_items, returns, membership, sessions, addresses, payment_intents, shipments
Products -->> prices, product_variants,inventory
marketing-->> attribution, customers, orders
payments
orders
returns
orders-->>returns, refunds, payments
