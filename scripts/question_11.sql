--Is there any correlation between number of wins and team salary? 
--Use data from 2000 and later to answer this question. 
--As you do this analysis, keep in mind that salaries across the whole league tend to increase together, 
--so you may want to look on a year-by-year basis.

SELECT DISTINCT yearid, corr(team_salary, w) OVER(PARTITION BY yearid) AS correlation --Correlation by year
FROM 													--NB: corr returns correlation coefficient
	(SELECT yearid, teamid, team_salary, w --Return salary by year, by team
	FROM teams
	INNER JOIN
		(SELECT DISTINCT teamid, yearid, SUM(salary) OVER(PARTITION BY teamid, yearid) AS team_salary
		FROM salaries --Returns teamwide salaries from salaries table
		WHERE yearid >= 2000 --We only want data from 2000 and later.
		ORDER BY yearid, teamid) as t
	USING(teamid, yearid)) AS salary_wins;

--There is a positive correlation between salary and wins, but not a strong one.