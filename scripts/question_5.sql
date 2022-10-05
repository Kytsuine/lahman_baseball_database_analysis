/*
	5. Find the average number of strikeouts per game by decade since 1920. 
	   Round the numbers you report to 2 decimal places. 
	   Do the same for home runs per game. Do you see any trends?
*/

-- average num strikeouts per game since 1920 --

SELECT 10*(yearid / 10) as decade,
	   ROUND(AVG(p.SO),2) AS avg_so,
	   ROUND(AVG(b.HR),2) AS avg_hr
FROM pitching AS p
INNER JOIN batting as b
	USING(yearid)
WHERE yearid > 1920
GROUP BY decade;
ORDER BY decade