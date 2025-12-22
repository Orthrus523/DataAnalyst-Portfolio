--today!! we gonna practice for window functions!

SELECT
    sale_id,
    customer_id,
    price,
    SUM(price) OVER (PARTITION BY customer_id) AS customer_total  --this partioned customer id in order with summing price and shows remaing col
FROM sales;

SELECT
    sale_id,
    customer_id,
    price,
    SUM(price) OVER (PARTITION BY customer_id order by sale_date) AS running_total  --similar to previous v can also make orderby colm which is opional
FROM sales;

SELECT
    sale_id,
    customer_id,
    sale_date,
    ROW_NUMBER() OVER (
        PARTITION BY customer_id  --Starts from 1 for each customer..which is Alwys unique
        ORDER BY sale_date
    ) AS sale_rank
FROM sales;

SELECT
    sale_id,
    customer_id,
    sale_date,
RANK() OVER (ORDER BY price DESC)  --> this ranks in tie and skip the gaps for eg-> 1,1,1 top r same score then 4 the person is 4
--1,1,1,4,5,5,7

    AS sale_rank
FROM sales;

SELECT
    sale_id,
    customer_id,
    sale_date,
DENSE_RANK() OVER (ORDER BY price DESC)  --> this fix the gap which rank lags
--1,1,1,2,3,3,4

    AS sale_rank
FROM sales;

SELECT *
FROM (
    SELECT *,
           PERCENT_RANK() OVER (ORDER BY price DESC) AS pr
    FROM sales  --this goes in range between 0->1 0 tops v used to c salary/revenue in percentage format
	--rank of the row - 1 /total no of rows -1
) t
WHERE pr <= 0.2;

--we seen ranking..now v ll c value 
--lag
SELECT
    sale_date,
    price,
    LAG(price) OVER (ORDER BY sale_date) AS prev_amount
FROM sales;  --first val comes null as it as no previous data remainig gets the previous and matches to show in current record with thta colm

SELECT
    sale_date,
    price,
    LEAD(price) OVER (ORDER BY sale_date) AS prev_amount  --vice versa of lag..shows the next value in the current row
FROM sales; 


select * from sales
--practice query
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY sale_date DESC
           ) AS rn
    FROM sales
) t
WHERE rn = 1; --> this is like window + filtering using the subqueries shows the latest order of the customer


SELECT
    sale_id,
    price,
    NTILE(4) OVER (ORDER BY price) AS quartile
FROM sales;  --as the data record is 8 it spilits equally to 4 as op v can split as per of or need

SELECT
    customer_id,
    sale_date,
    price,
    FIRST_VALUE(price) OVER (  -- this shows the first purchased amount for each customer in record
        PARTITION BY customer_id
        ORDER BY sale_date
    ) AS first_purchase_amount
FROM sales;

LAST_VALUE(amount) OVER ( --vice versa
    PARTITION BY customer_id
    ORDER BY order_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING  --neeeds this line coz w/o that current row’s amount return NOT the true last value means if added new data it stucks
) AS last_purchase_amount

SELECT
    price,
    NTH_VALUE(price, 3) OVER (  --this shows the 3rd value for all the rows of the record
        ORDER BY price
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS third_value
FROM sales;



