CREATE TABLE WAREHOUSE (
    WarehouseID VARCHAR(10) PRIMARY KEY,
    WarehouseName VARCHAR(20) NOT NULL,
    Location VARCHAR(20)
);

CREATE TABLE MATERIAL (
    MaterialID VARCHAR(10) PRIMARY KEY,
    MaterialName VARCHAR(50) NOT NULL,
);

CREATE TABLE WAREHOUSE_MATERIAL (
    WarehouseMaterialID VARCHAR(20) PRIMARY KEY,
    WarehouseID VARCHAR(10),
    MaterialID VARCHAR(10),
    QuantityInStock NUMERIC,
    LastUpdated DATETIME,
    FOREIGN KEY (WarehouseID) REFERENCES WAREHOUSE(WarehouseID),
    FOREIGN KEY (MaterialID) REFERENCES MATERIAL(MaterialID)
);

CREATE TABLE TRANSFERS (
    TransferID VARCHAR(20) PRIMARY KEY,
    WarehouseID VARCHAR(10),
    ProjectID VARCHAR(20),
    TransferCost NUMERIC,
    TransferDate DATETIME,
    FOREIGN KEY (WarehouseID) REFERENCES WAREHOUSE(WarehouseID)
); 

CREATE TABLE PART_OF_TRANSFER (
    PartOfTransferID VARCHAR(20) PRIMARY KEY,
    TransferID VARCHAR(20),
    WarehouseMaterialID VARCHAR(20),
    QuantityMoved NUMERIC,
    LostQuantity NUMERIC,
    FOREIGN KEY (TransferID) REFERENCES TRANSFERS(TransferID),
    FOREIGN KEY (WarehouseMaterialID) REFERENCES WAREHOUSE_MATERIAL(WarehouseMaterialID)
);