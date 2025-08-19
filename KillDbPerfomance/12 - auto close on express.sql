
/*
    Скрипт предназначен для проверки и демонстрации параметра AUTO_CLOSE для баз данных в SQL Server Express.
    Основные функции:
    - Получение значения параметра AUTO_CLOSE для системной и пользовательской базы
    - Создание и удаление тестовой базы данных
    - Анализ поведения параметра на разных базах
*/
USE [master]
GO
 
SELECT is_auto_close_on
FROM sys.databases
WHERE database_id = DB_ID('model')
GO

IF DB_ID('test') IS NOT NULL
        DROP DATABASE [test]
GO

CREATE DATABASE [test]
GO

SELECT is_auto_close_on
FROM sys.databases
WHERE database_id = DB_ID('test')
USE [master]
GO

SELECT is_auto_close_on
FROM sys.databases
WHERE database_id = DB_ID('model')
GO

IF DB_ID('test') IS NOT NULL
    DROP DATABASE [test]
GO

CREATE DATABASE [test]
GO

SELECT is_auto_close_on
FROM sys.databases
WHERE database_id = DB_ID('test')