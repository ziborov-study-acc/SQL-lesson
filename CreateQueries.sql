use FlowerDb;
GO

CREATE TABLE Flower(
	Id INT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(200) NOT NULL 
);

GO

CREATE TABLE Plantation(
	Id INT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(200) NOT NULL,
	[Address] NVARCHAR(200) NOT NULL 
);

GO

CREATE TABLE PlantationFlower(
	[PlantationId] INT FOREIGN KEY REFERENCES [Plantation](Id),
	[FlowerId] INT FOREIGN KEY REFERENCES [Flower](Id)
	ON DELETE CASCADE,
	[Amount] INT NOT NULL,
	CONSTRAINT [PK_PlantationFlower] PRIMARY KEY CLUSTERED([PlantationId] ASC,[FlowerId] ASC)
 
);

GO

CREATE TABLE Warehouse(
	Id INT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(200) NOT NULL,
	[Address] NVARCHAR(200) NOT NULL 
);

GO

CREATE TABLE WarehouseFlower(
	[WarehouseId] INT FOREIGN KEY REFERENCES [Warehouse](Id),
	[FlowerId] INT FOREIGN KEY REFERENCES [Flower](Id)
	ON DELETE CASCADE,
	[Amount] INT NOT NULL,
	CONSTRAINT [PK_WarehouseFlower] PRIMARY KEY CLUSTERED([WarehouseId] ASC,[FlowerId] ASC)
);


GO

CREATE TABLE Supply(
	Id INT PRIMARY KEY IDENTITY(1,1),
	[PlantationId] INT FOREIGN KEY REFERENCES [Plantation](Id),
	[WarehouseId] INT FOREIGN KEY REFERENCES [Warehouse](Id),
	[ScheduledDate] DATE,
	[ClosedDate] DATE,
	[Status] NVARCHAR(100) NOT NULL
);

GO

CREATE TABLE SupplyFlower(
	[SupplyId] INT FOREIGN KEY REFERENCES [Supply](Id),
	[FlowerId] INT FOREIGN KEY REFERENCES [Flower](Id)
	ON DELETE CASCADE,
	[Amount] INT NOT NULL
	CONSTRAINT [PK_SupplyFlower] PRIMARY KEY CLUSTERED([SupplyId] ASC,[FlowerId] ASC)
);
