# Diko's Farm Grill and Restaurant — Sales Management System

A complete PHP + MySQL Sales Management System (POS) built for XAMPP, themed
around the Diko's Farm Grill and Restaurant logo (dark green, gold, red, cream).

## ✅ Features
- Separate **Cashier** and **Owner** login pages
- **Registration system**: open cashier signup + secret-code-protected owner signup
- **New Order / POS screen**: full real menu across 7 categories (Chicken, Pork,
  Seafood, Sizzling Plates, Soup, Dessert, Drinks), live cart, cash & change calculator
- **Auto-generated Order Numbers & Receipt Numbers**
- **Printable 80mm thermal-style receipt**
- **Inventory System**: stock in/out logging, low-stock alerts, current stock levels
- **Product management**: add/edit/deactivate products for any category, upload
  images, enforce 10-chicken/5-drink limits (other categories are uncapped)
- **Best Sellers**: Top 10 chicken + Top 5 drinks, with bar chart, pie chart, and progress bars
- **Sales Reports**: filter by Today/Weekly/Monthly/Custom range, export to CSV, print
- **Receipt History**: cashiers see their own, owner sees everyone's, with reprint

## 📦 Requirements
- XAMPP (Apache + MySQL + PHP 8+)

## 🚀 Setup Instructions

1. **Copy the project folder**
   Copy the `dikos-sales-system` folder into your XAMPP `htdocs` directory, e.g.:
   ```
   C:\xampp\htdocs\dikos-sales-system
   ```

2. **Start Apache and MySQL** in the XAMPP Control Panel.

3. **Import the database**
   - Open `http://localhost/phpmyadmin`
   - Click **Import**, choose `database.sql`, and click **Go**.
   - This creates the `dikos_sales_system` database with all tables and sample products.

4. **Create your first Owner and Cashier accounts**
   - Open `http://localhost/dikos-sales-system/setup_admin.php`
   - Fill in the form to create your first Owner account and Cashier account.
   - **After this succeeds, delete `setup_admin.php` from the server** (it can only be
     run once anyway, since it refuses to run if any users already exist).

5. **(Optional) Change the Owner Secret Code**
   - Open `includes/config.php`
   - Change `OWNER_SECRET_CODE` to something private. Anyone who registers with
     `role = owner` on `register.php` must know this code — this is what keeps
     Owner registration "private/restricted" while Cashier registration stays open.

6. **Visit the system**
   - `http://localhost/dikos-sales-system/` — landing page
   - `http://localhost/dikos-sales-system/login_cashier.php` — Cashier login
   - `http://localhost/dikos-sales-system/login_owner.php` — Owner login
   - `http://localhost/dikos-sales-system/register.php` — Create new accounts

## 🍽️ Real Menu (already loaded in database.sql)
| Category | Item | Price |
|---|---|---|
| Chicken | Diko's Signature Thigh (Chicken Inasal) | ₱159.00 |
| Chicken | Diko's Pecho Supreme (Chicken Inasal) | ₱169.00 |
| Pork | Crispy Pata Alacart | ₱638.00 |
| Pork | Crispy Pata (Good for 4, Unli Rice/Soup/Drinks) | ₱868.00 |
| Pork | Pork BBQ (2 pcs) | ₱129.00 |
| Pork | Liempo | ₱159.00 |
| Pork | Sizzling Pork Tapa | ₱179.00 |
| Pork | Sizzling Liempo (Unli Rice Only) | ₱179.00 |
| Seafood | Sizzling Squid | ₱210.00 |
| Seafood | Sizzling Bangus Sisig | ₱159.00 |
| Seafood | Grilled Tuna Belly | ₱229.00 |
| Seafood | Sizzling Salmon Belly | ₱159.00 |
| Seafood | Tuna Steak | ₱230.00 |
| Sizzling | Sizzling Tofu Sisig | ₱99.00 |
| Soup | Special Bulalo | ₱259.00 * |
| Dessert | Halo-Halo (without Ice Cream) | ₱99.00 |
| Dessert | Halo-Halo (with Ice Cream) | ₱129.00 |
| Drink | Coke / Sprite / Royal / Iced Tea / Bottled Water | ₱15–25 |

\* **Special Bulalo's price wasn't visible in the menu photo** — ₱259 is a
placeholder. Update it via **Owner → Products → Edit** with the real price.

New categories (`pork`, `seafood`, `sizzling`, `soup`, `dessert`) have **no item
limit**. Only `chicken` (max 10) and `drink` (max 5) are capped, per the
original system requirements.

## 🖼️ Logo & Product Images
- Your restaurant logo is already placed at `assets/images/logo.jpg` and used
  throughout the login pages, sidebar, and receipts.
- Your chicken inasal promo photo has been added as `assets/images/chicken_inasal.jpg`
  and is used for the two Chicken Inasal products.
- Every other item currently uses a placeholder image. To add real photos, go to
  **Owner → Products → Edit** and upload an image for each item.

## 🔑 Default Behavior / Business Rules
- Payment is **Cash only**.
- Maximum of **10** active grilled-chicken products and **5** active drink choices
  (enforced when adding new products). Pork, Seafood, Sizzling, Soup, and Dessert
  categories have no cap.
- Cashiers **cannot** access the Owner dashboard, and the Owner **cannot** place
  orders — only view reports, products, inventory, and receipts.
- Every sale automatically deducts stock and logs it in the Inventory Log.
- Order Numbers look like `ORD-20260728-0001`; Receipt Numbers look like `RCPT-20260728-0001`.

## 📁 Folder Structure
```
dikos-sales-system/
├── assets/
│   ├── css/style.css
│   ├── js/script.js
│   └── images/ (logo.jpg, chicken_inasal.jpg, product photos)
├── cashier/
│   ├── dashboard.php
│   ├── new_order.php
│   ├── process_order.php
│   ├── sales.php
│   ├── receipt.php
│   └── receipt_history.php
├── owner/
│   ├── dashboard.php
│   ├── reports.php
│   ├── products.php
│   ├── inventory.php
│   ├── best_sellers.php
│   └── receipts.php
├── includes/
│   ├── config.php   (DB credentials + Owner secret code)
│   ├── db.php
│   ├── auth.php
│   └── functions.php
├── index.php
├── login_cashier.php
├── login_owner.php
├── register.php
├── logout.php
├── setup_admin.php   (run once, then delete)
└── database.sql
```

## 🛠️ Customizing
- **Colors/fonts**: edit `assets/css/style.css` (CSS variables at the top).
- **Restaurant name/address**: edit `includes/config.php`.
- **Menu items, prices, stock**: edit via Owner → Products, or directly in `database.sql` before importing.

Enjoy your system! If you add features later (e.g. GCash payment, multiple
branches, table/dine-in tracking), the database and code structure above give
you a clean base to extend from.
