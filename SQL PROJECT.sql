--Create Table Books
CREATE TABLE books(
book_id INT PRIMARY KEY,
title VARCHAR(100) NOT NULL,
author VARCHAR(50) NOT NULL,
genre VARCHAR(50) NOT NULL,
published_year NUMERIC NOT NULL,
price NUMERIC(10,2)
stock NUMERIC
)

--Importing books csv file
COPY books(book_id, title, author, genre, published_year, price, stock)
FROM 'D:\revision\ST - SQL ALL PRACTICE FILES-2\All Excel Practice Files\Books.csv'
CSV HEADER;

--Create Table Customers
CREATE TABLE customers(
customer_id INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
email VARCHAR(50) UNIQUE,
phone NUMERIC,
city VARCHAR(100) NOT NULL,
country VARCHAR(100) NOT NULL
);

--Importing customers csv file
COPY customers(customer_id, name, email, phone, city, country)
FROM '‪D:\revision\ST - SQL ALL PRACTICE FILES-2\All Excel Practice Files\Customers.csv'
CSV HEADER;

--Create Table employee_data
CREATE TABLE employee_data(
employee_id INT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50),
email VARCHAR(100) UNIQUE,
department VARCHAR(60) NOT NULL,
salary NUMERIC(10,2),
joining_date DATE,
age NUMERIC
);

--Change Table Name
ALTER TABLE employee_date
RENAME TO employee_data;

--Importing employee_data csv file
COPY employee_data(employee_id, first_name, last_name, email, department, salary, joining_date, age)
FROM 'D:\revision\ST - SQL ALL PRACTICE FILES-2\All Excel Practice Files\employee_data.csv'
CSV HEADER;

--Create Table orders
CREATE TABLE orders(
order_id INT PRIMARY KEY,
customer_id INT NOT NULL,
book_id INT NOT NULL,
order_date DATE,
quantity NUMERIC,
total_amount NUMERIC(10,2)
);

--Importing orders csv file
COPY orders(order_id, customer_id, book_id, order_date, quantity, total_amount)
FROM 'D:\revision\ST - SQL ALL PRACTICE FILES-2\All Excel Practice Files\Orders.csv'
CSV HEADER;

--Queries
--Retrieve all books in the 'Fiction' genre.
SELECT * FROM books
WHERE genre = 'Fiction'
ORDER BY book_id ASC;


--Find books Published after the year 1950.
SELECT book_id, title, author, genre, published_year FROM books
WHERE published_year > '1950';


--List all customers from the Canada.
SELECT * FROM customers
WHERE country = 'Canada';


--Show orders placed in November 2023.
SELECT * FROM orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

--Retrieve the total stock of books available.
SELECT SUM(quantity) FROM orders;


--Find the details of the most expensive book.
SELECT * FROM books
ORDER BY price DESC
LIMIT 10;


--Show all customers who ordered more than 1 quantity of a book.
SELECT c.customer_id, c.name, SUM(o.quantity) AS total_qty FROM customers c
JOIN orders o ON
c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING SUM(o.quantity) > 1 
ORDER BY c.customer_id;


--Retrieve all orders where the total amount exceeds $20.
SELECT * FROM orders
WHERE total_amount >20;


--List all genres available in the Books table.
SELECT genre FROM books
GROUP BY genre;
--OR
SELECT DISTINCT genre FROM books;


--Find the book with the lowest stock.
SELECT title, stock FROM books
ORDER BY stock ASC
LIMIT 1;


--Calculate the total revenue generated from all orders.
SELECT SUM(total_amount) AS Total_revenue FROM orders;


--ADVANCE QUERIES
--Retrieve the total number of books sold for each genre.
SELECT b.genre, SUM(o.quantity) FROM books b
JOIN orders o ON
b.book_id = o.book_id
GROUP BY b.genre;


--Find the average price of books in the 'Fantasy' genre.
SELECT genre, ROUND(AVG(price),2) AS Avg_price
FROM books
WHERE genre = 'Fantasy'
GROUP BY genre;


--List customers who have placed at least 2 orders.
SELECT c.customer_id,c.name, COUNT(o.customer_id) AS Placed_orders FROM Customers c
JOIN orders o ON
c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.customer_id) >=2;


--Find the most frequently ordered book.
SELECT b.book_id, b.title, COUNT(o.book_id) AS Total_count FROM books b
JOIN orders o ON
b.book_id = o.book_id
GROUP BY b.book_id, b.title
ORDER BY COUNT(o.book_id) DESC
LIMIT 1;


--Show the top 3 most expensive books of 'Fantasy' Genre.
SELECT book_id, title, genre, price FROM books
WHERE genre ='Fantasy'
GROUP BY book_id, title, genre, price
ORDER BY price DESC
LIMIT 3;


--Retrieve the total quantity of books sold by each author.
SELECT b.author, SUM(o.quantity) AS Total_Qty FROM books b
JOIN orders o ON
b.book_id = o.book_id
GROUP BY b.author;


--List the cities where customers who spent over $30 are located.
SELECT c.city, o.total_amount FROM customers c
JOIN orders o ON
c.customer_id = o.customer_id
GROUP BY c.city, o.total_amount
HAVING o.total_amount >30;


--Find the customers who spent the most on orders;
SELECT c.customer_id, c.name, SUM(o.total_amount) AS Spent_Amount FROM customers c
JOIN orders o ON
c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Spent_Amount DESC
limit 1;


--Calculate the stock remaining after fulfilling all orders.
SELECT b.book_id, b.title, (SUM(b.stock) - SUM(o.quantity)) AS Remaining_stock FROM books b
JOIN orders o ON
b.book_id = o.book_id
GROUP BY b.book_id, b.title;



