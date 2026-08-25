# Olist Delivery & Quality Analysis

An end-to-end data analysis project using SQL Server, Power BI, DAX,
and Power Query to evaluate delivery reliability, revenue exposure,
customer satisfaction, and product-category quality across Olist's
e-commerce marketplace.

---

## Business Problem

Olist's overall delivery performance appears strong at the national
level, but aggregate performance can hide meaningful differences across
states, delivery outcomes, and product categories.

This analysis investigates:

- Where delivery performance is weakest
- How much revenue is exposed to late or failed deliveries
- How delivery outcomes relate to customer satisfaction
- Which product categories have persistent review-score issues
- Where Olist should prioritize operational and quality improvements

### Decision

> Should Olist prioritize delivery logistics or product/seller quality
> investment next quarter to improve customer satisfaction and repeat
> purchase?

---

# Analytical Approach

The project follows an end-to-end analytics workflow:

**Source Data**
↓
**SQL Server / SSMS**
↓
**Analytical Views**
↓
**Power BI Data Model**
↓
**DAX Measures**
↓
**Dashboard Analysis**
↓
**Business Recommendations**

---

## 1. SQL Data Modeling

SQL Server / SSMS was used to create reporting-ready analytical views
before the data was brought into Power BI.

### `fact_orders`

The order-level analytical view combines:

- Orders
- Customers
- Reviews
- Payments

The view also derives analytical fields including:

- Delivery duration
- Delivery status
- Order-level payment value

The review data is deduplicated by retaining the latest review record
per order using `ROW_NUMBER()`.

Payment values are aggregated to the order level before being joined to
the order data.

### `fact_order_items`

The order-item analytical view combines:

- Order items
- Products
- Product category translations

It retains item-level fields including:

- Product
- Seller
- Price
- Freight value
- Product category

These two views provide separate analytical grains for order-level and
order-item/category analysis.

---

## 2. Power BI & DAX

The SQL views were imported into Power BI and used as the foundation
for the reporting model.

DAX was then used to create business-focused KPIs and analytical
measures, including:

- On-Time Delivery Rate
- Average Review Score
- Repeat Purchase Rate
- Revenue at Risk
- Total Revenue
- Total Orders
- Delivery variance from the national benchmark
- Category-level review analysis
- On-time-only review analysis

The model was designed to support analysis across delivery status,
customer state, product category, revenue, and customer satisfaction.

---

# Dashboard

The final dashboard consists of four pages.

---

## 01 — Overview

### Purpose

Provide an executive-level view of Olist's delivery performance,
customer satisfaction, revenue, and order activity.

### Key Metrics

- **93.23%** On-Time Delivery Rate
- **4.09** Average Review Score
- **3.12%** Repeat Purchase Rate
- **$16.01M** Total Revenue
- **99K+** Total Orders

### Executive Takeaways

**Strong Delivery Performance**

93.23% of eligible orders were delivered on time, leaving a 6.77%
delivery gap.

**Meaningful Revenue Exposure**

$1.74M, representing approximately 10.86% of total revenue, is
associated with deliveries that were not on time.

**Delivery Impacts Customer Satisfaction**

Average review scores decline from:

- 4.29 — On-time deliveries
- 2.27 — Late deliveries
- 1.75 — Undelivered orders

This establishes the relationship between delivery performance,
financial exposure, and customer experience.

---

## 02 — Delivery Performance

### Purpose

Identify where delivery reliability is weakest and determine which
states represent the greatest operational priority.

### Key Findings

- National on-time delivery rate: **93.23%**
- RJ on-time delivery rate: **87.89%**
- Revenue associated with late/not-on-time deliveries: **$1.74M**

The state-level analysis compares delivery performance against the
national benchmark and uses revenue exposure to distinguish
higher-impact operational problems from lower-value exceptions.

### Priority States

**RJ, BA, and ES** were selected as priority delivery states based on
their below-benchmark delivery performance combined with meaningful
revenue exposure.

---

## 03 — Quality & Category

### Purpose

Determine whether weaker customer satisfaction is primarily associated
with delivery performance or whether certain product categories have
additional quality concerns.

### Key Finding

**Office Furniture** was identified as the primary category-level
quality concern.

| Measure | Review Score |
|---|---:|
| Overall | **3.62** |
| On-time orders | **3.76** |
| Platform average | **4.09** |

The category improves when orders are delivered on time, but remains
below the platform average.

This suggests that delivery performance does not fully explain the
category's weaker customer satisfaction and that a separate
product/seller quality investigation is warranted.

---

## 04 — Priority Actions & Recommendations

The final page translates the analytical findings into a prioritized
action plan.

### P0 — Fix RJ Delivery Performance

Investigate the operational drivers behind RJ's below-benchmark
delivery performance and address the highest-impact causes of delay.

### P1 — Fix BA Delivery Performance

Investigate delivery bottlenecks in BA and prioritize improvements
toward the national benchmark.

### P2 — Fix ES Delivery Performance

Investigate delivery performance in ES given its combination of
below-benchmark reliability and meaningful revenue exposure.

### P3 — Investigate Office Furniture Quality

Investigate category-level quality drivers because Office Furniture
remains below the platform review average even when orders are
delivered on time.

---

# Key Findings

| Area | Finding |
|---|---|
| Delivery | **93.23%** of eligible orders were delivered on time |
| Delivery gap | **6.77%** were not delivered on time |
| Revenue exposure | **$1.74M / 10.86%** of revenue associated with deliveries that were not on time |
| Customer experience | Review scores fall from **4.29 → 2.27 → 1.75** across on-time, late, and undelivered outcomes |
| Delivery priority | **RJ, BA, and ES** identified for logistics intervention |
| Category quality | **Office Furniture: 3.62 overall / 3.76 on-time** |

---

# Business Recommendation

The analysis supports a **two-track improvement strategy**.

### 1. Prioritize Delivery Performance

Focus operational investigation on **RJ, BA, and ES**, where delivery
performance is below the national benchmark and the associated revenue
base makes improvement more consequential.

### 2. Investigate Product/Seller Quality

Treat **Office Furniture** as a separate quality problem rather than
assuming delivery is the sole driver of customer dissatisfaction.

This distinction prevents Olist from applying a single logistics
solution to problems that may have different underlying causes.

---

# Technical Stack

### SQL Server / SSMS
- Analytical data modeling
- SQL views
- Order-level and order-item-level data preparation
- Delivery-status derivation
- Review deduplication
- Payment aggregation
- Table joins

### Power BI
- Data modeling
- Interactive dashboard development
- KPI cards
- Analytical visualizations
- Cross-filtering
- Executive reporting

### DAX
- KPI development
- Delivery performance measures
- Revenue exposure measures
- Customer metrics
- Review-score analysis
- Benchmark/variance analysis

### Power Query
- Data transformation
- Data preparation
- Loading and shaping data for the Power BI model

---

# Skills Demonstrated

- SQL data modeling
- Relational joins and aggregation
- Window functions
- Data transformation
- Power BI data modeling
- DAX measure development
- KPI design
- Data visualization
- Exploratory data analysis
- Geographic segmentation
- Revenue-risk analysis
- Customer satisfaction analysis
- Category benchmarking
- Root-cause analysis
- Business prioritization
- Data storytelling
- Recommendation development

---

# Dashboard Preview

## Overview

![Overview](screenshots/overview.png)

## Delivery Performance

![Delivery Performance](screenshots/delivery-performance.png)

## Quality & Category

![Quality & Category](screenshots/quality-category.png)

## Recommendations

![Recommendations](screenshots/recommendations.png)

---

# Repository Structure

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
├── sql/
│   └── final_views.sql
│
├── dax/
│   └── measures.md
│
└── documentation/
    └── data-model.md