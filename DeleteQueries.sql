USE FlowerDb;

-- ������� ������ � ���� ������ �� ����������� ���������;

DELETE FROM PlantationFlower
WHERE PlantationFlower.PlantationId =1 AND PlantationFlower.FlowerId = 2 ;

-- ������� ������ � ���� ������ �� ���� ��.
--� �������� ������� �������� ������� ���� ���������� �������� ����� ��������� ������� ���������� �������� ON DELETE CASCADE
DELETE FROM Flower
WHERE Flower.Id = 2;