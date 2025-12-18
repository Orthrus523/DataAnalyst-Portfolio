--aggregations for today!!

CREATE TABLE sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT,
    product TEXT,
    quantity INT,
    price NUMERIC,
    sale_date DATE  --creating a dummy table to practice few conceptts!
);


INSERT INTO sales (customer_id, product, quantity, price, sale_date) VALUES
(1, 'Laptop',     1, 60000, '2025-01-10'),
(1, 'Mouse',      2,  500,  '2025-01-10'),
(2, 'Laptop',     1, 60000, '2025-01-11'),
(2, 'Keyboard',   1, 1500,  '2025-01-11'),
(3, 'Laptop',     2, 60000, '2025-01-12'),
(3, 'Mouse',      1,  500,  '2025-01-12'),
(3, 'Headset',    1, 3000,  '2025-01-12');

SELECT SUM(quantity) AS total_qty
FROM sales;  -- here i summed quantity of prod's that was sold came as 9

SELECT AVG(price) AS avg_price
FROM sales;  --this made the average amount from price column as 26,500

SELECT MIN(price) AS min_price
FROM sales; --shows min price is 500

SELECT MAX(price) AS max_price
FROM sales;  --here shows me 60k is the max price in tables

SELECT COUNT(*) AS total_rows
FROM sales;  --here v have 7 rows in total in table.

SELECT COUNT(DISTINCT product)
FROM sales;  --this gave me 4 unique product v have

SELECT product, SUM(quantity) AS total_qty
FROM sales
GROUP BY product;  --this grouping shows the product like laptop and v also summed quantites v have is 4 for lap

SELECT product, SUM(quantity) AS total_qty
FROM sales
GROUP BY product
HAVING SUM(quantity) > 2;  -- as it is aggregated func v r using having here to filter the prods quantity atleast 2 abv

SELECT product, SUM(quantity * price) AS revenue
FROM sales
GROUP BY product
ORDER BY revenue DESC;  --seperating products..multiplies quan and price with sum and based on revenue v making the order view
 
SELECT *
FROM sales
WHERE product = 'Laptop'
  AND quantity >= 1;  --this AND filters me the laptop rows which quantity atlleast  one or more

SELECT *
FROM sales
WHERE product = 'Mouse'
   OR product = 'Keyboard';  --this OR shows me mouse or keyboard from row..want both to show??
   --we cant use AND for this because one row cannot have two different values in the same column at the same time
   --instead v can use IN like below mentioning product in where 
SELECT *
FROM sales
WHERE product IN ('Mouse','Keyboard');

SELECT *
FROM sales
WHERE product NOT IN ('Mouse');  --similarly if v want to exclude sumtg like mouse for view v use not in

SELECT customer_id, SUM(quantity*price) AS revenue
FROM sales
GROUP BY customer_id
ORDER BY revenue DESC
LIMIT 2;  -- we can use this all combined with limit to c the top revenues of this table!

SELECT * FROM sales
WHERE sale_date BETWEEN '2025-01-10' AND '2025-01-11';  --we can use between specifyng dates/values to get in sepecific ranges



