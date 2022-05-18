USE master;
GO

DECLARE @DbName nvarchar(50), 
		@SqlExecuteCreate nvarchar(50),
		@SqlExecuteDrop nvarchar(50);
SET @DbName = 'SalesDB';
SET @SqlExecuteCreate = ('CREATE DATABASE'+ ' '+ @DbName);
SET @SqlExecuteDrop = ('DROP DATABASE'+ ' '+ @DbName);

IF EXISTS (SELECT * FROM sys.databases WHERE name = @DbName)
BEGIN
	EXEC sp_executesql @SqlExecuteDrop
    EXEC sp_executesql @SqlExecuteCreate
END
ELSE
BEGIN
	EXEC sp_executesql @SqlExecuteCreate
END

USE SalesDB;
GO

CREATE TABLE [dbo].[Customer]
(
	Id BIGINT IDENTITY(1, 1) NOT NULL, 
	FirstName VARCHAR(100) NOT NULL, 
	Age SMALLINT NOT NULL, 
	Gender CHAR(1) NOT NULL, 
	[Address] VARCHAR(250) NULL, 
	BirthDate DATE NULL, 
	RegistrationDate SMALLDATETIME NULL, 
	CurrentDate DATETIME NOT NULL, 
	Note VARCHAR(100) NOT NULL CONSTRAINT DFT_Customer_Note DEFAULT 'N/A', 
	CustomerGuid UNIQUEIDENTIFIER NOT NULL CONSTRAINT DFT_Customer_CustomerGuid DEFAULT NEWSEQUENTIALID(), 
	CONSTRAINT PK_Customer PRIMARY KEY CLUSTERED (Id), 
	CONSTRAINT CHK_Customer_Age CHECK (Age >= 0), 
	CONSTRAINT CHK_Customer_Gender CHECK(Gender IN ('F', 'M')) 
) 
GO

INSERT INTO dbo.Customer(FirstName, Age, Gender, BirthDate, RegistrationDate, CurrentDate, Note) 
VALUES ('Everton', 35, 'M', CAST('1985-09-28' AS DATE), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Teste') 

INSERT INTO dbo.Customer(FirstName, Age, Gender, BirthDate, RegistrationDate, CurrentDate, Note) 
VALUES ('Isabel', 35, 'F', CAST('1985-08-02' AS DATE), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Teste') 

INSERT INTO dbo.Customer(FirstName, Age, Gender, BirthDate, RegistrationDate, CurrentDate, Note) 
VALUES ('Teste', 35, 'M', CAST('1985-09-28' AS DATE), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Teste') 

--INSERT INTO dbo.Customer(FirstName, Age, Gender, BirthDate, RegistrationDate, CurrentDate, Note) 
--VALUES ('Everton', -1, 'M', CAST('1985-09-28' AS DATE), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Teste') 

--INSERT INTO dbo.Customer(FirstName, Age, Gender, BirthDate, RegistrationDate, CurrentDate, Note) 
--VALUES ('Everton', 35, 'Z', CAST('1985-09-28' AS DATE), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Teste') 

--INSERT INTO dbo.Customer(FirstName, Age, Gender, BirthDate, RegistrationDate, CurrentDate, Note) 
--VALUES ('Everton', 35, 'M', CAST('1985-09-28' AS DATE), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL) 

INSERT INTO dbo.Customer(FirstName, Age, Gender, BirthDate, RegistrationDate, CurrentDate) 
VALUES ('Everton', 35, 'M', CAST('1985-09-28' AS DATE), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP) 

SELECT Id, FirstName, Age, Gender, Address, BirthDate, RegistrationDate, CurrentDate, Note, CustomerGuid 
  FROM dbo.Customer With(NoLock)
GO

/*
Demonstração de FOREIGN KEY, UNIQUE Constraint e Coluna Computada
*/

CREATE TABLE [dbo].[Product] 
(
	Id TINYINT IDENTITY(1, 1) NOT NULL CONSTRAINT PK_Product PRIMARY KEY CLUSTERED, 
	Description VARCHAR(100) NOT NULL 
)
GO

INSERT INTO dbo.Product (Description) 
VALUES ('Product 1'), 
       ('Product 2') 
GO

SELECT Id, Description 
  FROM dbo.Product With(NoLock)  

CREATE TABLE [dbo].[Order]
(
	Id BIGINT IDENTITY(1, 1) NOT NULL, 
	Id_Customer BIGINT NOT NULL, 
	Id_Product TINYINT NOT NULL, 
	Amount INT NOT NULL, 
	UnitValue NUMERIC(9, 2) NOT NULL, 
	TotalValue AS Amount * UnitValue, 
	CONSTRAINT PK_Order PRIMARY KEY CLUSTERED (Id), 
	CONSTRAINT UC_Order UNIQUE(Id_Customer, Id_Product), 
	CONSTRAINT CHK_Order_Amount CHECK (Amount > 0), 
	CONSTRAINT CHK_Order_UnitValue CHECK (UnitValue > 0.0), 
	CONSTRAINT FK_Customer FOREIGN KEY (Id_Customer) REFERENCES dbo.Customer(Id), 
	CONSTRAINT FK_Product FOREIGN KEY (Id_Product) REFERENCES dbo.Product (Id) 
) 
GO

INSERT INTO [dbo].[Order] (Id_Customer, Id_Product, Amount, UnitValue) 
VALUES (1, 1, 10, 20), 
       (1, 2, 15, 25), 
	   (2, 1, 20, 30), 
	   (3, 1, 25, 35), 
	   (3, 2, 40, 55) 
GO

--INSERT INTO [dbo].[Order] (Id_Customer, Id_Product, Amount, UnitValue) 
--VALUES (1, 3, 10, 20)

INSERT INTO [dbo].[Order] (Id_Customer, Id_Product, Amount, UnitValue) 
VALUES (4, 1, 10, 20)

--INSERT INTO [dbo].[Order] (Id_Customer, Id_Product, Amount, UnitValue) 
--VALUES (1, 1, 10, 20)

SELECT Id, Id_Customer, Id_Product, Amount, UnitValue, TotalValue 
  FROM [dbo].[Order] With(NoLock)
GO
