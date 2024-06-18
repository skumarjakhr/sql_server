
Can you share top 20 most commonly used query samples in bigquery with very little description, keep it short

ChatGPT
Sure! Here are 20 commonly used BigQuery query samples with brief descriptions:

Select All Columns:

sql
Copy code
SELECT * FROM `project.dataset.table`
Retrieves all columns from a table.

Select Specific Columns:

sql
Copy code
SELECT column1, column2 FROM `project.dataset.table`
Retrieves specific columns from a table.

Filtering Rows:

sql
Copy code
SELECT * FROM `project.dataset.table` WHERE column1 = 'value'
Filters rows based on a condition.

Aggregating Data:

sql
Copy code
SELECT column1, COUNT(*) AS count FROM `project.dataset.table` GROUP BY column1
Groups data and counts occurrences.

Sorting Results:

sql
Copy code
SELECT * FROM `project.dataset.table` ORDER BY column1 DESC
Sorts results in descending order.

Limiting Results:

sql
Copy code
SELECT * FROM `project.dataset.table` LIMIT 10
Limits the number of rows returned.

Joins (INNER JOIN):

sql
Copy code
SELECT a.*, b.column1 FROM `project.dataset.table1` a
JOIN `project.dataset.table2` b ON a.id = b.id
Joins two tables on a common column.

Left Join:

sql
Copy code
SELECT a.*, b.column1 FROM `project.dataset.table1` a
LEFT JOIN `project.dataset.table2` b ON a.id = b.id
Returns all rows from the left table, with matched rows from the right table.

Right Join:

sql
Copy code
SELECT a.*, b.column1 FROM `project.dataset.table1` a
RIGHT JOIN `project.dataset.table2` b ON a.id = b.id
Returns all rows from the right table, with matched rows from the left table.

Full Join:

sql
Copy code
SELECT a.*, b.column1 FROM `project.dataset.table1` a
FULL JOIN `project.dataset.table2` b ON a.id = b.id
Returns all rows when there is a match in either table.

Cross Join:

sql
Copy code
SELECT a.*, b.column1 FROM `project.dataset.table1` a
CROSS JOIN `project.dataset.table2` b
Returns the Cartesian product of the two tables.

Union:

sql
Copy code
SELECT column1 FROM `project.dataset.table1`
UNION
SELECT column1 FROM `project.dataset.table2`
Combines results from two queries.

Union All:

sql
Copy code
SELECT column1 FROM `project.dataset.table1`
UNION ALL
SELECT column1 FROM `project.dataset.table2`
Combines results from two queries including duplicates.

Subquery:

sql
Copy code
SELECT * FROM (
    SELECT column1, column2 FROM `project.dataset.table`
) WHERE column1 = 'value'
Uses a subquery within a query.

Case Statement:

sql
Copy code
SELECT column1,
    CASE
        WHEN condition1 THEN 'Result1'
        WHEN condition2 THEN 'Result2'
        ELSE 'Result3'
    END AS new_column
FROM `project.dataset.table`
Performs conditional logic.

Date Functions:

sql
Copy code
SELECT CURRENT_DATE() AS today, EXTRACT(YEAR FROM CURRENT_DATE()) AS year
Retrieves the current date and extracts the year.

String Functions:

sql
Copy code
SELECT LOWER(column1) AS lower_case, LENGTH(column1) AS length FROM `project.dataset.table`
Applies string functions like LOWER and LENGTH.

Window Functions:

sql
Copy code
SELECT column1, 
       ROW_NUMBER() OVER (PARTITION BY column2 ORDER BY column3) AS row_num
FROM `project.dataset.table`
Adds a row number based on partitioning and ordering.

Common Table Expressions (CTEs):

sql
Copy code
WITH cte AS (
    SELECT column1, column2 FROM `project.dataset.table`
)
SELECT * FROM cte WHERE column1 = 'value'
Uses a CTE to structure complex queries.

Array Functions:

sql
Copy code
SELECT column1, ARRAY_LENGTH(column2) AS array_length FROM `project.dataset.table`
Applies functions to array-type columns.

These examples cover a wide range of basic and advanced querying techniques in BigQuery.

Share couple method to import and export data as well

ChatGPT
Certainly! Here are a couple of methods for importing and exporting data in BigQuery:

Importing Data into BigQuery
Using the BigQuery Web UI:

Steps:
Go to the BigQuery web UI in the Google Cloud Console.
Click on the project and dataset where you want to load the data.
Click the "Create Table" button.
In the "Create Table" page, specify the source of the data (Google Cloud Storage, Upload from your computer, etc.).
Configure the table details, such as the table name and schema.
Click the "Create Table" button to load the data.
Description: This method is straightforward and useful for one-time imports or small datasets.
Using the bq Command-Line Tool:

Command:
sh
Copy code
bq load --source_format=CSV dataset.table gs://bucket/path/to/data.csv schema.json
Description: This command loads data from a CSV file stored in Google Cloud Storage into a specified BigQuery table. The schema of the table is defined in schema.json.
Example Schema File (schema.json):
json
Copy code
[
  {"name": "name", "type": "STRING", "mode": "NULLABLE"},
  {"name": "age", "type": "INTEGER", "mode": "NULLABLE"},
  {"name": "email", "type": "STRING", "mode": "NULLABLE"}
]
Using Python Client Library:

Code:
python
Copy code
from google.cloud import bigquery

client = bigquery.Client()
table_id = "your-project.your_dataset.your_table"

job_config = bigquery.LoadJobConfig(
    source_format=bigquery.SourceFormat.CSV, skip_leading_rows=1, autodetect=True,
)

uri = "gs://your-bucket/path/to/your/file.csv"

load_job = client.load_table_from_uri(
    uri, table_id, job_config=job_config
)

load_job.result()  # Wait for the job to complete.

destination_table = client.get_table(table_id)
print("Loaded {} rows.".format(destination_table.num_rows))
Description: This code snippet uses the BigQuery Python client library to load a CSV file from Google Cloud Storage into BigQuery.
Exporting Data from BigQuery
Using the BigQuery Web UI:

Steps:
Go to the BigQuery web UI in the Google Cloud Console.
Run a query to select the data you want to export.
Click on the "Save Results" button.
Choose the destination (e.g., Google Sheets, CSV file in Google Cloud Storage, etc.).
Description: This method is simple and convenient for exporting query results or small datasets.
Using the bq Command-Line Tool:

Command:
sh
Copy code
bq extract --destination_format CSV dataset.table gs://bucket/path/to/exported_data.csv
Description: This command exports data from a specified BigQuery table to a CSV file in Google Cloud Storage.
Using Python Client Library:

Code:
python
Copy code
from google.cloud import bigquery

client = bigquery.Client()
table_id = "your-project.your_dataset.your_table"
destination_uri = "gs://your-bucket/path/to/exported_data.csv"

extract_job = client.extract_table(
    table_id,
    destination_uri,
    location="US",
)

extract_job.result()  # Wait for the job to complete.

print("Exported {} to {}".format(table_id, destination_uri))
Description: This code snippet uses the BigQuery Python client library to export data from a BigQuery table to a CSV file in Google Cloud Storage.
These methods provide flexibility for importing and exporting data with BigQuery, whether you're working with the web UI, command-line tool, or client libraries.

ChatGPT
Sure, here are the details on how to import and export data using BigQuery:

Importing Data into BigQuery
Method 1: Using the BigQuery Web UI
Go to BigQuery in the Google Cloud Console:

Navigate to BigQuery Web UI.
Select the Dataset:

In the Explorer panel, select the project and dataset where you want to create the new table.
Create a Table:

Click on the Create Table button.
In the Create Table page, specify the source of the data:
Source: Choose Google Cloud Storage, Upload, Google Drive, or another source.
Select file: Choose or drag the file to upload.
File format: Select the format of your data file (e.g., CSV, JSON, Avro).
Configure Table Details:

Table Name: Provide a name for the new table.
Schema: Define the schema manually, or use the auto-detect feature if the source file supports it.
Create Table:

Click the Create Table button to load the data into BigQuery.
Method 2: Using the bq Command-Line Tool
sh
Copy code
bq load --source_format=CSV dataset.table gs://bucket/path/to/data.csv schema.json
Description: Loads data from a CSV file stored in Google Cloud Storage into a specified BigQuery table. The schema of the table is defined in schema.json.

Example Schema File (schema.json):

json
Copy code
[
  {"name": "name", "type": "STRING", "mode": "NULLABLE"},
  {"name": "age", "type": "INTEGER", "mode": "NULLABLE"},
  {"name": "email", "type": "STRING", "mode": "NULLABLE"}
]
Method 3: Using the BigQuery Python Client Library
python
Copy code
from google.cloud import bigquery

client = bigquery.Client()
table_id = "your-project.your_dataset.your_table"

job_config = bigquery.LoadJobConfig(
    source_format=bigquery.SourceFormat.CSV, skip_leading_rows=1, autodetect=True,
)

uri = "gs://your-bucket/path/to/your/file.csv"

load_job = client.load_table_from_uri(
    uri, table_id, job_config=job_config
)

load_job.result()  # Wait for the job to complete.

destination_table = client.get_table(table_id)
print("Loaded {} rows.".format(destination_table.num_rows))
Description: Loads a CSV file from Google Cloud Storage into BigQuery using the BigQuery Python client library.
Exporting Data from BigQuery
Method 1: Using the BigQuery Web UI
Run a Query:

Run a query to select the data you want to export.
Save Results:

Click on the Save Results button.
Choose the destination, such as Google Sheets, CSV file, JSON, etc.
Configure Export:

Follow the prompts to configure and start the export process.
Method 2: Using the bq Command-Line Tool
sh
Copy code
bq extract --destination_format CSV dataset.table gs://bucket/path/to/exported_data.csv
Description: Exports data from a specified BigQuery table to a CSV file in Google Cloud Storage.
Method 3: Using the BigQuery Python Client Library
python
Copy code
from google.cloud import bigquery

client = bigquery.Client()
table_id = "your-project.your_dataset.your_table"
destination_uri = "gs://your-bucket/path/to/exported_data.csv"

extract_job = client.extract_table(
    table_id,
    destination_uri,
    location="US",
)

extract_job.result()  # Wait for the job to complete.

print("Exported {} to {}".format(table_id, destination_uri))
Description: Exports data from a BigQuery table to a CSV file in Google Cloud Storage using the BigQuery Python client library.
These methods provide comprehensive ways to import and export data with BigQuery, utilizing the web interface, command-line tools, and client libraries.
