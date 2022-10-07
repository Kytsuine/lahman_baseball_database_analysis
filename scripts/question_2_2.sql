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
SELECT DISTINCT G_ALL as games_played, 
	   teamID, 
	   t.name, 
	   a.yearID
FROM appearances AS a
INNER JOIN teams AS t
USING(teamID)
WHERE playerid = 'gaedeed01'
GROUP BY a.teamID, t.name, a.yearID, g_all;