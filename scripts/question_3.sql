
--3. Find all players in the database who played at Vanderbilt University. Create a list showing each player’s 
--   first and last names as well as the total salary they earned in the major leagues. Sort this list in 
--   descending order by the total salary earned. Which Vanderbilt player earned the most money in the majors?

--Players who played at Vanderbilt University
SELECT p.playerid, p.namefirst, p.namelast, min(cp.yearid), max(cp.yearid)
FROM people AS p INNER JOIN collegeplaying AS cp USING (playerid)
WHERE cp.schoolid = 'vandy'
GROUP BY p.playerid, p.namefirst, p.namelast;
--returns 24 players

select * from salaries
where playerid in ('alvarpe01','baxtemi01');

select distinct lgid from salaries;

--schoolid = 'vandy', schoolname = 'Vanderbilt University'
SELECT p.namefirst, p.namelast, cp.yearid, s.salary
FROM collegeplaying AS cp INNER JOIN people AS p USING (playerid)
                          INNER JOIN salaries AS s ON p.playerid = s.playerid AND cp.yearid = s.yearid
WHERE schoolid = 'vandy';
--returns no records

SELECT p.namefirst, p.namelast, cp.yearid, s.salary
FROM people AS p INNER JOIN collegeplaying AS cp USING (playerid)
                  INNER JOIN salaries AS s ON p.playerid = s.playerid AND cp.yearid = s.yearid
;
--returns 4 records
--WHERE schoolid = 'vandy';

SELECT MIN(YEARID), MAX(YEARID) FROM SALARIES;
--COLLEGE PLAYING 1864 TO 2014
--SALARIES 1985 TO 2016

SELECT p.namefirst, p.namelast, s.yearid, s.salary
FROM people AS p INNER JOIN salaries AS s ON p.playerid = s.playerid
LIMIT 20;

select * 
from salaries as s INNER JOIN collegeplaying as cp using(yearid);
