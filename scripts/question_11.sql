--Is there any correlation between number of wins and team salary? 
--Use data from 2000 and later to answer this question. 
--As you do this analysis, keep in mind that salaries across the whole league tend to increase together, 
--so you may want to look on a year-by-year basis.

SELECT *
FROM teams
INNER JOIN
(SELECT DISTINCT teamid, yearid, SUM(salary) OVER(PARTITION BY teamid, yearid) AS team_salary
FROM salaries
WHERE yearid >= 2000
ORDER BY yearid, teamid) as t
USING(teamid, yearid);