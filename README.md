# Olist Delivery & Quality Analysis

![Power BI](https://img.shields.io/badge/Power%20BI-Data%20Analysis-yellow)
![DAX](https://img.shields.io/badge/DAX-Measures-blue)
![Power Query](https://img.shields.io/badge/Power%20Query-Data%20Transformation-green)

## Overview

An end-to-end Power BI analysis of Olist e-commerce data focused on
delivery reliability, revenue exposure, customer satisfaction, and
product-category quality.

The project was designed to answer a practical business question:

> Where should Olist prioritize operational and product-quality
> improvements to protect revenue and improve customer experience?

The analysis combines delivery performance, revenue, customer reviews,
order volume, and category-level performance to identify operational
risks and translate them into prioritized business recommendations.

---

## Business Questions

The analysis focuses on five key questions:

1. How reliable is Olist's delivery performance overall?
2. Which customer states represent the greatest delivery risk?
3. How does delivery performance affect customer satisfaction?
4. Which product categories have persistent quality concerns?
5. Where should Olist prioritize operational and quality improvements?

---

## Dataset

The analysis uses the publicly available Olist Brazilian e-commerce
dataset.

The data contains information related to:

- Orders
- Customers
- Products
- Sellers
- Order items
- Payments
- Reviews
- Geographical information

The analysis focuses primarily on order-level delivery outcomes,
revenue, customer reviews, product categories, customer states, and
order volume.

---

## Analytical Approach

The project follows an end-to-end analytics workflow:

### 1. Data Preparation

Data was prepared and transformed using Power Query.

Key preparation tasks included:

- Cleaning and standardizing fields
- Preparing order and delivery information
- Creating delivery outcome classifications
- Preparing revenue and review metrics
- Connecting customer, order, product, and review information

### 2. Data Modeling

The model was structured to support analysis across:

- Orders
- Customers
- Products
- Reviews
- Geography
- Delivery performance

### 3. DAX Measures

DAX was used to create business-focused KPIs and analytical measures,
including:

- On-Time Delivery Rate
- Average Review Score
- Repeat Customer Rate
- Revenue at Risk
- Total Revenue
- Total Orders
- Delivery performance by state
- Category-level review performance
- Variance from the national delivery benchmark

---

# Dashboard

The final Power BI dashboard contains four analytical pages.

## 01 — Overview

The Overview page provides an executive-level summary of:

- Delivery performance
- Customer satisfaction
- Revenue exposure
- Order volume
- Revenue trends
- Geographic revenue distribution

### Executive Takeaways

**Strong Delivery Performance**

93.23% of eligible orders were delivered on time, leaving a 6.77%
delivery gap.

**Meaningful Revenue at Risk**

$1.74M, representing approximately 10.86% of total revenue, is
associated with deliveries that were not on time.

**Delivery Impacts Satisfaction**

Average review scores fall from 4.29 for on-time deliveries to 2.27
for late deliveries and 1.75 for undelivered orders.

---

## 02 — Delivery Performance

This page investigates where delivery reliability is weakest and where
the financial exposure is concentrated.

### Key Findings

- National on-time delivery rate: **93.23%**
- RJ was identified as the lowest-priority-state benchmark at
  **87.89% on-time delivery**
- Late delivery revenue: **$1.15M**
- RJ, BA, and ES were prioritized based on below-benchmark delivery
  performance combined with meaningful revenue exposure.

The scatter plot compares state-level delivery reliability against
revenue exposure, helping distinguish high-impact operational problems
from lower-value exceptions.

---

## 03 — Quality & Category

This page investigates whether weak customer satisfaction is explained
by delivery performance alone or whether some product categories have
underlying quality concerns.

### Key Findings

**Office Furniture** was identified as the clearest category-level
quality concern.

- Overall review score: **3.62**
- Review score for on-time orders: **3.76**

The limited improvement when delivery is on time suggests that the
category's weaker satisfaction cannot be explained by delivery issues
alone.

The analysis also compares review scores against order volume to
provide context around category scale.

---

## 04 — Recommendations

The final page translates the analysis into prioritized actions.

### P0 — Fix RJ Delivery Performance

Audit RJ-serving sellers and delivery routes to identify the primary
sources of delays and address the root cause.

### P1 — Fix BA Delivery Performance

Audit BA-serving sellers and delivery routes to identify delivery
bottlenecks and improve performance toward the national benchmark.

### P2 — Fix ES Delivery Performance

Audit ES-serving sellers and delivery routes because ES combines
below-benchmark delivery performance with meaningful revenue exposure.

### P3 — Investigate Office Furniture Quality

Investigate packaging, listing accuracy, and seller quality because
Office Furniture remains below the desired satisfaction level even when
orders arrive on time.

---

# Key Business Insights

| Area | Finding | Business Implication |
|---|---|---|
| Delivery | 93.23% on-time rate | Delivery performance is strong but has room for improvement |
| Revenue | $1.74M revenue at risk | Late or failed deliveries represent meaningful financial exposure |
| Customer Experience | 4.29 → 2.27 → 1.75 review scores | Delivery failures have a strong relationship with customer satisfaction |
| Geography | RJ, BA, and ES prioritized | Operational intervention should focus on high-impact states |
| Product Quality | Office Furniture score of 3.62 | Some satisfaction problems appear to extend beyond delivery |

---

# Recommendations Summary

The analysis suggests a two-track improvement strategy:

### 1. Logistics Performance

Prioritize RJ, BA, and ES for operational investigation based on their
combination of delivery underperformance and revenue exposure.

### 2. Product Quality

Investigate Office Furniture separately because its lower satisfaction
persists even when delivery performance improves.

This prevents Olist from treating every customer-experience problem as a
delivery problem.

---

# Tools & Skills

### Tools

- Power BI
- DAX
- Power Query

### Skills Demonstrated

- Data cleaning and transformation
- Data modeling
- KPI development
- DAX measure creation
- Business-focused data visualization
- Revenue-risk analysis
- Geographic performance analysis
- Customer satisfaction analysis
- Category benchmarking
- Root-cause analysis
- Business recommendations

---

# Dashboard Preview

Screenshots of each dashboard page are available in the
`screenshots/` folder.

### Overview

![Overview](screenshots/overview.png)

### Delivery Performance

![Delivery Performance](screenshots/delivery-performance.png)

### Quality & Category

![Quality & Category](screenshots/quality-category.png)

### Recommendations

![Recommendations](screenshots/recommendations.png)

---

# Project Structure

```text
olist-delivery-quality-analysis/
│
├── README.md
│
├── dashboard/
│   └── Olist_Delivery_Quality_Analysis.pbix
│
├── screenshots/
│   ├── overview.png
│   ├── delivery-performance.png
│   ├── quality-category.png
│   └── recommendations.png
│
├── dax/
│   └── measures.md
│
└── documentation/
    └── data-model.md