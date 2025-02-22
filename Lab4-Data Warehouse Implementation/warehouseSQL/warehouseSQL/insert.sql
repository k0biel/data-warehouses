-- Wstawianie danych do DimMaterial
INSERT INTO DimMaterial (MaterialName, Unit, PriceCategory) VALUES
('Bricks', 'kg', 'moderate'),
('Cement', 'kg', 'cheap'),
('Steel', 'm', 'expensive'),
('Paint', 'l', 'moderate'),
('Wood', 'm?', 'cheap'),
('Glass', 'm?', 'expensive'),
('Tiles', 'kg', 'moderate');

-- Wstawianie danych do DimSupplier
INSERT INTO DimSupplier (SupplierName) VALUES
('ABC Supplies'),
('Global Materials'),
('BuildCo'),
('PaintMasters'),
('Eco Materials'),
('SolidBuild Inc.');

-- Wstawianie danych do DimWarehouse
INSERT INTO DimWarehouse (WarehouseName, Location) VALUES
('Main Warehouse', 'New York'),
('West Depot', 'Los Angeles'),
('East Hub', 'Chicago'),
('South Center', 'Houston');

-- Wstawianie danych do DimProject
INSERT INTO DimProject (ProjectName, Location, ProjectManagerPesel, MaterialPriceCategory, IsCurrent) VALUES
('Highrise Construction', 'New York', '12345678901', 'Premium', 1),
('Bridge Renovation', 'Los Angeles', '98765432109', 'Standard', 0),
('Eco Housing', 'Chicago', '11223344556', 'Economical', 1),
('Luxury Apartments', 'Houston', '99887766554', 'Premium', 1);

-- Wstawianie danych do DimDate
INSERT INTO DimDate (Date, Year, Month, MonthNo, DayOfWeek) VALUES
('2024-11-01', 2024, 'November', 11, 'Friday'),
('2024-11-02', 2024, 'November', 11, 'Saturday'),
('2024-11-03', 2024, 'November', 11, 'Sunday'),
('2024-11-04', 2024, 'November', 11, 'Monday'),
('2024-11-05', 2024, 'November', 11, 'Tuesday'),
('2024-11-06', 2024, 'November', 11, 'Wednesday'),
('2024-11-07', 2024, 'November', 11, 'Thursday'),
('2024-11-08', 2024, 'November', 11, 'Friday');
-- Dodano DateKey od 1 do 8

-- Wstawianie danych do DimJunk
INSERT INTO DimJunk (IsDelayed) VALUES
(1), -- OpóŸnienie
(0); -- Brak opóŸnienia

-- Wstawianie danych do FactMaterialOrders
INSERT INTO FactMaterialOrders (
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
) VALUES
(1, 1, 1, 1, 2, 3, 1, 1000.00, 500.00, 1500.00),
(2, 2, 2, 2, 3, 3, 2, 500.00, 200.00, 700.00),
(3, 3, 3, 3, 4, 5, 1, 800.00, 400.00, 1200.00),
(4, 4, 1, 4, 5, 5, 2, 300.00, 150.00, 450.00),
(5, 1, 4, 5, 1, 2, 1, 700.00, 350.00, 1050.00),
(6, 2, 2, 1, 2, 3, 2, 600.00, 300.00, 900.00),
(7, 3, 3, 4, 5, 1, 1, 400.00, 200.00, 600.00);

-- Wstawianie danych do FactMaterialTransfers
INSERT INTO FactMaterialTransfers (
    MaterialKey, 
    WarehouseKey, 
    ProjectKey, 
    TransferDateKey, 
    QuantityTransferred, 
    TransferCost, 
    LostQuantity
) VALUES
(1, 1, 1, 1, 900.00, 300.00, 100.00),
(3, 2, 2, 2, 700.00, 500.00, 50.00),
(4, 3, 3, 3, 1000.00, 200.00, 75.00),
(5, 4, 4, 4, 600.00, 150.00, 30.00),
(2, 1, 1, 5, 800.00, 400.00, 50.00),
(7, 2, 2, 6, 700.00, 300.00, 20.00), 
(6, 3, 3, 7, 500.00, 250.00, 10.00), 
(5, 4, 4, 8, 1200.00, 350.00, 40.00);
