USE KillDB
GO

/*
    Скрипт предназначен для уменьшения размера файлов базы данных KillDB в SQL Server.
    Основные функции:
    - Выполнение операций SHRINKFILE и SHRINKDATABASE
    - Демонстрация способов освобождения дискового пространства
    - Примеры команд для оптимизации размера файлов
*/
USE KillDB
GO
DBCC SHRINKFILE (N'KillDB', 25)

/*
    DBCC SHRINKDATABASE(N'KillDB')
*/
