USE [developer_dw];
GO

IF OBJECT_ID('vETLFDimMaterial') IS NOT NULL
    DROP VIEW vETLFDimMaterial;
GO

CREATE VIEW vETLFDimMaterial AS
SELECT DISTINCT 
    o.MaterialID AS MID,             
    o.MaterialName, 
    o.Unit, 
    CASE 
        WHEN o.UnitPrice < 10 THEN 'Very Cheap'
        WHEN o.UnitPrice BETWEEN 10 AND 50 THEN 'Cheap'
        WHEN o.UnitPrice BETWEEN 50 AND 100 THEN 'Moderate'
        WHEN o.UnitPrice BETWEEN 100 AND 500 THEN 'Expensive'
        ELSE 'Exclusive'
    END AS PriceCategory
FROM [ordering_db].[dbo].[MATERIAL] AS o
LEFT JOIN [inventory_db].[dbo].[MATERIAL] AS i
    ON o.MaterialID = i.MaterialID
WHERE o.MaterialID IS NOT NULL;
GO

MERGE INTO DimMaterial AS TT
USING vETLFDimMaterial AS ST
ON TT.MID = ST.MID  
--WHEN MATCHED THEN
--    UPDATE 
--    SET 
--        TT.MaterialName = ST.MaterialName,
--        TT.Unit = ST.Unit,
--        TT.PriceCategory = ST.PriceCategory
WHEN NOT MATCHED THEN
    INSERT (MID, MaterialName, Unit, PriceCategory)
    VALUES (ST.MID, ST.MaterialName, ST.Unit, ST.PriceCategory)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE; 
GO

DROP VIEW vETLFDimMaterial;
GO
