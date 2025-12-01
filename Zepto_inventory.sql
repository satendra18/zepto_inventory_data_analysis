select * from zepto limit 5;


-- product name present multiple times
SELECT name, Count(sku_id) as number_of_skus
FROM zepto
GROUP BY name 
HAVING Count(sku_id) > 1
ORDER BY number_of_skus DESC;



-- Data Cleaning

-- items with zero as price

Select name 
FROM zepto
WHERE discpunted_selling_price = 0 OR mrp = 0;

DELETE FROM zepto
WHERE name = 'Cherry Blossom Liquid Shoe Polish Neutral ';


-- convert paise to rupees

UPDATE zepto
SET mrp = mrp/100.0,
discpunted_selling_price = discpunted_selling_price/100.0;



--data analysis

-- Q1. Find the top 10 best-value products based on the discount percentage.

SELECT name, discount_percent
FROM zepto
ORDER BY discount_percent DESC
LIMIT 10;



--Q2.What are the Products with High MRP but Out of Stock

SELECT * 
FROM zepto
WHERE out_of_stock = True
AND mrp > 300
ORDER by mrp desc;


--Q3.Calculate Estimated Revenue for each category

SELECT category, SUM(discounted_selling_price * quantity) as revenue
FROM zepto
GROUP BY category
ORDER by revenue DESC;


-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.

SELECT name, mrp, discount_percent
FROM zepto 
WHERE mrp > 500
and discount_percent < 10
ORDER BY mrp DESC, discount_percent DESC;


-- Q5. Identify the top 5 categories offering the highest average discount percentage.

SELECT category, Round(AVG(discount_percent), 2) as avg_discount
from zepto
GROUP BY category 
ORDER by avg_discount DESC
LIMIT 5;


-- Q6. Find the price per gram for products above 100g and sort by best value.

SELECT name, ROUND(discounted_selling_price/weight_in_gms, 2) as price_per_gm
From zepto
WHERE weight_in_gms > 100
ORDER BY price_per_gm;

--Q7.Group the products into categories like Low, Medium, Bulk.

SELECT name, weight_in_gms,
CASE WHEN weight_in_gms >= 4000 THEN 'Bulk'
WHEN weight_in_gms >= 1000 THEN 'Medium' Else 'Low' END as weight_category
FROM zepto; 


--Q8.What is the Total Inventory Weight Per Category 

SELECT category, SUM(weight_in_gms * quantity/1000) as total_inventory_weight_in_kg
FROM zepto
GROUP BY category;








