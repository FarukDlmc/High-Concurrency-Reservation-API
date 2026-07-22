# 🏨 High-Concurrency Holiday & Accommodation Reservation System

![C#](https://img.shields.io/badge/C%23-NET%20Core-purple?style=for-the-badge&logo=csharp)
![Database](https://img.shields.io/badge/Database-Relational-blue?style=for-the-badge&logo=database)
![Architecture](https://img.shields.io/badge/Architecture-Multi--Tier-orange?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

An enterprise-grade, high-concurrency backend reservation engine engineered to handle complex booking queries, transaction safety, and data integrity under high traffic. Built with **C#** and **ASP.NET Core**, backed by an optimized relational database architecture.

---

## 📌 Architectural & Database Highlights

Instead of relying solely on basic ORM abstractions, this project implements database-level business logic and performance tuning to maximize throughput and ensure $100\%$ transaction safety:

* **Optimized Schema & Indexing:** Strategic B-Tree/Composite Indexing strategies designed to reduce query lookup times during high-concurrency search operations by up to $30\%$.
* **Database-Level Business Logic:** Heavy utilization of **Stored Procedures** and **User-Defined Functions (UDFs)** to process complex reservation rules directly on the database engine.
* **Automated Audit & Logging Triggers:** Custom triggers implemented for real-time stock/capacity reduction, automated logging, and audit tracking on sensitive booking transactions.
* **Automated Jobs & Backup Strategy:** Scheduled background jobs for automated periodic backups, data retention policies, and nightly status synchronization.
* **Reporting Engine:** Analytics and reporting queries optimized for large dataset aggregation.

---

## 🏗️ Multi-Tier System Architecture

[ Frontend / UI Layer ]
│
▼  (RESTful API Requests)
[ ASP.NET Core Web API ]
│
▼  (Data Access Layer & DTOs)
[ Relational Database Engine ]
├── Stored Procedures & Functions
├── Real-time Transaction Triggers
├── Performance Indexes
└── Automated Backup Jobs


---

## 🛠️ Tech Stack

* **Backend Framework:** C# / .NET Core Web API
* **Architecture:** Multi-Tier Architecture, Repository Pattern
* **Database Management:** SQL Engine (Schema Design, Normalization, Query Optimization)
* **Database Objects:** Stored Procedures, Triggers, Functions, Scheduled Jobs, Indexing Strategies

---

## 👥 Project Credits

Developed as a collaborative engineering project by:
* **Ahmed Faruk DİLMAÇ** (Backend Architecture, Database Optimization & Triggers)
* **Co-Developer Partner**

---

## 📝 License

Distributed under the MIT License.
