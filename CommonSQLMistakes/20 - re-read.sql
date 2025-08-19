USE AdventureWorks2014
GO

SET STATISTICS IO ON

/*
  Скрипт демонстрирует проблему повторного чтения данных (re-read) при использовании вложенных подзапросов в SQL Server.
  Основные функции:
  - Сравнение подходов с вложенными подзапросами и с использованием JOIN
  - Анализ влияния на производительность и количество операций чтения
  - Пример для обучения оптимизации запросов
*/
USE AdventureWorks2014
GO
SET STATISTICS IO ON
SELECT e.BusinessEntityID
    , (
        SELECT p.LastName
        FROM Person.Person p
        WHERE e.BusinessEntityID = p.BusinessEntityID
      )
    , (
        SELECT p.FirstName
        FROM Person.Person p
        WHERE e.BusinessEntityID = p.BusinessEntityID
      )
FROM HumanResources.Employee e

SELECT e.BusinessEntityID
     , p.LastName
     , p.FirstName
FROM HumanResources.Employee e
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID