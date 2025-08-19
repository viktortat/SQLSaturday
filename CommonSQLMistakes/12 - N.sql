/*
 Скрипт предназначен для демонстрации различий между строками ANSI и UNICODE, а также особенностей сравнения символов в SQL Server.
 Основные функции:
 - Сравнение строковых литералов с и без префикса N.
 - Анализ поведения при сравнении символов в разных кодировках и сортировках.
 - Примеры создания базы данных с различными COLLATE.
*/
SELECT '文本 ANSI'
    , N'文本 UNICODE'

------------------------------------------------------------------

DECLARE @a NCHAR(1) = 'Ё'
      , @b NCHAR(1) = 'Ф'

SELECT @a, @b
WHERE @a = @b
GO

------------------------------------------------------------------

USE [master]
GO

IF DB_ID('test') IS NOT NULL BEGIN
    ALTER DATABASE test SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE test
END
GO

CREATE DATABASE test
    COLLATE Latin1_General_100_CI_AS
    --COLLATE Cyrillic_General_100_CI_AS
GO

USE test
GO

DECLARE @a NCHAR(1) = 'Ё'
      , @b NCHAR(1) = 'Ф'

SELECT @a, @b
WHERE @a = @b