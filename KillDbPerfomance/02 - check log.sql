/*
    Скрипт предназначен для анализа времени выполнения операций в тестовой базе KillDB.
    Основные функции:
    - Вычисление минимального, среднего и максимального времени транзакций
    - Получение и сортировка логов операций
    - Оценка производительности на основе временных меток
*/
USE KillDB
GO
USE KillDB
GO

SELECT MinTran = MIN(InsertTime)
     , AvgTran = AVG(InsertTime * 1.)
     , MaxTran = MAX(InsertTime)
FROM (
    SELECT InsertTime = DATEDIFF(MILLISECOND, StartTime, EndTime)
    FROM dbo.LogTable
) t

SELECT TOP(50) *, InsertTime = DATEDIFF(MILLISECOND, StartTime, EndTime)
FROM dbo.LogTable
ORDER BY InsertTime DESC