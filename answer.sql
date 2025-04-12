


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
