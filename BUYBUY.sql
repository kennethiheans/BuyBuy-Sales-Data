SELECT *
FROM sales_data;

/*Write a query that returns the total profit made by BuyBuy from 1Q11 to 4Q16 (all
quarters of every year).*/

SELECT SUM(revenue-cost)AS total_profit, sales_year, 
DATE_PART('quarter',sales_date)AS quarter
FROM sales_data
WHERE sales_date BETWEEN '2011-01-01' and '2016-12-31'
GROUP BY DATE_PART('quarter', sales_date), sales_year
ORDER BY DATE_PART('quarter', sales_date),sales_year ASC;

/*Write queries that return the total profit made by BuyBuy in Q2 of every year from
2011 to 2016.*/

SELECT SUM(revenue-cost)AS total_profit, sales_year,
DATE_PART('quarter', sales_date)AS quarter
FROM sales_data
WHERE DATE_PART('quarter', sales_date) = 2 AND sales_date
BETWEEN '2011-01-01' and '2016-12-31'
GROUP BY DATE_PART('quarter', sales_date), sales_year
ORDER BY DATE_PART('quarter', sales_date), sales_year ASC;

/*Write a query that returns the annual profit made by BuyBuy from the year 2011 to
2016.*/

SELECT SUM (revenue - cost)AS annual_profit, sales_year
FROM sales_data
WHERE sales_year BETWEEN '2011' AND '2016'
GROUP BY sales_year
ORDER BY sales_year ASC;

2. /*Write 2 queries that return the countries where BuyBuy has made the most profit
and also the least profit of all-time. Your query must display both results on the
same output.*/

SELECT SUM(revenue-cost)AS max_profit, cus_country
FROM sales_data
GROUP BY cus_country
ORDER BY max_profit DESC;

SELECT SUM(revenue-cost)AS min_profit, cus_country
FROM sales_data
GROUP BY cus_country
ORDER BY min_profit ASC;

/*Write a query that shows the Top-10 most profitable countries for BuyBuy sales
operations from 2011 to 2016*/

SELECT SUM(revenue-cost)AS profit, cus_country AS profitable_country
FROM sales_data
WHERE sales_year BETWEEN '2011' AND '2016'
GROUP BY cus_country
ORDER BY profit DESC;

/*Write a query that shows the all-time Top-10 least profitable countries for BuyBuy
sales operations*/

SELECT SUM(revenue-cost)AS profit, cus_country AS profitable_country
FROM sales_data
WHERE sales_year BETWEEN '2011' AND '2016'
GROUP BY cus_country
ORDER BY profit ASC;

3. /*Write a query that ranks all product categories sold by Buybuy, from least amount
to the most amount of all-time revenue generated.*/

SELECT SUM(revenue-cost)AS profit, cost, prod_category
FROM sales_data
GROUP BY cost, prod_category
ORDER BY profit ASC;

/*Write a query that returns Top-2 product categories offered by Buybuy with an
all-time high number of units sold.*/

SELECT prod_category, SUM (ord_quantity)AS highest_sold
FROM sales_data
GROUP BY prod_category
ORDER BY highest_sold DESC LIMIT 2;

/*Write a query that shows the Top 10 highest-grossing products sold by BuyBuy
based on all-time profits*/

SELECT product, SUM(revenue)AS revenue, SUM(revenue-cost)AS profit
FROM sales_data
GROUP BY product, revenue
ORDER BY profit DESC LIMIT 10;

COPY(SELECT SUM(revenue-cost)AS total_profit, sales_year,
DATE_PART('quarter', sales_date)AS quarter
FROM sales_data
WHERE DATE_PART('quarter', sales_date) = 2 AND sales_date
BETWEEN '2011-01-01' and '2016-12-31'
GROUP BY DATE_PART('quarter', sales_date), sales_year
ORDER BY DATE_PART('quarter', sales_date), sales_year ASC
) TO 'C:\Buybuy Sales Data.csv' DELIMITER ',' CSV HEADER;

COPY(SELECT SUM(revenue-cost)AS profit, cus_country AS profitable_country
FROM sales_data
WHERE sales_year BETWEEN '2011' AND '2016'
GROUP BY cus_country
ORDER BY profit DESC) TO 'C:\Users\Public\Buybuy Sales Data2.csv' DELIMITER ',' CSV HEADER;

COPY(SELECT prod_category, SUM (ord_quantity)AS highest_sold
FROM sales_data
GROUP BY prod_category
ORDER BY highest_sold DESC LIMIT 2) TO 'C:\Users\Public\Buybuy Sales Data3.csv' DELIMITER ',' CSV HEADER;