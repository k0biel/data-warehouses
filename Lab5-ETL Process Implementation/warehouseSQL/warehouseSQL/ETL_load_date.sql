ALTER TABLE DimDate ALTER COLUMN Date DATE NULL;

INSERT INTO DimDate (Date, Year, Month, MonthNo, DayOfWeek)
VALUES (NULL, 0, 'NULL_DATE', 0, 'NULL_DATE');

WITH DateRange AS (
    SELECT CAST('2000-01-01' AS DATE) AS Date
    UNION ALL
    SELECT DATEADD(DAY, 1, Date) 
    FROM DateRange
    WHERE Date < '2006-12-31' 
)
INSERT INTO DimDate (Date, Year, Month, MonthNo, DayOfWeek)
SELECT 
    Date,
    YEAR(Date) AS Year,
    DATENAME(MONTH, Date) AS Month,
    MONTH(Date) AS MonthNo,
    DATENAME(WEEKDAY, Date) AS DayOfWeek
FROM DateRange
OPTION (MAXRECURSION 0);
GO
