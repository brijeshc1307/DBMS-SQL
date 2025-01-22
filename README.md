# Automation of CSV Uploading to Test Database

**Prepared by:** Brijesh Chaudhary  
**Date:** 10 Jan 2025

---

## Introduction
The process of manually uploading CSV data to the Test database is both time-consuming and error-prone. Previously, this task required approximately 10 hours to complete manually, which significantly impacted operational efficiency. To address this challenge, an automated solution was developed to upload CSV data, creating database tables with the current date as the table name. A scheduled job was configured to run this automated process every Tuesday at 12:00 PM. This automation reduces the time taken to upload data to just 3-7 minutes, significantly improving productivity and accuracy.

---

## Objectives
1. Minimize the time required for uploading CSV data to the Test database.  
2. Enhance the efficiency and accuracy of the data upload process.  
3. Ensure a consistent and reliable data upload schedule.  

---

## Scope
The automation solution covers the following key aspects:

- **CSV Data Upload:** Automates the uploading of CSV files to the Test database.
- **Dynamic Table Naming:** Creates new database tables with the current date as part of the table name.
- **Job Scheduling:** Implements a job scheduler to run the automated query every Tuesday at 12:00 PM.
- **Performance Optimization:** Reduces the data upload time from 10 hours to just 3-7 minutes.

---

## Implementation Details

1. **Automated Script Development:**  
   - Developed a Python script to read CSV files, process the data, and upload it to the Test database.
   - Integrated logic to create tables dynamically with the current date as part of the table name.

2. **Job Scheduling:**  
   - Configured a job scheduler using [specify tool or platform, e.g., Windows Task Scheduler, Cron, etc.] to trigger the script every Tuesday at 12:00 PM.
   - Implemented error logging and notification mechanisms in case of failures.

3. **Performance Optimization:**  
   - Optimized database queries and file processing logic to handle large datasets efficiently.
   - Conducted thorough testing to ensure consistent performance and reliability.

4. **Fallback for Manual Uploads:**  
   - Maintained a fallback process for manual data uploads as a contingency measure, ensuring business continuity.

---

## Benefits

- **Time Savings:** Reduced the time required for CSV data uploads from 10 hours to 3-7 minutes, saving over 9 hours per upload cycle.
- **Improved Accuracy:** Eliminated human errors associated with manual data entry.
- **Increased Productivity:** Freed up valuable resources to focus on higher-value tasks.
- **Consistency:** Ensured timely data uploads with an automated schedule.

---

## Results and Impact

The implementation of this automation has:

- Increased efficiency by over 90%.  
- Enhanced data accuracy and reliability.  
- Demonstrated a scalable solution that can be adapted for other similar processes.  

---

## Future Enhancements

- Integrate notification systems (e.g., email or Slack alerts) to inform stakeholders about the success or failure of the scheduled jobs.
- Extend the automation to handle additional data formats, such as JSON or XML.
- Implement monitoring and reporting dashboards to track upload performance.

---

## Conclusion

The automated solution for CSV uploading to the Test database has successfully transformed a labor-intensive process into an efficient and reliable system. This implementation not only saves time but also contributes to overall operational excellence. Expanding this approach to other data management tasks within the organization is recommended to achieve similar benefits.

---
**Attachments:**  
- Script Documentation  
- Performance Metrics  
- Test Results

