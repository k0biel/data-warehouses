USE [developer_dw];
GO

IF OBJECT_ID('vETLFDimSupplier') IS NOT NULL
    DROP VIEW vETLFDimSupplier;
GO

CREATE VIEW vETLFDimSupplier AS
SELECT DISTINCT 
    SupplierID AS SID,         
    SupplierName
FROM [ordering_db].[dbo].[SUPPLIER]
WHERE SupplierID IS NOT NULL;
GO

MERGE INTO DimSupplier AS TT
USING vETLFDimSupplier AS ST
ON TT.SID = ST.SID  
--WHEN MATCHED THEN
--    UPDATE 
--    SET 
--        TT.SupplierName = ST.SupplierName
WHEN NOT MATCHED THEN
    INSERT (SID, SupplierName)
    VALUES (ST.SID, ST.SupplierName)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE; 
GO

DROP VIEW vETLFDimSupplier;
GO
