/*
 Скрипт предназначен для демонстрации ошибок, связанных с подавлением использования индекса при фильтрации строковых данных в SQL Server.
 Основные функции:
 - Выполнение запросов с различными функциями и операторами для фильтрации строк.
 - Сравнение эффективности использования индекса при разных способах фильтрации.
 - Примеры корректных и некорректных подходов к фильтрации для оптимального использования индексов.
*/
USE AdventureWorks2014
GO

SET STATISTICS IO ON

SELECT AddressLine1
FROM Person.[Address]
WHERE SUBSTRING(AddressLine1, 1, 3) = '100'

SELECT AddressLine1
FROM Person.[Address]
WHERE LEFT(AddressLine1, 3) = '100'

SELECT AddressLine1
FROM Person.[Address]
WHERE CAST(AddressLine1 AS CHAR(3)) = '100'

SELECT AddressLine1
FROM Person.[Address]
WHERE AddressLine1 LIKE '100%'

/*
    Table 'Address'. Scan count 1, logical reads 216, ...
    Table 'Address'. Scan count 1, logical reads 216, ...
    Table 'Address'. Scan count 1, logical reads 216, ...
    Table 'Address'. Scan count 1, logical reads 4, ...
*/

------------------------------------------------------------------

SELECT AddressLine1
FROM Person.[Address]
WHERE AddressLine1 LIKE '%100%'

/*
    Table 'Address'. Scan count 1, logical reads 216, ...
*/