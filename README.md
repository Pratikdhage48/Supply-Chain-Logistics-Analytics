# 📦 Supply Chain & Logistics Analytics Dashboard

End-to-end analytics project covering data cleaning, SQL analysis, Python EDA, and an interactive Power BI dashboard for supply chain, inventory, supplier, and logistics performance.

> **Tech Stack:** Microsoft SQL Server 2022 · Python (Pandas, Numpy, Matplotlib, Seaborn) · Jupyter Notebook · Power BI . Excel

---

## 📖 Project Overview

This project analyzes an end-to-end supply chain dataset — sales, inventory, suppliers, manufacturing, quality, and logistics — and turns it into a 3-page interactive Power BI dashboard, backed by SQL views/queries and a Python (Pandas/Seaborn) EDA notebook.

## ❓ Problem Statement

Supply chain data at the company is spread across sales, inventory, supplier, manufacturing, and logistics functions, making it hard for management to spot high-cost areas, inventory risk, underperforming suppliers, and the most profitable products in one place.

## 🎯 Business Objective

Consolidate the data into a single model and build an interactive dashboard that helps management:
- Track revenue, profit, and cost across products, suppliers, and carriers
- Monitor inventory health and identify restocking risk
- Evaluate supplier reliability (lead time, defect rate)
- Compare logistics providers and delivery routes on cost and speed

## 🗂️ Dataset Information

| Attribute | Details |
|---|---|
| Grain | One row per SKU / order record |
| Key fields | Product Category, SKU, Unit Price, Product Availability (%), Units Sold, Sales Revenue, Customer Gender, Current Inventory, Order Lead Time, Order Quantity, Supplier, Supplier Location, Supplier Lead Time, Manufacturing Cost, Manufacturing Lead Time, Defect Rate (%), Quality Inspection Status, Shipping Carrier, Shipping Cost, Shipping Time, Transportation Mode, Transportation Cost, Delivery Route |
| Format | CSV, loaded into SQL Server and Pandas |

> **Note:** The raw CSV file was not included in the uploaded project files, so exact row/column counts could not be independently verified for this documentation — insert the actual `df.shape` output from the notebook here once confirmed.

## 🛠️ Tools & Technologies

| Category | Tools |
|---|---|
| Database | SQL Server (T-SQL, Views, Window Functions) |
| Programming | Python (Pandas, NumPy) |
| Visualization | Matplotlib, Seaborn, Power BI |
| BI / Dashboard | Power BI Desktop (slicers, decomposition tree, DAX measures) |

## 🏗️ Project Architecture / Workflow

```
Raw CSV Data
     │
     ▼
SQL Server  →  Data cleaning checks, vw_SupplyChain (Total Cost, Profit)
     │
     ▼
Python (Pandas/Seaborn) → Cleaning, feature engineering, EDA, visual insights
     │
     ▼
Power BI  →  Data model, DAX measures, 3-page interactive dashboard
     │
     ▼
Business Insights & Recommendations
```

## 🧹 Data Cleaning Process

**SQL** (`Supply Chain & Logistics Querys.sql`):
- Checked for duplicate `SKU` records
- Checked for `NULL` values in `Product_Category`, `SKU`, `Sales_Revenue`, `Supplier`
- Reviewed distinct values for categorical fields (`Product_Category`, `Customer_Gender`, `Shipping_Carrier`, `Supplier`, `Supplier_Location`, `Quality_Inspection_Status`, `Transportation_Mode`, `Delivery_Route`) to catch inconsistent labels

**Python** (`Supply_Chain_&_Logistics.ipynb`):
- `df.info()`, `df.describe()`, `df.describe(include='object')` to profile the data
- `df.isnull().sum()` for missing values
- `df[df.duplicated()]` for full-row duplicates
- Rounded float columns to 2 decimals
- Renamed verbose columns (e.g. `Order Lead Time (Days)` → `Order Lead Time`, `Current Inventory` → `Inventory Level`) for readability

## 📊 Exploratory Data Analysis (EDA)

Performed in Python with Matplotlib/Seaborn:
- Product category distribution (pie chart)
- Revenue distribution and revenue by category/supplier (bar, histogram)
- Profit distribution and profit by category
- Defect rate by supplier
- Shipping cost by carrier
- Inventory level distribution and by category (pie, histogram)
- Inventory status distribution
- Unit Price vs Units Sold scatter (by category)
- Correlation heatmap across numeric fields
- Boxplots for Sales Revenue, Shipping Cost, and Profit Margin (outlier check)
- Pairplot across Unit Price, Sales Revenue, Profit, Inventory Level, Units Sold

## ⚙️ Feature Engineering

New columns created for business analysis:

| Column | Logic |
|---|---|
| `Total Cost` | `Manufacturing Cost + Shipping Cost + Transportation Cost` |
| `Profit` | `Sales Revenue − Total Cost` |
| `Profit Margin (%)` | `Profit / Sales Revenue × 100` |
| `Inventory Status` | `Low` (≤30), `Medium` (31–70), `High` (>70), based on `Inventory Level` |

## 🗃️ SQL Analysis

A `vw_SupplyChain` view adds `TotalCost` and `Profit` on top of the raw table. Query groups cover:
- **Revenue:** total revenue, revenue by category/supplier/carrier/gender, top-5 SKUs, `RANK()` of products overall and within category
- **Inventory:** average inventory by category, highest/lowest inventory SKUs, average order quantity, average product availability
- **Supplier:** revenue and manufacturing cost by supplier, average lead time, average defect rate, profit by supplier
- **Logistics:** shipping cost by carrier, transportation cost by mode, shipping time by carrier, delivery route performance (revenue, cost, avg shipping/lead time, profit)
- **Quality:** inspection status counts, average defect rate by category/supplier

## 🐍 Python Analysis

The notebook (`Supply_Chain_&_Logistics.ipynb`) covers business problem framing, EDA, feature engineering, and a conclusion/recommendations section, using `pandas`, `numpy`, `matplotlib`, and `seaborn`.

## 📈 Power BI Dashboard

Three pages, connected by a shared slicer panel and left-hand navigation:

### 1. Executive Overview
KPI cards (Total Revenue, Total Units Sold, Total Profit, Profit Margin %, Total Cost, Total Inventory Level) plus Revenue by Product, Revenue by Supplier, Revenue by Shipping Carrier, Top 5 SKU by Revenue, Revenue by Customer Gender, and a Revenue-by-Supplier tree map.

### 2. Product & Inventory Analysis
Top 10 SKU by Revenue, Inventory Level by Product, Profit Margin by Product, Average Order Lead Time by Product, Inventory Status by SKU (donut), Revenue by Inventory Status, and a Revenue decomposition tree (Category → Supplier → Carrier → Transport Mode → Location → Inspection Status).

### 3. Supplier & Logistics
KPI cards (Average Shipping Cost, Average Transportation Cost, Average Supplier Lead Time, Average Defect Rate), Manufacturing Cost by Supplier, Transportation Cost by Mode, Shipping Cost by Carrier, Defect Rate by Supplier, Transportation Cost by Delivery Route, a Supplier Lead Time vs Defect Rate scatter, and a full supplier cost/profit table.

*(Insert dashboard screenshots here: `/screenshots/executive_overview.png`, `/screenshots/product_inventory.png`, `/screenshots/supplier_logistics.png`)*

## 🖥️ Dashboard Pages Explanation

See [Power BI Dashboard](#-power-bi-dashboard) above for a page-by-page breakdown of visuals and their purpose.

## 💡 Key Business Insights

- **Skincare** is the top revenue-generating category (₹241.63K), ahead of Haircare (₹174.46K) and Cosmetics (₹161.52K).
- **Global Supply Ltd** is the leading supplier by revenue contribution (~₹158K) but also carries a high manufacturing cost (~₹1,222) and mid-range defect rate.
- **DTDC** handles the largest share of shipped revenue (₹250.09K) among the three carriers tracked.
- Female customers drive **59.13%** of revenue versus 40.87% from male customers.
- **Route A** carries the highest transportation cost (2.2K) of the three delivery routes, well above Route B and C.
- Inventory is fairly balanced: 41.71% of revenue sits in "Medium" inventory-status SKUs, 35.53% in "Low," and 22.76% in "High," suggesting a meaningful share of revenue-driving products may be under-stocked.
- **Elite Distributors** has the lowest defect-rate figure and lowest manufacturing cost among the five suppliers, but also the lowest revenue contribution — a possible quality-vs-scale trade-off worth investigating further.

## ✅ Business Recommendations

1. Prioritize inventory replenishment for "Low" and "Medium" status SKUs that are already high-revenue, to avoid stockouts on best-sellers.
2. Review **Prime Manufacturing** and **Global Supply Ltd** — the two highest cumulative defect-rate suppliers in the table — for quality-improvement plans or renegotiation.
3. Evaluate whether volume can be shifted from Route A toward the lower-cost Route B/C without hurting delivery performance.
4. Benchmark **Blue Dart** and **Delhivery** against **DTDC** on cost-per-shipment, since DTDC currently carries the most shipping cost and revenue share.
5. Fix the **Average Defect Rate (%)** measure (currently showing 227.71%, which is not a valid percentage) before sharing this dashboard externally — see the Review section for the likely cause.

## 📁 Project Folder Structure

```
Supply-Chain-Logistics-Analytics/
│
├── data/
│   └── supply_chain_data.csv          # (not included in upload — add source data here)
│
├── sql/
│   └── Supply_Chain_&_Logistics_Queries.sql
│
├── notebook/
│   └── Supply_Chain_&_Logistics.ipynb
│
├── dashboard/
│   └── Supply_Chain_&_Logistics_Report.pbix
│
├── screenshots/
│   ├── executive_overview.png
│   ├── product_inventory.png
│   └── supplier_logistics.png
│
├── README.md
└── requirements.txt                    # (not included — add pandas, numpy, matplotlib, seaborn)
```

## 🚀 Future Improvements

- Fix the Average Defect Rate DAX measure and the SQL `RANK()` / `TOP 5` ordering issues (see Review section)
- Add a `requirements.txt` and remove the hardcoded local file path in the notebook
- Add row-level data validation (defect rate bounds, negative cost/revenue checks)
- Extend the model with a time dimension (currently no date field is used) to support trend analysis
- Add row-level counts / data dictionary to this README once the source CSV is available
- Publish the dashboard to Power BI Service and link it here

# 📊 Dashboard Preview

 ![Dashboard](https://raw.githubusercontent.com/Pratikdhage48/Supply-Chain-Logistics-Analytics/main/Executive_Overview.jpg)
 ![Dashboard](https://raw.githubusercontent.com/Pratikdhage48/Supply-Chain-Logistics-Analytics/main/Product_&_Inventory_Analysis.jpg)
 ![Dashboard](https://raw.githubusercontent.com/Pratikdhage48/Supply-Chain-Logistics-Analytics/main/Supplier_&_Logistics_Analysis.jpg)
