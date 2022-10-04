--6. Find the player who had the most success stealing bases in 2016, where __success__ is measured as the 
--   percentage of stolen base attempts which are successful. (A stolen base attempt results either in a 
--   stolen base or being caught stealing.) Consider only players who attempted _at least_ 20 stolen bases.
	
--Stolen Bases = batting.SB 
--Caught Stealing = batting.CS
--Stolen Base Attempts = SB + CS

SELECT playerid,
       namefirst, 
	   namelast,
       SUM(SB) AS stolen_bases,
	   SUM(CS) AS caught_stealing,
	   ROUND(SUM(COALESCE(SB,0))::numeric / SUM(COALESCE(SB,0) + COALESCE(CS,0))::numeric
			 ,2) AS stolen_base_attempt_success
FROM batting INNER JOIN people USING (playerid)
WHERE yearid = 2016
      AND COALESCE(SB,0) + COALESCE(CS,0) > 0 
GROUP BY playerid, namefirst, namelast
HAVING SUM(SB) >= 20
ORDER BY stolen_base_attempt_success DESC;

SELECT playerid,
	   sb,
	   cs,
	   SB+CS
from batting
where sb is null
      and cs is not null;

select count(*) from batting where SB is null and cs is not null;
--79360 records   SB is not null    CS is not null  Included
--1300 records    SB is null        CS is null      Not included
--0 records       SB is null        CS is not null  --none--
--22156 records   SB is null        CS is not null  ???
