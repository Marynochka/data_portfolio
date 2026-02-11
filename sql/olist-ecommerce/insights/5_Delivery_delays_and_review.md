# 📦 Delivery Delays & Customer Experience  
**Dataset:** Olist Brazilian E-commerce  

---

## 🎯 Objective  

To evaluate how delivery performance influences customer satisfaction and determine whether longer delays lead to disproportionately lower review scores.

---

# 14. Do Review Scores Differ Between On-Time and Late Deliveries?

## 📊 Results  

| Delivery Status  | Average Review Score | Total Reviews |
|------------------|----------------------|--------------|
| On-Time Delivery | 4.29                 | 89,952       |
| Late Delivery    | 2.27                 | 6,409        |

---

## 🔎 Key Findings  

- On-time deliveries receive a strong average rating of **4.29**.
- Late deliveries receive a significantly lower average rating of **2.27**.
- The difference of **−2.02 rating points** (on a 1–5 scale) is substantial.
- Customers clearly penalise delivery delays in their reviews.

---

## 📈 Interpretation  

The results show a strong negative association between delivery delays and customer satisfaction.  

A decline of more than **2 full rating points** indicates that logistics performance is a major driver of customer experience.

Even though late deliveries represent a smaller share of total reviews, their extremely low ratings can materially reduce the platform’s overall reputation.

---

## 💡 Business Insight  

Improving delivery reliability may yield higher returns than product-level optimisations.  
Reducing late deliveries could significantly improve average platform ratings and customer retention.

---

# 15. Is There a Relationship Between Delay Duration and Review Score?

Rather than treating deliveries as simply “on-time” or “late,” this analysis investigates how **the length of delay** impacts customer satisfaction.

---

## 📊 Results  

| Delivery Bucket        | Avg Review Score | Total Reviews | % of Total | 1-Star Reviews | 1-Star % | Std Dev |
|------------------------|-----------------|---------------|------------|---------------|----------|---------|
| Early Delivery         | 4.29            | 88,653       | 92.01%     | 5,851         | 6.60%    | 1.15    |
| On-Time Delivery       | 4.03            | 1,291        | 1.34%      | 110           | 8.52%    | 1.25    |
| 1–2 Days Late          | 3.51            | 1,360        | 1.41%      | 256           | 18.82%   | 1.50    |
| 3–7 Days Late          | 2.23            | 2,252        | 2.34%      | 1,239         | 55.02%   | 1.57    |
| More than 7 Days Late  | 1.70            | 2,797        | 2.90%      | 1,949         | 69.68%   | 1.23    |

---

## 🔎 Key Findings  

### 1️⃣ Strong Monotonic Decline  

Average review scores decrease consistently as delay duration increases:

- Early deliveries: **4.29**
- 1–2 days late: **3.51**
- 3–7 days late: **2.23**
- 7+ days late: **1.70**

This confirms a strong negative relationship between delay length and satisfaction.

---

### 2️⃣ Clear Behavioural Threshold  

Customer tolerance appears limited to delays of up to **2 days**.  

Once delays exceed **3 days**, satisfaction collapses sharply:

- 1–2 days late → **18.82%** 1-star reviews  
- 3–7 days late → **55.02%** 1-star reviews  
- 7+ days late → **69.68%** 1-star reviews  

This suggests a **threshold effect** rather than a gradual linear decline.

---

### 3️⃣ Disproportionate Impact  

Deliveries delayed more than 3 days account for only **~5% of total orders**, yet generate the majority of extreme dissatisfaction.

A small operational segment is responsible for a large share of negative customer experiences.

---

## 📈 Overall Interpretation  

Customer satisfaction remains relatively stable for minor delays (≤2 days).  
However, once delivery exceeds 3 days late, ratings deteriorate dramatically and the likelihood of a 1-star review increases sharply.

This indicates that preventing long delays (3+ days) should be prioritised over marginal improvements to already on-time deliveries.

---

## 💡 Strategic Implication  

Targeting and reducing extreme delays could:

- Substantially reduce 1-star reviews  
- Increase overall marketplace rating  
- Improve customer trust and retention  

From an operational standpoint, addressing a small percentage of severe delays offers a high-leverage opportunity to improve overall customer experience.
