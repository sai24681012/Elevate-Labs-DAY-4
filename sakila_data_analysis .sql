-- ===============================
-- Task 4: SQL for Data Analysis
-- Dataset: SQLite Sakila Database
-- ===============================

-- 1. List all tables
SELECT name 
FROM sqlite_master 
WHERE type='table';

-- 2. View structure of key tables
PRAGMA table_info(actor);
PRAGMA table_info(film);
PRAGMA table_info(customer);
PRAGMA table_info(rental);
PRAGMA table_info(payment);

-- 3. Basic SELECT with WHERE + ORDER BY
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name = 'DAVIS'
ORDER BY first_name
LIMIT 10;

-- 4. Customers table sample (first 100 rows)
SELECT customer_id, first_name, last_name, email
FROM customer
LIMIT 100;

-- 5. Rentals with customer info
SELECT r.rental_id, r.rental_date,
       c.first_name || ' ' || c.last_name AS customer
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
LIMIT 50;

-- 6. Rentals with film title and customer name
SELECT r.rental_id, r.rental_date, 
       f.title AS film_title,
       c.first_name || ' ' || c.last_name AS customer
FROM rental r
JOIN customer c ON r.customer_id = c.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
LIMIT 20;

-- 7. Customers and number of rentals
SELECT c.customer_id,
       c.first_name || ' ' || c.last_name AS customer,
       COUNT(r.rental_id) AS rentals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY rentals DESC
LIMIT 10;

-- 8. Customers who never made a payment (LEFT JOIN)
SELECT c.customer_id,
       c.first_name || ' ' || c.last_name AS customer
FROM customer c
LEFT JOIN payment p ON c.customer_id = p.customer_id
WHERE p.payment_id IS NULL;

-- 9. Customers with more rentals than the average (Subquery)
SELECT c.customer_id, 
       c.first_name || ' ' || c.last_name AS customer,
       COUNT(r.rental_id) AS rental_count
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
HAVING rental_count > (
    SELECT AVG(rental_count) 
    FROM (
        SELECT COUNT(r.rental_id) AS rental_count
        FROM rental r
        GROUP BY r.customer_id
    )
);

-- 10. Total & Average payments per customer
SELECT c.customer_id,
       c.first_name || ' ' || c.last_name AS customer,
       SUM(p.amount) AS total_spent,
       AVG(p.amount) AS avg_payment
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- 11. Create a view of top customers (drop first if exists)
DROP VIEW IF EXISTS top_customers;

CREATE VIEW top_customers AS
SELECT c.customer_id,
       c.first_name || ' ' || c.last_name AS customer,
       SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Use the view
SELECT * FROM top_customers;

-- ===============================
-- Indexes to optimize queries
-- ===============================
CREATE INDEX IF NOT EXISTS idx_rental_customer ON rental(customer_id);
CREATE INDEX IF NOT EXISTS idx_rental_inventory ON rental(inventory_id);
CREATE INDEX IF NOT EXISTS idx_inventory_film ON inventory(film_id);
CREATE INDEX IF NOT EXISTS idx_payment_customer ON payment(customer_id);
CREATE INDEX IF NOT EXISTS idx_actor_lastname ON actor(last_name);
CREATE INDEX IF NOT EXISTS idx_film_title ON film(title);

-- ===============================
-- Alternative: Get top 10 customers without creating a view
-- ===============================
SELECT c.customer_id,
       c.first_name || ' ' || c.last_name AS customer,
       SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 10;