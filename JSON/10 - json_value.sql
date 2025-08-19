/*
   Скрипт демонстрирует использование функций JSON_VALUE и JSON_QUERY для извлечения данных из JSON в SQL Server.
   Основные функции:
   - Получение отдельных значений из JSON-объекта
   - Извлечение вложенных данных
   - Пример работы с массивами и свойствами JSON
*/
DECLARE @json NVARCHAR(MAX) = N'
    {
        "UserID": 1,
        "UserName": "JC Denton",
        "IsActive": true,
        "Date": "2016-05-31T00:00:00",
        "Settings": [
             {
                "Language": "EN"
             },
             {
                "Skin": "FlatUI"
             }
          ]
    }'

SELECT JSON_VALUE(@json, '$.UserID')
     , JSON_VALUE(@json, '$.UserName')
     , JSON_VALUE(@json, '$.Settings[0].Language')
     , JSON_VALUE(@json, '$.Settings[1].Skin')
     , JSON_QUERY(@json, '$.Settings')