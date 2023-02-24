CREATE DATABASE delightful_bakes;
USE delightful_bakes;

------------------------------------------------------------------------
/* Create tables */
------------------------------------------------------------------------

CREATE TABLE products (
	product_id INT NOT NULL PRIMARY KEY,
	product_name VARCHAR(50) NOT NULL,
	product_description TEXT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
	category VARCHAR(20) NOT NULL
);

CREATE TABLE customers (
	customer_id INT NOT NULL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NULL,
    email VARCHAR(100) NOT NULL,
	city VARCHAR(10) NOT NULL,
	phone VARCHAR(20) NOT NULL
);

CREATE TABLE orders (
	order_id INT NOT NULL PRIMARY KEY,
	customer_id INT NOT NULL,
	order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
	order_detail_id INT NOT NULL PRIMARY KEY,
	order_id INT NOT NULL,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE bakers (
	baker_id INT NOT NULL PRIMARY KEY,
    created_product INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (created_product) REFERENCES products(product_id)
);

CREATE TABLE reviews (
    review_id INT NOT NULL,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL,
    review_description TEXT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

------------------------------------------------------------------------
/* Insert values into the tables */
------------------------------------------------------------------------
INSERT INTO products
(product_id, product_name, product_description, price, category)
VALUES
(1, 'Chocolate Cake', 'A rich chocolate cake made with dark chocolate and cocoa powder', 10.99, 'Cake'),
(2, 'Blueberry Muffin', 'A fluffy and sweet blueberry muffin with fresh blueberries and a crumbly topping', 5.99, 'Muffin'),
(3, 'Coffee Bun', 'A buttery bun that is coated with coffee powder', 7.99, 'Bread'),
(4, 'Vanilla Meringue', 'A crusty and chewy baguette made with all-purpose flour and yeast', 3.99, 'Sweets'),
(5, 'Bread Pudding', 'A creamy and comforting bread pudding made with milk, eggs, and spices', 8.99, 'Cake'),
(6, 'Agar', 'A rainbow gelatin cube that is a traditional Malay dessert', 8.99, 'Sweets'),
(7, 'Chendol', 'A shaved-ice bowl filled with Gula Melaka sauce and jellies', 3.99, 'Sweets'),
(8, 'Portuguese Egg Tart', 'A scrumtuous egg tart commonly sold in Hong Kong', 2.99, 'Tart'),
(9, 'Lemon Pound Cake', 'A tangy and buttery lemon pound cake made with fresh lemon zest', 5.99, 'Cake'),
(10, 'Croissant', 'A flaky and buttery croissant with a light and crisp texture', 3.49, 'Pastry');


INSERT INTO customers
(customer_id, first_name, last_name, email, city, phone)
VALUES
(1, 'John', 'Doe', 'johndoe@email.com', 'NY', '123-456-7890'),
(2, 'Jane', 'Doe', 'janedoe@email.com', 'LA', '123-456-7891'),
(3, 'Jim', 'Smith', 'jimsmith@email.com', 'CHI', '123-456-7892'),
(4, 'Sophie', 'Johnson', 'sophiejohnson@email.com', 'HTX', '123-456-7893'),
(5, 'Emma', 'Williams', 'emmawilliams@email.com', 'PHI', '123-456-7894'),
(6, 'Liam', 'Smith', 'liamsmith@email.com', 'NY', '212-555-1212'),
(7, 'Emma', 'Jones', 'emmajones@email.com', 'LA', '310-555-1212'),
(8, 'Olivia', 'Brown', 'oliviabrown@email.com', 'CHI', '312-555-1212'),
(9, 'Noah', 'Davis', 'noahdavis@email.com', 'HTX', '713-555-1212'),
(10, 'Ava', 'Wilson', 'avawilson@email.com', 'PHI', '215-555-1212');

INSERT INTO orders
(order_id, customer_id, order_date, total_amount)
VALUES
(1, 1, '2022-12-01', 50.97),
(2, 2, '2022-12-02', 23.97),
(3, 3, '2022-12-03', 37.95),
(4, 4, '2022-12-04', 56.93),
(5, 5, '2022-12-05', 28.91),
(6, 6, '2023-02-12', 20.47),
(7, 7, '2023-02-13', 15.99),
(8, 8, '2023-02-14', 10.49),
(9, 9, '2023-02-15', 25.97),
(10, 10, '2023-02-16', 18.99);


INSERT INTO order_details
(order_detail_id, order_id, product_id, quantity)
VALUES
(1, 1, 1, 2),
(2, 1, 2, 4),
(3, 2, 3, 3),
(4, 2, 4, 1),
(5, 3, 1, 1),
(6, 6, 6, 2),
(7, 7, 7, 4),
(8, 8, 8, 1),
(9, 9, 9, 3),
(10, 10, 10, 2);
INSERT INTO order_details
(order_detail_id, order_id, product_id, quantity)
VALUES
(11, 1, 2, 3),
(12, 2, 4, 2),
(13, 3, 1, 1),
(14, 4, 5, 4),
(15, 5, 3, 2);

INSERT INTO bakers
(baker_id, created_product, first_name, last_name, hire_date, salary)
VALUES
(1, 1, 'Tom', 'Brown', '2022-01-01', 35000.00),
(2, 2, 'Emily', 'Jones', '2022-02-01', 38000.00),
(3, 3, 'Michael', 'Johnson', '2022-03-01', 41000.00),
(4, 4, 'Sarah', 'Lee', '2021-08-01', 49000.00),
(5, 5, 'Azma', 'Knowles', '2022-03-01', 41000.00),
(6, 6, 'Mitch', 'Poller', '2022-07-01', 55000.00),
(7, 7, 'William', 'Williams', '2022-07-02', 50000.00),
(8, 8, 'David', 'Jones', '2022-07-03', 45000.00),
(9, 9, 'Richard', 'Brown', '2022-07-04', 60000.00),
(10, 10, 'Charles', 'Davis', '2022-07-05', 65000.00);

INSERT INTO reviews
(review_id, order_id, product_id, rating, review_description)
VALUES
(1, 1, 1, 4, 'Delicious cake, moist and fluffy'),
(2, 2, 2, 5, 'Nice muffins, sweet and soft'),
(3, 3, 3, 4, 'Decent coffee taste, bit dry'),
(4, 4, 4, 5, 'Best meringues ever'),
(5, 5, 5, 4, 'Awesome bread, soft and fluffy'),
(6, 6, 6, 3, 'Sweeter than I am used to, but delicious'),
(7, 7, 7, 5, 'Unique dessert, very refreshing'),
(8, 8, 8, 4, 'Nice tarts, flaky crust'),
(9, 9, 9, 5, 'Amazing texture, delicate and sweet'),
(10, 10, 10, 4, 'Good croissant, crisp and buttery'),
(11, 11, 7, 4, 'The chendol was rich and refreshing.'),
(12, 12, 2, 5, 'The blueberry muffins were incredibly delicious, especially when warmed up.'),
(13, 13, 3, 3, 'The bun was just okay, nothing extraordinary.'),
(14, 14, 4, 5, 'The bread pudding was the perfect balance of sweet and savoury.'),
(15, 15, 9, 4, 'The cake was light and flaky, with a lovely citrus flavor.');

------------------------------------------------------------------------
/* Check tables */
------------------------------------------------------------------------
SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM order_details;
SELECT * FROM reviews;