# Automating SQL Server Tasks

## Overview
This repository provides SQL scripts and automation techniques to manage recurring database tasks in SQL Server. The following tasks are automated:

1. **Automated Weekly CSV Data Upload** - Automatically imports CSV data into a SQL table on a weekly basis.
2. **Auto Delete Old Tables** - Retains only the latest two tables and removes older ones.
3. **Automated Daily Morning Checklist Report** - Generates a daily report summarizing key database metrics.

---

## Features
### 1. Automated Weekly CSV Data Upload
- **Description:**
  - A SQL Server Job scheduled to run weekly.
  - Imports CSV data into a new SQL table.
  - Ensures data integrity and logs successful uploads.
- **Technology Used:**
  - SQL Server Integration Services (SSIS)
  - BULK INSERT command
  - SQL Server Agent

### 2. Auto Delete Old Tables
- **Description:**
  - Scheduled task to remove outdated tables.
  - Retains only the most recent two tables.
  - Helps optimize database storage and performance.
- **Technology Used:**
  - Dynamic SQL scripting
  - SQL Server Agent Jobs

### 3. Automated Daily Morning Checklist Report
- **Description:**
  - A daily report generation task to monitor key system metrics.
  - Provides insights on system health, job statuses, and performance metrics.
  - Sends the report via email to the concerned stakeholders.
- **Technology Used:**
  - SQL Server Reporting Services (SSRS)
  - SQL stored procedures
  - Database Mail for automated reporting

---

## Prerequisites
- Microsoft SQL Server (2016 or later)
- SQL Server Management Studio (SSMS)
- SQL Server Agent enabled
- CSV files formatted correctly for import
- Database Mail configured for email reports

---

## Setup Instructions
### 1. Configure CSV Upload
- Place the CSV files in the designated folder.
- Modify the `BULK INSERT` query in the provided SQL script.
- Schedule the job using SQL Server Agent.

### 2. Configure Table Retention
- Adjust the table naming convention as per your requirement.
- Schedule the cleanup script using SQL Server Agent.

### 3. Setup Checklist Report
- Modify the report query to include relevant checks.
- Configure email settings in SQL Server.
- Schedule the report generation task.

---

## Usage
1. Clone the repository and update SQL scripts as per your database structure.
2. Use SSMS to deploy the scripts.
3. Monitor execution logs for troubleshooting.

---

## Folder Structure
```
|-- scripts/
    |-- upload_csv.sql
    |-- delete_old_tables.sql
    |-- daily_checklist_report.sql
|-- README.md
```

---

## Contributing
Feel free to open issues or submit pull requests to improve the automation process.

---

## License
This project is licensed under the MIT License - see the LICENSE file for details.

