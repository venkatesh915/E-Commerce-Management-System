# 🛒 E-Commerce Management System (Advanced SQL Project)

## 📌 Project Overview

The **E-Commerce Management System** is a comprehensive relational database project designed to simulate a real-world online shopping platform. It focuses on advanced SQL concepts, database normalization, and complex relationships between entities.

This project demonstrates how large-scale e-commerce platforms manage customers, products, orders, payments, shipments, and analytics using structured SQL queries.

---

## 🚀 Key Features

* Customer management with multiple addresses
* Product catalog with categories and suppliers
* Order processing system with order items
* Payment tracking and shipment management
* Customer reviews and ratings system
* Wishlist and shopping cart functionality
* Employee hierarchy (self-referencing relationship)
* Advanced reporting using SQL queries

---

## 🧱 Database Schema

### 👤 Customers

* customer_id (PK)
* customer_name
* email
* phone
* registration_date

### 📍 Addresses

* address_id (PK)
* customer_id (FK)
* address_type
* city
* state
* pincode

### 📦 Products

* product_id (PK)
* product_name
* description
* price
* stock_quantity
* category_id (FK)
* supplier_id (FK)

### 🛒 Orders

* order_id (PK)
* customer_id (FK)
* order_date
* order_status
* total_amount

### 📄 Order Items

* order_item_id (PK)
* order_id (FK)
* product_id (FK)
* quantity
* unit_price

### 💳 Payments

* payment_id (PK)
* order_id (FK)
* payment_date
* payment_method
* payment_status
* amount

### 🚚 Shipments

* shipment_id (PK)
* order_id (FK)
* shipment_date
* delivery_date
* shipment_status

### ⭐ Reviews

* review_id (PK)
* customer_id (FK)
* product_id (FK)
* rating
* review_text

### ❤️ Wishlist & Cart

* Wishlist and Cart tables handle customer product preferences and shopping activity

### 🏢 Suppliers & Categories

* category_id (PK)
* parent_category_id (FK → Categories)
* supplier_id (PK)

### 👨‍💼 Employees

* employee_id (PK)
* employee_name
* manager_id (FK → Employees)
* salary
* designation

---

## 🔗 Relationships

* Customers → Orders (1:M)
* Orders → Order_Items (1:M)
* Products → Categories (M:1)
* Products → Suppliers (M:1)
* Orders → Payments (1:1)
* Orders → Shipments (1:1)
* Customers → Reviews (1:M)
* Products → Reviews (1:M)
* Employees → Employees (Self Join Hierarchy)

---

## 🧠 SQL Concepts Covered

### 🔹 Basic Queries

* SELECT, WHERE, ORDER BY, LIMIT

### 🔹 Aggregations

* COUNT(), SUM(), AVG(), MIN(), MAX()

### 🔹 GROUP BY & HAVING

* Category-wise, supplier-wise, and customer analytics

### 🔹 Joins

* INNER JOIN
* LEFT JOIN
* RIGHT JOIN
* FULL OUTER JOIN

### 🔹 Subqueries

* Nested queries for business insights

### 🔹 Correlated Subqueries

* Dynamic row-level comparisons

### 🔹 Window Functions

* RANK(), DENSE_RANK(), ROW_NUMBER()
* Running totals & rankings

### 🔹 CTE (Common Table Expressions)

* Modular query design for analytics

### 🔹 Recursive CTE

* Employee hierarchy & category trees

### 🔹 Transactions

* COMMIT, ROLLBACK, SAVEPOINT

### 🔹 Optimization

* Indexing
* Query performance tuning
* EXPLAIN ANALYZE

---

## 📊 Advanced Use Cases

* Sales Dashboard (Amazon-style analytics)
* Customer Lifetime Value (CLV)
* Product Recommendation System (SQL-based)
* Inventory Analysis
* Supplier Performance Dashboard
* Monthly Revenue Growth Report
* Business KPI Dashboard

---

## ⚙️ How to Run This Project

1. Install PostgreSQL or MySQL
2. Create database:

   ```sql
   CREATE DATABASE ecommerce_db;
   ```
3. Import schema file:

   ```bash
   psql -U username -d ecommerce_db -f schema.sql
   ```
4. Run queries from `queries.sql`
5. Analyze results

---

## 📸 Future Improvements

* Add backend API using Python (Flask/Django)
* Integrate frontend dashboard
* Add real-time analytics
* Build REST APIs for product and order management
* Implement caching for performance optimization

---

## 🧑‍💻 Author

**Student Developer**
Python Full Stack Developer Learner
Focused on Backend, SQL & System Design

---

## 📌 Skills Gained

* Advanced SQL Development
* Database Design (ER Modeling)
* Data Analysis Thinking
* Backend System Design
* Real-world Problem Solving

---

⭐ If you like this project, don't forget to star the repository!
