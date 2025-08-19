DECLARE @json NVARCHAR(MAX) = N'
    {
        "UserID": 1,
        "UserName": "JC Denton"
    }'
/*
    Скрипт демонстрирует различия между режимами lax и strict при работе с JSON_VALUE в SQL Server.
    Основные функции:
    - Примеры извлечения данных с использованием lax и strict
    - Анализ поведения при отсутствии ключей
    - Демонстрация особенностей обработки JSON
*/
DECLARE @json NVARCHAR(MAX) = N'
        {
                "UserID": 1,
                "UserName": "JC Denton"
        }'

SELECT JSON_VALUE(@json, '$.IsActive')
     , JSON_VALUE(@json, 'lax$.IsActive')

SELECT JSON_VALUE(@json, 'strict$.UserName')

SELECT JSON_VALUE(@json, 'strict$.IsActive')