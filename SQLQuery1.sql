--=============  Part 2  ==============

-- How is our team performing compared to previous season ?

--- 2024

--as Home Team -- IN 2024 -- What are the Total of goals thet are scored by EGYPT ? 
WITH filter_CTE AS (
    SELECT 2024 AS last_year,
	       'Egypt' AS team )

SELECT SUM(home_score) AS total_GE_HOME ,
       COUNT(*) AS Count_ME_HOME ,
	   (SELECT COUNT(*)   FROM results  WHERE home_team = (SELECT team FROM filter_CTE ) AND
                                              YEAR(date)= (SELECT last_year FROM filter_CTE )AND 
								              (home_score < away_score) ) AS NUM_EM_LOSS ,

	  (SELECT COUNT(*)   FROM results  WHERE home_team = (SELECT team FROM filter_CTE ) AND
                                              YEAR(date)= (SELECT last_year FROM filter_CTE )AND 
								              (home_score = away_score) ) AS NUM_EM_DRAW ,

	  (SELECT COUNT(*)   FROM results  WHERE home_team = (SELECT team FROM filter_CTE ) AND
                                              YEAR(date)= (SELECT last_year FROM filter_CTE )AND 
								              (home_score > away_score) ) AS NUM_EM_WIN
FROM results
WHERE home_team = (SELECT team FROM filter_CTE ) AND
      YEAR(date)= (SELECT last_year FROM filter_CTE )




--as away Team -- IN 2024 -- What are the Total of goals thet are scored by EGYPT ?
WITH filter_CTE AS (
    SELECT 2024 AS last_year,
	       'Egypt' AS team )

SELECT SUM(away_score) AS total_GE_AWAY ,
       COUNT(*) AS Count_ME_AWAY ,
	   (SELECT COUNT(*)   FROM results  WHERE away_team = (SELECT team FROM filter_CTE ) AND
                                              YEAR(date)= (SELECT last_year FROM filter_CTE )AND 
								              (home_score > away_score) ) AS NUM_EM_LOSS ,

	  (SELECT COUNT(*)   FROM results  WHERE away_team = (SELECT team FROM filter_CTE ) AND
                                              YEAR(date)= (SELECT last_year FROM filter_CTE )AND 
								              (home_score = away_score) ) AS NUM_EM_DRAW ,

	  (SELECT COUNT(*)   FROM results  WHERE away_team = (SELECT team FROM filter_CTE ) AND
                                              YEAR(date)= (SELECT last_year FROM filter_CTE )AND 
								              (home_score < away_score) ) AS NUM_EM_WIN
FROM results
WHERE away_team = (SELECT team FROM filter_CTE ) AND
      YEAR(date)= (SELECT last_year FROM filter_CTE )






-- What is our Win / draw / loss ratio ?





-- which opponents do we perform best / worst against ?




-- Are we scoring more or fewer goals than expected ?




-- What are the main reasons behind our recent wins or losses ?