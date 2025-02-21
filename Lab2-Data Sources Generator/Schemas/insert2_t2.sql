-- Wczytanie tabeli WAREHOUSE dla T1
BULK INSERT WAREHOUSE
FROM 'D:\studia\semestr-5\hd\dataGenerator\dataScripts\inventory-management-system\warehouses_t2.csv'
WITH (
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

-- Wczytanie tabeli MATERIAL dla T1
BULK INSERT MATERIAL
FROM 'D:\studia\semestr-5\hd\dataGenerator\dataScripts\inventory-management-system\materials_t2.csv'
WITH (
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

-- Wczytanie tabeli WAREHOUSE_MATERIAL dla T1
BULK INSERT WAREHOUSE_MATERIAL
FROM 'D:\studia\semestr-5\hd\dataGenerator\dataScripts\inventory-management-system\warehouse_materials_t2.csv'
WITH (
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

-- Wczytanie tabeli TRANSFER dla T1
BULK INSERT TRANSFERS
FROM 'D:\studia\semestr-5\hd\dataGenerator\dataScripts\inventory-management-system\transfers_t2.csv'
WITH (
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

-- Wczytanie tabeli PART_OF_TRANSFER dla T1
BULK INSERT PART_OF_TRANSFER
FROM 'D:\studia\semestr-5\hd\dataGenerator\dataScripts\inventory-management-system\part_of_transfers_t2.csv'
WITH (
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);
