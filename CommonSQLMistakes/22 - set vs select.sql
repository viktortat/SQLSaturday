DECLARE @a INT
/*
    Скрипт демонстрирует различия между операторами SET и SELECT при присваивании значений переменным в SQL Server.
    Основные функции:
    - Сравнение поведения SET и SELECT при отсутствии данных
    - Примеры присваивания из подзапросов и множественных строк
    - Анализ @@rowcount и особенностей работы с переменными
    - Демонстрация влияния индексов и TOP на результат
*/
DECLARE @a INT
SET @a = 1

DECLARE @b INT
SELECT @b = 1

SET @a = (
    SELECT 123
    WHERE 1 = 0
)
SELECT @@rowcount, @a -- NULL

SELECT @b = 123
WHERE 1 = 0
SELECT @@rowcount, @b -- 1

------------------------------------------------------------------

DROP TABLE IF EXISTS #temp
GO

CREATE TABLE #temp (a INT, b INT)
INSERT INTO #temp
VALUES (1, 9), (1, 6)

SELECT b FROM #temp

DECLARE @id INT
SELECT @id = b
FROM #temp
SELECT @id

CREATE NONCLUSTERED INDEX ix ON #temp (b)

SELECT b FROM #temp

SELECT @id = b
FROM #temp
SELECT @id

SELECT TOP(1) @id = b
FROM #temp
SELECT @id