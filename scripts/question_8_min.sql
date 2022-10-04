SELECT team, park, attendance/games AS avg_attendance
FROM homegames
WHERE year = 2016
AND games >= 10
ORDER BY avg_attendance ASC
LIMIT 5;