--Loading data from company_dim.csv to the company_dim table
COPY company_dim
FROM 'C:\projects\sql_project_jobs_data_analysis\csv_files\company_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
--Loading data from skills_dim.csv to the skills_dim table
COPY skills_dim
FROM 'C:\projects\sql_project_jobs_data_analysis\csv_files\skills_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
--Loading data from job_postings_fact.csv to the job_postings_fact table
COPY job_postings_fact
FROM 'C:\projects\sql_project_jobs_data_analysis\csv_files\job_postings_fact.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
--Loading data from skills_job_dim.csv to the skills_job_dim table
COPY skills_job_dim
FROM 'C:\projects\sql_project_jobs_data_analysis\csv_files\skills_job_dim.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

--Testing whether data is loaded into each of the tables
--company_dim
SELECT *
FROM company_dim
LIMIT 10;
--skills_dim
SELECT *
FROM skills_dim
LIMIT 10;
--job_postings_fact
SELECT *
FROM job_postings_fact
LIMIT 10;
--skills_job_dim
SELECT *
FROM skills_job_dim
LIMIT 10;
--all data imported successfully