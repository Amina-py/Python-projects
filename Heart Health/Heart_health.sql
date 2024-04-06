CREATE DATABASE heart;
USE heart;

SELECT *
FROM Heart_health$;

SELECT Gender, COUNT(Gender) Frequency
FROM Heart_health$
GROUP BY Gender;

SELECT Smoker, COUNT(Smoker) Frequency
FROM Heart_health$
GROUP BY Smoker;

SELECT [Exercise(hours/week)], COUNT([Exercise(hours/week)]) Frequency
FROM Heart_health$
GROUP BY [Exercise(hours/week)];

SELECT [Heart Attack], COUNT([Heart Attack]) Frequency
FROM Heart_health$
GROUP BY [Heart Attack];

SELECT Age_Group, COUNT(Age_Group) Frequency
FROM Heart_health$
GROUP BY Age_Group;

SELECT [Heart Attack], COUNT([Heart Attack]) Frequency
FROM Heart_health$
GROUP BY [Heart Attack];

--- WHICH GENDER IS MORE PRONE TO HEART ATTACKS AND IS ALSO NOT?
SELECT Gender, [Heart Attack], COUNT([Heart Attack]) 'Count'
FROM Heart_health$
GROUP BY Gender, [Heart Attack];

--- WHICH AGE GROUP IS THE MOST SUSCEPTIBLE TO HEART ATTACK
ALTER TABLE Heart_health$ ADD Age_Group VARCHAR(30);

UPDATE Heart_health$ 
SET Age_Group = CASE	
					WHEN Age <= 16 THEN 'Child'
					WHEN Age <= 30 THEN 'Young Adult'
					WHEN Age <= 45 THEN 'Middle-aged Adult'
					ELSE 'Old-aged Adult'
					END;

SELECT Age_Group, COUNT([Heart Attack]) 'Heart Attack Count'
FROM Heart_health$
WHERE [Heart Attack] = 1
GROUP BY Age_Group
ORDER BY COUNT([Heart Attack]) desc;

--COUNT OF HEART ATTACK ACROSS EACH BMI 
ALTER TABLE Heart_health$ ADD BMI INT;

UPDATE Heart_health$ 
SET BMI = CAST(([Weight(kg)] / (POWER(([Height(cm)] / 100), 2)))AS INT);

SELECT BMI, [Heart Attack], COUNT([Heart Attack]) 'Heart Attack Frequency'
FROM Heart_health$
GROUP BY BMI, [Heart Attack]
ORDER BY [Heart Attack];

---HOW DOES BEING A SMOKER OR A NON SMOKER AFFECT CHANCES OF HAVING HEART ATTACKS
SELECT Smoker,[Heart Attack],COUNT([Heart Attack]) Frequency
FROM Heart_health$
GROUP BY Smoker,[Heart Attack]
ORDER BY [Heart Attack];


---WHY DO SOME SMOKERS NOT HAVE HEART ATTACK
CREATE VIEW SMOKERS_ANALYSIS 
AS
SELECT *
FROM Heart_health$
WHERE Smoker ='Yes' AND [Heart Attack] = 0;

SELECT Age_Group, COUNT(Age_Group)
FROM SMOKERS_ANALYSIS
GROUP BY Age_Group;

SELECT Gender, COUNT(Gender)
FROM SMOKERS_ANALYSIS
GROUP BY Gender;

SELECT [Blood Pressure(mmHg)], COUNT([Blood Pressure(mmHg)])
FROM SMOKERS_ANALYSIS
GROUP BY [Blood Pressure(mmHg)];

SELECT [Cholesterol(mg/dL)], COUNT([Cholesterol(mg/dL)])
FROM SMOKERS_ANALYSIS
GROUP BY [Cholesterol(mg/dL)];

SELECT [Exercise(hours/week)], COUNT([Exercise(hours/week)])
FROM SMOKERS_ANALYSIS
GROUP BY [Exercise(hours/week)];

SELECT BMI, COUNT(BMI)
FROM SMOKERS_ANALYSIS
GROUP BY BMI;
