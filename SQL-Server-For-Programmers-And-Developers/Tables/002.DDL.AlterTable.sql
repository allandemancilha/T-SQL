USE SalesDB;
GO

-- Aplicando ALTER TABLER P/ Remover CONSTRAINT CHECK Gender: M/F
ALTER TABLE dbo.Customer DROP CONSTRAINT CHK_Customer_Gender 

-- Testando Remoção de CONSTRAINT CHECK Inserindo Valor Gender: Z
INSERT INTO dbo.Customer (FirstName, Age, Gender, BirthDate, RegistrationDate, CurrentDate, Note) 
VALUES ('Allan', 22, 'Z', CAST('1999-02-02' AS DATE), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Teste') 

SELECT Id, FirstName, Age, Gender, Address, BirthDate, RegistrationDate, CurrentDate, Note, CustomerGuid 
  FROM dbo.Customer 


-- Aplicando ALTER TABLER P/ Remover CONSTRAINT DEFAULT Note: N/A
ALTER TABLE dbo.Customer DROP CONSTRAINT DFT_Customer_Note 

INSERT INTO dbo.Customer (FirstName, Age, Gender, BirthDate, RegistrationDate, CurrentDate, Note) 
VALUES ('Allan', 24, 'Z', CAST('1985-09-28' AS DATE), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Teste') 

INSERT INTO dbo.Customer (FirstName, Age, Gender, BirthDate, RegistrationDate, CurrentDate, Note) 
VALUES ('Allan', 24, 'Z', CAST('1985-09-28' AS DATE), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL) 

INSERT INTO dbo.Customer (FirstName, Age, Gender, BirthDate, RegistrationDate, CurrentDate) 
VALUES ('Allan', 24, 'Z', CAST('1985-09-28' AS DATE), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP) 

SELECT Id, FirstName, Age, Gender, Address, BirthDate, RegistrationDate, CurrentDate, Note, CustomerGuid 
  FROM dbo.Customer 

/*
Demonstração de Alterações na Estrutura da Tabela dbo.Customer, P/ Remover CONSTRAINT NULL Note
*/

ALTER TABLE dbo.Customer ALTER COLUMN Note VARCHAR(100) NULL 

INSERT INTO dbo.Customer (FirstName, Age, Gender, BirthDate, RegistrationDate, CurrentDate, Note) 
VALUES ('Allan', 24, 'Z', CAST('1985-09-28' AS DATE), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 'Teste') 

INSERT INTO dbo.Customer (FirstName, Age, Gender, BirthDate, RegistrationDate, CurrentDate, Note) 
VALUES ('Allan', 24, 'Z', CAST('1985-09-28' AS DATE), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, NULL) 

INSERT INTO dbo.Customer (FirstName, Age, Gender, BirthDate, RegistrationDate, CurrentDate) 
VALUES ('Allan', 24, 'Z', CAST('1985-09-28' AS DATE), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP) 

SELECT Id, FirstName, Age, Gender, Address, BirthDate, RegistrationDate, CurrentDate, Note, CustomerGuid 
  FROM dbo.Customer 

/*
Demonstração de Alterações na Estrutura da Tabela dbo.Customer, P/ Restrição CONSTRAINT NOT NULL na Coluna Note
*/

ALTER TABLE dbo.Customer ALTER COLUMN Gender INT NULL 

/*
Demonstração de Alterações na Estrutura da Tabela dbo.Customer, Cuidado ao Tentar Efetuar Esta Alteração Sem Remover o CHECK Antes
*/

ALTER TABLE dbo.Customer ALTER COLUMN Age BIT NULL  