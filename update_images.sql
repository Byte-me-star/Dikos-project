-- ============================================================
-- UPDATE SCRIPT: Attach real menu photos to existing products
-- Safe to run on your EXISTING database — only updates the
-- "image" column, does not touch prices, stock, or anything else.
-- Run in phpMyAdmin: SQL tab > paste this whole file > Go
-- ============================================================

USE dikos_sales_system;

UPDATE products SET image = 'chicken_signature_thigh.jpg' WHERE product_name = "Diko's Signature Thigh (Chicken Inasal)";
UPDATE products SET image = 'chicken_pecho_supreme.jpg'   WHERE product_name = "Diko's Pecho Supreme (Chicken Inasal)";
UPDATE products SET image = 'crispy_pata.jpg'             WHERE product_name = 'Crispy Pata Alacart';
UPDATE products SET image = 'crispy_pata.jpg'             WHERE product_name = 'Crispy Pata (Good for 4, Unli Rice/Soup/Drinks)';
UPDATE products SET image = 'pork_bbq.jpg'                WHERE product_name = 'Pork BBQ (2 pcs)';
UPDATE products SET image = 'liempo.jpg'                  WHERE product_name = 'Liempo' AND category = 'pork';
UPDATE products SET image = 'sizzling_pork_tapa.jpg'      WHERE product_name = 'Sizzling Pork Tapa';
UPDATE products SET image = 'sizzling_liempo.jpg'         WHERE product_name = 'Sizzling Liempo (Unli Rice Only)';
UPDATE products SET image = 'sizzling_squid.jpg'          WHERE product_name = 'Sizzling Squid';
UPDATE products SET image = 'sizzling_bangus_sisig.jpg'   WHERE product_name = 'Sizzling Bangus Sisig';
UPDATE products SET image = 'grilled_tuna_belly.jpg'      WHERE product_name = 'Grilled Tuna Belly';
UPDATE products SET image = 'sizzling_salmon_belly.jpg'   WHERE product_name = 'Sizzling Salmon Belly';
UPDATE products SET image = 'tuna_steak.jpg'              WHERE product_name = 'Tuna Steak';
UPDATE products SET image = 'sizzling_tofu_sisig.jpg'     WHERE product_name = 'Sizzling Tofu Sisig';
UPDATE products SET image = 'special_bulalo.jpg'          WHERE product_name = 'Special Bulalo';
UPDATE products SET image = 'halo_halo.jpg'               WHERE product_name = 'Halo-Halo (without Ice Cream)';
UPDATE products SET image = 'halo_halo.jpg'               WHERE product_name = 'Halo-Halo (with Ice Cream)';

-- Done. Refresh cashier/new_order.php and owner/products.php to see the photos.
