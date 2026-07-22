==========================================================
1 BASIC EXPLORATION
==========================================================

-- 1. View all records
SELECT * FROM ai_tools;

-- 2. Count total records
SELECT COUNT(*) AS Total_Records
FROM ai_tools;

-- 3. Display unique AI categories
SELECT DISTINCT category
FROM ai_tools
ORDER BY category;

-- 4. Display unique companies
SELECT DISTINCT company
FROM ai_tools
ORDER BY company;

-- 5. Display AI tools launched after 2020
SELECT tool_name, company, launch_year
FROM ai_tools
WHERE launch_year > 2020
ORDER BY launch_year;


==========================================================
2 KPI QUERIES
==========================================================

-- 1. Total AI Tools
SELECT COUNT(*) AS Total_AI_Tools
FROM ai_tools;

-- 2. Total Categories
SELECT COUNT(DISTINCT category) AS Total_Categories
FROM ai_tools;

-- 3. Total Companies
SELECT COUNT(DISTINCT company) AS Total_Companies
FROM ai_tools;

-- 4. Average Users
SELECT ROUND(AVG(users_millions),2) AS Average_Users
FROM ai_tools;

-- 5. Maximum Users
SELECT MAX(users_millions) AS Highest_User_Base
FROM ai_tools;

-- 6. Minimum Users
SELECT MIN(users_millions) AS Lowest_User_Base
FROM ai_tools;

-- 7. Total Open Source Tools
SELECT COUNT(*) AS Open_Source_Tools
FROM ai_tools
WHERE open_source='Yes';

-- 8. Total Proprietary Tools
SELECT COUNT(*) AS Proprietary_Tools
FROM ai_tools
WHERE open_source='No';

-- 9. Total Free Tools
SELECT COUNT(*) AS Free_Tools
FROM ai_tools
WHERE pricing_model='Free';

-- 10. Total Paid Tools
SELECT COUNT(*) AS Paid_Tools
FROM ai_tools
WHERE pricing_model='Paid';


==========================================================
3 BUSINESS INSIGHT QUERIES
==========================================================

-- 1. Category-wise AI Tools
SELECT category,
COUNT(*) AS Total_Tools
FROM ai_tools
GROUP BY category
ORDER BY Total_Tools DESC;

-- 2. Company-wise AI Tools
SELECT company,
COUNT(*) AS Total_Tools
FROM ai_tools
GROUP BY company
ORDER BY Total_Tools DESC;

-- 3. Pricing Model Distribution
SELECT pricing_model,
COUNT(*) AS Total_Tools
FROM ai_tools
GROUP BY pricing_model;

-- 4. AI Tools launched every year
SELECT launch_year,
COUNT(*) AS Total_Tools
FROM ai_tools
GROUP BY launch_year
ORDER BY launch_year;

-- 5. Average Users by Category
SELECT category,
ROUND(AVG(users_millions),2) AS Avg_Users
FROM ai_tools
GROUP BY category
ORDER BY Avg_Users DESC;

-- 6. Top 10 AI Tools by Users
SELECT tool_name,
company,
users_millions
FROM ai_tools
ORDER BY users_millions DESC
LIMIT 10;

-- 7. Companies with more than one AI Tool
SELECT company,
COUNT(*) AS Total_Tools
FROM ai_tools
GROUP BY company
HAVING COUNT(*) > 1
ORDER BY Total_Tools DESC;

-- 8. Open Source vs Proprietary
SELECT open_source,
COUNT(*) AS Total
FROM ai_tools
GROUP BY open_source;

-- 9. Users by Pricing Model
SELECT pricing_model,
ROUND(AVG(users_millions),2) AS Average_Users
FROM ai_tools
GROUP BY pricing_model;

-- 10. Category having Highest Users
SELECT category,
SUM(users_millions) AS Total_Users
FROM ai_tools
GROUP BY category
ORDER BY Total_Users DESC;


==========================================================
4 ADVANCED SQL
==========================================================

-- 1. CASE Statement
SELECT tool_name,
users_millions,
CASE
WHEN users_millions >= 100 THEN 'Highly Popular'
WHEN users_millions >= 50 THEN 'Popular'
ELSE 'Emerging'
END AS Popularity
FROM ai_tools;

-- 2. ROW_NUMBER()
SELECT tool_name,
users_millions,
ROW_NUMBER() OVER(ORDER BY users_millions DESC) AS Ranking
FROM ai_tools;

-- 3. RANK()
SELECT tool_name,
users_millions,
RANK() OVER(ORDER BY users_millions DESC) AS Tool_Rank
FROM ai_tools;

-- 4. DENSE_RANK()
SELECT tool_name,
users_millions,
DENSE_RANK() OVER(ORDER BY users_millions DESC) AS Dense_Rank
FROM ai_tools;

-- 5. Common Table Expression (CTE)
WITH CategoryUsers AS
(
SELECT category,
AVG(users_millions) AS AvgUsers
FROM ai_tools
GROUP BY category
)
SELECT *
FROM CategoryUsers
ORDER BY AvgUsers DESC;

-- 6. Subquery
SELECT tool_name,
users_millions
FROM ai_tools
WHERE users_millions >
(
SELECT AVG(users_millions)
FROM ai_tools
);

-- 7. Create View
CREATE VIEW AI_Category_Summary AS
SELECT category,
COUNT(*) AS Total_Tools
FROM ai_tools
GROUP BY category;

-- 8. Display View
SELECT *
FROM AI_Category_Summary;

-- 9. Top 5 Companies by Users
SELECT company,
SUM(users_millions) AS Total_Users
FROM ai_tools
GROUP BY company
ORDER BY Total_Users DESC
LIMIT 5;

-- 10. Running Total using Window Function
SELECT tool_name,
users_millions,
SUM(users_millions)
OVER(ORDER BY users_millions DESC) AS Running_Total
FROM ai_tools;