--Do teams that win the world series see a boost in attendance the following year? 
--What about teams that made the playoffs? 
--Making the playoffs means either being a division winner or a wild card winner.
SELECT ROUND(AVG(next_year_attendance_diff), 0) AS avg_diff, ROUND(AVG(next_year_diff_per_game), 0) AS avg_diff_per_game
FROM
	(SELECT b.yearid, a.teamid, a.g, (a.attendance - b.attendance) AS next_year_attendance_diff, (a.attendance - b.attendance)/a.g AS next_year_diff_per_game
	FROM teams AS a 
	INNER JOIN teams AS b
	ON a.teamid = b.teamid 
		AND a.yearid = b.yearid + 1
	WHERE b.attendance IS NOT NULL 
		AND a.attendance IS NOT NULL
		AND b.wswin = 'Y'
	GROUP BY b.yearid, a.teamid, a.attendance, b.attendance, a.g
	ORDER BY yearid, teamid) 
AS WS_attendance_diffs;
 --Yes, but it's barely noticeable.