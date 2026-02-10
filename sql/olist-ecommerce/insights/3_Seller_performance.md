# 📦 Seller Performance & Reliability  
**Dataset:** Olist Brazilian E-commerce

---

## 🎯 Objective

Evaluate seller reliability through delivery performance and determine whether order volume can serve as an indicator of operational maturity.

This section answers three questions:

8. Which sellers have the highest late delivery rates (after applying a minimum order threshold)?
9. Which sellers contribute the largest absolute number of late deliveries?
10. Are high-volume sellers more or less reliable than low-volume sellers?

---

# 8. Sellers with the Highest Late Delivery Rates


To avoid distortion from very small sellers, minimum order thresholds were applied:

- ≥ 50 orders  
- ≥ 500 orders  

---

## 🔎 Sellers with ≥ 50 Orders

| seller_id | late_delivery_rate | total_orders |
|------------|--------------------|--------------|
| 54965bbe3e4f07ae045b90b0b8541f52 | 0.32 | 81 |
| 2a1348e9addc1af5aaa619b1a3679d6b | 0.29 | 51 |
| 6039e27294dc75811c0d8a39069f52c0 | 0.26 | 74 |
| a49928bcdf77c55c6d6e05e09a9b4ca5 | 0.25 | 104 |
| beadbee30901a7f61d031b6b686095ad | 0.24 | 68 |
| 602044f2c16190c2c6e45eb35c2e21cb | 0.24 | 55 |
| 06a2c3af7b3aee5d69171b0e14f0ee87 | 0.24 | 402 |
| cac4c8e7b1ca6252d8f20b2fc1a2e4af | 0.23 | 82 |
| 99a54764c341d5dc80b4a8fac4eba3fb | 0.23 | 66 |
| bbad7e518d7af88a0897397ffdca1979 | 0.23 | 84 |

### Key Insights

- Late delivery rates reach as high as **32%**.
- Many high-risk sellers operate with relatively small order volumes (50–100 orders).
- However, some mid-sized sellers (300–400 orders) also show elevated late rates (~24%).

This suggests that poor performance is not limited to very small sellers, though smaller sellers exhibit greater variability.

---

## 🔎 Sellers with ≥ 500 Orders

| seller_id | late_delivery_rate | total_orders |
|------------|--------------------|--------------|
| 7d13fca15225358621be4086e1eb0964 | 0.12 | 571 |
| 4869f7a5dfa277a7dca6462dcf3b52b2 | 0.12 | 1148 |
| 1835b56ce799e6a4dc4eddc053f04066 | 0.11 | 551 |
| 4a3ca9315b744ce9f8e9374361493884 | 0.11 | 1949 |
| 1900267e848ceeba8fa32d80c1a5f5a8 | 0.10 | 523 |
| fa1c13f2614d7b5c4749cbc52fecda94 | 0.10 | 579 |
| 620c87c171fb2a6dd6e8bb4dec959fc6 | 0.10 | 778 |
| 391fc6631aebcf3004804e51b40bcf1e | 0.10 | 605 |
| 8b321bb669392f5163d04c59e235e066 | 0.10 | 1005 |
| 7c67e1448b00f6e969d365cea6b010ab | 0.10 | 1355 |

### Key Insights

- Late delivery rates range between **10–12%**.
- High-volume sellers show significantly more stable performance.
- No extreme outliers appear in this segment.

This indicates that operational scale may reduce variability and extreme inefficiencies.

---

# 9. Sellers Contributing the Largest Absolute Number of Late Deliveries

While late rate measures *efficiency*, absolute late deliveries measure *customer impact*.

A seller with a moderate late rate but very high order volume can generate more total dissatisfaction than a small seller with a high percentage.

---

## 🔎 Top Sellers by Absolute Late Deliveries

| seller_id | late_delivery | total_orders | late_delivery_rate |
|------------|--------------|--------------|--------------------|
| 4a3ca9315b744ce9f8e9374361493884 | 214 | 1949 | 0.1098 |
| 1f50f920176fa81dab994f9023523100 | 182 | 1926 | 0.0945 |
| 4869f7a5dfa277a7dca6462dcf3b52b2 | 133 | 1148 | 0.1159 |
| 1025f0e2d44d7041d6cf58b6550e0bfa | 131 | 1420 | 0.0923 |
| 7c67e1448b00f6e969d365cea6b010ab | 130 | 1355 | 0.0959 |
| 6560211a19b47992c3666cc44a7e94c0 | 124 | 1996 | 0.0621 |
| ea8482cd71df3c1969d7b9473ff13abc | 123 | 1188 | 0.1035 |
| 955fee9216a65b617aa5c0531780ce60 | 119 | 1472 | 0.0808 |
| da8622b14eb17ae2831f4ac5b9dab84a | 113 | 1548 | 0.0730 |
| 8b321bb669392f5163d04c59e235e066 | 103 | 1005 | 0.1025 |

### Key Insight

All sellers in this list have more than **1,000 orders**.

Even with late rates around 8–11%, large order volumes generate over 100 late deliveries each.

This highlights two distinct risk dimensions:

| Risk Type | Interpretation |
|------------|----------------|
| High late rate | Operational inefficiency |
| High absolute late volume | Marketplace impact |

From a platform perspective, large sellers with moderate inefficiency may represent a greater reputational risk than small sellers with extreme rates.

---

# 10. Reliability by Seller Volume Segment

To evaluate whether seller size systematically affects reliability, sellers were grouped into:

- `low_volume` → ≤ 50 orders  
- `mid_volume` → 51–200 orders  
- `high_volume` → > 200 orders  

Average late delivery rate was calculated per segment.

---

## 📊 Results

| volume_category | num_sellers | avg_late_delivery_rate |
|-----------------|------------|------------------------|
| low_volume      | 2517       | 0.085 |
| mid_volume      | 355        | 0.076 |
| high_volume     | 98         | 0.079 |

---

## 🔎 Interpretation

- Low-volume sellers have the highest average late rate (8.5%).
- Mid-volume sellers perform best (7.6%).
- High-volume sellers are slightly worse than mid-volume sellers (7.9%), but still better than low-volume sellers.

However, differences are modest:

- 8.5% vs 7.6% vs 7.9%

This suggests:

Seller size has some influence on reliability,  
but it is **not the dominant driver**.

Other structural factors likely play a larger role:
- Geographic distance  
- Shipping provider  
- Product category  
- Seasonality  
- Regional logistics infrastructure  

---

# 📌 Overall Conclusion

The analysis reveals two important marketplace dynamics:

1. Small sellers exhibit greater variability and occasional extreme inefficiency.
2. Large sellers generate the highest absolute number of late deliveries due to scale.
3. Volume alone is not a strong predictor of reliability — differences across segments are relatively small.

This demonstrates the importance of evaluating both:

- Relative metrics (rates)
- Absolute metrics (impact)

Together, they provide a more complete picture of operational risk within the marketplace.

---

## 💡 Technical Skills Demonstrated

- CTEs (`WITH`)
- Conditional aggregation (`CASE WHEN`)
- Ratio calculations
- Threshold filtering (`HAVING`)
- Segmentation logic
- Business-driven interpretation of SQL results

