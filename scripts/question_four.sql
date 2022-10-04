SELECT DISTINCT position_category, SUM(po) OVER(PARTITION BY position_category) AS putouts
FROM fielding
INNER JOIN
	(SELECT playerid, yearid, CASE
	WHEN pos = 'OF' THEN 'Outfield'
	WHEN pos IN ('SS', '1B', '2B', '3B') THEN 'Infield'
	WHEN pos IN ('P', 'C') THEN 'Battery' END AS position_category
	FROM fielding) AS position_categories
USING(playerid, yearid)
WHERE yearid = 2016;