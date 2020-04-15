Use FlowerDb;

-- - ������ ���������;
SELECT * FROM Plantation

--- ������ �� ���������: ������ ������ � �� ����������.
--   ������� � ����������: Id ���������, ��� , �����,��� ���� ������,����������;
SELECT Plantation.Id AS [Plantation Id],
	   Plantation.Name AS [Plantation Name],
	   Plantation.Address AS [Address],
	   Flower.Name AS [Flower Name],
	   PlantationFlower.Amount AS [Amount]
FROM Plantation,PlantationFlower
LEFT JOIN Flower ON Flower.Id = PlantationFlower.FlowerId
WHERE Plantation.Id = PlantationFlower.PlantationId
;


-- - ������ �� ����� ������: ��� ������� ���� ���������� ���������, �� ������� ���� ����� ������� ����. 
--   ������� � ����������: Id ���� ������, ���, ���������� ��������� (������ ���������� ��� ������� "Plantations number");
SELECT *,
	(SELECT COUNT(*) FROM PlantationFlower WHERE PlantationFlower.FlowerId = Flower.Id) AS [Plantations number]
FROM Flower

-- - ������ �� ����� ������: ��� ������� ���� ���������� ���������, �� ������� ���� ����� ������� ���� � ���������� ������ 1000.
--   �������, ��� � � ���������� ������;

SELECT Flower.Id,Flower.Name , COUNT(PlantationFlower.FlowerId) AS [Plantations number]
FROM Flower
JOIN PlantationFlower ON Flower.Id = PlantationFlower.FlowerId
WHERE PlantationFlower.Amount > 1000
GROUP BY Flower.Id,Flower.Name;


-- ������ �� ���������: ������ ������ � �� ���������� (����� �� ������� ����), �������� ������� ��������� �� ������������ ���������.
--������� � ����������: Id ���� ������, ���, ����������. ��� ����� ������ �� �����-�� ����� ���������;

SELECT SupplyFlower.FlowerId AS [Flower Id],
	   Flower.Name AS [Flower Name],
	   SupplyFlower.Amount AS [Amount]
FROM SupplyFlower
JOIN Supply ON Supply.Id = SupplyFlower.SupplyId
JOIN Flower ON Flower.Id = SupplyFlower.FlowerId
WHERE Supply.PlantationId = 2 -- Plantation Id

-- - ������ �� ���������: ������� ����������� �������� �� ��������� �����.
--   ������� � ����������: Id ��������, ��� ���������, ��� ������, ���� ���������� ��������.

SELECT Supply.Id AS [Supply Id],
	   Plantation.Name AS [Plantation name],
	   Warehouse.Name AS [Warehouse name],
	   Supply.ClosedDate AS [Closed date]
FROM Supply
JOIN Plantation ON Plantation.Id = Supply.PlantationId
JOIN Warehouse ON Warehouse.Id = Supply.WarehouseId
WHERE Supply.Status = 'Closed'