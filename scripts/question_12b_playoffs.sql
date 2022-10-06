--Do teams that win the world series see a boost in attendance the following year? 
--What about teams that made the playoffs? 
--Making the playoffs means either being a division winner or a wild card winner.
SELECT ROUND(AVG(next_year_attendance_diff), 0) AS avg_diff, ROUND(AVG(next_year_diff_per_game), 0) AS avg_diff_per_game
FROM
	(SELECT b.yearid, a.teamid, b.wcwin, b.divwin, (a.attendance - b.attendance) AS next_year_attendance_diff, (a.attendance - b.attendance)/a.ghome AS next_year_diff_per_game
	FROM teams AS a 
	INNER JOIN teams AS b
	ON a.teamid = b.teamid 
		AND a.yearid = b.yearid + 1
	WHERE b.attendance IS NOT NULL 
		AND a.attendance IS NOT NULL
		AND b.wcwin = 'Y' OR b.divwin = 'Y'
	ORDER BY yearid, teamid) 
AS WS_attendance_diffs;
 --Yes, though not as much as you'd think.