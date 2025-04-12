-- Create Bookstore Database
CREATE DATABASE IF NOT EXISTS bookstore_db;

-- Use the newly created database
USE bookstore_db;

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
