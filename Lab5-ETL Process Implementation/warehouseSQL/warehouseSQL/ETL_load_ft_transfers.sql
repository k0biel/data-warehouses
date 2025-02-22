USE [developer_dw];
GO

IF OBJECT_ID('vETLFMaterialTransfers') IS NOT NULL
    DROP VIEW vETLFMaterialTransfers;
GO

CREATE VIEW vETLFMaterialTransfers AS
SELECT
    dm.MaterialKey,                                -- Klucz surogowany materia³u
    dw.WarehouseKey,                               -- Klucz surogowany magazynu
    dp.ProjectKey,                                 -- Klucz surogowany projektu
    dd_transfer.DateKey AS TransferDateKey,        -- Klucz surogowany daty transferu
    SUM(pot.QuantityMoved) AS QuantityTransferred, -- Suma iloœci przeniesionej
    SUM(pot.LostQuantity) AS LostQuantity,         -- Suma iloœci utraconej
    SUM(t.TransferCost) AS TransferCost            -- Suma kosztów transferu
FROM [inventory_db].[dbo].[PART_OF_TRANSFER] AS pot
INNER JOIN [inventory_db].[dbo].[TRANSFERS] AS t
    ON pot.TransferID = t.TransferID
INNER JOIN DimWarehouse AS dw
    ON dw.WID = t.WarehouseID
INNER JOIN DimProject AS dp
    ON dp.PID = t.ProjectID
INNER JOIN [inventory_db].[dbo].[WAREHOUSE_MATERIAL] AS wm
    ON pot.WarehouseMaterialID = wm.WarehouseMaterialID
INNER JOIN DimMaterial AS dm
    ON dm.MID = wm.MaterialID
INNER JOIN DimDate AS dd_transfer
    ON dd_transfer.Date = t.TransferDate
GROUP BY 
    dm.MaterialKey,
    dw.WarehouseKey,
    dp.ProjectKey,
    dd_transfer.DateKey;
GO

MERGE INTO FactMaterialTransfers AS TT
USING vETLFMaterialTransfers AS ST
ON 
    TT.MaterialKey = ST.MaterialKey
    AND TT.WarehouseKey = ST.WarehouseKey
    AND TT.ProjectKey = ST.ProjectKey
    AND TT.TransferDateKey = ST.TransferDateKey
WHEN NOT MATCHED THEN
    INSERT (
        MaterialKey,
        WarehouseKey,
        ProjectKey,
        TransferDateKey,
        QuantityTransferred,
        TransferCost,
        LostQuantity
    )
    VALUES (
        ST.MaterialKey,
        ST.WarehouseKey,
        ST.ProjectKey,
        ST.TransferDateKey,
        ST.QuantityTransferred,
        ST.TransferCost,
        ST.LostQuantity
    );
GO

DROP VIEW vETLFMaterialTransfers;
GO
