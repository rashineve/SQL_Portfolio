
--11  
--کیس درست مثل if/else پایتون عمل میکنه 
/*
join هم برای وصل کردن دوتا جدول به همه 
*/
 use WorkforceManagement
 GO 
 SELECT 
    A.EmployeeId,
    CASE 
        WHEN A.JobId IS NULL THEN 'UNKNOWN JOB!'
        ELSE B.Title
    END AS JobName
FROM WorksOn AS A 
LEFT JOIN Job AS B     -- رو دربیار حتی اگه متناظرن  work onاین میگه همه رکورد های
    ON A.JobId = B.JobId;
--15
SELECT *
FROM Project
WHERE [Name] LIKE '%_%'




	

