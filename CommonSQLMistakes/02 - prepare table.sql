/*
 Скрипт предназначен для подготовки тестовой базы данных и таблицы для демонстрации типичных ошибок в SQL Server.
 Основные функции:
 - Удаление и пересоздание базы данных test с заданными параметрами файлов.
 - Создание таблицы big_table с индексами и различными типами столбцов.
 - Заполнение таблицы тестовыми данными для дальнейших экспериментов.
*/
USE [master]
GO

IF DB_ID('test') IS NOT NULL BEGIN
    ALTER DATABASE test SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE test
END
GO

CREATE DATABASE test
ON PRIMARY (NAME = test,     FILENAME = 'X:\test.mdf', SIZE = 300MB, FILEGROWTH = 100MB)
    LOG ON (NAME = test_log, FILENAME = 'X:\test.ldf', SIZE = 300MB, FILEGROWTH = 100MB)
GO

USE test
GO

DROP TABLE IF EXISTS big_table
GO

CREATE TABLE big_table (
      A INT IDENTITY
    , B VARCHAR(10) NOT NULL
    , C INT NOT NULL DEFAULT 1
    , D VARCHAR(50) DEFAULT REPLICATE('-', 50)
    , E VARCHAR(20) DEFAULT REPLICATE('-', 20)
    , F VARCHAR(10) DEFAULT REPLICATE('-', 10)
    , INDEX ix NONCLUSTERED (B, C)
    , INDEX pk UNIQUE CLUSTERED (A)
)
GO

DBCC TRACEOFF(2371, -1)

INSERT INTO big_table (B)
SELECT TOP(2000000) LEFT(val, 1)
FROM (
    SELECT val = CAST(NEWID() AS NVARCHAR(36))
    FROM [master].dbo.spt_values AS sv
    CROSS JOIN [master].dbo.spt_values AS sv2
) t
WHERE val BETWEEN 'A' AND 'F'
GO

SELECT B, COUNT_BIG(1)
FROM big_table
GROUP BY B

UPDATE TOP(10) PERCENT big_table
SET B = 'Z'
WHERE B = 'A'

INSERT INTO big_table (B, C) VALUES ('X', 0)
INSERT INTO big_table (B) VALUES ('ABC')

SELECT B, COUNT_BIG(1)
FROM big_table
GROUP BY B

DBCC TRACEON (2371, -1)