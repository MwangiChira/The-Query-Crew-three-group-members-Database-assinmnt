-- CREATE DATABASE bookstore_db;
-- USE bookstore_db;

-- CREATE TABLE book_language (
-- language_id INT PRIMARY KEY AUTO_INCREMENT,
-- language_name VARCHAR(50) NOT NULL);

-- CREATE TABLE publisher (publisher_id INT PRIMARY KEY AUTO_INCREMENT,name VARCHAR(255) NOT NULL);
-- first_name VARCHAR(100) NOT NULL,lsat_name VARCHAR(100) NOT NULL);
/*CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);

CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publication_date DATE,
    language_id INT NOT NULL,
    publisher_id INT NOT NULL,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

CREATE TABLE book_author (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

CREATE TABLE country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(100) NOT NULL
);

CREATE TABLE address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE address_status (
    address_status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL
);

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(20)
);

CREATE TABLE customer_address (
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    address_status_id INT NOT NULL,
    PRIMARY KEY (customer_id, address_id, address_status_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (address_status_id) REFERENCES address_status(address_status_id)
);

CREATE TABLE shipping_method (
    shipping_method_id INT PRIMARY KEY AUTO_INCREMENT,
    method_name VARCHAR(100) NOT NULL
);

CREATE TABLE order_status (
    order_status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL
);

CREATE TABLE cust_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    shipping_method_id INT NOT NULL,
    order_status_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);

CREATE TABLE order_line (
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

CREATE TABLE order_history (
    order_history_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    order_status_id INT NOT NULL,
    status_change_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);*/
/*CREATE USER 'bookstore_admin'@'localhost' IDENTIFIED BY '0000';
CREATE USER 'bookstore_staff'@'localhost' IDENTIFIED BY '0000'*/
/*CREATE ROLE 'admin_role';
CREATE ROLE 'sales_role';*/
-- GRANT ALL PRIVILEGES ON bookstore_db.*TO 'admin_role';
-- GRANT SELECT, INSERT, UPDATE ON bookstore_db.book TO 'sales_role';
-- GRANT SELECT, INSERT, UPDATE ON bookstore_db.customer TO 'sales_role';
-- GRANT SELECT, INSERT, UPDATE ON bookstore_db.cust_order TO 'sales_role';
-- GRANT SELECT, INSERT ON bookstore_db.order_line TO 'sales_role';
-- GRANT 'sales_role' TO 'bookstore_staff'@'localhost';
-- SET DEFAULT ROLE admin_role TO 'bookstore_admin'@'localhost';
-- SET DEFAULT ROLE sales_role TO 'bookstore_staff'@'localhost';
-- Insert a new language
INSERT INTO book_language (language_name) VALUES ('English');

-- Inserting a new publisher
/*order_statusorder_lineINSERT INTO publisher (name) VALUES ('Penguin Books');

-- Inserting a new author
INSERT INTO author (first_name, last_name) VALUES ('Daniel', 'Lorri');

-- Inserting a new book
INSERT INTO book (title, isbn, publication_date, language_id, publisher_id)
VALUES ('The sweetest oblivian', '978-01331439518', '1813-101-28', 1, 0);

-- Insert a customer
INSERT INTO Customer (first_name, last_name, email)
VALUES ('Chira', 'Mwangi', 'chira.mwangi@gmail.com');

-- Retrieve all books
SELECT * FROM book;

-- Retrieve all customers
SELECT * FROM Customer;

-- Find all books by a specific author (you'll need to insert data into book_author first)
SELECT b.title, a.first_name, a.last_name
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
WHERE a.last_name = 'Lorri';*/





