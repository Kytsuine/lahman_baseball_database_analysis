--7. From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? 
--What is the smallest number of wins for a team that did win the world series? 
--Doing this will probably result in an unusually small number of wins for a world series champion – 
--determine why this is the case. Then redo your query, excluding the problem year. 
--How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? 
--What percentage of the time?

SELECT 	--Outer query, analyzes when world series is won by max win teams.
	SUM	( --Counts WS wins in top win teams
	CASE --Case converts Y to 1 and others to 0.
		WHEN m.wswin = 'Y' THEN 1 
		ELSE 0 END
		) AS most_wins_won, 
	CONCAT	( --Add a % sign to percentage
		ROUND(	(	( --Cut it down to three sig figs
			SUM	( --Same function as lines 9-13
			CASE 
				WHEN m.wswin = 'Y' THEN 1 
				ELSE 0 END
				)
					)::numeric --Converts to numeric because ints don't decimalize
				)/(COUNT(m.yearid)::numeric --Number of years of baseball from 1970 to 2016
				  )*100, 1 --Convert to percent, finish ROUND function
			 ), '%' --Finish concat function
			) AS most_wins_won_pct
FROM	(
	SELECT	--Middle query, serves only to intermediary between innermost and outermost. Trimmed down to only max wins teams by a double-conditioned inner join.
		t.yearid, 
		w, 
		wswin
FROM 
	teams AS t
INNER JOIN
	(SELECT DISTINCT --Innermost query, gives max wins by year
	 	yearid, 
	 	MAX(w) AS max_w
FROM 
	teams
WHERE 
	yearid BETWEEN 1970 AND 2016 --Years in selected range
GROUP BY 
	yearid
ORDER BY 
	yearid ASC --Orders it so if you need to check this subquery it makes more sense to humans. Remove for optimization.
	) AS max_wins --Adds innermost query, giving max wins for each year.
ON 
	t.yearid = max_wins.yearid --Same year
AND 
	t.w = max_wins.max_w --Checking that winning team's wins equals the year's max wins
		) AS m; --Adds middle query to outermost query with alias m (no meaning).