


-- Create Bookstore Database
CREATE DATABASE IF NOT EXISTS bookstore_db;

-- Use the newly created database
USE bookstore_db;

-- Country
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

-- Address Status
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE
);

-- Book Language
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(100) NOT NULL UNIQUE
);

-- Publisher
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    contact_email VARCHAR(100)
);

-- Shipping Method
CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL,
    cost DECIMAL(10,2)
);

-- Order Status
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE
);


-- Author
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    bio TEXT
);

-- Book
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publisher_id INT,
    language_id INT,
    isbn VARCHAR(20) UNIQUE,
    publication_year INT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

-- Book Author (Many-to-Many)
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- Customer
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20)
);

-- Address
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- Customer Address (Many-to-One with status)
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- Customer Order
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    shipping_method_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- Order Line (Books in Order)
CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    price_at_order DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- Order History
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);



-- ===============================
-- Lookup Tables
-- ===============================
INSERT INTO country (country_name) VALUES 
  ('United States'), ('Canada'), ('United Kingdom');

INSERT INTO address_status (status_name) VALUES 
  ('current'), ('old');

INSERT INTO book_language (language_name) VALUES 
  ('English'), ('French'), ('Spanish');

INSERT INTO publisher (name, contact_email) VALUES 
  ('Penguin Random House', 'contact@penguin.com'),
  ('HarperCollins', 'info@harpercollins.com');

INSERT INTO shipping_method (method_name, cost) VALUES 
  ('Standard Shipping', 5.00),
  ('Express Shipping', 10.00);

INSERT INTO order_status (status_name) VALUES 
  ('Pending'), ('Shipped'), ('Delivered'), ('Cancelled');

-- ===============================
-- Authors and Books
-- ===============================
INSERT INTO author (first_name, last_name, bio) VALUES 
  ('George', 'Orwell', 'English novelist and essayist'),
  ('J.K.', 'Rowling', 'British author of the Harry Potter series');

INSERT INTO book (title, publisher_id, language_id, isbn, publication_year, price, stock_quantity) VALUES 
  ('1984', 1, 1, '9780451524935', 1949, 15.99, 50),
  ('Harry Potter and the Philosopher''s Stone', 2, 1, '9780747532699', 1997, 29.99, 100);

INSERT INTO book_author (book_id, author_id) VALUES 
  (1, 1),
  (2, 2);

-- ===============================
-- Customers & Addresses
-- ===============================
INSERT INTO customer (first_name, last_name, email, phone) VALUES 
  ('Alice', 'Johnson', 'alice@example.com', '555-1234'),
  ('Bob', 'Smith', 'bob@example.com', '555-5678');

INSERT INTO address (street, city, state, postal_code, country_id) VALUES 
  ('123 Maple St', 'New York', 'NY', '10001', 1),
  ('456 Oak Ave', 'Toronto', 'ON', 'M5H 2N2', 2),
  ('789 Pine Rd', 'London', '', 'SW1A 1AA', 3);

INSERT INTO customer_address (customer_id, address_id, status_id) VALUES 
  (1, 1, 1),
  (1, 2, 2),
  (2, 3, 1);

-- ===============================
-- Orders
-- ===============================
INSERT INTO cust_order (customer_id, order_date, shipping_method_id, status_id) VALUES 
  (1, NOW(), 1, 1),
  (2, NOW(), 2, 2);

INSERT INTO order_line (order_id, book_id, quantity, price_at_order) VALUES 
  (1, 1, 2, 15.99),
  (2, 2, 1, 29.99);

INSERT INTO order_history (order_id, status_id, changed_at) VALUES 
  (1, 1, NOW()),
  (2, 2, NOW());

-- 1. List all books with their authors, language, and publisher
SELECT 
  b.title,
  CONCAT(a.first_name, ' ', a.last_name) AS author,
  bl.language_name,
  p.name AS publisher,
  b.price
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
JOIN book_language bl ON b.language_id = bl.language_id
JOIN publisher p ON b.publisher_id = p.publisher_id;

-- 2. Get recent customer orders with shipping method and status
SELECT 
  o.order_id,
  CONCAT(c.first_name, ' ', c.last_name) AS customer,
  o.order_date,
  sm.method_name AS shipping_method,
  os.status_name AS order_status
FROM cust_order o
JOIN customer c ON o.customer_id = c.customer_id
JOIN shipping_method sm ON o.shipping_method_id = sm.shipping_method_id
JOIN order_status os ON o.status_id = os.status_id
ORDER BY o.order_date DESC;

-- 3. Top 5 Best-Selling Books by Quantity Ordered
SELECT 
  b.title,
  SUM(ol.quantity) AS total_sold
FROM order_line ol
JOIN book b ON ol.book_id = b.book_id
GROUP BY b.book_id
ORDER BY total_sold DESC
LIMIT 5;

-- 4. Total Sales Revenue by Book
SELECT 
  b.title,
  SUM(ol.quantity * ol.price_at_order) AS revenue
FROM order_line ol
JOIN book b ON ol.book_id = b.book_id
GROUP BY b.book_id
ORDER BY revenue DESC;

-- 5. Customers and Their Current Addresses
SELECT 
  CONCAT(c.first_name, ' ', c.last_name) AS customer,
  a.street, a.city, a.state, a.postal_code
FROM customer c
JOIN customer_address ca ON c.customer_id = ca.customer_id
JOIN address a ON ca.address_id = a.address_id
JOIN address_status ast ON ca.status_id = ast.status_id
WHERE ast.status_name = 'current';

-- 6. Monthly Order Count and Revenue
SELECT 
  DATE_FORMAT(order_date, '%Y-%m') AS month,
  COUNT(*) AS order_count,
  SUM(ol.quantity * ol.price_at_order) AS total_revenue
FROM cust_order o
JOIN order_line ol ON o.order_id = ol.order_id
GROUP BY month
ORDER BY month DESC;



-- ===================================
-- Create Users
-- ===================================
CREATE USER IF NOT EXISTS 'dba_user'@'localhost' IDENTIFIED BY 'secureDBApass';
CREATE USER IF NOT EXISTS 'sales_user'@'localhost' IDENTIFIED BY 'secureSalesPass';
CREATE USER IF NOT EXISTS 'inventory_user'@'localhost' IDENTIFIED BY 'secureInventoryPass';

-- ===================================
-- Grant Privileges
-- ===================================

-- DBA: Full access
GRANT ALL PRIVILEGES ON bookstore_db.* TO 'dba_user'@'localhost';

-- Sales Staff: Customer and Order Access
GRANT SELECT, INSERT, UPDATE ON bookstore_db.customer TO 'sales_user'@'localhost';
GRANT SELECT, INSERT ON bookstore_db.cust_order TO 'sales_user'@'localhost';
GRANT SELECT, INSERT ON bookstore_db.order_line TO 'sales_user'@'localhost';
GRANT SELECT ON bookstore_db.book TO 'sales_user'@'localhost';
GRANT SELECT ON bookstore_db.order_status TO 'sales_user'@'localhost';
GRANT SELECT ON bookstore_db.shipping_method TO 'sales_user'@'localhost';

-- Inventory Staff: Book and Author Management
GRANT SELECT, INSERT, UPDATE ON bookstore_db.book TO 'inventory_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON bookstore_db.author TO 'inventory_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON bookstore_db.publisher TO 'inventory_user'@'localhost';

-- ===================================
-- Apply Changes
-- ===================================
FLUSH PRIVILEGES;

-- ===================================
-- Optional: Show Grants (for manual testing)
-- ===================================
-- SHOW GRANTS FOR 'sales_user'@'localhost';
-- SHOW GRANTS FOR 'inventory_user'@'localhost';
-- SHOW GRANTS FOR 'dba_user'@'localhost';
