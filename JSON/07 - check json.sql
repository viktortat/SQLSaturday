/*
      Скрипт демонстрирует проверку корректности JSON-данных с помощью функции ISJSON в SQL Server.
      Основные функции:
      - Проверка различных вариантов строк на соответствие формату JSON
      - Создание таблицы с ограничением CHECK для JSON-данных
      - Примеры вставки и проверки данных
*/
DECLARE @json1 NVARCHAR(MAX) = N'{"id": 1}'
      , @json2 NVARCHAR(MAX) = N'[1,2,3]'
      , @json3 NVARCHAR(MAX) = N'1'
      , @json4 NVARCHAR(MAX) = N''
      , @json5 NVARCHAR(MAX) = NULL

SELECT ISJSON(@json1)
     , ISJSON(@json2)
     , ISJSON(@json3)
     , ISJSON(@json4)
     , ISJSON(@json5)


DROP TABLE IF EXISTS #JSON
GO

CREATE TABLE #JSON (
      ID INT IDENTITY PRIMARY KEY
    , UserData NVARCHAR(MAX) --NOT NULL
    , CONSTRAINT CK_IsJSON CHECK (ISJSON(UserData) = 1) -- NOT FALSE :)
)
GO

INSERT INTO #JSON VALUES (N'{"id": 1}')
INSERT INTO #JSON VALUES (N'erteter')
INSERT INTO #JSON VALUES (NULL)