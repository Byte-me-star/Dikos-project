-- ============================================================
-- Diko's Farm Grill and Restaurant - Sales Management System
-- Database Schema
-- Import this file in phpMyAdmin (XAMPP) before running the app
-- ============================================================

CREATE DATABASE IF NOT EXISTS dikos_sales_system;
USE dikos_sales_system;

-- ------------------------------------------------------------
-- USERS TABLE (Cashier + Owner accounts)
-- ------------------------------------------------------------
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role ENUM('cashier','owner') NOT NULL,
    status ENUM('active','inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- NOTE: No default users are inserted here because passwords must be
-- hashed by PHP's password_hash() function, not typed in as plain SQL.
-- After importing this file, open setup_admin.php ONCE in your browser
-- to create the first Owner and Cashier accounts. Delete setup_admin.php
-- afterwards for security.

-- ------------------------------------------------------------
-- PRODUCTS TABLE
-- Categories: chicken (max 10), drink (max 5) - enforced in PHP
-- pork, seafood, sizzling, soup, dessert - no hard cap
-- ------------------------------------------------------------
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category ENUM('chicken','pork','seafood','sizzling','soup','dessert','drink') NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    image VARCHAR(255) DEFAULT 'no-image.png',
    stock INT NOT NULL DEFAULT 0,
    low_stock_threshold INT NOT NULL DEFAULT 10,
    status ENUM('active','inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Real Diko's Farm Grill and Restaurant menu (from actual menu boards)
INSERT INTO products (product_name, category, price, image, stock, low_stock_threshold) VALUES

-- CHICKEN
("Diko's Signature Thigh (Chicken Inasal)", 'chicken', 159.00, 'chicken_signature_thigh.jpg', 50, 10),
("Diko's Pecho Supreme (Chicken Inasal)", 'chicken', 169.00, 'chicken_pecho_supreme.jpg', 50, 10),

-- PORK
('Crispy Pata Alacart', 'pork', 638.00, 'crispy_pata.jpg', 15, 5),
('Crispy Pata (Good for 4, Unli Rice/Soup/Drinks)', 'pork', 868.00, 'crispy_pata.jpg', 10, 5),
('Pork BBQ (2 pcs)', 'pork', 129.00, 'pork_bbq.jpg', 60, 15),
('Liempo', 'pork', 159.00, 'liempo.jpg', 40, 10),
('Sizzling Pork Tapa', 'pork', 179.00, 'sizzling_pork_tapa.jpg', 40, 10),
('Sizzling Liempo (Unli Rice Only)', 'pork', 179.00, 'sizzling_liempo.jpg', 40, 10),

-- SEAFOOD
('Sizzling Squid', 'seafood', 210.00, 'sizzling_squid.jpg', 30, 10),
('Sizzling Bangus Sisig', 'seafood', 159.00, 'sizzling_bangus_sisig.jpg', 30, 10),
('Grilled Tuna Belly', 'seafood', 229.00, 'grilled_tuna_belly.jpg', 25, 10),
('Sizzling Salmon Belly', 'seafood', 159.00, 'sizzling_salmon_belly.jpg', 25, 10),
('Tuna Steak', 'seafood', 230.00, 'tuna_steak.jpg', 25, 10),

-- OTHER SIZZLING PLATES
('Sizzling Tofu Sisig', 'sizzling', 99.00, 'sizzling_tofu_sisig.jpg', 40, 10),

-- SOUP
('Special Bulalo', 'soup', 259.00, 'special_bulalo.jpg', 20, 5),

-- DESSERT
('Halo-Halo (without Ice Cream)', 'dessert', 99.00, 'halo_halo.jpg', 40, 10),
('Halo-Halo (with Ice Cream)', 'dessert', 129.00, 'halo_halo.jpg', 40, 10),

-- DRINKS
('Coke', 'drink', 25.00, 'no-image.png', 100, 20),
('Sprite', 'drink', 25.00, 'no-image.png', 100, 20),
('Royal', 'drink', 25.00, 'no-image.png', 100, 20),
('Iced Tea', 'drink', 20.00, 'no-image.png', 100, 20),
('Bottled Water', 'drink', 15.00, 'no-image.png', 100, 20);

-- ------------------------------------------------------------
-- INVENTORY LOG (tracks stock in/out for the Inventory System)
-- ------------------------------------------------------------
CREATE TABLE inventory_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    change_type ENUM('stock_in','stock_out','sale_deduction','adjustment') NOT NULL,
    quantity INT NOT NULL,
    remarks VARCHAR(255) DEFAULT NULL,
    created_by INT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);

-- ------------------------------------------------------------
-- ORDERS TABLE
-- ------------------------------------------------------------
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_number VARCHAR(30) NOT NULL UNIQUE,
    cashier_id INT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    cash_received DECIMAL(10,2) NOT NULL,
    change_amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(20) DEFAULT 'Cash',
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cashier_id) REFERENCES users(id)
);

-- ------------------------------------------------------------
-- ORDER ITEMS TABLE
-- ------------------------------------------------------------
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- ------------------------------------------------------------
-- RECEIPTS TABLE
-- ------------------------------------------------------------
CREATE TABLE receipts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    receipt_number VARCHAR(30) NOT NULL UNIQUE,
    order_id INT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    cash_received DECIMAL(10,2) NOT NULL,
    change_amount DECIMAL(10,2) NOT NULL,
    receipt_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);
