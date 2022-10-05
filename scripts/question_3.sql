--3. Find all players in the database who played at Vanderbilt University. Create a list showing each player’s 
--   first and last names as well as the total salary they earned in the major leagues. Sort this list in 
--   descending order by the total salary earned. 

SELECT p.namefirst, 
	   p.namelast, 
	   SUM(s.salary)::numeric::money AS player_total_salary
FROM people AS p LEFT JOIN salaries AS s USING (playerid)
WHERE p.playerid IN
	(SELECT DISTINCT cp.playerid
	 FROM collegeplaying AS cp
	 WHERE cp.schoolid = 'vandy')
GROUP BY p.playerid, p.namefirst, p.namelast
ORDER BY player_total_salary DESC NULLS LAST;
--Results include all players who played at Vanderbilt Univesity.
--Players in results with NULL for player_total_salary 
--do not have records in salaries table.

--Which Vanderbilt player earned the most money in the majors?
SELECT p.playerid, p.namefirst, 
	   p.namelast, 
	   SUM(s.salary)::numeric::money AS player_total_salary
FROM people AS p LEFT JOIN salaries AS s USING (playerid)
WHERE p.playerid IN
	(SELECT DISTINCT cp.playerid
	 FROM collegeplaying AS cp
	 WHERE cp.schoolid = 'vandy')
GROUP BY p.playerid, p.namefirst, p.namelast
ORDER BY player_total_salary DESC NULLS LAST
LIMIT 1;
--The Vanderbilt player who earned the most money in the major leagues is
--David Price, with a total salary of $81,851,296.

