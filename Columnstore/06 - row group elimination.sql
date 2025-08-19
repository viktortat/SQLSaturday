/*
 Скрипт предназначен для демонстрации механизма исключения row group'ов при работе с Columnstore индексами.
 Основные функции:
 - Выполнение выборки по различным типам столбцов для анализа эффективности row group elimination.
 - Сравнение статистики чтения и времени выполнения запросов при фильтрации по числовым и строковым значениям.
 - Оценка влияния типа данных на работу механизма row group elimination.
*/
USE CCI
GO

SET NOCOUNT ON
SET STATISTICS IO, TIME ON

SELECT *
FROM dbo.tCCI
WHERE RowID = 1

SELECT *
FROM dbo.tCCI
WHERE RowID_Varchar = '1' -- NUMERIC/DATETIMEOFFSET/[N]CHAR/[N]VARCHAR/VARBINARY/UNIQUEIDENTIFIER

SET STATISTICS IO, TIME OFF

/*
    Table 'tCCI'. ..., lob logical reads 3639, lob physical reads 0, lob read-ahead reads 0.
    Table 'tCCI'. Segment reads 1, segment skipped 6.
    SQL Server Execution Times:
       CPU time = 0 ms,  elapsed time = 7 ms.

    Table 'tCCI'. ..., lob logical reads 21789, lob physical reads 0, lob read-ahead reads 0.
    Table 'tCCI'. Segment reads 7, segment skipped 0.
    SQL Server Execution Times:
       CPU time = 672 ms,  elapsed time = 671 ms.
*/