/*
 Скрипт предназначен для демонстрации ошибок, связанных с вычислениями в условиях фильтрации (WHERE) и их влияния на использование индексов в SQL Server.
 Основные функции:
 - Выполнение запросов с вычислениями в условиях фильтрации.
 - Сравнение эффективности использования индексов при разных способах записи условий.
 - Примеры корректных и некорректных подходов к фильтрации для оптимального использования индексов.
*/
USE AdventureWorks2014
GO

SET STATISTICS IO ON

SELECT BusinessEntityID
FROM Person.Person
WHERE BusinessEntityID * 2 = 10000

SELECT BusinessEntityID
FROM Person.Person
WHERE BusinessEntityID = 2500 * 2

SELECT BusinessEntityID
FROM Person.Person
WHERE BusinessEntityID = 5000

/*
    Table 'Person'. Scan count 1, logical reads 67, ...
    Table 'Person'. Scan count 0, logical reads 3, ...
    Table 'Person'. Scan count 0, logical reads 3, ...
*/

