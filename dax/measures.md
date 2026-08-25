# DAX Measures

This document lists the DAX measures used in the Olist Delivery &
Quality Analysis dashboard, grouped by purpose. Headline measures that
drive the dashboard's key findings are listed first; supporting
measures used internally (revenue decomposition, customer
segmentation, category/quality support) follow.

---

## Headline Measures

These measures directly power the KPI cards and key findings
referenced in the README.

### On-Time Delivery Rate
```dax
On-Time Delivery Rate =
DIVIDE(
    CALCULATE(
        COUNTROWS(fact_orders),
        fact_orders[order_status] = "delivered",
        fact_orders[delivery_status] = "on time"
    ),
    CALCULATE(
        COUNTROWS(fact_orders),
        fact_orders[order_status] = "delivered",
        fact_orders[delivery_status] IN {"on time", "not on time"}
    )
)
```
Share of delivered orders that arrived on or before the estimated
delivery date. Excludes "not delivered" orders from the denominator,
since they have no actual delivery date to compare against.

### Avg Review Score
```dax
Avg Review Score = AVERAGE(fact_orders[review_score])
```
Average customer review score across all orders with a review.

### Repeat Customer Rate
```dax
Repeat Customer Rate =
DIVIDE(
    COUNTROWS(
        FILTER(
            SUMMARIZE(
                fact_orders,
                fact_orders[customer_unique_id],
                "OrderCount", COUNTROWS(fact_orders)
            ),
            [OrderCount] > 1
        )
    ),
    DISTINCTCOUNT(fact_orders[customer_unique_id])
)
```
Share of unique customers (by `customer_unique_id`) who placed more
than one order.

### Total Revenue
```dax
Total Revenue = SUM(fact_orders[total_per_order])
```
Sum of total payment value across all orders.

### Total Orders
```dax
Total Orders = DISTINCTCOUNT(fact_orders[order_id])
```
Canonical order count for the dashboard, used on the Overview page's
"Total Orders" KPI card. Defined on `fact_order_items` so it can be
sliced by category alongside item-level measures, but counts distinct
`order_id` values from `fact_orders` to avoid inflating the count when
an order has multiple line items.

### Revenue at Risk
```dax
Revenue at Risk =
CALCULATE(
    SUM(fact_orders[total_per_order]),
    fact_orders[delivery_status] <> "on time"
)
```
Total revenue associated with orders that were not delivered on time
(includes both "not on time" and "not delivered" orders).

### Variance from Avg
```dax
Variance from Avg =
[On-Time Delivery Rate] - CALCULATE([On-Time Delivery Rate], ALL(fact_orders[customer_state]))
```
Difference between a given state's on-time delivery rate and the
national average, used to identify states performing below benchmark.

### Priority State
```dax
Priority State =
"RJ - " &
FORMAT(
    CALCULATE(
        [On-Time Delivery Rate],
        fact_orders[customer_state] = "RJ"
    ),
    "0.00%"
)
```
Displays a fixed callout label for RJ's on-time delivery rate (e.g.,
"RJ - 87.89%") on the Delivery Performance page. Intentionally scoped
to RJ rather than built as a dynamic per-state measure, since RJ is
the top delivery priority (P0) and the label is used as a static
annotation, not a slicer-driven value.

---

## Revenue Decomposition

Used to break "Revenue at Risk" down by delivery outcome, supporting
the analysis of *why* revenue is at risk (late vs. never delivered).

```dax
Delivered Revenue =
CALCULATE(
    SUM(fact_orders[total_per_order]),
    fact_orders[order_status] = "delivered"
)

On-Time Delivered Revenue =
CALCULATE(
    SUM(fact_orders[total_per_order]),
    fact_orders[order_status] = "delivered",
    fact_orders[delivery_status] = "on time"
)

Late Delivery Revenue =
CALCULATE(
    SUM(fact_orders[total_per_order]),
    fact_orders[order_status] = "delivered",
    fact_orders[delivery_status] = "not on time"
)

Revenue Without Delivery Outcome =
CALCULATE(
    SUM(fact_orders[total_per_order]),
    fact_orders[delivery_status] = "not delivered"
)

On-Time Revenue = [Total Revenue] - [Revenue at Risk]
```

---

## Customer Segmentation

```dax
Repeat Customers Count =
COUNTROWS(FILTER(VALUES(fact_orders[customer_unique_id]), CALCULATE(COUNTROWS(fact_orders)) > 1))

One-Time Customers Count =
DISTINCTCOUNT(fact_orders[customer_unique_id]) - [Repeat Customers Count]
```
Underlying counts behind `Repeat Customer Rate`, split into repeat vs.
one-time customers.

---

## Category & Quality Support

Used together to confirm Office Furniture's review score stays below
the platform average even among on-time orders — the basis for the
Office Furniture finding in the README's Key Findings.

```dax
Avg Review Score (On-Time Only) =
CALCULATE(
    [Avg Review Score],
    fact_orders[delivery_status] = "on time"
)

Platform Avg Review Score =
CALCULATE(
    [Avg Review Score],
    REMOVEFILTERS(fact_order_items[product_category_name_english])
)

Office Furniture Review Score =
CALCULATE(
    [Avg Review Score],
    fact_order_items[product_category_name_english] IN { "office_furniture", "Office Furniture" }
)

Category Order Count = DISTINCTCOUNT(fact_orders[order_id])

Order Count = COUNT(fact_orders[order_id])

Order Count (On-Time Only) =
CALCULATE([Order Count], fact_orders[delivery_status] = "on time")
```

---

## Display / Formatting Helpers

```dax
Revenue Custom Label =
IF(
    [Total Revenue] > 10000,
    FORMAT([Total Revenue] / 1000000, "$#,##0.00") & "M",
    BLANK()
)
```
Formats `Total Revenue` as a rounded "$X.XXM" string for display on
KPI cards.
