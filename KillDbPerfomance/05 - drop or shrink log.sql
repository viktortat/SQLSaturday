/*
    Скрипт предназначен для уменьшения или очистки журнала транзакций базы данных KillDB в SQL Server.
    Основные функции:
    - Выполнение операций SHRINKFILE для журнала
    - Примеры команд для резервного копирования и смены режима восстановления
    - Демонстрация способов освобождения места в журнале
*/
USE KillDB
GO
DBCC SHRINKFILE (N'KillDB_log' , EMPTYFILE)
DBCC SHRINKFILE (N'KillDB_log' , 10)

/*
    --ALTER DATABASE KillDB SET RECOVERY FULL
    BACKUP LOG KillDB TO DISK = 'KillDB.trn' WITH INIT, COMPRESSION

    --ALTER DATABASE KillDB SET RECOVERY SIMPLE
    CHECKPOINT
*/