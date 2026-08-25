# Data Model

The Power BI model consists of two tables, both built from SQL Server
views (see [`sql/01_final_views.sql`](../sql/01_final_views.sql)).
There is no separate star schema with dimension tables — both tables
serve as fact tables at different grains, connected by a single
relationship.

---

## Tables

### `fact_orders`

**Grain:** one row per order.

Combines order, customer, review, and payment data.

| Column | Description |
|---|---|
| `order_id` | Unique order identifier (primary key for this table) |
| `customer_id` | Customer identifier for this order |
| `customer_unique_id` | Persistent customer identifier, stable across a customer's multiple `customer_id` records — used for repeat-customer measures |
| `customer_city` | Customer's city |
| `customer_state` | Customer's state (used for state-level delivery analysis) |
| `order_status` | Order status as recorded by Olist (e.g. delivered, shipped, canceled) |
| `order_purchase_timestamp` | Date/time the order was placed |
| `order_purchase_timestamp (bins) months` | Auto-generated Power BI date hierarchy bin, used for time-based visuals |
| `order_estimated_delivery_date` | Estimated delivery date given to the customer at purchase |
| `days_delivered` | Days between purchase and actual delivery |
| `delivery_status` | Derived field: `on time`, `not on time`, or `not delivered` (see `sql/01_final_views.sql` for the exact logic) |
| `review_score` | Most recent review score for the order (deduplicated — see `sql/02_data_quality_investigation.sql`) |
| `review_creation_date` | Date the review was created |
| `review_answer_timestamp` | Date the review was submitted/answered |
| `total_per_order` | Total payment value for the order, summed across payment installments |
| `Priority State Group` | Calculated column: returns the state name if it's one of the flagged states (`RJ`, `BA`, `ES`, `AL`, `SP`), otherwise blank. Used to selectively label priority states on map/chart visuals without cluttering non-priority states. |

### `fact_order_items`

**Grain:** one row per order item (an order with 3 products has 3 rows here).

Combines order line items with product and category data.

| Column | Description |
|---|---|
| `order_id` | Order identifier (foreign key to `fact_orders`) |
| `order_item_id` | Line-item number within the order |
| `product_id` | Product identifier |
| `seller_id` | Seller identifier |
| `price` | Item price |
| `freight_value` | Shipping/freight cost for the item |
| `product_category_name_english` | Product category, translated to English |
| `shipping_limit_date` | Seller's shipping deadline for the item |
| `Scatter Label` | Calculated column: returns the category name if it's one of a fixed set of categories of interest (e.g. Office Furniture, Bed Bath Table), otherwise blank. Used to label only specific categories on a scatter chart without cluttering the rest. |

---

## Relationship

```
fact_orders (1) ───< order_id >─── (*) fact_order_items
```

- **From:** `fact_orders[order_id]`
- **To:** `fact_order_items[order_id]`
- **Cardinality:** One-to-many — one order can have multiple order
  items.

This is a single-relationship model rather than a traditional star
schema: `fact_orders` carries order/customer/review/delivery context,
and `fact_order_items` carries product/category/pricing context. Most
dashboard measures live on `fact_orders`; category-level measures
(e.g. category review scores) live on `fact_order_items` so they can
be filtered by product category directly.

---

## Notes

- Both tables originate from the SQL views documented in
  [`sql/01_final_views.sql`](../sql/01_final_views.sql). No further
  joins happen inside Power BI beyond the one relationship above —
  the heavier joins (customers, reviews, payments, products, category
  translation) are resolved in SQL before the data reaches the model.
- For the full list of DAX measures built on top of these tables, see
  [`dax/measures.md`](../dax/measures.md).
