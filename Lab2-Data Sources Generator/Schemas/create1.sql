CREATE TABLE PROJECT (
    ProjectID VARCHAR(10) PRIMARY KEY,
    ProjectName VARCHAR(50) NOT NULL,       -- zwiêkszone do 50 znaków
    Location VARCHAR(50),                   -- zwiêkszone do 50 znaków
    StartDate DATETIME,
    ExpectedEndDate DATETIME,
    ActualEndDate DATETIME,
    ProjectManagerPesel VARCHAR(11)
);

CREATE TABLE SUPPLIER (
    SupplierID VARCHAR(10) PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL      -- zwiêkszone do 100 znaków
);

CREATE TABLE MATERIAL (
    MaterialID VARCHAR(10) PRIMARY KEY,
    MaterialName VARCHAR(30) NOT NULL,      -- zwiêkszone do 30 znaków
    Unit VARCHAR(20) CHECK (Unit IN ('kg', 'm', 'm2', 'm3', 'l')),  -- poprawiono wartoœæ "m?"
    UnitPrice DECIMAL(10, 2),
    SupplierID VARCHAR(10),
    FOREIGN KEY (SupplierID) REFERENCES SUPPLIER(SupplierID)
);

CREATE TABLE ORDERS (
    OrderID VARCHAR(10) PRIMARY KEY,
    OrderDate DATETIME,
    ExpectedDeliveryDate DATETIME,
    DeliveryDate DATETIME,
    OrderCost DECIMAL(10, 2),
    WarehouseID VARCHAR(10),
    DeliveryStatus VARCHAR(15) CHECK (DeliveryStatus IN ('Excellent', 'Average', 'Poor'))  -- zwiêkszone do 15 znaków
);

CREATE TABLE PROJECT_MATERIAL (
    ProjectMaterialID VARCHAR(10) PRIMARY KEY,
    ProjectID VARCHAR(10),
    MaterialID VARCHAR(10),
    Quantity INT,
    OrderID VARCHAR(10),
    FOREIGN KEY (ProjectID) REFERENCES PROJECT(ProjectID),
    FOREIGN KEY (MaterialID) REFERENCES MATERIAL(MaterialID),
    FOREIGN KEY (OrderID) REFERENCES ORDERS(OrderID)
);
