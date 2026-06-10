-- =========================================================
-- E-COMMERCE MANAGEMENT SYSTEM COMPLETE SQL PROJECT
-- PostgreSQL Full Single File Code
-- =========================================================

-- =========================
-- DATABASE
-- =========================




create database ecommerce_db;

\c ecommerce_db


-- =========================
-- TABLES
-- =========================


create table customers(customer_id serial primary key , customer_name varchar(100), email varchar(100) unique, phone varchar(15),registration_date date) ;

create table addresses(address_id serial primary key, customer_id int references customers(customer_id), address_type varchar(100),  city varchar(50), state varchar(50),pincode char(6));

create table categories(category_id serial primary key, category_name varchar(100), parent_category_id int references categories(category_id) );

create table suppliers(supplier_id serial primary key , supplier_name varchar(100), email varchar(100), phone varchar(15));

create table products(product_id serial primary key , product_name varchar(100), description text,price NUMERIC(10,2), stock_quantity int, category_id int references categories(category_id), supplier_id int references suppliers(supplier_id));

create table orders(order_id serial primary key, customer_id int references customers(customer_id), order_date date, order_status varchar(50), total_amount numeric(10,2));

create table order_items (order_item_id serial primary key, order_id int references orders(order_id), product_id int references products(product_id), quantity int , unit_price numeric(10,2));

create table payments(payment_id serial primary key , order_id int references orders(order_id), payment_date date, payment_method varchar(50), payment_status varchar(50),amount numeric(10,2) );

create table shipments(shipment_id serial primary key , order_id int references orders(order_id), shipment_date date, delivery_date date, shipment_status varchar(50));

create table reviews(review_id serial primary key, customer_id int references customers(customer_id), product_id int references products(product_id), rating int , review_text text) ;

create table wishlist(wishlist_id serial primary key, customer_id int references customers(customer_id), product_id int references products(product_id));

create table cart(cart_id serial primary key , customer_id int references customers(customer_id));

create table cart_items(cart_item_id serial primary key, cart_id  int references cart(cart_id), product_id int references products(product_id), quantity int);

create table employees(employee_id serial primary key, employee_name varchar(100), manager_id int references employees(employee_id), salary numeric(10,2), designation varchar(50));

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


--1
select * from customers;
--2
select * from products where price > 5000;
--3
select * from products where stock_quantity < 10;
--4
select * from suppliers;
--5
select * from orders where order_status = 'Completed';
--6
select * from orders where DATE_TRUNC('month',order_date)= DATE_TRUNC('month',current_date);
--7
select * from customers where registration_date >=current_date - INTERVAL '30 days';
--8
select * from products order by price desc;
--9
select * from products order by price desc limit 10;
--10
select * from shipments where shipment_status = 'Shipped';


-- aggregate functions

--11
select count(*)  as total_customers from customers;
--12
select count(*) as total_products from products;
--13
select avg(price) as average_price from products;
--14
select max(price) as highest_price from products;
--15
select min(price) as lowest_price from products;
--16
select sum(total_amount) as total_revenue from orders;
--17
select count(*) as total_orders from orders;
--18
select sum(stock-quantity) as total_stock from products;
--19
select avg(total_amount) as avg_order_value from orders;
--20
select sum(price) from payments;

-- group by
--21
select c.category_name,count(p.product_name) from categories c join products p on c.category_id = p.category_id group by c.category_name; 
--22
select c.category_name,sum(oi.quantity * oi.unit_price) as total_price from categories c join products p on c.category_id = p.category_id  join order_items oi on oi.product_id = p.product_id group by category_name;
--23

select s.supplier_name,sum(oi.quantity* oi.unit_price) as revenue from suppliers s join products p on s.supplier_id = p.supplier_id join order_items oi on oi.product_id = p.product_id group by s.supplier_name;


--24

select city,count(customer_id) from addresses group by city;

--25
select order_status , count(order_id) from orders group by order_status;
--26

select avg(rating),product_id from reviews group by product_id;

--27
select s.supplier_name,count(product_id) from suppliers s join products p on s.supplier_id = p.supplier_id group by supplier_name;

--28
select shipment_status , count(shipment_id) from shipments group by shipment_status;
--29
select payment_method,count(payment_id) from payments group by payment_method;
--30
select date_trunc('month',order_date) as month , sum(total_amount) from orders group by month;

--havings
--31

select c.category_name,count(product_id) from categories c join products p on c.category_id=p.category_id group by category_name having count (p.product_id) > 20;
--32
select supplier_name ,count(supplier_id) from suppliers group by supplier_name having count(supplier_id)>10;
--33

select c.customer_name,count(o.order_id) from customers c join orders o on c.customer_id=o.customer_id group by c.customer_name having count(o.order_id) >4;

--34
select p.product_name,avg(r.rating) from products p join reviews r on p.product_id = r.product_id group by p.product_name  having avg(r.rating) > 4;
--35

select city ,count(customers_id) from addresses group by city having customer_id > 50;

-- inner join 
--36

select c.customer_name,o.order_id,o.total_amount from customers c join orders o on c.customer_id = o.customer_id ;

--37
select p.product_name ,o.* from products p join order_items oi on p.product_id=oi.product_id join orders o on oi.order_id = o.order_id;
--38
select p.product_name , c.category_name from products p inner join
categories c on p.product_id = c.category_id;
--39

select p.product_name , s.supplier_name from products p inner join suppliers s
on p.supplier_id = s.supplier_id; 
--40
select r.review_text , c.customer_name from reviews r inner join customers c
on c.customer_id = r.customer_id;
--41
select c.customer_name,p.* from customers c inner join orders o on o.customer_id= c.customer_id join payments p on p.order_id = o.order_id;
--42
select s.* , o.* from shipments s inner join orders o 
on o.order_id = s.order_id;
--43

select c.cart_item_id, p.product_name from cart_items c inner join products p
on c.product_id = p.product_id;
--44
select w.wishlist_id , p.product_name from wishlist w inner join products p 
on w.product_id = p.product_id;
--45

select c.customer_name, a.* from addresses a inner join customers c 
on c.customer_id = a.customer_id;

--46 left joins

select  c.customer_name from customers c left join orders o on c.customer_id = o.customer_id where o.order_id is null;
--47
select p.product_name from products p left join order_items oi on p.product_id= oi.product_id where oi.order_id is null;
--48
select p.product_name 
from products p 
left join reviews r 
on p.product_id = r.product_id
where r.review_id is null;

--49
select c.customer_name from customers c left join addresses a on c.customer_id = a.customer_id where a.address_id is null;

--50

select o.order_id from orders o left join payments p on o.order_id = p.payment_id where p.payment_id is null;
--right/full joins
--51
select p.product_name, r.review_text from products p full join reviews r on p.product_id = r.product_id ;

--52
select c.customer_name ,o.order_id from customers c full join orders o on c.customer_id = o.customer_id;
--53
select s.supplier_id ,p.product_name from suppliers s full join products p on s.supplier_id = p.supplier_id;

--54
select c.category_name ,p.product_name from categories c full join products p on c.category_id = p.category_id;
--55
select o.order_id, s.shipment_id from orders o full join shipments s on o.order_id = s.order_id;
--subqueries
--56
select product_id,sum(quantity) from order_items group by product_id order by sum(quantity) desc limit 1;

--57


select product_id,sum(quantity) from order_items group by product_id order by sum(quantity) desc offset 1  limit 1;
--58
select product_id,sum(quantity) from order_items group by product_id order by sum(quantity) desc  offset 2 limit 1;
--59
select c.customer_name, sum(o.total_amount) from customers c join orders o on c.customer_id = o.customer_id group by c.customer_name order by sum(o.total_amount) desc limit 1;
--60
select customer_id,avg(total_amount) from orders group by customer_id having sum(total_amount)> (select avg(total_amount) from orders);

--61

select * from products where price > (select avg(price) from products);

--62

select supplier_id, count(product_id) from products  group  by supplier_id order by count(product_id) desc limit 1;
--63

SELECT supplier_name FROM suppliers WHERE supplier_id = ( SELECT supplier_id FROM products GROUP BY supplier_id ORDER BY COUNT(*) DESC LIMIT 1 );

--64
select distinct c.customer_id,c.customer_name
from customers c
join orders o
on c.customer_id=o.customer_id
join order_items oi
on o.order_id=oi.order_id
join products p
on oi.product_id=p.product_id
where p.category_id=2;


--65
select p.product_id,p.product_name
from products p
left join order_items oi
on p.product_id=oi.product_id
where oi.product_id is null;


--66
select p.product_id,p.product_name,p.price
from products p
where p.price>
(
select avg(price)
from products
where category_id=p.category_id
);


--67
select c.customer_id,c.customer_name,sum(o.total_amount) as total_spent
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.customer_name
having sum(o.total_amount)>
(
select avg(total_amount)
from orders
);


--68
select s.supplier_id,s.supplier_name,sum(oi.quantity*oi.unit_price) as revenue
from suppliers s
join products p
on s.supplier_id=p.supplier_id
join order_items oi
on p.product_id=oi.product_id
group by s.supplier_id,s.supplier_name
having sum(oi.quantity*oi.unit_price)>
100000;



--69
select *
from orders
where total_amount>
(
select avg(total_amount)
from orders
);


--Window Functions 

--70
select p.product_name,r.rating
from products p
join reviews r
on p.product_id=r.product_id
where r.rating>
4;

--71 Rank products by revenue

select p.product_name,
sum(oi.quantity*oi.unit_price) as revenue,
rank() over(order by sum(oi.quantity*oi.unit_price) desc) as rank_no
from products p
join order_items oi
on p.product_id=oi.product_id
group by p.product_name;



--72 Rank customers by spending

select c.customer_name,
sum(o.total_amount) as spending,
rank() over(order by sum(o.total_amount) desc) as rank_no
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_name;



--73 Rank suppliers by sales

select s.supplier_name,
sum(oi.quantity*oi.unit_price) as sales,
rank() over(order by sum(oi.quantity*oi.unit_price) desc) as rank_no
from suppliers s
join products p
on s.supplier_id=p.supplier_id
join order_items oi
on p.product_id=oi.product_id
group by s.supplier_name;



--74 Find top 3 products per category

select *
from
(
select c.category_name,
p.product_name,
p.price,
row_number() over(partition by c.category_name order by p.price desc) as rn
from categories c
join products p
on c.category_id=p.category_id
)x
where rn<=3;



--75 Find top 5 customers per city

select *
from
(
select a.city,
c.customer_name,
sum(o.total_amount) as spending,
row_number() over(partition by a.city order by sum(o.total_amount) desc) as rn
from customers c
join addresses a
on c.customer_id=a.customer_id
join orders o
on c.customer_id=o.customer_id
group by a.city,c.customer_name
)x
where rn<=5;



--76 Find running total revenue

select order_date,
total_amount,
sum(total_amount) over(order by order_date) as running_total
from orders;



--77 Find cumulative monthly sales

select month,total_sales,
sum(total_sales) over(order by month) as cumulative_sales
from
(
select date_trunc('month',order_date) as month,
sum(total_amount) as total_sales
from orders
group by month
)x;



--78 Find highest order per customer

select *
from
(
select c.customer_name,
o.order_id,
o.total_amount,
row_number() over(partition by c.customer_name order by o.total_amount desc) as rn
from customers c
join orders o
on c.customer_id=o.customer_id
)x
where rn=1;



--79 Find latest order per customer

select *
from
(
select c.customer_name,
o.order_id,
o.order_date,
row_number() over(partition by c.customer_name order by o.order_date desc) as rn
from customers c
join orders o
on c.customer_id=o.customer_id
)x
where rn=1;



--80 Find top-rated product in each category

select *
from
(
select c.category_name,
p.product_name,
avg(r.rating) as avg_rating,
row_number() over(partition by c.category_name order by avg(r.rating) desc) as rn
from categories c
join products p
on c.category_id=p.category_id
join reviews r
on p.product_id=r.product_id
group by c.category_name,p.product_name
)x
where rn=1;

CTE Questions 

--81 Find category-wise revenue using CTE

with revenue_cte as
(
select c.category_name,
sum(oi.quantity*oi.unit_price) as revenue
from categories c
join products p
on c.category_id=p.category_id
join order_items oi
on p.product_id=oi.product_id
group by c.category_name
)
select * from revenue_cte;



--82 Find customer spending summary using CTE

with customer_cte as
(
select c.customer_name,
sum(o.total_amount) as spending
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_name
)
select * from customer_cte;



--83 Find top 10 customers using CTE

with top_customers as
(
select c.customer_name,
sum(o.total_amount) as spending
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_name
)
select *
from top_customers
order by spending desc
limit 10;



--84 Find top products using CTE

with product_cte as
(
select p.product_name,
sum(oi.quantity) as total_sold
from products p
join order_items oi
on p.product_id=oi.product_id
group by p.product_name
)
select *
from product_cte
order by total_sold desc;



--85 Find supplier performance report using CTE

with supplier_cte as
(
select s.supplier_name,
count(p.product_id) as total_products,
sum(oi.quantity*oi.unit_price) as revenue
from suppliers s
join products p
on s.supplier_id=p.supplier_id
join order_items oi
on p.product_id=oi.product_id
group by s.supplier_name
)
select * from supplier_cte;

--Recursive CTE 

--86 Display category hierarchy

with recursive category_tree as
(
select category_id,category_name,parent_category_id
from categories
where parent_category_id is null

union all

select c.category_id,c.category_name,c.parent_category_id
from categories c
join category_tree ct
on c.parent_category_id=ct.category_id
)
select * from category_tree;



--87 Display sub-category tree

with recursive sub_category as
(
select category_id,category_name,parent_category_id
from categories
where parent_category_id is null

union all

select c.category_id,c.category_name,c.parent_category_id
from categories c
join sub_category s
on c.parent_category_id=s.category_id
)
select * from sub_category;



--88 Display employee reporting hierarchy

with recursive emp_tree as
(
select employee_id,employee_name,manager_id
from employees
where manager_id is null

union all

select e.employee_id,e.employee_name,e.manager_id
from employees e
join emp_tree et
on e.manager_id=et.employee_id
)
select * from emp_tree;



--89 Find all managers and employees under them

with recursive manager_tree as
(
select employee_id,employee_name,manager_id
from employees
where manager_id is null

union all

select e.employee_id,e.employee_name,e.manager_id
from employees e
join manager_tree mt
on e.manager_id=mt.employee_id
)
select * from manager_tree;



--90 Generate category depth levels

with recursive depth_cte as
(
select category_id,category_name,parent_category_id,1 as level
from categories
where parent_category_id is null

union all

select c.category_id,c.category_name,c.parent_category_id,d.level+1
from categories c
join depth_cte d
on c.parent_category_id=d.category_id
)
select * from depth_cte;

--Transaction Questions 

--91 Place order with payment and shipment inside one transaction

begin;

insert into orders(customer_id,order_date,order_status,total_amount)
values(1,current_date,'Placed',50000);

insert into payments(order_id,payment_date,payment_method,payment_status,amount)
values(1,current_date,'UPI','Paid',50000);

insert into shipments(order_id,shipment_date,shipment_status)
values(1,current_date,'Shipped');

commit;



--92 Rollback failed payment transaction

begin;

insert into payments(order_id,payment_date,payment_method,payment_status,amount)
values(2,current_date,'Card','Failed',30000);

rollback;



--93 Use SAVEPOINT during checkout process

begin;

savepoint cart_save;

insert into orders(customer_id,order_date,order_status,total_amount)
values(2,current_date,'Pending',40000);

rollback to cart_save;

commit;



--94 Demonstrate COMMIT after successful order

begin;

insert into orders(customer_id,order_date,order_status,total_amount)
values(3,current_date,'Completed',70000);

commit;



--95 Handle stock deduction transaction

begin;

update products
set stock_quantity=stock_quantity-1
where product_id=1;

commit;


--Optimization 
--96 Create index on product_name

create index idx_product_name
on products(product_name);



--97 Create index on customer_email

create index idx_customer_email
on customers(email);



--98 Compare query performance before and after index

explain analyze
select *
from products
where product_name='iPhone 15';



--99 Use EXPLAIN ANALYZE on revenue report

explain analyze
select p.product_name,
sum(oi.quantity*oi.unit_price) as revenue
from products p
join order_items oi
on p.product_id=oi.product_id
group by p.product_name;

--Mega Challenge Queries (Interview Level) 

--100 Optimize highest-selling-product query

select p.product_name,
sum(oi.quantity) as total_sold
from products p
join order_items oi
on p.product_id=oi.product_id
group by p.product_name
order by total_sold desc
limit 1;

--101 Generate Amazon-style Sales Dashboard

select
date_trunc('month',o.order_date) as month,
count(o.order_id) as total_orders,
sum(o.total_amount) as total_sales,
avg(o.total_amount) as avg_order_value
from orders o
group by month
order by month;



--102 Generate Top 10 Products Report

select
p.product_name,
sum(oi.quantity) as total_sold,
sum(oi.quantity*oi.unit_price) as revenue
from products p
join order_items oi
on p.product_id=oi.product_id
group by p.product_name
order by revenue desc
limit 10;



--103 Generate Customer Lifetime Value Report

select
c.customer_id,
c.customer_name,
count(o.order_id) as total_orders,
sum(o.total_amount) as lifetime_value
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.customer_name
order by lifetime_value desc;



--104 Generate Product Recommendation Query

select
p.product_name,
count(w.customer_id) as wishlist_count
from products p
join wishlist w
on p.product_id=w.product_id
group by p.product_name
order by wishlist_count desc;



--105 Generate Repeat Customer Analysis

select
c.customer_id,
c.customer_name,
count(o.order_id) as total_orders
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_id,c.customer_name
having count(o.order_id)>1;



--106 Generate Inventory Aging Report

select
product_name,
stock_quantity,
case
when stock_quantity<5 then 'Low Stock'
when stock_quantity between 5 and 20 then 'Medium Stock'
else 'High Stock'
end as stock_status
from products;



--107 Generate Supplier Performance Dashboard

select
s.supplier_name,
count(p.product_id) as total_products,
sum(oi.quantity*oi.unit_price) as revenue
from suppliers s
join products p
on s.supplier_id=p.supplier_id
join order_items oi
on p.product_id=oi.product_id
group by s.supplier_name
order by revenue desc;



--108 Generate Monthly Growth Report

select
month,
sales,
lag(sales) over(order by month) as previous_month_sales,
sales-lag(sales) over(order by month) as growth
from
(
select
date_trunc('month',order_date) as month,
sum(total_amount) as sales
from orders
group by month
)x;



--109 Generate Revenue Forecast Dataset Query

select
date_trunc('month',order_date) as month,
sum(total_amount) as revenue
from orders
group by month
order by month;



--110 Generate Complete Business KPI Dashboard using CTEs + Window Functions + Joins

with sales_cte as
(
select
date_trunc('month',o.order_date) as month,
sum(o.total_amount) as total_sales,
count(o.order_id) as total_orders
from orders o
group by month
),

customer_cte as
(
select
c.customer_name,
sum(o.total_amount) as spending,
rank() over(order by sum(o.total_amount) desc) as customer_rank
from customers c
join orders o
on c.customer_id=o.customer_id
group by c.customer_name
),

product_cte as
(
select
p.product_name,
sum(oi.quantity) as total_sold,
rank() over(order by sum(oi.quantity) desc) as product_rank
from products p
join order_items oi
on p.product_id=oi.product_id
group by p.product_name
)

select
s.month,
s.total_sales,
s.total_orders,
c.customer_name,
c.spending,
c.customer_rank,
p.product_name,
p.total_sold,
p.product_rank
from sales_cte s
cross join customer_cte c
cross join product_cte p;