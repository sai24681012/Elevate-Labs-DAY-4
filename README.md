# Elevate-Labs-DAY-4
# 🧠 Task 4: SQL for Data Analysis

## 📌 Objective
Use SQL queries to extract, analyze, and manipulate structured data from a relational database. This task demonstrates proficiency in SQL fundamentals, joins, subqueries, views, and performance optimization.

## 🛠️ Tools Used
- **Database Engine**: SQLite (or MySQL / PostgreSQL)
- **SQL Editor**: DB Browser for SQLite / pgAdmin / MySQL Workbench
- **Dataset**: `Ecommerce_SQL_Database` (or any dataset of your choice)


## 📚 Concepts Demonstrated
- `SELECT`, `WHERE`, `ORDER BY`, `GROUP BY` for data filtering and sorting
- `JOIN` operations: `INNER`, `LEFT`, `RIGHT` to combine related tables
- Subqueries for nested analysis
- Aggregate functions: `SUM`, `AVG`, `COUNT` for metrics
- Views for reusable analysis
- Indexing for query performance
## 📸 Screenshots
https://github.com/sai24681012/Elevate-Labs-DAY-4/tree/main/screenshots/

<img width="898" height="689" alt="Screenshot 2025-09-28 142019" src="https://github.com/user-attachments/assets/f75864b9-6780-4fa3-b582-1897442840ab" />
<img width="485" height="304" alt="Screenshot 2025-09-28 142047" src="https://github.com/user-attachments/assets/1c3ffe42-e9d8-4948-b274-2c338bf10915" />
<img width="568" height="507" alt="Screenshot 2025-09-28 142122" src="https://github.com/user-attachments/assets/7f34c63c-b0bb-4539-a1a5-19e15a1b8d10" />
<img width="651" height="429" alt="Screenshot 2025-09-28 142146" src="https://github.com/user-attachments/assets/cea4495c-4b9a-4a69-9634-b331a9c6704f" />

## 🧪 Sample Queries
```sql
-- Top 10 spending customers
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Customers with rental count
SELECT p.customer_id, SUM(p.amount) AS total_spent, COUNT(r.rental_id) AS rental_count
FROM payment p
JOIN rental r ON p.customer_id = r.customer_id
GROUP BY p.customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Create a view for top customers
CREATE VIEW top_customers AS
SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id;

-- Query the view
SELECT * FROM top_customers
ORDER BY total_spent DESC
LIMIT 10;
⚙️ Performance Optimization
CREATE INDEX idx_payment_customer ON payment(customer_id);
CREATE INDEX idx_rental_customer ON rental(customer_id);
🚀 How to Run
Clone the repository:
git clone https://github.com/sai24681012/Elevate-Labs-DAY-4.git
cd Elevate-Labs-DAY-4

Open the .sqlite database in DB Browser for SQLite.

Load and execute queries from sql_queries.sql.

View results and screenshots for verification.
🎯 Outcome
By completing this task, I’ve learned to:

Write efficient SQL queries for real-world data analysis

Use views and indexes to improve performance

Troubleshoot errors and locked database issues

Prepare clean deliverables for submission

📬 Deliverables
✅ sql_queries.sql file containing all queries

✅ Screenshots of query outputs

✅ This README.md file for documentation
## 🧪 Testing & Validation

All queries were tested using DB Browser for SQLite. Screenshots of successful query execution are included in the `screenshots/` folder.
 Each query was validated for:
- Correct syntax
- Accurate results
- Performance (using indexes)
- Reusability (via views)


