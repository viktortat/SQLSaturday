/*
 Скрипт предназначен для демонстрации различий между типами данных CHAR и VARCHAR, а также особенностей их сравнения и хранения в SQL Server.
 Основные функции:
 - Сравнение длины и размера данных для CHAR и VARCHAR.
 - Анализ поведения операторов сравнения и LIKE для разных типов.
 - Примеры влияния пробелов и формата на результат сравнения.
*/
DECLARE @a CHAR(20)    = 'text'
      , @b VARCHAR(20) = 'text'

SELECT LEN(@a)
     , LEN(@b)
     , DATALENGTH(@a)
     , DATALENGTH(@b)
     , '"' + @a + '"'
     , '"' + @b + '"'

SELECT [a = b] =    IIF(@a = @b, 'TRUE', 'FALSE')
     , [b = a] =    IIF(@b = @a, 'TRUE', 'FALSE')
     , [a LIKE b] = IIF(@a LIKE @b, 'TRUE', 'FALSE')
     , [b LIKE a] = IIF(@b LIKE @a, 'TRUE', 'FALSE')

------------------------------------------------------------------

SELECT 1
WHERE 'a ' LIKE 'a'

SELECT 1
WHERE 'a' LIKE 'a ' -- !!!

SELECT 1
WHERE 'a' LIKE 'a'

SELECT 1
WHERE 'a' LIKE 'a%'