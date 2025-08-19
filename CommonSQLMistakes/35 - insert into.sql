/*
	Скрипт демонстрирует особенности и типичные ошибки при использовании оператора INSERT INTO в SQL Server.
	Основные функции:
	- Сравнение вставки данных в табличные переменные и временные таблицы
	- Примеры группировки и агрегации при вставке
	- Анализ влияния параллелизма (MAXDOP) на выполнение
*/
USE test
GO
USE test
GO

DECLARE @t TABLE (id VARCHAR(10) PRIMARY KEY, val BIGINT)

INSERT INTO @t
SELECT B, COUNT_BIG(1)
FROM big_table
GROUP BY B
OPTION(MAXDOP 4)
GO

DROP TABLE IF EXISTS #t
CREATE TABLE #t (id VARCHAR(10) PRIMARY KEY, val BIGINT)

INSERT INTO #t
SELECT B, COUNT_BIG(1)
FROM big_table
GROUP BY B
OPTION(MAXDOP 4)