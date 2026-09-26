-- ============================================================
-- MIGRATION SCRIPT: Add new menu categories & items
-- Safe to run on an EXISTING database — does NOT delete anything.
-- Run this in phpMyAdmin: select "dikos_sales_system" database,
-- open the "SQL" tab, paste this whole file, then click "Go".
-- ============================================================

USE dikos_sales_system;

-- 1) Expand the category list so new item types are allowed
ALTER TABLE products
  MODIFY COLUMN category ENUM('chicken','pork','seafood','sizzling','soup','dessert','drink') NOT NULL;

-- 2) Insert each new menu item ONLY if it doesn't already exist
--    (safe to run this script more than once — it will not duplicate rows)

INSERT INTO products (product_name, category, price, image, stock, low_stock_threshold)
SELECT * FROM (SELECT 'Crispy Pata Alacart' AS n, 'pork' AS c, 638.00 AS p, 'no-image.png' AS i, 15 AS s, 5 AS t) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM products WHERE product_name = 'Crispy Pata Alacart');

INSERT INTO products (product_name, category, price, image, stock, low_stock_threshold)
SELECT * FROM (SELECT 'Crispy Pata (Good for 4, Unli Rice/Soup/Drinks)', 'pork', 868.00, 'no-image.png', 10, 5) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM products WHERE product_name = 'Crispy Pata (Good for 4, Unli Rice/Soup/Drinks)');

INSERT INTO products (product_name, category, price, image, stock, low_stock_threshold)
SELECT * FROM (SELECT 'Pork BBQ (2 pcs)', 'pork', 129.00, 'no-image.png', 60, 15) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM products WHERE product_name = 'Pork BBQ (2 pcs)');

INSERT INTO products (product_name, category, price, image, stock, low_stock_threshold)
SELECT * FROM (SELECT 'Liempo', 'pork', 159.00, 'no-image.png', 40, 10) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM products WHERE product_name = 'Liempo' AND category = 'pork');

INSERT INTO products (product_name, category, price, image, stock, low_stock_threshold)
SELECT * FROM (SELECT 'Sizzling Pork Tapa', 'pork', 179.00, 'no-image.png', 40, 10) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM products WHERE product_name = 'Sizzling Pork Tapa');

INSERT INTO products (product_name, category, price, image, stock, low_stock_threshold)
SELECT * FROM (SELECT 'Sizzling Liempo (Unli Rice Only)', 'pork', 179.00, 'no-image.png', 40, 10) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM products WHERE product_name = 'Sizzling Liempo (Unli Rice Only)');

INSERT INTO products (product_name, category, price, image, stock, low_stock_threshold)
SELECT * FROM (SELECT 'Sizzling Squid', 'seafood', 210.00, 'no-image.png', 30, 10) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM products WHERE product_name = 'Sizzling Squid');

INSERT INTO products (product_name, category, price, image, stock, low_stock_threshold)
SELECT * FROM (SELECT 'Sizzling Bangus Sisig', 'seafood', 159.00, 'no-image.png', 30, 10) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM products WHERE product_name = 'Sizzling Bangus Sisig');

INSERT INTO products (product_name, category, price, image, stock, low_stock_threshold)
SELECT * FROM (SELECT 'Grilled Tuna Belly', 'seafood', 229.00, 'no-image.png', 25, 10) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM products WHERE product_name = 'Grilled Tuna Belly');

INSERT INTO products (product_name, category, price, image, stock, low_stock_threshold)
SELECT * FROM (SELECT 'Sizzling Salmon Belly', 'seafood', 159.00, 'no-image.png', 25, 10) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM products WHERE product_name = 'Sizzling Salmon Belly');

INSERT INTO products (product_name, category, price, image, stock, low_stock_threshold)
SELECT * FROM (SELECT 'Tuna Steak', 'seafood', 230.00, 'no-image.png', 25, 10) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM products WHERE product_name = 'Tuna Steak');

INSERT INTO products (product_name, category, price, image, stock, low_stock_threshold)
SELECT * FROM (SELECT 'Sizzling Tofu Sisig', 'sizzling', 99.00, 'no-image.png', 40, 10) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM products WHERE product_name = 'Sizzling Tofu Sisig');

INSERT INTO products (product_name, category, price, image, stock, low_stock_threshold)
SELECT * FROM (SELECT 'Special Bulalo', 'soup', 259.00, 'no-image.png', 20, 5) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM products WHERE product_name = 'Special Bulalo');

INSERT INTO products (product_name, category, price, image, stock, low_stock_threshold)
SELECT * FROM (SELECT 'Halo-Halo (without Ice Cream)', 'dessert', 99.00, 'no-image.png', 40, 10) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM products WHERE product_name = 'Halo-Halo (without Ice Cream)');

INSERT INTO products (product_name, category, price, image, stock, low_stock_threshold)
SELECT * FROM (SELECT 'Halo-Halo (with Ice Cream)', 'dessert', 129.00, 'no-image.png', 40, 10) AS tmp
WHERE NOT EXISTS (SELECT 1 FROM products WHERE product_name = 'Halo-Halo (with Ice Cream)');

-- Done. Refresh New Order page (cashier/new_order.php) to see all new sections.
