SET NOCOUNT ON
/*
    Скрипт демонстрирует использование вычисляемых столбцов для работы с JSON-данными в SQL Server.
    Основные функции:
    - Создание временной таблицы с JSON-данными
    - Примеры фильтрации и поиска по вычисляемому столбцу
    - Добавление вычисляемого столбца для объединения данных из JSON
    - Анализ производительности операций
*/
SET NOCOUNT ON

USE AdventureWorks2014
GO
USE AdventureWorks2014
GO

DROP TABLE IF EXISTS #JSON
GO

CREATE TABLE #JSON (
      DatabaseLogID INT PRIMARY KEY
    , InfoJSON NVARCHAR(MAX) NOT NULL
)
GO

INSERT INTO #JSON
SELECT DatabaseLogID
     , InfoJSON = (
            SELECT PostTime, DatabaseUser, [Event], [Schema], [Object], [TSQL]
            FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
         )
FROM dbo.DatabaseLog

------------------------------------------------------


SELECT *
FROM #JSON
WHERE JSON_VALUE(InfoJSON, '$.Schema') + '.' + JSON_VALUE(InfoJSON, '$.Object') = 'Person.Person'

SET STATISTICS IO, TIME OFF

/*
    Table '#JSON'. Scan count 1, logical reads 187, ...
        CPU time = 16 ms, elapsed time = 29 ms
*/

------------------------------------------------------

    ADD ObjectName AS JSON_VALUE(InfoJSON, '$.Schema') + '.' + JSON_VALUE(InfoJSON, '$.Object')
GO

CREATE INDEX IX_ObjectName ON #JSON (ObjectName)

------------------------------------------------------


SELECT *
FROM #JSON
WHERE JSON_VALUE(InfoJSON, '$.Schema') + '.' + JSON_VALUE(InfoJSON, '$.Object') = 'Person.Person'

SELECT *
FROM #JSON
WHERE ObjectName = 'Person.Person'

SET STATISTICS IO, TIME OFF

/*
    Table '#JSON'. Scan count 1, logical reads 13, ...
        CPU time = 0 ms, elapsed time = 1 ms

    Table '#JSON'. Scan count 1, logical reads 13, ...
        CPU time = 0 ms, elapsed time = 1 ms
*/