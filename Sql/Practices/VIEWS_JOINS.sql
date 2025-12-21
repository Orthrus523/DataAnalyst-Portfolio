--lessgo for (views) and JOIN today!

--so wat is views? a virtual table created from a select ..is like a query saved with my name not in the db


CREATE VIEW vw_clean_sales AS  ---creating a view
SELECT
    txn_id,
    TRIM(LOWER(customer_name)) AS customer_name,
    TRIM(LOWER(city)) AS city,
    UPPER(state) AS state,
    product,
    quantity,
    unit_price,
    order_date
FROM india_sales_raw; --with all this inside func to be implmnt from this table ...so v need to excecute the whole query agn instd use elect to c results

select * from vw_clean_sales;  -- v can see the results!!

--wat if table is updated will it get update?

UPDATE india_sales_raw
SET customer_name = 'ramesh'  --here v updated the org data
WHERE txn_id = 1;

select * from vw_clean_sales;  --yes! ramesh is got  ipdated

DROP VIEW vw_clean_sales;  -- vjuz dropped the view after using lyk a temp table..aftr u run select it says doesn exist!! now.

--now joins!

--lets add sum dummy tables

CREATE TABLE custom (
    customer_id SERIAL PRIMARY KEY,
    customer_name TEXT,
    phone TEXT,
    city TEXT,
    state TEXT
);

CREATE TABLE orrder (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    product TEXT,
    quantity INT,
    unit_price NUMERIC,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES custom(customer_id)
);

select * from custom
INSERT INTO custom (customer_name, phone, city, state) VALUES
('Ramesh Kumar', '9876543210', 'Chennai', 'Tamil Nadu'),
('Anita Sharma', '9123456789', 'Bengaluru', 'Karnataka'),
('Mohammed Ali', NULL, 'Hyderabad', 'Telangana'),
('Priya Iyer', '9876501234', 'Chennai', 'Tamil Nadu');

INSERT INTO orrder (customer_id, product, quantity, unit_price, order_date) VALUES
(1, 'Laptop - Dell', 1, 62000, '2025-01-03'),
(1, 'Wireless Mouse', 1, 699, '2025-01-05'),
(2, 'Bluetooth Headset', 1, 2499, '2025-01-04'),
(4, 'Laptop - HP', 1, 58000, '2025-01-05');

--lets try simple inner join

select 
c.customer_name,
c.city,
o.product,
o.order_date
from custom c inner join orrder o on o.customer_id = c.customer_id; --done! v showcased the name city from custom table and prod and orderdate from orrder table in a single table

--left join
select 
c.customer_name,
c.city,
o.product,
o.order_date
from custom c left join orrder o on o.customer_id = c.customer_id; --it takes all data from left ..here ali is customer n didn purchased shows the name but missing values as no order shows null in table

--right join

select 
c.customer_name,
c.city,
o.product,
o.order_date
from custom c right join orrder o on o.customer_id = c.customer_id;--its a vice versa of left join

--full outer join

SELECT 
    c.customer_name,
    o.product
FROM custom c
FULL OUTER JOIN orrder o
    ON c.customer_id = o.customer_id;  --literally everytg from rows matching n avaialble rows in left n right tables ..missing goes null




