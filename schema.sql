
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
