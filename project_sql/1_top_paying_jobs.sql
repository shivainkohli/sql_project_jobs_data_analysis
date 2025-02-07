/* Question
What are the top-paying data anaylst jobs?
-Identify the top 15 highest-paying Data Analyst roles that are available remotely.
-Focused on jobs with specified salaries (remove nulls).
-Why? Highlight the top-paying opprtunities for Data Analysts. 
*/
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

/*
Breakdown of the top data analyst jobs in 2023:
-Wide Salary Range: Top 10 paying data analyst roles range from $184,000 to $650,000
indicating good growth potential for a career in this field.
-Diverse Employers: There are a lot of companies that offer these jobs across this
salary range.
Job Title Variety: A lot of diversity in job titles, from Data Analyst to Director
of Analytics showing the various specializations in this fields.

Results:
[
  {
    "job_id": 226942,
    "job_title": "Data Analyst",
    "job_location": "Anywhere",
    "company_name": "Mantys",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "650000.0",
    "job_posted_date": "2023-02-20 15:13:33"
  },
  {
    "job_id": 547382,
    "job_title": "Director of Analytics",
    "job_location": "Anywhere",
    "company_name": "Meta",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "336500.0",
    "job_posted_date": "2023-08-23 12:04:42"
  },
  {
    "job_id": 552322,
    "job_title": "Associate Director- Data Insights",
    "job_location": "Anywhere",
    "company_name": "AT&T",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "255829.5",
    "job_posted_date": "2023-06-18 16:03:12"
  },
  {
    "job_id": 99305,
    "job_title": "Data Analyst, Marketing",
    "job_location": "Anywhere",
    "company_name": "Pinterest Job Advertisements",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "232423.0",
    "job_posted_date": "2023-12-05 20:00:40"
  },
  {
    "job_id": 1021647,
    "job_title": "Data Analyst (Hybrid/Remote)",
    "job_location": "Anywhere",
    "company_name": "Uclahealthcareers",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "217000.0",
    "job_posted_date": "2023-01-17 00:17:23"
  },
  {
    "job_id": 168310,
    "job_title": "Principal Data Analyst (Remote)",
    "job_location": "Anywhere",
    "company_name": "SmartAsset",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "205000.0",
    "job_posted_date": "2023-08-09 11:00:01"
  },
  {
    "job_id": 731368,
    "job_title": "Director, Data Analyst - HYBRID",
    "job_location": "Anywhere",
    "company_name": "Inclusively",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "189309.0",
    "job_posted_date": "2023-12-07 15:00:13"
  },
  {
    "job_id": 310660,
    "job_title": "Principal Data Analyst, AV Performance Analysis",
    "job_location": "Anywhere",
    "company_name": "Motional",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "189000.0",
    "job_posted_date": "2023-01-05 00:00:25"
  },
  {
    "job_id": 1749593,
    "job_title": "Principal Data Analyst",
    "job_location": "Anywhere",
    "company_name": "SmartAsset",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "186000.0",
    "job_posted_date": "2023-07-11 16:00:05"
  },
  {
    "job_id": 387860,
    "job_title": "ERM Data Analyst",
    "job_location": "Anywhere",
    "company_name": "Get It Recruit - Information Technology",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "184000.0",
    "job_posted_date": "2023-06-09 08:01:04"
  },
  {
    "job_id": 1781684,
    "job_title": "DTCC Data Analyst",
    "job_location": "Anywhere",
    "company_name": "Robert Half",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "170000.0",
    "job_posted_date": "2023-10-06 00:01:41"
  },
  {
    "job_id": 987523,
    "job_title": "Azure Data Python Consultant - contract to HIRE - Citizen or Perm...",
    "job_location": "Anywhere",
    "company_name": "Kelly Science, Engineering, Technology & Telecom",
    "job_schedule_type": "Contractor",
    "salary_year_avg": "170000.0",
    "job_posted_date": "2023-01-23 22:28:01"
  },
  {
    "job_id": 1352513,
    "job_title": "REMOTE Director of Data Analytics",
    "job_location": "Anywhere",
    "company_name": "A-Line Staffing Solutions",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "170000.0",
    "job_posted_date": "2023-08-09 14:02:45"
  },
  {
    "job_id": 1525451,
    "job_title": "Manager, Data Analyst",
    "job_location": "Anywhere",
    "company_name": "Uber",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "167000.0",
    "job_posted_date": "2023-04-18 07:01:17"
  },
  {
    "job_id": 712473,
    "job_title": "Data Analyst",
    "job_location": "Anywhere",
    "company_name": "Get It Recruit - Information Technology",
    "job_schedule_type": "Full-time",
    "salary_year_avg": "165000.0",
    "job_posted_date": "2023-08-14 16:01:19"
  }
]
*/