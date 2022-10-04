/*
	1. What range of years for baseball games played does the provided database cover? 
		- Database year range is from: 1871 to 2016
*/

-- find year range --
SELECT MIN(year) as min_year, 
	   MAX(year) as max_year
FROM homegames;

/*
	2. Find the name and height of the shortest player in the database. 
		- Eddie Gaedel is shortest player in DB at 43cm?
		
	   How many games did he play in? 
	    - 52? or 1?
		
	   What is the name of the team for which he played?
	    - St. Louis Browns
*/

-- find shortest player --
SELECT namefirst, 
	   namelast, 
	   MIN(height) AS short_player, playerid
FROM people
GROUP BY namefirst, namelast, height, playerid
ORDER BY height;

-- how many games Eddie played in AND what team name --
SELECT COUNT(G_all), 
	   teamID, 
	   t.name, 
	   a.yearID
FROM appearances AS a
INNER JOIN teams AS t
USING(teamID)
WHERE playerid = 'gaedeed01'
GROUP BY a.teamID, t.name, a.yearID;

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


