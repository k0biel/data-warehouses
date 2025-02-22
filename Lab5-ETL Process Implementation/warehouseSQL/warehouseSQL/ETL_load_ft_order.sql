USE [developer_dw];
GO

IF OBJECT_ID('vETLFMaterialOrders') IS NOT NULL
    DROP VIEW vETLFMaterialOrders;
GO

CREATE VIEW vETLFMaterialOrders AS
SELECT 
    dm.MaterialKey,                              
    ds.SupplierKey,                              
    dw.WarehouseKey,                             
    ISNULL(dd_order.DateKey, (SELECT DateKey FROM DimDate WHERE Date IS NULL)) AS OrderDateKey, 
    ISNULL(dd_delivery.DateKey, (SELECT DateKey FROM DimDate WHERE Date IS NULL)) AS DeliveryDateKey, 
    ISNULL(dd_expected.DateKey, (SELECT DateKey FROM DimDate WHERE Date IS NULL)) AS ExpectedDeliveryDateKey,
    dj.JunkKey,                              
    SUM(pm.Quantity) AS Quantity,               
    SUM(o.OrderCost) AS TransferCost,            
    SUM(pm.Quantity * m.UnitPrice) AS MaterialCost 
FROM [ordering_db].[dbo].[PROJECT_MATERIAL] AS pm
INNER JOIN DimMaterial AS dm
    ON dm.MID = pm.MaterialID
INNER JOIN [ordering_db].[dbo].[MATERIAL] AS m
    ON pm.MaterialID = m.MaterialID
INNER JOIN DimSupplier AS ds
    ON ds.SID = m.SupplierID
INNER JOIN [ordering_db].[dbo].[ORDERS] AS o
    ON pm.OrderID = o.OrderID
INNER JOIN DimWarehouse AS dw
    ON dw.WID = o.WarehouseID
LEFT JOIN DimDate AS dd_order
    ON dd_order.Date = o.OrderDate
LEFT JOIN DimDate AS dd_delivery
    ON dd_delivery.Date = o.DeliveryDate
LEFT JOIN DimDate AS dd_expected
    ON dd_expected.Date = o.ExpectedDeliveryDate
LEFT JOIN DimJunk AS dj
    ON dj.IsDelayed = CASE 
                        WHEN o.ExpectedDeliveryDate < o.DeliveryDate THEN 1
                        ELSE 0
                      END
GROUP BY 
    dm.MaterialKey, ds.SupplierKey, dw.WarehouseKey, 
    dd_order.DateKey, dd_delivery.DateKey, dd_expected.DateKey, dj.JunkKey;
GO

MERGE INTO FactMaterialOrders AS TT
USING vETLFMaterialOrders AS ST
ON 
    TT.MaterialKey = ST.MaterialKey
    AND TT.SupplierKey = ST.SupplierKey
    AND TT.WarehouseKey = ST.WarehouseKey
    AND TT.OrderDateKey = ST.OrderDateKey
    AND TT.DeliveryDateKey = ST.DeliveryDateKey
    AND TT.ExpectedDeliveryDateKey = ST.ExpectedDeliveryDateKey
    AND TT.JunkKey = ST.JunkKey
WHEN NOT MATCHED THEN
    INSERT (
        MaterialKey,
        SupplierKey,
        WarehouseKey,
        OrderDateKey,
        DeliveryDateKey,
        ExpectedDeliveryDateKey,
        JunkKey,
        Quantity,
        TransferCost,
        MaterialCost
    )
    VALUES (
        ST.MaterialKey,
        ST.SupplierKey,
        ST.WarehouseKey,
        ST.OrderDateKey,
        ST.DeliveryDateKey,
        ST.ExpectedDeliveryDateKey,
        ST.JunkKey,
        ST.Quantity,
        ST.TransferCost,
        ST.MaterialCost
    );
GO

DROP VIEW vETLFMaterialOrders;
GO
