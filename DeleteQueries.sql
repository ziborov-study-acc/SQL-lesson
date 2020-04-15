USE FlowerDb;

-- удалить данные о виде цветов на опредленной плантации;

DELETE FROM PlantationFlower
WHERE PlantationFlower.PlantationId =1 AND PlantationFlower.FlowerId = 2 ;

-- удалить данные о виде цветов из всей БД.
--В таблицах которые содержат внешний ключ удаляемого значения нужно поставить правило каскадного удаления ON DELETE CASCADE
DELETE FROM Flower
WHERE Flower.Id = 2;