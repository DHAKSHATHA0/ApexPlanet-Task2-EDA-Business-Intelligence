
-- =====================================================
-- APEXPLANET INTERNSHIP - TASK 2
-- Exploratory Data Analysis & Business Intelligence
-- SQL Business Questions
-- Database: apexplanet_sales
-- Table: sales
-- =====================================================

USE apexplanet_sales;


-- Q1. What is the overall sales performance?

SELECT
    COUNT(*) AS total_orders,
    SUM(Quantity) AS total_items_sold,
    ROUND(SUM(Total_Sales), 2) AS total_revenue,
    ROUND(AVG(Total_Sales), 2) AS average_order_value
FROM sales;


-- Q2. Which products generate the highest revenue?

SELECT
    Product,
    SUM(Quantity) AS total_quantity_sold,
    COUNT(*) AS total_orders,
    ROUND(SUM(Total_Sales), 2) AS total_revenue
FROM sales
GROUP BY Product
ORDER BY total_revenue DESC;


-- Q3. Which cities generate the highest sales revenue?

SELECT
    City,
    COUNT(*) AS total_orders,
    ROUND(SUM(Total_Sales), 2) AS total_revenue
FROM sales
GROUP BY City
ORDER BY total_revenue DESC;


-- Q4. What is the revenue contribution of each category?

SELECT
    Category,
    COUNT(*) AS total_orders,
    SUM(Quantity) AS total_quantity,
    ROUND(SUM(Total_Sales), 2) AS total_revenue,
    ROUND(
        SUM(Total_Sales) * 100 /
        (SELECT SUM(Total_Sales) FROM sales),
        2
    ) AS revenue_percentage
FROM sales
GROUP BY Category
ORDER BY total_revenue DESC;


-- Q5. Which orders have sales above ₹200,000?

SELECT
    Order_ID,
    Order_Date,
    Customer_Name,
    City,
    Product,
    Quantity,
    Total_Sales
FROM sales
WHERE Total_Sales > 200000
ORDER BY Total_Sales DESC;


-- Q6. How do sales differ by gender?

SELECT
    Gender,
    COUNT(*) AS total_orders,
    SUM(Quantity) AS total_quantity,
    ROUND(SUM(Total_Sales), 2) AS total_revenue,
    ROUND(AVG(Total_Sales), 2) AS average_order_value
FROM sales
GROUP BY Gender
ORDER BY total_revenue DESC;


-- Q7. Who are the top 10 customers by purchase value?

CREATE TABLE IF NOT EXISTS customers AS
SELECT
    Customer_ID,
    MAX(Customer_Name) AS Customer_Name,
    MAX(City) AS City,
    MAX(Gender) AS Gender
FROM sales
GROUP BY Customer_ID;


SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.City,
    COUNT(s.Order_ID) AS total_orders,
    ROUND(SUM(s.Total_Sales), 2) AS total_purchase_value
FROM customers c
INNER JOIN sales s
    ON c.Customer_ID = s.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name,
    c.City
ORDER BY total_purchase_value DESC
LIMIT 10;
