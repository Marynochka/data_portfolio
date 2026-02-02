# 🛒 Brazilian E-Commerce SQL Analysis (Olist)

## 📌 Project Overview
This project analyses delivery performance and operational efficiency in a Brazilian e-commerce marketplace using **SQL (PostgreSQL)**.
The goal is to identify patterns in delivery delays across sellers, regions, and product categories, and assess their impact on customer experience.

The analysis is based on the public **Olist Brazilian E-Commerce Dataset** from Kaggle.

---

## 📂 Dataset
**Source:** Kaggle — Brazilian E-Commerce Public Dataset by Olist  

The dataset contains real anonymised data of orders made on Olist Store, including customers, sellers, products, payments, deliveries, and reviews.

Key tables used:
- `orders`
- `order_items`
- `customers`
- `sellers`
- `products`
- `payments`
- `reviews`

---

## 🎯 Business Objectives
The main objectives of this analysis are to:
- Evaluate customer satisfaction using review scores
- Measure delivery performance and delays
- Identify patterns linking delivery delays to negative reviews
- Compare seller performance based on revenue, delivery reliability, and reviews

---

## ❓ Business Questions
This project answers the following questions:
1. What percentage of orders receive customer reviews?
2. How does delivery delay affect review scores?
3. Are late deliveries associated with significantly lower ratings?
4. Which product categories have the lowest average review scores?
5. What proportion of orders are delivered late?
6. What is the average delivery time by customer state?
7. Which sellers have the highest rate of late deliveries?
8. Which sellers generate high revenue but receive poor reviews?
9. Does payment type correlate with delivery delays?
10. Which factors are most strongly associated with low review scores?

---

## 🗂 Database Design
The original dataset is provided as multiple CSV files. These were loaded into a **relational PostgreSQL database** with appropriate primary and foreign keys.

Design notes:
- Some source tables (e.g. `reviews`) do not contain a natural primary key.
- A **surrogate primary key** was introduced where necessary to ensure relational integrity.
- Foreign key constraints reflect real-world relationships between entities.


---

## 🧠 SQL Techniques Used
The analysis demonstrates:
- Multi-table `JOIN`s
- Aggregations using `GROUP BY` and `HAVING`
- Conditional logic with `CASE WHEN`
- Common Table Expressions (CTEs)
- Subqueries
- Date and time calculations
- Window functions (`RANK`, `AVG() OVER`, etc.)

---

## 📈 Key Insights (Summary)
Key findings include:
- Late deliveries receive significantly lower average review scores
- Delivery delay is a major driver of customer dissatisfaction
- Some sellers generate high revenue despite poor delivery performance
- Review behaviour varies across product categories and payment types

Detailed queries and insights are available in the `sql/` and `insights/` directories.

---

## 🛠 Tools Used
- PostgreSQL
- SQL
- Kaggle Dataset
- GitHub

---

## 📁 Repository Structure
```text
olist-sql-analysis/
│
├── README.md
├── figures/
│   └── schema_diagram.png
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_constraints.sql
│   └── 03_analysis_queries.sql
└── insights/
    └── business_insights.md
## ❓ Business Questions (SQL Analysis)

### 1️⃣ Overall Delivery Performance
1. What percentage of orders are delivered late?
2. What is the average delivery delay (in days) for late orders?
3. How does actual delivery time compare to the estimated delivery time?
4. How has the late delivery rate changed over time (monthly trend)?

---

### 2️⃣ Geographic Analysis (Regional Delivery Performance)
5. Which customer states have the highest late delivery rates?
6. What is the average delivery time by customer state?
7. Which regions consistently underperform compared to the national average?

---

### 3️⃣ Seller Performance & Reliability
8. Which sellers have the highest late delivery rates (after applying a minimum order threshold)?
9. Which sellers contribute the largest absolute number of late deliveries?
10. Are high-volume sellers more or less reliable than low-volume sellers?

---

### 4️⃣ Product Category Impact
11. Which product categories have the longest average delivery times?
12. Which categories have the highest late delivery rates?
13. Are delivery delays concentrated in a small number of product categories?

---

### 5️⃣ Delivery Delays & Customer Experience
14. How do review scores differ between on-time and late deliveries?
15. Is there a relationship between delivery delay duration and review score?

---

## 🧠 Analytical Notes
- Late delivery is defined as orders delivered after the estimated delivery date.
- Delivery delay is calculated as:  
  `order_delivered_customer_date - order_estimated_delivery_date`
- Small sample sizes are filtered using minimum order thresholds.
- Time-based analyses are aggregated at a monthly level.

---

## 📊 Dashboard Mapping (Future Work)
The SQL analysis is designed to support a future dashboard with:
- KPI cards (late delivery rate, average delay)
- Time-series charts (monthly trends)
- Geographic maps (delivery performance by state)
- Ranked tables (seller and category performance)


## 🧱 Schema-Level Data Integrity

Data quality controls were implemented directly during database creation using explicit constraints and relational design principles.  
This reduces the need for downstream structural cleaning and prevents duplicate or orphan records.

### Primary Keys

The following primary keys were defined:

- `customers(customer_id)`
- `sellers(seller_id)`
- `products(product_id)`
- `orders(order_id)`
- `order_items(order_id, order_item_id)` — composite primary key
- `payments(order_id, payment_sequential)` — composite primary key
- `product_category_translation(product_category_name)`

Composite primary keys were used in transactional tables where uniqueness is scoped within an order:

- In `order_items`, `order_item_id` is unique only within each order.
- In `payments`, `payment_sequential` is unique only within each order.

This design reflects real business logic (multiple items and payments per order) without introducing artificial surrogate IDs.

The following tables intentionally do not define primary keys:

- `reviews` — the raw dataset allows repeated `review_id` values.
- `geolocation` — duplicate ZIP prefixes are expected and represent multiple coordinate observations.

---

### Foreign Key Constraints

Referential integrity is enforced through foreign key relationships:

- `orders.customer_id → customers.customer_id`
- `order_items.order_id → orders.order_id`
- `order_items.product_id → products.product_id`
- `order_items.seller_id → sellers.seller_id`
- `payments.order_id → orders.order_id`
- `reviews.order_id → orders.order_id`

`ON DELETE CASCADE` is applied to dependent transactional tables to ensure relational consistency.

This prevents orphan records and guarantees structural integrity across the database.

---

### Domain Constraints & Data Types

Appropriate data types and validation rules were enforced at schema level:

- `review_score` includes `CHECK (review_score BETWEEN 1 AND 5)`
- Monetary fields (`price`, `freight_value`, `payment_value`) use `NUMERIC(10,2)`
- Date columns use `TIMESTAMP`
- State fields use `CHAR(2)`
- Product dimensions and weight use `INTEGER`

By enforcing correct data types during database creation, type casting and structural corrections during analysis are minimized.

---

### Indexing Strategy

Indexes were created on frequently joined and filtered columns:

- `customers(customer_unique_id)`
- `products(product_category_name)`
- `orders(customer_id)`
- `orders(order_purchase_timestamp)`
- `order_items(product_id)`
- `order_items(seller_id)`
- `payments(payment_type)`
- `reviews(order_id)`
- `reviews(review_score)`
- `geolocation(geolocation_zip_code_prefix)`

These indexes improve query performance while preserving raw data integrity.

---

Overall, structural integrity is enforced at the database level rather than corrected post hoc during analysis.

## 🔎 Data Validation Findings

A series of structural and business logic validation checks were performed after database creation, including row count verification, timestamp consistency checks, monetary domain validation, and referential integrity review. Minor anomalies were identified (e.g., inconsistent delivery timestamps, zero or negative payments, and missing category translations); however, each issue affects only a very small fraction of the dataset and is not statistically significant.

Raw data was preserved to maintain reproducibility and data lineage. For business analysis (e.g., delivery performance or revenue metrics), logically consistent subsets of the data should be used where necessary. These validation findings are considered when interpreting KPIs to ensure edge cases do not distort analytical conclusions.

