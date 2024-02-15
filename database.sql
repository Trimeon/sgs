/*
Таблица Контейнеров с полями
i.    ИД - тип уникальный идентификатор
ii.    Номер - тип числовой
iii.    Тип – тип текстовый
iv.    Длина – тип числовой
v.    Ширина – тип числовой
vi.    Высота – тип числовой
vii.    Вес – тип числовой
viii.    Пустой/не пустой – тип бит
ix.    Дата поступления – тип дата/время
*/

CREATE TABLE Containers (
    id UNIQUEIDENTIFIER PRIMARY KEY,
    Number INT,
    Type NVARCHAR(255),
    Length INT,
    Width INT,
    Height INT,
    Weight INT,
    Empty_NotEmpty BIT,
    DateOfArrival DATETIME
);

/*
Таблица операций с полями:
i.    ИД - тип уникальный идентификатор
ii.    ИД Контейнера - тип уникальный идентификатор
iii.    Дата начала операции – тип дата/время
iv.    Дата окончания операции – тип дата/время
v.    Тип операции - тип текстовый
vi.    ФИО оператора - тип текстовый
vii.    Место инспекции - тип текстовый
*/

CREATE TABLE Operations (
    id UNIQUEIDENTIFIER PRIMARY KEY,
    ContainerId UNIQUEIDENTIFIER,
    StartDate DATETIME,
    EndDate DATETIME,
    OperationType NVARCHAR(255),
    OperatorFullName NVARCHAR(255),
    InspectionLocation NVARCHAR(255),
    FOREIGN KEY (ContainerId) REFERENCES Containers(id)
);

-- Напишите запрос, выбирающий из первой таблицы все данные по контейнерам в формате JSON не используя встроенную функцию

SELECT 
    '{' +
    '"id": "' + CAST(id AS NVARCHAR(36)) + '", ' +
    '"Number": ' + CAST(Number AS NVARCHAR) + ', ' +
    '"Type": "' + REPLACE(Type, '"', '\"') + '", ' +
    '"Length": ' + CAST(Length AS NVARCHAR) + ', ' +
    '"Width": ' + CAST(Width AS NVARCHAR) + ', ' +
    '"Height": ' + CAST(Height AS NVARCHAR) + ', ' +
    '"Weight": ' + CAST(Weight AS NVARCHAR) + ', ' +
    '"Empty_NotEmpty": ' + (CASE WHEN Empty_NotEmpty = 1 THEN '"true"' ELSE '"false"' END) + ', ' +
    '"DateOfArrival": "' + FORMAT(DateOfArrival, 'yyyy-MM-dd HH:mm:ss') + '"' +
    '}' 
FROM Containers;

-- Напишите запрос, выбирающий из второй таблицы все данные по операциям для определенного контейнера в формате JSON не используя встроенную функцию

SELECT 
    '{' +
    '"ID": "' + CAST(ID AS NVARCHAR(36)) + '", ' +
    '"ContainerId": "' + CAST(ContainerId AS NVARCHAR(36)) + '", ' +
    '"StartDate": "' + FORMAT(StartDate, 'yyyy-MM-dd HH:mm:ss') + '", ' +
    '"EndDate": "' + FORMAT(EndDate, 'yyyy-MM-dd HH:mm:ss') + '", ' +
    '"OperationType": "' + REPLACE(OperationType, '"', '\"') + '", ' +
    '"OperatorFullName": "' + REPLACE(OperatorFullName, '"', '\"') + '", ' +
    '"InspectionLocation": "' + REPLACE(InspectionLocation, '"', '\"') + '"' +
    '}' 
FROM Operations 
WHERE ContainerId = 'specified_container_id';