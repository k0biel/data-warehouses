CREATE TABLE DimMaterial (
    MaterialKey INTEGER IDENTITY(1,1) PRIMARY KEY, -- Klucz sztuczny
    MID VARCHAR(10) NULL,                         -- Klucz biznesowy (mo¿e byæ pusty)
    MaterialName VARCHAR(40),
    Unit VARCHAR(10),
    PriceCategory VARCHAR(20)
);


CREATE TABLE DimSupplier (
    SupplierKey INTEGER IDENTITY(1,1) PRIMARY KEY, -- Klucz sztuczny
    SID VARCHAR(10) NULL,                         -- Klucz biznesowy (mo¿e byæ pusty)
    SupplierName VARCHAR(128)
);


CREATE TABLE DimWarehouse (
    WarehouseKey INTEGER IDENTITY(1,1) PRIMARY KEY, -- Klucz sztuczny
    WID VARCHAR(10) NULL,                          -- Klucz biznesowy (mo¿e byæ pusty)
    WarehouseName VARCHAR(40),
    Location VARCHAR(40)
);


CREATE TABLE DimProject (
    ProjectKey INTEGER IDENTITY(1,1) PRIMARY KEY, -- Klucz sztuczny
    PID VARCHAR(10) NULL,                        -- Klucz biznesowy (mo¿e byæ pusty)
    ProjectName VARCHAR(40),
    Location VARCHAR(40),
    ProjectManagerPesel VARCHAR(11),
    MaterialPriceCategory VARCHAR(20),
    IsCurrent BIT
);


CREATE TABLE DimDate (
    DateKey INTEGER IDENTITY(1,1) PRIMARY KEY,
    Date DATE NOT NULL,
    Year INT,
    Month VARCHAR(10),
    MonthNo INT,
    DayOfWeek VARCHAR(10)
);

CREATE TABLE DimJunk (
    JunkKey INTEGER IDENTITY(1,1) PRIMARY KEY,
    IsDelayed BIT
);

CREATE TABLE FactMaterialOrders (
    MaterialKey INTEGER FOREIGN KEY REFERENCES DimMaterial(MaterialKey),
    SupplierKey INTEGER FOREIGN KEY REFERENCES DimSupplier(SupplierKey),
    WarehouseKey INTEGER FOREIGN KEY REFERENCES DimWarehouse(WarehouseKey),
    OrderDateKey INTEGER FOREIGN KEY REFERENCES DimDate(DateKey),
    DeliveryDateKey INTEGER FOREIGN KEY REFERENCES DimDate(DateKey),
    ExpectedDeliveryDateKey INTEGER FOREIGN KEY REFERENCES DimDate(DateKey),
    JunkKey INTEGER FOREIGN KEY REFERENCES DimJunk(JunkKey),
    Quantity DECIMAL(18, 2),
    TransferCost DECIMAL(18, 2),
    MaterialCost DECIMAL(18, 2),
    CONSTRAINT PK_FactMaterialOrders PRIMARY KEY (
        MaterialKey, SupplierKey, WarehouseKey, OrderDateKey, DeliveryDateKey, ExpectedDeliveryDateKey, JunkKey
    )
);

CREATE TABLE FactMaterialTransfers (
    MaterialKey INTEGER FOREIGN KEY REFERENCES DimMaterial(MaterialKey),
    WarehouseKey INTEGER FOREIGN KEY REFERENCES DimWarehouse(WarehouseKey),
    ProjectKey INTEGER FOREIGN KEY REFERENCES DimProject(ProjectKey),
    TransferDateKey INTEGER FOREIGN KEY REFERENCES DimDate(DateKey),
    QuantityTransferred DECIMAL(18, 2),
    TransferCost DECIMAL(18, 2),
    LostQuantity DECIMAL(18, 2),
    CONSTRAINT PK_FactMaterialTransfers PRIMARY KEY (
        MaterialKey, WarehouseKey, ProjectKey, TransferDateKey
    )
);
