# 📦 Product Category Impact  
**Dataset:** Olist Brazilian E-commerce

---

## 🎯 Objective

Analyse how product category influences:

- Delivery time  
- Late delivery rate  
- Contribution to overall platform delays  

This section answers three questions:

11. Which product categories have the longest average delivery times?  
12. Which categories have the highest late delivery rates?  
13. Are delivery delays concentrated in a small number of product categories?  

---

## 🧹 Data Quality Check

Before conducting the analysis, missing values were examined:

- 610 products (1.85%) have `NULL` in `product_category_name`
- 22 entries do not have a valid `product_category_name_english` in the translation table

These records were excluded or handled appropriately to ensure consistent aggregation.

---

# 11️⃣ Categories with the Longest Average Delivery Time


Each item in an order was counted separately.  
If an order contained multiple items from the same category, each item contributed to the category average.

---

## 🔎 Top Categories by Average Delivery Time

| product_category_name_english | delivery_days | total_orders |
|--------------------------------|--------------|--------------|
| office_furniture | 20.79 | 1668 |
| christmas_supplies | 15.67 | 150 |
| fashion_shoes | 15.40 | 257 |
| security_and_services | 15.00 | 2 |
| home_comfort_2 | 14.53 | 30 |
| furniture_mattress_and_upholstery | 14.41 | 37 |
| home_appliances_2 | 13.86 | 231 |
| furniture_living_room | 13.78 | 495 |
| garden_tools | 13.66 | 4268 |
| consoles_games | 13.54 | 1089 |

---

## 📊 Interpretation

### 1️⃣ Furniture Categories Are Structurally Slower

Furniture-related categories consistently show above-average delivery times:

- `office_furniture`
- `furniture_living_room`
- `furniture_mattress_and_upholstery`

Likely reasons:

- Large and heavy items  
- Freight shipping instead of parcel delivery  
- Higher handling complexity  

This suggests delivery speed is strongly influenced by product characteristics.

---

### 2️⃣ Small Consumer Goods Deliver Faster

Examples:

- `arts_and_craftmanship` – 5.67 days  
- `books_imported` – 7.96 days  
- `fashion_childrens_clothes` – 8.86 days  

These items are lightweight, easy to package, and compatible with standard logistics networks.

---

### 3️⃣ Volume Alone Does Not Explain Delivery Time

High-volume categories such as:

- `bed_bath_table`
- `health_beauty`
- `sports_leisure`

show delivery times close to the overall average (11–13 days).

This indicates logistics complexity matters more than demand scale.

---

### ⚠️ Statistical Note

Categories with very small order counts (e.g., 2–30 orders) produce unstable averages and should not be overinterpreted.

---

# 12️⃣ Categories with the Highest Late Delivery Rates


---

## 🔎 Highest Late Delivery Rates

| product_category_name_english | late_delivery_rate | delivery_time_days | total_orders |
|--------------------------------|--------------------|-------------------|--------------|
| furniture_mattress_and_upholstery | 0.14 | 14.41 | 37 |
| home_comfort_2 | 0.13 | 14.53 | 30 |
| audio | 0.12 | 13.27 | 362 |
| christmas_supplies | 0.10 | 15.67 | 150 |
| home_confort | 0.09 | 13.46 | 429 |
| baby | 0.08 | 12.45 | 2982 |
| office_furniture | 0.08 | 20.79 | 1668 |
| health_beauty | 0.08 | 11.91 | 9465 |
| electronics | 0.08 | 12.81 | 2729 |

---

## 📊 Interpretation

### 1️⃣ Furniture Shows Elevated Late Risk

Furniture-related categories combine:

- Long delivery times  
- Higher late rates  

This indicates structural logistics difficulty rather than isolated inefficiency.

---

### 2️⃣ Long Delivery Time ≠ High Late Rate

Example:

- `fashion_shoes`
  - 15.40 days average delivery
  - 4% late rate

This suggests estimated delivery windows may already account for slower logistics.

Important distinction:

- Delivery time measures speed  
- Late rate measures forecasting accuracy  

---

### 3️⃣ High-Volume Categories Are Operationally Stable

Large categories such as:

- `health_beauty`
- `bed_bath_table`
- `sports_leisure`
- `housewares`

maintain moderate late rates (5–8%) despite high order volumes.

This reinforces that category structure matters more than scale alone.

---

# 13️⃣ Concentration of Delivery Delays

### Objective

Determine whether late deliveries are evenly distributed or concentrated in a few categories.

---

## 🔎 Categories Contributing the Most Late Deliveries

| product_category_name_english | late_deliveries | total_deliveries | share_of_all_late |
|--------------------------------|----------------|------------------|-------------------|
| bed_bath_table | 770 | 10953 | 0.1077 |
| health_beauty | 716 | 9465 | 0.1002 |
| furniture_decor | 574 | 8160 | 0.0803 |
| sports_leisure | 532 | 8431 | 0.0744 |
| computers_accessories | 496 | 7644 | 0.0694 |

---

## 📊 Key Findings

### 1️⃣ Delays Are Highly Concentrated

The top 5 categories account for:

**43.2% of all platform late deliveries**

This indicates a strong concentration effect.

---

### 2️⃣ Concentration Is Driven by Volume

These categories do not have extreme late rates.

They generate many delays because:

- They have very high order volumes
- Even moderate late rates create large absolute delay counts

This is a scale-driven effect.

---

### 3️⃣ Long-Tail Categories Have Minimal Impact

Most categories contribute less than 1% of total late deliveries.

From an operational perspective, improving these would not significantly reduce platform-wide delays.

---

# 📌 Overall Conclusion

Product category is a meaningful structural driver of delivery performance.

Key patterns:

- Furniture-related products are slower and more delay-prone.
- High-volume consumer goods generate the largest absolute number of late deliveries.
- Delivery delays are concentrated in a small number of dominant categories.
- Volume alone does not determine reliability — product characteristics and logistics complexity play a larger role.

This analysis highlights the importance of distinguishing between:

- Relative risk (late rate)
- Absolute impact (total delays)

Together, they provide a comprehensive view of operational risk across product categories.

---

# 📌 Business Implications


1. Focus logistics optimization efforts on top 5–10 categories.
2. Review delivery estimates in high-volume segments.
3. Conduct supplier audits in dominant categories.
4. Consider category-specific shipping policies.

Targeted intervention is more efficient than platform-wide blanket improvements.


## 💡 Technical Skills Demonstrated

- Aggregation by category
- Date difference calculations
- Ratio computation
- Concentration analysis (share of total)
- Interpretation of structural vs scale effects
- Handling missing values in relational joins
