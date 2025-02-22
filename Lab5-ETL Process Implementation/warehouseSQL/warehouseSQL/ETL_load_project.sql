USE [developer_dw];
GO

IF OBJECT_ID('vETLFDimProject') IS NOT NULL
    DROP VIEW vETLFDimProject;
GO

CREATE VIEW vETLFDimProject AS
SELECT DISTINCT 
    p.ProjectID AS PID,         
    p.ProjectName, 
    p.Location, 
    p.ProjectManagerPesel,
    CASE 
        WHEN SUM(m.UnitPrice * pm.Quantity) < 5000000 THEN 'Economical'
        WHEN SUM(m.UnitPrice * pm.Quantity) BETWEEN 5000000 AND 7000000 THEN 'Standard'
        ELSE 'Premium'
    END AS MaterialPriceCategory,
    1 AS IsCurrent 
FROM [ordering_db].[dbo].[PROJECT] AS p
LEFT JOIN [ordering_db].[dbo].[PROJECT_MATERIAL] AS pm
    ON p.ProjectID = pm.ProjectID
LEFT JOIN [ordering_db].[dbo].[MATERIAL] AS m
    ON pm.MaterialID = m.MaterialID
WHERE p.ProjectID IS NOT NULL
GROUP BY p.ProjectID, p.ProjectName, p.Location, p.ProjectManagerPesel;
GO

MERGE INTO DimProject AS TT
USING vETLFDimProject AS ST
ON TT.PID = ST.PID  
WHEN MATCHED THEN
    UPDATE 
    SET 
        TT.ProjectName = ST.ProjectName,
        TT.Location = ST.Location,
        TT.ProjectManagerPesel = ST.ProjectManagerPesel,
        TT.MaterialPriceCategory = ST.MaterialPriceCategory,
        TT.IsCurrent = ST.IsCurrent
WHEN NOT MATCHED THEN
    INSERT (PID, ProjectName, Location, ProjectManagerPesel, MaterialPriceCategory, IsCurrent)
    VALUES (ST.PID, ST.ProjectName, ST.Location, ST.ProjectManagerPesel, ST.MaterialPriceCategory, ST.IsCurrent)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE; 
GO

DROP VIEW vETLFDimProject;
GO
