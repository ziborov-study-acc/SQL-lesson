USE FlowerDb;

--Хранимую процедуру, которая закрывает поставку: 
--проставляет статус поставки, дату закрытия текущую. 
--Снять нужное количество у плантации и добавить к запасам на складе.
GO
CREATE PROCEDURE CloseSupply 
	@SupplyId INT AS 
	BEGIN 
	IF  (SELECT COUNT(Supply.Id) FROM Supply WHERE Supply.Id = @SupplyId) > 0
		BEGIN
			IF (SELECT Supply.Status FROM Supply WHERE Supply.Id = @SupplyId) = 'InProgress' 
				BEGIN
					UPDATE Supply
					SET ClosedDate = GETDATE(), Status = 'Closed'
					WHERE Supply.Id = @SupplyId;

						DECLARE @SupplyWarehouseID INT,@SupplyPlantationId INT;--INT,@SupplyFlowerId INT,@SupplyAmount INT;

						SET @SupplyWarehouseID = (SELECT Supply.WarehouseId  FROM Supply WHERE Supply.Id = @SupplyId);
						SET @SupplyPlantationId = (SELECT Supply.PlantationId FROM Supply WHERE Supply.Id = @SupplyId);

						UPDATE WarehouseFlower
						SET Amount = Amount + (SELECT PlantationFlower.Amount FROM PlantationFlower WHERE PlantationFlower.FlowerId =  FlowerId AND PlantationFlower.PlantationId = @SupplyPlantationId)
						WHERE WarehouseId = @SupplyWarehouseID;

						UPDATE PlantationFlower
						SET Amount = Amount - (SELECT SupplyFlower.Amount FROM SupplyFlower WHERE SupplyFlower.FlowerId = FlowerId AND SupplyFlower.SupplyId = @SupplyId)
						WHERE PlantationFlower.PlantationId = @SupplyPlantationId;
				END
		END
	END;