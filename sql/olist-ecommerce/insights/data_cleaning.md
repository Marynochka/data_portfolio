## 🔎 Data Validation Findings

After enforcing schema-level constraints, additional validation queries were executed to assess business logic consistency and domain correctness.

The dataset demonstrates high structural integrity. Detected anomalies are minimal in proportion and consistent with real-world enterprise data.

---

### 1. Volume & Structural Observations

- The `payments` table contains more records than `orders`, which is expected due to installment payments and split transactions.
- The `geolocation` table contains significantly more records than other tables (over 1M rows), reflecting multiple coordinate observations per ZIP prefix.

No unexpected volume discrepancies were detected.

---

### 2. Order Timestamp Consistency

Chronological validation checks identified a small number of inconsistencies:

- 23 orders marked as delivered before being shipped.
- 8 orders with status `delivered` but missing a delivery timestamp.
- 6 orders with status `canceled` containing a delivery timestamp.

These represent less than 0.05% of total orders and were flagged as minor inconsistencies rather than systemic data corruption.

For analytical purposes, delivery performance metrics can be calculated using a filtered subset of logically consistent delivered orders.

---

### 3. Monetary Validation

- 9 payments with value = 0 (likely fully covered by vouchers or promotional credits).
- 4 payments with negative values (potential refunds or chargebacks).

Zero-value payments were retained as valid business events.  
Negative payments were flagged for interpretation rather than automatically removed.

No widespread pricing anomalies were detected in `order_items`.

---

### 4. Product Category Translation

- 2 product categories lack English translation.

These were identified but not modified in order to preserve raw data integrity.

---

### 5. Geolocation Characteristics

- 8 ZIP code prefixes are associated with multiple states.

Given the structure of the source dataset, this was treated as a characteristic of the data rather than a data quality defect.

---

## 📌 Data Handling Approach

Instead of deleting or modifying anomalous records:

- Raw data was preserved.
- Inconsistencies were flagged.
- Clean analytical subsets can be derived where necessary.

This approach maintains transparency, reproducibility, and data lineage while allowing robust analytical modeling.


 



