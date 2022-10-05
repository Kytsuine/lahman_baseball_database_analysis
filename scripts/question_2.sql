-- find shortest player --
SELECT namefirst, 
	   namelast, 
	   MIN(height) AS short_player, playerid
FROM people
GROUP BY namefirst, namelast, height, playerid
ORDER BY height
LIMIT 1;

-- how many games Eddie played in AND what team name --
SELECT G_all, 
	   teamID, 
	   t.name, 
	   a.yearID
FROM appearances AS a
INNER JOIN teams AS t
USING(teamID)
WHERE playerid = 'gaedeed01'
GROUP BY a.teamID, t.name, a.yearID, a.G_all;