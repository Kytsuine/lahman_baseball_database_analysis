--13. It is thought that since left-handed pitchers are more rare, causing batters to face 
--    them less often, that they are more effective. Investigate this claim and present 
--    evidence to either support or dispute this claim. 

--First, determine just how rare left-handed pitchers are compared with right-handed pitchers. 

SELECT throws, 
       COUNT(playerid) AS num_pitchers,
	   SUM(COUNT(playerid)) OVER() AS total_pitchers,
	   CONCAT(ROUND(100 * COUNT(playerid) / SUM(COUNT(playerid)) OVER()
			       ,2)::text
			  ,'%') AS perc_of_pitchers
FROM people
WHERE throws IN ('R','L')
      AND EXISTS (SELECT * FROM pitching WHERE pitching.playerid = people.playerid)
GROUP BY throws;

--27.27% of pitchers are left-handed.
--In contrast, roughly 11% of the general population is left-handed.

--Pitchers are over twice as likely to be left-handed compared to the general population.
--Despite this, a clear majority of pitchers are right-handed.


-----------------------------------------------------------------
--Are left-handed pitchers more likely to win the Cy Young Award? 


--This analysis only considers players who have been a pitcher in any year since 1956,
--which is when the first Cy Young Award was given.

WITH cy_young_winners AS (SELECT distinct playerid
						  FROM awardsplayers
						  WHERE awardid = 'Cy Young Award')
SELECT throws, cy_young_winner, SUM(num_pitchers) 
FROM
	(SELECT throws, 
		   'Y' AS cy_young_winner,
		   COUNT(DISTINCT playerid) AS num_pitchers
		FROM people INNER JOIN pitching USING (playerid)
		WHERE throws IN ('R','L')
			  AND pitching.yearid >= 1956
			  AND playerid IN (SELECT * FROM cy_young_winners)
		GROUP BY throws
	UNION
	SELECT throws, 
		   'N' AS cy_young_winner, 
		   COUNT(DISTINCT playerid) AS num_pitchers
		FROM people INNER JOIN pitching USING (playerid)
		WHERE throws IN ('R','L')
			  AND pitching.yearid >= 1956
			  AND playerid NOT IN (SELECT * FROM cy_young_winners)
		GROUP BY throws
	) AS thisquery
GROUP BY CUBE(throws,cy_young_winner);

--(24/77) = 31.17% of Cy Young Award winners are left-handed.
--(1593/5597) = 28.46% of all pitchers (since 1956) are left-handed. 

--(24/1593) = 1.51% of left-handed pitchers have won the Cy Young Award. 
--(53/4004) = 1.32% of right-handed pitchers have won the Cy Young Award. 

--Left-handed pitchers are slightly more likely to win the Cy Young Award
--than right-handed pitchers.

--------------------------------------------------------
--Are they more likely to make it into the hall of fame?


--This analysis only considers players who have been a pitcher in any year since 1936,
--which is the first year players were inducted into the Baseball Hall of Fame.

WITH hall_of_fame_players AS (SELECT distinct playerid
						      FROM halloffame
						      WHERE category = 'Player'
							        AND inducted = 'Y')
SELECT throws, in_hall_of_fame, SUM(num_pitchers) 
FROM
	(SELECT throws, 
		   'Y' AS in_hall_of_fame,
		   COUNT(DISTINCT playerid) AS num_pitchers
		FROM people INNER JOIN pitching USING (playerid)
		WHERE throws IN ('R','L')
			  AND pitching.yearid >= 1936
			  AND playerid IN (SELECT * FROM hall_of_fame_players)
		GROUP BY throws
	UNION
	SELECT throws, 
		   'N' AS in_hall_of_fame, 
		   COUNT(DISTINCT playerid) AS num_pitchers
		FROM people INNER JOIN pitching USING (playerid)
		WHERE throws IN ('R','L')
			  AND pitching.yearid >= 1936
			  AND playerid NOT IN (SELECT * FROM hall_of_fame_players)
		GROUP BY throws
	) AS thisquery
GROUP BY CUBE(throws,in_hall_of_fame);

--(11/45) = 24.44% of pitchers inducted into the Hall of Fame are left-handed.
--(1850/6617) = 27.96% of all pitchers (since 1936) are left-handed.

--(11/1850) = 0.59% of left-handed pitchers have been inducted into the Hall of Fame.
--(34/4767) = 0.71% of right-handed pitchers have been inducted into the Hall of Fame.

--Left-handed pitchers are slightly less likely to be inducted into the Hall of Fame
--than right-handed pitchers.

---------------------
--Overall Conclusions
--Left-handed pitchers are more rare than right-handed pitchers, but the percentage 
--of pitchers who are left-handed is much higher than in the general population. 
--Based on analyzing Cy Young award winners and Hall of Fame
--inductees, it is not clear that left-handed pitchers are more effective than right-handed
--pitchers; the results are mixed.
