USE FlowerDb;

--Функцию, которая проверяет, можно ли создать поставку 
--с определенным количеством цветов определенного типа из определённой плантации.
--Т.е. хватает ли на плантации количества цветов с учетом того, что до того, как поставка закрыта,
--количество цветов на плантации остается неизменным. После закрытия поставки количество цветов на плантации уменьшается.
--Входящие параметры: Id вида цветов, Id плантации, количество. Возвращаемое значение в формате true/false.


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


