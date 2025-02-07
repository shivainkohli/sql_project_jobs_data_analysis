/* Question
What are the most in demand skills for data analysts?
-Join job postings to inner join table similar to query 2
-Identify top 5 in demand skills for a data analyst
-Focus on all job postings
*/

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

/*
Breakdown of the most in-demand skills for data analysts in 2023:
-SQL and Excel are the most important fundamental skills to build a foundation on for
data processing and spreadsheet manipulation.
-Programming and visulaization tools like Python, Tableau, and Power BI are essential
pointing towards the increasing importance of technical skills in data storytelling
and decision support.

Results:
[
  {
    "skills": "sql",
    "demand_count": "7291"
  },
  {
    "skills": "excel",
    "demand_count": "4611"
  },
  {
    "skills": "python",
    "demand_count": "4330"
  },
  {
    "skills": "tableau",
    "demand_count": "3745"
  },
  {
    "skills": "power bi",
    "demand_count": "2609"
  }
]
*/