--=============  Part 2  ==============

-- How is our team performing compared to previous season ?

--- 2023 
---- as home team
WITH Fiter_CTE_2023 AS (
       SELECT 2023 AS last_year , 
	          'Egypt' AS team )

SELECT SUM(home_score) AS Total_Goal ,
       SUM(away_score) AS total_concedered_home,
       COUNT(*) AS Total_Maches,
	   (SELECT COUNT(*)  FROM results   WHERE home_team = (SELECT team FROM Fiter_CTE_2023 ) AND
	                                    YEAR(date) = (SELECT last_year FROM Fiter_CTE_2023 ) AND 
									    home_score < away_score ) AS total_loss ,

	   (SELECT COUNT(*)  FROM results   WHERE home_team = (SELECT team FROM Fiter_CTE_2023 ) AND
	                                    YEAR(date) = (SELECT last_year FROM Fiter_CTE_2023 ) AND 
									    home_score = away_score ) AS total_Draw  ,
       
	  (SELECT COUNT(*)  FROM results    WHERE home_team = (SELECT team FROM Fiter_CTE_2023 ) AND
	                                    YEAR(date) = (SELECT last_year FROM Fiter_CTE_2023 ) AND 
									    home_score > away_score ) AS total_Win
	  
	   
FROM results 
WHERE home_team = ( SELECT team    FROM Fiter_CTE_2023 )  AND 
             YEAR(date) = (SELECT last_year FROM Fiter_CTE_2023 )




---2023 
--- as away team 
WITH Fiter_CTE_2023 AS (
       SELECT 2023 AS last_year , 
	          'Egypt' AS team )

SELECT SUM(away_score) AS Total_Goal ,
       SUM(home_score) AS total_concedered_AWAY,
       COUNT(*) AS Total_Maches,
	   (SELECT COUNT(*)  FROM results   WHERE away_team = (SELECT team FROM Fiter_CTE_2023 ) AND
	                                    YEAR(date) = (SELECT last_year FROM Fiter_CTE_2023 ) AND 
									    home_score > away_score ) AS total_loss ,

	   (SELECT COUNT(*)  FROM results   WHERE away_team = (SELECT team FROM Fiter_CTE_2023 ) AND
	                                    YEAR(date) = (SELECT last_year FROM Fiter_CTE_2023 ) AND 
									    home_score = away_score ) AS total_Draw  ,
       
	  (SELECT COUNT(*)  FROM results    WHERE away_team = (SELECT team FROM Fiter_CTE_2023 ) AND
	                                    YEAR(date) = (SELECT last_year FROM Fiter_CTE_2023 ) AND 
									    home_score < away_score ) AS total_Win
	  
	   
FROM results 
WHERE away_team = ( SELECT team    FROM Fiter_CTE_2023 )  AND 
             YEAR(date) = (SELECT last_year FROM Fiter_CTE_2023 )





--- 2024

--as Home Team -- IN 2024 -- What are the Total of goals thet are scored by EGYPT ? 
WITH filter_CTE AS (
    SELECT 2024 AS last_year,
	       'Egypt' AS team )

SELECT SUM(home_score) AS total_GE_HOME ,
       SUM(away_score) AS total_concedered_HOME ,
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
       SUM(home_score) AS total_concedered_AWAY ,
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



SELECT *
FROM results 

--test 



--=======================================================================
----- WIN RATE PER SEASSON -------------  
-- rule   -- > Win rate = Wins / Number of Maches 

--1 -  2023 

SELECT CAST (SUM (Egypt_Win) AS float) 
   / COUNT(*) AS Win_Rate

FROM(SELECT CASE 
            WHEN away_team = 'Egypt' AND away_score > home_score THEN 1 
		    WHEN home_team = 'Egypt' AND away_score < home_score THEN 1
		    ELSE 0 
		    END AS Egypt_Win
     FROM results
     WHERE YEAR(date) = 2023 AND (home_team = 'Egypt' OR away_team = 'Egypt' ) )AS Egypt_Win
		

		
--1 -  2024 
SELECT CAST (SUM (Egypt_Win) AS float) 
   / COUNT(*) AS Win_Rate

FROM(SELECT CASE 
            WHEN away_team = 'Egypt' AND away_score > home_score THEN 1 
		    WHEN home_team = 'Egypt' AND away_score < home_score THEN 1
		    ELSE 0 
		    END AS Egypt_Win
     FROM results
     WHERE YEAR(date) = 2024 AND (home_team = 'Egypt' OR away_team = 'Egypt' ) )AS Egypt_Win





--===============================================================
--------- AVG Goals Scored ---------
--- eqation  -- >   Avg Goals Scored = Total Goals /  Matches


SELECT *
FROM results

--- 2023 
SELECT 

    SUM(CASE
            WHEN away_team = 'Egypt' THEN away_score 
	        WHEN home_team = 'Egypt' THEN home_score
	        ELSE 0  
	     END  )*1.0
			/

    COUNT(CASE
            WHEN away_team = 'Egypt' OR home_team = 'Egypt' THEN 1  
	      END  ) AS AVG_Goal_Scored_2023
       
FROM results 
WHERE YEAR (date) = 2023 




--- 2024 
SELECT 

    SUM(CASE
            WHEN away_team = 'Egypt' THEN away_score 
	        WHEN home_team = 'Egypt' THEN home_score
	        ELSE 0  
	     END  )*1.0
			/

    COUNT(CASE
            WHEN away_team = 'Egypt' OR home_team = 'Egypt' THEN 1  
	      END  ) AS AVG_Goal_Scored_2023
       
FROM results 
WHERE YEAR (date) = 2024 





--=========================================================
---- Goals_Difference
---- Equation -- goals scored - goals conceded 
--2023
SELECT SUM (home_score) - SUM (away_score) AS Diff
FROM results  
WHERE YEAR(date) =2023 AND home_team = 'Egypt'   


--2024
SELECT SUM (home_score) - SUM (away_score) AS Diff
FROM results  
WHERE YEAR(date) =2024 AND home_team = 'Egypt'   