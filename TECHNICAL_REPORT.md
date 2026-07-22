# 🏗️ Database Architecture & Technical Report

## 1. System Overview & Architecture
The **Holiday & Accommodation Reservation System** is a scalable reservation platform where users can query hotels, restaurants, car rentals, flights, and tours, make reservations, and securely process payments via an integrated digital wallet.

The system is built on a **Multi-Tier Architecture**, prioritizing database-level Data Integrity, High-Concurrency Transaction Safety, and query performance optimization.

---

## 2. Detailed Analysis of Core Database Components

### A. Schema Design & Indexing Strategy
The system consists of **25 relational tables**. The database schema is strictly normalized to the **3rd Normal Form (3NF)** to eliminate data redundancy.

* **Multi-Service & Category Architecture:** Tables like `Otels`, `Restorans`, `Aracs`, `Turs`, and `Ucaks` hold the main service providers, while their respective category tables (`OtelKategoris`, `MutfakKategoris`, etc.) provide a flexible and scalable data model.
* **Geographical Relations:** The `Sehir` (City) and `ülke` (Country) tables are connected via Foreign Keys (FK) to allow location-based filtering across all services.
* **Concurrency & Isolation:** To minimize deadlock risks during high traffic, reservation tables (`RezervasyonOtels`, `RezervasyonRestorans`) and review tables (`Yorumlars`) are completely decoupled for each service type.
* **Indexing Strategy:** To enhance query performance, **B-Tree Non-Clustered Indexes** are implemented on frequently queried Foreign Key columns such as `OtelKategori_ID`, `Sehir_ID`, `Kullanici_ID`, and `GidisTarihi`. This optimization reduces the database scanning cost from $O(N)$ to $O(\log N)$.

---

### B. Transaction Management & Payment Security
To ensure data consistency, an ACID-compliant (Atomicity, Consistency, Isolation, Durability) **Transaction-Based Payment System** is engineered.

* **Execution Flow:** When a user initiates a hotel reservation, a `BEGIN TRANSACTION` block is triggered. The system reads the user's wallet balance from the `Cuzdans` table and the per-person price from the `Otels` table.
* **Balance Validation & Rollback:** If the wallet balance is insufficient, a `RAISERROR` is triggered, and the process is entirely reverted using `ROLLBACK TRANSACTION`; no changes are committed to the database. If sufficient, the reservation is created via `INSERT`, the balance is deducted via `UPDATE`, and the transaction is permanently saved using `COMMIT TRANSACTION`.
* **Architectural Impact:** This structure provides 100% financial transaction safety by preventing scenarios where a balance is deducted without a reservation being created (or vice versa) during server failures or concurrent requests.

---

### C. Stored Procedures & Functions
Crucial business logic is shifted to the database layer to reduce network latency and provide robust protection against SQL Injection attacks.

1. **`sp_AddKullanici`:** Securely inserts new user registration parameters into the `Kullanicilars` table.
2. **`sp_GetOtellerByKategori`:** Allows users to dynamically and rapidly filter hotels based on specific categories.
3. **`sp_GetOtelRaporu`:** Aggregates reporting data by executing a `LEFT JOIN` between `Otels` and `RezervasyonOtels`. It calculates the average star rating dynamically using the `dbo.fn_GetOtelYildizOrtalama` scalar function.
4. **`sp_GetRestoranYorumlari`:** Joins `YorumlarRESTORANs` and `Kullanicilars` to list restaurant reviews, sorted by the most recent (`ORDER BY YorumTarihi DESC`).
5. **`sp_GetTemaliOteller`:** Utilizes a subquery architecture to fetch details of themed hotels (`OtelKategori_ID = 5`).
6. **`sp_GetUcuslarByTarih`:** Uses the `BETWEEN` operator to query and sort flight reservations within a specific date range.
7. **`sp_UpdateCuzdanBakiyesi`:** Executes atomic wallet balance top-up operations.

---

### D. Triggers & Data Integrity
Automated **AFTER** triggers are deployed to react instantly to DML (Data Manipulation Language) events:

1. **`trg_DeleteKullaniciCuzdan` (Data Integrity):** Triggered `AFTER DELETE` on the `Kullanicilars` table. It automatically removes the associated wallet record from the `Cuzdans` table to prevent orphan records and maintain relational integrity.
2. **`trg_AfterInsertOtels` (Audit Logging):** Triggered `AFTER INSERT` on the `Otels` table. It logs the newly added hotel's name, category, and timestamp into the `LogTable`.
3. **`trg_AfterDeleteRezervasyon` (Cancellation Tracking):** Secures the system's audit trail by logging deleted/canceled hotel reservations (via `Rotel_ID`) into the `LogTable`.

---

### E. Scheduled Jobs & Disaster Recovery
An automated backup procedure is designed to guarantee system continuity and prevent data loss.

* **`SP_YEDEK_ALINSIN` Procedure:** Dynamically generates a unique `.bak` file name using the current timestamp (`YYYYMMDD_HHMMSS`). It executes the `BACKUP DATABASE` command to perform a Full Backup of the `TatilSeyehatdb` database to a specified disk directory, and inserts a success log into the `YedekAlindi` table.
* **SQL Server Agent Integration:** This procedure is configured as a scheduled Job via SQL Server Agent, running automatically every night to ensure zero data loss without requiring manual administrative intervention.
