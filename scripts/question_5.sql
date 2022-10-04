/*
	5. Find the average number of strikeouts per game by decade since 1920. 
	   Round the numbers you report to 2 decimal places. 
	   Do the same for home runs per game. Do you see any trends?
*/

-- average num strikeouts per game since 1920 --
SELECT DISTINCT yearid, ROUND(AVG(p.SO) OVER(PARTITION BY yearid),2) AS avg_so
FROM pitching AS p
INNER JOIN appearances as a
USING(yearid)
GROUP BY yearid, p.so