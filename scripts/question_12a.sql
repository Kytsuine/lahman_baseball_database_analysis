--Does there appear to be any correlation between attendance at home games and number of wins?

SELECT CORR(attendance, w) AS hg_attend_corr
FROM teams;

--Yes, but not as strong as the correlation with salary.