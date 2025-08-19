/*
  Скрипт демонстрирует особенности и типичные ошибки использования конструкции INSERT ... EXEC в SQL Server.
  Основные функции:
  - Примеры вставки данных из процедуры и динамического SQL
  - Сравнение с прямой вставкой через SELECT
  - Анализ ограничений, производительности и потенциальных проблем
*/

USE test
GO

DROP PROCEDURE IF EXISTS #proc
GO

CREATE PROCEDURE #proc
AS
    SELECT TOP(10000) A
    FROM big_table
GO

DROP TABLE IF EXISTS #t
CREATE TABLE #t (id INT)

INSERT INTO #t
EXEC #proc
GO

------------------------------------------------------------------

DROP TABLE IF EXISTS #t
CREATE TABLE #t (id INT)

INSERT INTO #t
SELECT TOP(10000) A
FROM big_table
GO

------------------------------------------------------------------

DECLARE @sql NVARCHAR(MAX) = '
SELECT TOP(10000) A
FROM big_table'

DROP TABLE IF EXISTS #t
CREATE TABLE #t (id INT)

INSERT INTO #t
EXEC(@sql)
GO

------------------------------------------------------------------

DECLARE @sql NVARCHAR(MAX) = '
INSERT INTO #t
SELECT TOP(10000) A
FROM big_table'

DROP TABLE IF EXISTS #t
CREATE TABLE #t (id INT)

EXEC(@sql)