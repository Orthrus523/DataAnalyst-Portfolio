
--so today we re seeing subqueries-> which means query inside a query

--Instead of executing two queries 
--you can combine them into one making the first query as a subquery and the second query as the main query!!!

select * from india_sales_raw


--v can call this as a scalar subquery meansn it returns a single value v can use this same where single value is expected in where/having
SELECT
    customer_name,
    (quantity * unit_price) AS order_value,  --so here v select the customer name to classify and price of one prod and no of quan purchased so v can calc the total amount
    (SELECT AVG(quantity * unit_price) FROM india_sales_raw) AS avg_order_value  --with use of this v can see the overall sales revenue like a each order vs average ordr from whole sales
FROM india_sales_raw;

--so this query v tried basically cleans the data make every cities same to filter and handle not miss any data also v used having to check more than one record for more filteration
SELECT *
FROM india_sales_raw
WHERE TRIM(LOWER(city)) IN (
    SELECT TRIM(LOWER(city))
    FROM india_sales_raw
    GROUP BY TRIM(LOWER(city))
    HAVING COUNT(*) > 1
);
select* from india_sales_raw

--so this methd is called derived table so basically inner query run trim n clean city and 
--generate each records value and outer query sum it and shows total revenue of city grouped

SELECT city_clean, COUNT(*) AS orders
FROM (
    SELECT TRIM(LOWER(city)) AS city_clean
    FROM india_sales_raw
) AS t
GROUP BY city_clean;


SELECT city_clean, SUM(order_value) AS revenue
FROM (
    SELECT
        TRIM(LOWER(city)) AS city_clean,
        quantity * unit_price AS order_value
    FROM india_sales_raw
) AS cleaned
GROUP BY city_clean
ORDER BY revenue DESC;

select * from india_sales_raw

 
--we can call it as correlated query whr outer drived inner each time
SELECT
    t.customer_name,
    t.product,
    t.quantity * t.unit_price AS order_value,
    (
        SELECT SUM(quantity * unit_price)
        FROM india_sales_raw AS x
        WHERE TRIM(LOWER(x.customer_name)) = TRIM(LOWER(t.customer_name))
    ) AS total_customer_spending
FROM india_sales_raw AS t;



