/*
	1. What range of years for baseball games played does the provided database cover? 
		- Database year range is from: 1871 to 2016
*/

-- find year range --
SELECT MIN(year) as min_year, 
	   MAX(year) as max_year
FROM homegames;