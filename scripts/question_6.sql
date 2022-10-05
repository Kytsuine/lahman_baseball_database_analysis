--6. Find the player who had the most success stealing bases in 2016, where __success__ is measured as the 
--   percentage of stolen base attempts which are successful. (A stolen base attempt results either in a 
--   stolen base or being caught stealing.) Consider only players who attempted _at least_ 20 stolen bases.
	
--Stolen Bases = batting.SB 
--Caught Stealing = batting.CS
--Stolen Base Attempts = SB + CS

SELECT playerid,
       namefirst, 
	   namelast,
	   ROUND(100 * SUM(COALESCE(SB,0))::numeric / SUM(COALESCE(SB,0) + COALESCE(CS,0))::numeric
			 ,2) AS stolen_base_success
FROM batting INNER JOIN people USING (playerid)
WHERE yearid = 2016
      AND COALESCE(SB,0) + COALESCE(CS,0) > 0 
GROUP BY playerid, namefirst, namelast
HAVING SUM(SB) >= 20
ORDER BY stolen_base_success DESC
LIMIT 1;

--Chris Owings has the highest percentage of stolen base attempts that are successful: %91.30
