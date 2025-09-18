USE sql_project_p2;
SELECT count(*) FROM retail_sales;
--  Data Analysis & Business Key Problems & Answers
 
-- Q1. Write a SQL Query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM retail_sales WHERE sale_date ='2022-11-05';

-- Q2. Write a SQL Query to retreive all transaction where the category is clothing and quantity is more than 4 and from the month of NOV-2022
SELECT * FROM retail_sales WHERE category='Clothing' AND quantiy>='4' AND DATE_FORMAT(sale_date, '%Y-%m') ='2022-11';

--  Q3. Write a SQL Query to calculate the total sales (total_sale) for each category
SELECT category, sum(total_sale) FROM retail_sales GROUP BY category;

--  Q4. Write a SQL Query to find average age of customers who purchased items from the 'Beauty' category
SELECT category ,ROUND(AVG(age)) AS AVG_AGE  FROM retail_sales WHERE category='Beauty';

--  Q5. Write a SQL Query to find all transactions where total_sale is more than 1000
SELECT * FROM retail_sales WHERE total_sale > 1000;

--  Q6. Write a SQL Query to find total number of transactions (transaction_id) made by each gender in each category
SELECT COUNT(transactions_id),gender,category FROM retail_sales GROUP BY gender,category;

-- Q7.write a sql query to calculate the average sale for each month.find out best selling month to each year
WITH MONTHLY_SALE AS(
SELECT 
YEAR(sale_date) AS year_sale,
MONTH(sale_date) AS month_sale,
SUM(total_sale) AS total_monthly_sale
FROM retail_sales
GROUP BY 1,2
),
RANKED_SALE AS(SELECT *,
RANK() OVER(PARTITION BY year_sale ORDER BY total_monthly_sale DESC) AS sale_rank FROM MONTHLY_SALE)
SELECT year_sale,month_sale,total_monthly_sale FROM RANKED_SALE WHERE year_sale=1;
 
--  Q8. Write a SQL Query to find the top 5 customers based on the highest total sales
SELECT customer_id,SUM(total_sale) FROM retail_sales GROUP BY 1 ORDER BY 2 DESC LIMIT 5;

--  Q9. Write a SQL Query to find the number of unique customers who purchased items from each category
SELECT COUNT(DISTINCT(customer_id)),category FROM retail_sales GROUP BY category;

--  Q10. Write a SQL Query to create each shift and number of orders (Example Morning <=12,Afternoon Between 12 & 17 , Evening >17)
WITH HOURLY_SALES AS(SELECT *, 
CASE
WHEN HOUR(sale_time)<12 THEN 'MORNING'
WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
ELSE 'EVENING'
END AS shift
FROM retail_sales
) 
SELECT shift,COUNT(*) AS TOTAL_ORDER FROM HOURLY_SALES GROUP BY shift;







