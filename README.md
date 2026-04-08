# AWS Core Services Hands-on (L11)

## Overview

This project demonstrates how to build a simple data analytics pipeline using AWS services.
An e-commerce dataset was uploaded to Amazon S3, processed using AWS Glue, and queried using Amazon Athena.

---

## Architecture / Workflow

1. Upload dataset to Amazon S3
2. Use AWS Glue Crawler to catalog the data
3. Store metadata in AWS Glue Data Catalog
4. Query data using Amazon Athena
5. Monitor crawler activity using CloudWatch

---

## Step-by-Step Setup (mostly completed in class!)

### 1. Create S3 Bucket and Upload Data

* Created an S3 bucket
* Uploaded the e-commerce dataset (CSV file)
* Verified file location and permissions

---

### 2. Configure IAM Role

* Created IAM role for AWS Glue
* Attached required policies:

  * AmazonS3FullAccess
  * AWSGlueServiceRole
* Ensured Glue had permission to access S3 data

---

### 3. Create AWS Glue Crawler

* Created a crawler to scan the S3 bucket
* Selected:

  * Data source: S3
  * IAM role created earlier
* Set output database:

  * `output_db`
* Ran crawler to automatically infer schema

---

### 4. Verify Data in Glue Data Catalog

* Confirmed table creation:

  * `amazon_sale_report_csv`
  * `raw`
* Verified schema and columns

---

### 5. Monitor with CloudWatch

* Opened CloudWatch logs
* Verified crawler execution logs:

  * Start crawl
  * Classification complete
  * Table creation
  * Crawl finished successfully

---

### 6. Query Data Using Athena

* Opened Athena query editor
* Selected:

  * Data source: AwsDataCatalog
  * Database: `output_db`
* Ran SQL queries to analyze dataset

---

## SQL Queries

### Query 1: Preview Data

* Display first 10 rows of dataset

### Query 2: Orders by Category

* Count total orders per category
* Sorted by highest orders

### Query 3: Fulfillment Analysis

* Total orders, units sold, and revenue by fulfillment type
* Excludes cancelled and pending orders

### Query 4: Monthly Sales Trend

* Aggregates orders and revenue by month

### Query 5: Top Products by Category

* Uses ROW_NUMBER() window function
* Finds top-performing SKUs per category

---

## AWS Services Used

* Amazon S3 → Data storage
* AWS Glue → Data catalog + crawler
* Amazon Athena → SQL querying
* Amazon CloudWatch → Monitoring and logs
* IAM → Access control

---

## Project Structure

```
project-root/
│
├── results/
│   ├── query1.csv
│   ├── query2.csv
│   ├── query3.csv
│   ├── query4.csv
│   └── query5.csv
│
├── screenshots/
│   ├── crawlerlogs.png
│   ├── query1.png
│   ├── query2.png
│   ├── query3.png
│   ├── query4.png
│   └── query5.png
│
├── queries.sql
├── README.md
└── L10_itcs6190_AWS_Core_Services.docx
```

---

## Screenshots Included

* CloudWatch crawler logs
* Athena query results (Query 1–5)

---

## Conclusion

This project demonstrates a complete AWS data pipeline:

* Data ingestion (S3)
* Data cataloging (Glue)
* Querying (Athena)
* Monitoring (CloudWatch)

The workflow shows how AWS services integrate to enable scalable data analysis.
