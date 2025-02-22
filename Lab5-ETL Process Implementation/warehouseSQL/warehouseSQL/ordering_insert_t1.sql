BULK INSERT SUPPLIER
FROM 'D:\studia\semestr-5\hd\dataGenerator\dataScripts\material-orderding-system\suppliers_t1.csv'
WITH (
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

BULK INSERT MATERIAL
FROM 'D:\studia\semestr-5\hd\dataGenerator\dataScripts\material-orderding-system\materials_t1.csv'
WITH (
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

BULK INSERT PROJECT
FROM 'D:\studia\semestr-5\hd\dataGenerator\dataScripts\material-orderding-system\projects_t1.csv'
WITH (
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

BULK INSERT ORDERS
FROM 'D:\studia\semestr-5\hd\dataGenerator\dataScripts\material-orderding-system\orders_t1.csv'
WITH (
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);

BULK INSERT PROJECT_MATERIAL
FROM 'D:\studia\semestr-5\hd\dataGenerator\dataScripts\material-orderding-system\project_materials_t1.csv'
WITH (
    FIELDTERMINATOR = ';',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2,
    TABLOCK
);
