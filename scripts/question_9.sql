--9. Which managers have won the TSN Manager of the Year award in both 
--   the National League (NL) and the American League (AL)? Give their 
--   full name and the teams that they were managing when they won the award.


--This analysis only considers TSN Manager of the Year awards given since 1986,
--when the award has been given to one National League manager and one
--American League manager each year.
--Before 1986, the TSN Manager of the Year award was given to only one manager
--in the National League or American League. These awards are recorded in the
--awardsmanager table with lgid = 'ML', and these records are excluded for our
--analysis.

SELECT am.playerid, 
       p.namefirst, 
	   p.namelast, 
	   am.yearid AS award_year, 
	   CASE WHEN am.lgid = 'AL' THEN 'American League' 
	        ELSE 'National League' END AS league,
	   t.name AS team_name
FROM awardsmanagers AS am INNER JOIN people AS p USING (playerid)
                          LEFT JOIN managers AS m USING (yearid,playerid,lgid)
					      LEFT JOIN teams AS t USING (teamid,lgid,yearid)
WHERE am.playerid IN
				(SELECT DISTINCT amal.playerid
					FROM awardsmanagers AS amal
					WHERE amal.awardid = 'TSN Manager of the Year'
					AND amal.lgid ='AL'
				INTERSECT
				SELECT DISTINCT amnl.playerid
					FROM awardsmanagers AS amnl
					WHERE amnl.awardid = 'TSN Manager of the Year'
					AND amnl.lgid ='NL') 
	  AND am.awardid = 'TSN Manager of the Year'
      AND am.lgid IN ('AL','NL')
ORDER BY am.playerid, am.yearid;
