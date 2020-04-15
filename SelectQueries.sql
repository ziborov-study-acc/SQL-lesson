Use FlowerDb;

-- - список плантаций;
SELECT * FROM Plantation

--- данные по плантации: список цветов и их количество.
--   Столбцы в результате: Id плантации, имя , адрес,имя вида цветов,количество;
SELECT Plantation.Id AS [Plantation Id],
	   Plantation.Name AS [Plantation Name],
	   Plantation.Address AS [Address],
	   Flower.Name AS [Flower Name],
	   PlantationFlower.Amount AS [Amount]
FROM Plantation,PlantationFlower
LEFT JOIN Flower ON Flower.Id = PlantationFlower.FlowerId
WHERE Plantation.Id = PlantationFlower.PlantationId
;


-- - данные по видам цветов: для каждого вида количество плантаций, на которых есть цветы данного вида. 
--   Столбцы в результате: Id вида цветов, имя, количество плантаций (должно выводиться имя столбца "Plantations number");
SELECT *,
	(SELECT COUNT(*) FROM PlantationFlower WHERE PlantationFlower.FlowerId = Flower.Id) AS [Plantations number]
FROM Flower

-- - данные по видам цветов: для каждого вида количество плантаций, на которых есть цветы данного вида в количестве больше 1000.
--   Столбцы, как и в предыдущем пункте;

SELECT Flower.Id,Flower.Name , COUNT(PlantationFlower.FlowerId) AS [Plantations number]
FROM Flower
JOIN PlantationFlower ON Flower.Id = PlantationFlower.FlowerId
WHERE PlantationFlower.Amount > 1000
GROUP BY Flower.Id,Flower.Name;


-- данные по поставкам: список цветов и их количество (общее по каждому виду), поставки которых назначены из определенной плантации.
--Столбцы в результате: Id вида цветов, имя, количество. Это будут данные по какой-то одной плантации;

SELECT SupplyFlower.FlowerId AS [Flower Id],
	   Flower.Name AS [Flower Name],
	   SupplyFlower.Amount AS [Amount]
FROM SupplyFlower
JOIN Supply ON Supply.Id = SupplyFlower.SupplyId
JOIN Flower ON Flower.Id = SupplyFlower.FlowerId
WHERE Supply.PlantationId = 2 -- Plantation Id

-- - данные по поставкам: успешно выполненные поставки за последний месяц.
--   Столбцы в результате: Id поставки, имя плантации, имя склада, дата выполнения поставки.

SELECT Supply.Id AS [Supply Id],
	   Plantation.Name AS [Plantation name],
	   Warehouse.Name AS [Warehouse name],
	   Supply.ClosedDate AS [Closed date]
FROM Supply
JOIN Plantation ON Plantation.Id = Supply.PlantationId
JOIN Warehouse ON Warehouse.Id = Supply.WarehouseId
WHERE Supply.Status = 'Closed'