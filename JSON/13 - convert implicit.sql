/*
    Скрипт демонстрирует влияние неявного и явного преобразования типов при работе с JSON_VALUE в SQL Server.
    Основные функции:
    - Сравнение фильтрации данных с неявным и явным преобразованием
    - Анализ влияния на производительность и количество логических чтений
    - Пример работы с таблицей Sales.Customer
*/
USE AdventureWorks2014
GO
USE AdventureWorks2014
GO

DECLARE @json NVARCHAR(MAX) = N'{ "AccountNumber": "AW00000009" }'

SET STATISTICS IO ON

SELECT CustomerID, AccountNumber
FROM Sales.Customer
WHERE AccountNumber = JSON_VALUE(@json, '$.AccountNumber')

SELECT CustomerID, AccountNumber
FROM Sales.Customer
WHERE AccountNumber = CAST(JSON_VALUE(@json, '$.AccountNumber') AS VARCHAR(10))

/*
    Table 'Customer'. Scan count 1, logical reads 37, ...
    Table 'Customer'. Scan count 0, logical reads 2, ...
*/