--WorkForceMangement practices 
--HAVING
--1
USE WorkforceManagement
GO 
SELECT ProjectId ,
		COUNT (EmployeeId) 
FROM WorksOn
GROUP BY  ProjectId
HAVING COUNT (EmployeeId)<=4 

--2 




