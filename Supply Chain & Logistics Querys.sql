SELECT * FROM supplychain_data

-- Basic Cleaning, Checking Missing Values, Duplicates

SELECT SKU, COUNT(*) as Duplicate_count 
FROM supplychain_data
GROUP BY SKU
HAVING COUNT(*) > 1

SELECT
	SUM(CASE WHEN Product_Category IS NULL THEN 1 ELSE 0 END) AS ProductCategory,
	SUM(CASE WHEN SKU IS NULL THEN 1 ELSE 0 END) AS SKU,
	SUM(CASE WHEN Sales_Revenue IS NULL THEN 1 ELSE 0 END) AS Revenue,
	SUM(CASE WHEN Supplier IS NULL THEN 1 ELSE 0 END) AS Supplier
FROM supplychain_data

SELECT DISTINCT Product_Category FROM supplychain_data
SELECT DISTINCT Customer_Gender FROM supplychain_data
SELECT DISTINCT Shipping_Carrier FROM supplychain_data
SELECT DISTINCT Supplier FROM supplychain_data
SELECT DISTINCT Supplier_Location FROM supplychain_data
SELECT DISTINCT Quality_Inspection_Status FROM supplychain_data
SELECT DISTINCT Transportation_Mode FROM supplychain_data
SELECT DISTINCT Delivery_Route FROM supplychain_data


-- Updateing Total Cost and Profit Cloumns by Creating View

CREATE VIEW vw_SupplyChain AS 
SELECT 
	*,
	(Manufacturing_Cost + Shipping_Cost + Transportation_Cost) AS TotalCost,
	(Sales_Revenue - (Manufacturing_Cost + Shipping_Cost + Transportation_Cost)) AS Profit
FROM supplychain_data

SELECT * FROM vw_SupplyChain


-- Revenue Analysis --

-- Total Revenue 
SELECT 
	SUM(Sales_Revenue) AS Total_Revenue 
FROM vw_SupplyChain

-- Revenue by Product Category 
SELECT
	Product_Category,
	SUM(Sales_Revenue) AS Revenue_By_Category 
FROM vw_SupplyChain
GROUP BY Product_Category

-- Revenue by Supplier Name 
SELECT
	Supplier,
	SUM(Sales_Revenue) AS Revenue_By_Supplier 
FROM vw_SupplyChain
GROUP BY Supplier

-- Revenue by Shipping Carrier 
SELECT
	Shipping_Carrier,
	SUM(Sales_Revenue) AS Revenue_By_Shipping_Carrier
FROM vw_SupplyChain
GROUP BY Shipping_Carrier

-- Revenue by Customer Gender
SELECT
	Customer_Gender,
	SUM(Sales_Revenue) AS Revenue_By_Customer_Gender
FROM vw_SupplyChain
GROUP BY Customer_Gender

-- Top 5 SKU by Revenue 
SELECT
	TOP 5 SKU,
	SUM(Sales_Revenue) AS Total_Sales
FROM vw_SupplyChain
GROUP BY SKU

-- Rank Products by Revenue
SELECT
	SKU,
	Product_Category,
	Sales_Revenue,
	RANK() OVER(ORDER BY Sales_Revenue) AS Revenue_Rank
FROM vw_SupplyChain

-- Rank Products Within Each Category
SELECT
    Product_Category,
    SKU,
    Sales_Revenue,
    RANK() OVER(
        PARTITION BY Product_Category
        ORDER BY Sales_Revenue DESC
    ) AS Category_Rank
FROM vw_SupplyChain;


-- Inventory Analysis --

-- Average Inventory Level 
SELECT
	Product_Category,
	AVG(Current_Inventory) AS Avg_Inventory_Level
FROM vw_SupplyChain
GROUP BY Product_Category

-- Lowest Inventory Products 
SELECT
	TOP 10
	SKU,
	Product_Category,
	Current_Inventory
FROM vw_SupplyChain
ORDER BY Current_Inventory

-- Highest Inventory Products 
SELECT
	TOP 10
	SKU,
	Product_Category,
	Current_Inventory
FROM vw_SupplyChain
ORDER BY Current_Inventory DESC

-- Average Order Quantity 
SELECT
	Product_Category,
	AVG(Order_Quantity) AS Avg_Order_Quantity
FROM vw_SupplyChain
GROUP BY Product_Category

-- Average Availability 
SELECT
	Product_Category,
	AVG(Product_Availability) AS Avg_Product_Availability
FROM vw_SupplyChain
GROUP BY Product_Category


-- Supplier Analysis --

-- Revenue AND Manufacturing Cost by Supplier 
SELECT
	Supplier,
	SUM(Sales_Revenue) AS Total_Revenue,
	SUM(Manufacturing_Cost) AS Total_Manufacturing_Cost
FROM vw_SupplyChain
GROUP BY Supplier
ORDER BY SUM(Sales_Revenue) DESC

-- Average Supplier Lead Time 
SELECT
	Supplier,
	AVG(Supplier_Lead_Time_Days) AS AVG_Supplier_Lead_Time
FROM vw_SupplyChain
GROUP BY Supplier

-- Average Defect Rate 
SELECT
	Supplier,
	ROUND(AVG(Defect_Rate), 2) AS AVG_Defect_Rate
FROM vw_SupplyChain
GROUP BY Supplier

-- Profit by Supplier 
SELECT
	Supplier,
	SUM(Profit) AS Total_Profit_by_Supplier
FROM vw_SupplyChain
GROUP BY Supplier


-- Logistics Analysis --

-- Shipping Cost by Carrier 
SELECT
	Shipping_Carrier,
	SUM(Shipping_Cost) AS Shipping_Cost_By_Carrier
FROM vw_SupplyChain
GROUP BY Shipping_Carrier

-- Transportation Cost by Mode 
SELECT
	Transportation_Mode,
	SUM(Transportation_Cost) AS Transportation_Cost_By_Mode
FROM vw_SupplyChain
GROUP BY Transportation_Mode

-- Shipping Time by Carrier 
SELECT
	Shipping_Carrier,
	SUM(Shipping_Time_Days) AS Shipping_Time_By_Carrier
FROM vw_SupplyChain
GROUP BY Shipping_Carrier

-- Delivery Route Performance 
SELECT
    Delivery_Route,
    SUM(Sales_Revenue) AS Total_Revenue,
    SUM(Transportation_Cost) AS Transportation_Cost,
    ROUND(AVG(Shipping_Time_Days),2) AS Avg_Shipping_Time,
    ROUND(AVG(Supplier_Lead_Time_Days),2) AS Avg_Lead_Time,
    SUM(Profit) AS Total_Profit
FROM vw_SupplyChain
GROUP BY Delivery_Route
ORDER BY Total_Revenue DESC;


-- Quality Analysis --

-- Inspection Status Count 
SELECT
	Quality_Inspection_Status,
	COUNT(Quality_Inspection_Status) AS Inspection_Status
FROM vw_SupplyChain
GROUP BY Quality_Inspection_Status
ORDER BY Inspection_Status

-- Average Defect Rate by Product Category 
SELECT
	Product_Category,
	AVG(Defect_Rate) AS AVG_Defect_Rate
FROM vw_SupplyChain
GROUP BY Product_Category
ORDER BY AVG_Defect_Rate

-- Average Defect Rate by Supplier 
SELECT
	Supplier,
	AVG(Defect_Rate) AS AVG_Defect_Rate
FROM vw_SupplyChain
GROUP BY Supplier
ORDER BY AVG_Defect_Rate








