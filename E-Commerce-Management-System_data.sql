
-- =========================
-- SAMPLE DATA
-- =========================


insert into  customers(customer_name,email,phone,registration_date)
values
('Eswar','eswar@gmail.com','9876543210','2026-01-10'),
('Sneha','sneha@gmail.com','9876543211','2026-02-15'),
('Arjun','arjun@gmail.com','9876543212','2026-03-12');

insert into addresses(customer_id,address_type,city,state,pincode)
values
(1,'Home','Hyderabad','Telangana','500001'),
(2,'Office','Bangalore','Karnataka','560001'),
(3,'Home','Chennai','Tamil Nadu','600001');

insert into categories(category_name,parent_category_id)
values
('Electronics',NULL),
('Mobiles',1),
('Laptops',1);

insert into suppliers(supplier_name,email,phone)
values
('ABC Suppliers','abc@gmail.com','9000000001'),
('XYZ Traders','xyz@gmail.com','9000000002');


insert into products(product_name,description,price,stock_quantity,category_id,supplier_id)
values
('iPhone 15','Apple Mobile',80000,20,2,1),
('Dell XPS','Dell Laptop',120000,10,3,2),
('Samsung S24','Samsung Mobile',70000,15,2,1);


insert into orders(customer_id,order_date,order_status,total_amount)
values
(1,'2026-06-01','Completed',80000),
(2,'2026-06-02','Pending',120000);

insert into order_items(order_id,product_id,quantity,unit_price)
values
(1,1,1,80000),
(2,2,1,120000);

insert into payments(order_id,payment_date,payment_method,payment_status,amount)
values
(1,'2026-06-01','UPI','Paid',80000),
(2,'2026-06-02','Card','Pending',120000);


insert into shipments(order_id,shipment_date,delivery_date,shipment_status)
values
(1,'2026-06-02','2026-06-05','Delivered'),
(2,'2026-06-03',NULL,'Shipped');


insert into reviews(customer_id,product_id,rating,review_text)
values
(1,1,5,'Excellent'),
(2,2,4,'Good Laptop');


insert into wishlist(customer_id,product_id)
values
(1,2),
(2,1);

insert into cart(customer_id)
values
(1),
(2);

insert into cart_items(cart_id,product_id,quantity)
values
(1,1,2),
(2,2,1);


insert into  employees(employee_name,manager_id,salary,designation)
values
('Manager',NULL,90000,'Senior Manager'),
('Employee1',1,50000,'Developer'),
('Employee2',1,45000,'Tester');

-- =========================================================
-- BASIC QUERIES
-- =========================================================

