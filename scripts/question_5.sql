/*
	5. Find the average number of strikeouts per game by decade since 1920. 
	   Round the numbers you report to 2 decimal places. 
	   Do the same for home runs per game. Do you see any trends?
*/

-- average num strikeouts per game since 1920 --


SELECT 10*(yearid / 10) as decade,
	   ROUND(SUM(so::numeric) / SUM(ghome),2) AS avg_so_per_game,
	   ROUND(SUM(hr::numeric) / SUM(ghome),2) AS avg_hr_per_game
	   
FROM teams
WHERE yearid >= 1920 
GROUP BY decade
ORDER BY decade DESC;





