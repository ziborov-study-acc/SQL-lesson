USE FlowerDb;

--�������, ������� ���������, ����� �� ������� �������� 
--� ������������ ����������� ������ ������������� ���� �� ����������� ���������.
--�.�. ������� �� �� ��������� ���������� ������ � ������ ����, ��� �� ����, ��� �������� �������,
--���������� ������ �� ��������� �������� ����������. ����� �������� �������� ���������� ������ �� ��������� �����������.
--�������� ���������: Id ���� ������, Id ���������, ����������. ������������ �������� � ������� true/false.


CREATE FUNCTION CanCreateSupply(@FlowerId INT,@PlantationId INT,@Amount INT)
	RETURNS BIT
BEGIN
	IF (SELECT COUNT(PlantationFlower.FlowerId) FROM PlantationFlower WHERE PlantationFlower.PlantationId = @PlantationId AND PlantationFlower.FlowerId =@FlowerId) = 0
		RETURN 0;
	DECLARE @FlowersOnPlantation INT;
	SET @FlowersOnPlantation = (SELECT PlantationFlower.Amount FROM PlantationFlower WHERE PlantationFlower.PlantationId = @PlantationId AND PlantationFlower.FlowerId = @FlowerId);

	IF (@FlowersOnPlantation - @Amount) < 0 
		RETURN 0;

	RETURN 1;
END;


