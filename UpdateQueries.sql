USE FlowerDb;

--��������� ���������� ������ � ��������.

UPDATE SupplyFlower
SET Amount = 999
WHERE SupplyFlower.SupplyId = 2 AND SupplyFlower.FlowerId=4;