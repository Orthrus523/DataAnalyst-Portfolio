--Replace NULL paint colors with 'unknown' and show counts.

select coalesce(paint, 'unknown') as unk_count , 
count(*) from cars 
group by unk_count ;
-----------
SELECT
  CASE
    WHEN paint IS NULL THEN 'unknown'
    ELSE paint
  END AS paint_color,
  COUNT(*) AS car_count
FROM cars
GROUP BY paint_color;
-----------

--Find manufacturers with NULL or blank names.

select Count(*) from cars where manufacturer is null or trim(manufacturer) = '';


--Standardize manufacturer names to lowercase and show duplicates created by casing.

SELECT LOWER(manufacturer)as low_man,count(*) as countt
from cars
group by LOWER(manufacturer)
having count(*)>1;

--Find rows where model is missing but manufacturer exists.

SELECT model,manufacturer 
from cars 
where (model is null or TRIM(model)='') and manufacturer is not null and TRIM(manufacturer) <> '';

--Identify years where more than 10% of rows have NULL paint.

SELECT
  year,
  COUNT(*) AS total_rows,
  COUNT(*) FILTER (WHERE paint IS NULL) AS null_paint_rows
FROM cars
GROUP BY year
HAVING
  COUNT(*) FILTER (WHERE paint IS NULL) 
  > 0.10 * COUNT(*);

