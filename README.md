# Little Lemon Restaurant Data Project

This is a comprehensive SQL-based project simulating the operations of a fictional restaurant, **Little Lemon**. The project demonstrates full-cycle data handling: from schema design and data insertion to advanced SQL procedures, Python analytics, and Tableau visualizations.

---

## Contents

- **1. Database Schema**
- **2. Data Insertion**
- **3. SQL Queries & Procedures**
- **4. Jupyter Notebook Analytics**
- **5. Tableau Dashboard**
- **6. Folder Structure**
- **7. Tools Used**

---

## 1. Database Schema

The schema includes the following key tables:
- `Customers`
- `MenuItems`
- `Menus`
- `Orders`
- `Staff`
- `Bookings`
- `OrderDeliveryStatus`
- `OrderDetails`

Schema design covers:
- Primary/Foreign keys
- Relationships (1-to-many, many-to-many)
- Normalized structure

> SQL File: `littlelemon_schema.sql`

---

## 2. Data Insertion

Random but structured sample data was inserted into all key tables to simulate realistic restaurant operations.

> SQL File: `littlelemon_db.sql`

---

## 3. SQL Queries & Procedures

Key SQL operations include:

### Views and Joins:
- Menu view combining items and categories
- Active customer view
- Order tracking view

### Procedures:
- `GetOrderDetail(order_id)` — Returns detailed information about a specific order
- `CancelOrder(order_id)` — Cancels a placed order and updates delivery status

### Advanced Filtering:
- Order status checks
- Bookings by date
- Staff assignment filters

> SQL File: `littlelemon_queries.sql`

---

## 4. Jupyter Notebook Analytics

Data from SQL tables was explored using Python and Jupyter Notebooks. This includes:
- Connecting to MySQL
- Performing SQL queries via Python
- Analyzing sales, orders, bookings
- Optional data visualizations using pandas and matplotlib

> Jupyter File: `littlelemon_project.ipynb`

---

## 5. Tableau Dashboard

Interactive Tableau dashboards were created to visualize:
- Sales trends
- Order frequency
- Staff performance
- Booking distribution

> Tableau Files:
- `littlelemon_dashboard.twbx`
- `littlelemon_summary.twb`

---

## 6. Folder Structure
LittleLemonProject/
│
├── littlelemon_schema.sql
├── littlelemon_db.sql
├── littlelemon_queries.sql
│
├── littlelemon_project.ipynb
│
├── littlelemon_dashboard.twbx
├── littlelemon_summary.twb
│
└── README.md

---

## 7. Tools Used

- **MySQL Workbench** — Schema design, data insertion, query execution
- **Python (Jupyter Notebook)** — Analytics and integration
- **Tableau** — Visualization dashboards
- **Markdown** — Documentation

---

## Summary

This project showcases real-world data handling skills including:
- Designing normalized databases
- Writing and testing SQL procedures
- Automating analysis with Python
- Visual storytelling using Tableau

A complete portfolio-ready project for showcasing SQL, Python, and BI skills.