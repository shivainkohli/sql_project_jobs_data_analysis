# Introduction
This project analyzes the job market in 2023 using SQL. It focuses on identifying top-paying jobs, the most in-demand skills, and the relationship between skills and salaries.
The data is stored in a relational database and queried using SQL scripts.  
Check out the queries here: [project_sql folder](/project_sql/)  
You can access the data csv files here: [CSV Files (Drive)](https://drive.google.com/drive/folders/19vLTV8KSPV8gUuDjy_6WSybVzd2SLkwV?usp=sharing)
# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was created from a ddesire to pinpoint top-paid and in-demand skills, streamlining the process for others to find optimal jobs

## The questions I wanted to answer through this project were:
1. What are the top-paying data analyst jobs?

2. What skills are required for these top-paying jobs?

3. What skills are in most demand for data analysts?

4. Which skills are associated with higher salaries?

5. What are the most optimal skills to learn for getting these top-paying data analyst roles?

# Tools I Used
For this deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and discover critical insights.

- **PostgreSQL:** The chosen database management system for handling the job posting data.

- **Visual Studio Code:** My chosen IDE for database management and executing SQL queries.

- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and collaboration and project-tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here's how I apprached each question:

### 1. Top-paying data analyst jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlighted the high-paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    name AS company_name,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 15;
```
Breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles range from $184,000 to $650,000 indicating good growth potential for a career in this field.
- **Diverse Employers:** There are a lot of companies that offer these jobs across this salary range.
- **Job Title Variety:** A lot of diversity in job titles, from Data Analyst to Director of Analytics showing the various specializations in this fields.

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
WITH top_paying_jobs AS(
    SELECT
        job_id,
        job_title,
        name AS company_name,
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 15
)
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```
Breakdown of the most demanded skills for Data Analysts in 2023, based on the job postings:
- SQL leads the count with 8 jobs.
- Python comes second with 7 jobs.
- Tableau has a count of 6 jobs.
- Other skills like R, Snowflake, Pandas, and Excel show varying degrees of demand.

### 3. In-Demand Skills for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.
```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```
Breakdown of the most in-demand skills for data analysts in 2023:
- **SQL** and **Excel** are the most important fundamental skills to build a foundation on for data processing and spreadsheet manipulation.
- **Programming** and **Visulaization Tools** like **Python**, **Tableau**, and **Power BI** are essential pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 7291         |
| Excel    | 4611         |
| Python   | 4330         |
| Tableau  | 3745         |
| Power Bi | 2609         |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```
Breakdown of the results for top paying skills is
1. **High Demand for Big Data & ML Skills:** 
    - Top skills are commanded by analysts in Big Data Tech(**PySpark**, **Couchbase**)
    - ML Tools(**DataRobot**, **Jupyter**), and Python libraries(**Pandas**,**NumPy**)
2. **Software Development and Deployment proficiency:**  
    Knowledge in development and deployment tools(**GitLab**, **Kubernetes**, **Airflow**)
    indicates a crossover between data analysis and engineering, with skills
    facilitating automation and efficient data pipeline management.
3. **Cloud computing expertise:**  
    Fimiliarity with cloud and data engineering tools(**Elastisearch**, **Databricks**, **GCP**) shows growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.

| Skills        | Average Salary($)|
|---------------|------------------|
| pyspark       |208,172           |
| bitbucket     |189,155           |
| couchbase     |160,515           |
| watson	    |160,515           |
| datarobot  	|155,486           |
| gitlab    	|154,500           |
| swift      	|153,750           |
| jupyter	    |152,777           |
| pandas	    |151,821           |
| elasticsearch	|145,000           |

*Table of the average salary for the top 10 paying skills for data analysts*

### 5. Most Optimal Skills to Learn
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.
```sql
WITH skills_demand AS(
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
), average_salary AS(
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_job_dim.skill_id
)
SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM 
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25
```
| Skill ID | Skills	    |Demand Count |	Average Salary ($)|
|----------|------------|-------------|-------------------|
| 8	       | go	        | 27	      | 115,320           |
| 234	   | confluence	| 11	      | 114,210           |
| 97	   | hadoop	    | 22	      | 113,193           |
| 80	   | snowflake	| 37	      | 112,948           |
| 74	   | azure	    | 34	      | 111,225           |
| 77	   | bigquery	| 13	      | 109,654           |
| 76	   | aws	    | 32	      | 108,317           |
| 4	       | java	    | 17	      | 106,906           |
| 194	   | ssis	    | 12	      | 106,683           |
| 233	   | jira	    | 20	      | 104,918           |

*Table of the most optimal skills for data analyst sorted by salary*

Breakdown for the most optimal skills for Data Analysts in 2023:
1. **High demand programming languages:**  
**Python** and **R** are at the top with counts of 236 and 148 respectively. Despite their demand, their average salaries are around $101,397 for Python and $100,499 for R showing the importance of having these skills in this field.
2. **Cloud Tools and Technologies:**  
Skills in specialized technologies like **Snowflake**, **Azure**, **AWS**, and **BigQuery** show significant demand with relatively high salaries showing the growing importance of having knowledge of cloud platforms and big data technologies.
3. **Business Intelligence and Visualization Tools:**  
**Tableau** and **Looker** have the highest counts of 230 and 49 respectively, having average salaries of around $99,288 and $103,795 highlighting the role of data visualization and business intelligence tools.


# What I Learned
Through this project, I gained valuable insights into:

- The relationship between job titles and salaries.

- The importance of specific skills in securing high-paying jobs.

- How SQL can be used to analyze job market trends and provide data-driven insights.


# Conclusions
The analysis revealed crucial trends in the job market for 2023:

- Certain skills significantly impact salary levels.

- The highest-paying jobs tend to require a combination of specialized skills.

- Data analysis using SQL can provide meaningful insights for job seekers and employers alike.

This project demonstrates the power of SQL in real-world data analysis and provides a foundation for further exploration of job market trends.