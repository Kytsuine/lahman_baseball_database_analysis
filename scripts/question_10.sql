/*
	10. Find all players who hit their career highest number of home runs in 2016. 
		Consider only players who have played in the league for at least 10 years, and who hit at least one home run in 2016. 
		Report the players' first and last names and the number of home runs they hit in 2016.
*/


------ GeT HiGh ------------------

WITH hr_high AS 
	(SELECT 
	   playerid,
	   yearid,
	   HR,
	   MAX(HR)  OVER(PARTITION BY playerid) as max_hr
	 FROM batting
	 ORDER BY max_hr DESC
	 )
	 
---------- Make Table ----------
	 		
SELECT playerid,
	   namefirst,
	   namelast,
	   HR
FROM hr_high
JOIN people
USING(playerid)
	WHERE playerid IN( 

-------- GeT CaReEr LeNgTh -------	
		
		WITH len_of_career AS 
			(SELECT COUNT(DISTINCT yearid) AS num_seasons,
	 	 			namelast,
	 				namefirst,
		 			playerid
	 	 		FROM batting
		 		INNER JOIN people
		 		USING(playerid)
		 		GROUP BY playerid, namelast, namefirst
		 		ORDER BY num_seasons DESC
	          )
------ Career length 10 or more ----		
		SELECT playerid
		FROM len_of_career
		WHERE num_seasons >= 10
	                  )
					  
-------  -Finish Table   ------------	
	
	AND yearid = 2016
	AND HR >= 1
	AND HR = max_hr
ORDER BY HR DESC;
		 
	 










----------IM-TRASH-------------
/*

WITH player_hr_by_year AS 
(SELECT p.namelast,
	   p.namefirst,
	   yearid,
	   SUM(b.HR) AS total_hr
FROM people AS p
INNER JOIN batting AS b
	USING(playerid)
WHERE yearid = 2016
GROUP BY yearid, p.namelast,
	   p.namefirst)
	   
*/
-----------------------------




