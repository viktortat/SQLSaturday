/*
 Скрипт предназначен для демонстрации использования фильтрованных индексов (filtered indexes) в SQL Server.
 Основные функции:
 - Создание и удаление фильтрованных индексов для оптимизации запросов.
 - Выполнение агрегатных запросов с условиями, соответствующими фильтру индекса.
 - Сравнение производительности запросов до и после создания фильтрованного индекса.
*/
USE Refactoring
GO

IF EXISTS(SELECT 1 FROM sys.indexes WHERE [object_id] = OBJECT_ID('Labour.WorkOut') AND name = 'ix')
	DROP INDEX ix ON Labour.WorkOut
GO

SET STATISTICS IO ON
SET STATISTICS TIME ON

SELECT
	  TimeSheetDate
	, EmployeeID
	, SUM(WorkHours)
FROM Labour.WorkOut
WHERE WorkShiftCD IS NULL AND WorkHours IS NOT NULL
GROUP BY TimeSheetDate, EmployeeID
OPTION(MAXDOP 1)
GO

-------------------------------------------------------------------

CREATE NONCLUSTERED INDEX ix
	ON Labour.WorkOut (TimeSheetDate, EmployeeID)
	INCLUDE (WorkHours, WorkShiftCD) -- filter
	WHERE WorkShiftCD IS NULL AND WorkHours IS NOT NULL
GO

SELECT
	  TimeSheetDate
	, EmployeeID
	, SUM(WorkHours)
FROM Labour.WorkOut
WHERE WorkShiftCD IS NULL AND WorkHours IS NOT NULL
GROUP BY TimeSheetDate, EmployeeID
OPTION(MAXDOP 1)
GO