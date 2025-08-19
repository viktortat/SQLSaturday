/*
 Скрипт предназначен для демонстрации различных способов удаления всех данных из таблиц в SQL Server.
 Основные функции:
 - Создание и заполнение тестовых таблиц для анализа удаления.
 - Сравнение команд DELETE и TRUNCATE TABLE по производительности и влиянию на структуру таблицы.
 - Примеры очистки таблиц и анализа статистики выполнения.
*/
USE tempdb
GO

IF OBJECT_ID('t2') IS NOT NULL
	DROP TABLE t2
GO

IF OBJECT_ID('t1') IS NOT NULL
	DROP TABLE t1
GO

SELECT TOP(1000000) ID = ROW_NUMBER() OVER(ORDER BY 1/0), t1.*
INTO t1
FROM [master].dbo.spt_values t1
CROSS JOIN [master].dbo.spt_values t2
GO

SELECT *
INTO t2
FROM t1

-------------------------------------------------------------------

SET STATISTICS IO ON
SET STATISTICS TIME ON

DELETE FROM t1

TRUNCATE TABLE t2

-------------------------------------------------------------------

IF OBJECT_ID('t1') IS NOT NULL
	DROP TABLE t1
GO
CREATE TABLE t1 (
	A SMALLINT PRIMARY KEY
)
GO

IF OBJECT_ID('t2') IS NOT NULL
	DROP TABLE t2
GO
CREATE TABLE t2 (
	A SMALLINT PRIMARY KEY,
	B INT
)
GO

ALTER TABLE t2  WITH CHECK ADD CONSTRAINT fk FOREIGN KEY(A)
REFERENCES t1 (A)
GO

ALTER TABLE t2 CHECK CONSTRAINT fk
GO

TRUNCATE TABLE t1