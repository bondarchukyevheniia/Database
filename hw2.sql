CREATE DATABASE hw2;
USE hw2;


SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM customers;

EXPLAIN
SELECT o.order_id, c.name, p.price, o.quantity, c.city
FROM orders o
JOIN products p ON o.product_id=p.product_id
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.quantity> 6 AND p.price< (
SELECT AVG(price)
FROM products)
ORDER BY city;

EXPLAIN ANALYZE
SELECT o.order_id, c.name, p.price, o.quantity, c.city
FROM orders o
JOIN products p ON o.product_id=p.product_id
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.quantity> 6 AND p.price< (
SELECT AVG(price)
FROM products)
ORDER BY city;
# I created database hw2, next I created a query what looking for such orders and name of customers
# that have more than 6 product in one order and also price of this order has to be less than 
# average price of all orders. I used joins to attach columns name, price, quantity and city by 
# product_id and customer_id to orders(table). I used where to filter by conditions and I used
# order by city in the end.

CREATE INDEX orderproduct ON orders(product_id);
CREATE INDEX ordercustomer ON orders(customer_id);
CREATE INDEX orderorder ON orders(order_id);
CREATE INDEX productprice ON products(price);
CREATE INDEX orderquantity ON orders(quantity);
# I created all possible indexes for columns to optimize new query. New query has to be faster 
# with indexes.


EXPLAIN
WITH average AS (
SELECT AVG(price) AS avg_price
FROM products p)
SELECT o.order_id, c.name, p.price, o.quantity, c.city 
FROM orders o
JOIN products p ON o.product_id=p.product_id
JOIN customers c ON o.customer_id=c.customer_id
JOIN average a
WHERE price<a.avg_price AND o.quantity>6
ORDER BY city;

EXPLAIN ANALYZE
WITH average AS (
SELECT AVG(price) AS avg_price
FROM products p)
SELECT o.order_id, c.name, p.price, o.quantity, c.city 
FROM orders o
JOIN products p ON o.product_id=p.product_id
JOIN customers c ON o.customer_id=c.customer_id
JOIN average a
WHERE price<a.avg_price AND o.quantity>6
ORDER BY city;
# I used CTE to help query filter rows by average price. I select all columns what i needed
# and joined they by product_id and customer_id. Also I joined cte average to compare prices. 
# Also I added second condition about quantity>6 and order by city.


