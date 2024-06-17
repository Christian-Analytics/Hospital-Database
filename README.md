# Hospital Database Project 🏥

Welcome to the Hospital Database Repository! This project features a robust database system designed to efficiently manage hospital-related data. Explore detailed documentation of the database schema and a set of example queries to interact with the data. This project showcases my skills in database design, SQL, and data management within a healthcare context.

## Getting Started 🚀

### Prerequisites 🔧
- **[SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)**: Install SQL Server to load the master and log data files.
- **SQL Server Management Studio (SSMS)**: Use SSMS for database management.

### Installation 📥
1. **Clone the Repository**:
    ```bash
    git clone https://github.com/Christian-DevInsights/hospital-database.git
    cd hospital-database
    ```

2. **Attach the Database**:
    - Open SSMS and connect to your SQL Server.
    - Right-click "Databases" and choose "Attach...".
    - Click "Add..." and select `Hospital.mdf` from the `MDF_and_LDF` folder.
    - Verify the path for `Hospital_Log.ldf` or locate it manually.
    - Click "OK".

### Documentation 📚
- **Database Design Documentation**: Find detailed descriptions of the tables and relationships within the database with a narrative provided, relational schema, a data dictionary and more in the `DBDD` folder.

### Running Example Queries 🔍
- Explore a variety of simple SQL queries in the `Queries` folder for data retrieval and reporting.

## Database Structure 🏗️
- **Data File**: Includes 14 base tables, 10 views, and 14 stored procedures for common operations.
    - Views and stored procedures are organized in respective folders in SSMS.

## Features 🌟
- **Database Schema**: Structured tables for patients, staff, medical supplies, treatments, and billing.
- **Query Collection**: Demonstrates SQL capabilities for data manipulation and reporting.
- **Data Examples**: Pre-loaded datasets facilitate easy testing.
