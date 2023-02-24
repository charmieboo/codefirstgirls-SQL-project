USE delightful_bakes;

--- TABLES
SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_details;
SELECT * FROM bakers;

--- VIEWS
SELECT * FROM cust_reviews;
SELECT * FROM cust_orders;

---------------------------------------------------------------------------------------
/* VIEW WITH JOINS
Using any type of the joins, create a view that combines multiple tables in a logical way.
---------------------------------------------------------------------------------------
VIEW 1: Creates a view with inner joins, to find what are our customer's reviews on our products.
Here, I will use three tables. */
CREATE VIEW cust_reviews AS
SELECT 
    c.customer_id, 
    p.product_name, 
    r.rating, 
    r.review_description 
FROM 
    customers c
INNER JOIN 
    reviews r ON c.customer_id = r.order_id
INNER JOIN 
    products p ON r.product_id = p.product_id;

SELECT * FROM cust_reviews;

/* VIEW 2: Creates a view with left joins to show all customers, even if they don't have any orders. */
CREATE VIEW cust_orders AS
SELECT 
  c.customer_id,
  o.order_id, 
  o.order_date, 
  o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

SELECT * FROM cust_orders
ORDER BY order_date;


/* demonstration: The query below retrieves information about customer's order for 2022-23 thus far. */
SELECT 
  customer_id,
  order_date, 
  total_amount
FROM cust_orders
WHERE order_date BETWEEN '2022-01-01' AND '2023-02-16'
ORDER BY order_date;

---------------------------------------------------------------------------------------
/* STORED FUNCTIONS
In your database, create a stored function that can be applied to a query in your DB.
---------------------------------------------------------------------------------------
SCENARIO:
Every month, Delightful Bakes gives 10% off the total cost of purchase. The following function can be run
during the sale to find the final price the customer needs to pay. */
DELIMITER //
CREATE FUNCTION calculate_discount(total_amount FLOAT(2))
RETURNS FLOAT(2)
DETERMINISTIC
BEGIN
  DECLARE final_price FLOAT(2);
  SET final_price = total_amount * 0.9;
  RETURN final_price;
END//
DELIMITER ;

/* for example to calculate final bill after 10% discount */
SELECT calculate_discount(total_amount) AS final_price
FROM orders;

---------------------------------------------------------------------------------------
/* SUBQUERY
Prepare an example query with a subquery to demonstrate how to extract data from your DB for analysis.
---------------------------------------------------------------------------------------
SCENARIO: 
To analyse which baker produced the most popular product. */
WITH baker_rank AS (
	SELECT
		p.product_id,
        p.product_name,
        SUM(od.quantity) AS total_quantity
	FROM products p
    JOIN order_details od ON p.product_id = od.product_id
	GROUP BY p.product_id, p.product_name
	ORDER BY total_quantity DESC)

SELECT
	b.baker_id,
    p.product_name,
    total_quantity
FROM bakers b
JOIN products p ON b.baker_id = p.product_id
JOIN baker_rank br ON p.product_id = br.product_id

---------------------------------------------------------------------------------------
/* TRIGGERS
In your database, create a trigger and demonstrate how it runs.
---------------------------------------------------------------------------------------
I have created a trigger that updates the the last_ordered_on column in 'customers' table
whenever a new order is inserted into the 'orders' table. */
DELIMITER //
CREATE TRIGGER update_last_order_date 
	AFTER INSERT ON orders
	FOR EACH ROW
BEGIN
	UPDATE customers 
	SET last_order_date = NEW.order_date 
	WHERE customer_id = NEW.customer_id;
END//
DELIMITER ;
/* Insert a new order into the 'orders' table and then check the updated
value of the last_order_date column in the 'customers' table to demonstrate. */
INSERT INTO orders (order_id, customer_id, order_date, total_amount)
VALUES (1000, 1, '2023-03-01', '25.99');

SELECT * FROM customers WHERE customer_id = 1;

---------------------------------------------------------------------------------------
/* QUERIES WITH GROUP BY
Prepare an example query with group by and having to demonstrate how to extract data
from your DB for analysis.
---------------------------------------------------------------------------------------
This query will find the names of customers who have made 3 or more orders and show the
total number of orders they have made. */
SELECT
  c.customer_id,
  COUNT(o.order_id) AS total_orders
FROM
  customers c
  JOIN orders o ON c.customer_id = o.customer_id
GROUP BY
  c.customer_id
HAVING
  total_orders > 1;

