USE [developer_dw];
GO

IF OBJECT_ID('vETLFDimWarehouse') IS NOT NULL
    DROP VIEW vETLFDimWarehouse;
GO

CREATE VIEW vETLFDimWarehouse AS
SELECT DISTINCT 
    WarehouseID AS WID,        
    WarehouseName, 
    Location
FROM [inventory_db].[dbo].[WAREHOUSE]
WHERE WarehouseID IS NOT NULL;
GO

MERGE INTO DimWarehouse AS TT
USING vETLFDimWarehouse AS ST
ON TT.WID = ST.WID 
--WHEN MATCHED THEN
--    UPDATE 
--    SET 
--        TT.WarehouseName = ST.WarehouseName,
--        TT.Location = ST.Location
WHEN NOT MATCHED THEN
    INSERT (WID, WarehouseName, Location)
    VALUES (ST.WID, ST.WarehouseName, ST.Location)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE; 
GO

DROP VIEW vETLFDimWarehouse;
GO
