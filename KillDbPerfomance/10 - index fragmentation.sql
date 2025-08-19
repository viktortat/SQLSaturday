USE KillDB
GO

/*
    Скрипт предназначен для анализа фрагментации индексов в базе данных KillDB в SQL Server.
    Основные функции:
    - Получение информации о степени фрагментации и использовании страниц
    - Анализ параметров индексов и их разделов
    - Сортировка по количеству фрагментов для выявления проблемных объектов
*/
USE KillDB
GO
SELECT
      SCHEMA_NAME(o.[schema_id]) AS [schema_name]
    , o.name AS parent_name
    , i.name
    , s.avg_fragmentation_in_percent
	, s.avg_page_space_used_in_percent
    , i.type_desc
    , size = s.page_count * 8. / 1024
    , p.partition_number
    , p.[rows]
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'DETAILED') s
JOIN sys.partitions p ON s.[object_id] = p.[object_id] AND s.index_id = p.index_id AND s.partition_number = p.partition_number
JOIN sys.indexes i ON i.[object_id] = s.[object_id] AND i.index_id = s.index_id
JOIN sys.objects o ON o.[object_id] = i.[object_id]
WHERE i.is_disabled = 0
    AND i.is_hypothetical = 0
    AND s.index_level = 0
    AND s.page_count > 0
    AND s.alloc_unit_type_desc = 'IN_ROW_DATA'
    AND o.[type] IN ('U', 'V')
ORDER BY s.fragment_count DESC