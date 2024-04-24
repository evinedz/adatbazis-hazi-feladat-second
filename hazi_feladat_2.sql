--CREATION 

CREATE TABLE dbo.Vendeg (
	USERNEV nvarchar(20) NOT NULL,
	NEV nvarchar(50) NOT NULL,
	EMAIL nvarchar(60) MASKED WITH (FUNCTION = 'partial(1, "************", 4)') NOT NULL,
	SZAML_CIM nvarchar(100) MASKED WITH (FUNCTION = 'default()') NULL,
	SZUL_DAT date MASKED WITH (FUNCTION = 'random(1900-01-01, 2005-12-31)') NULL
);
GO

ALTER TABLE dbo.Vendeg ADD CONSTRAINT PK_Vendeg PRIMARY KEY (USERNEV);
GO


CREATE TABLE dbo.Szallashely (
	SZALLAS_ID int NOT NULL,
	SZALLAS_NEV nvarchar(50) NOT NULL,
	HELY nvarchar(20) NULL,
	CSILLAGOK_SZAMA int NULL,
	TIPUS nvarchar(50) NULL,
	ROGZITETTE nvarchar(20) NOT NULL,
	ROGZ_IDO date NOT NULL,
	CIM nvarchar(100) NULL
);
GO

ALTER TABLE dbo.Szallashely ADD CONSTRAINT PK_Szallashely PRIMARY KEY (SZALLAS_ID);
GO

CREATE TABLE dbo.Szoba (
	SZOBA_ID int NOT NULL,
	SZOBA_SZAMA nvarchar(20) NOT NULL,
	FEROHELY int NOT NULL,
	POTAGY int NULL,
	KLIMAS nvarchar(1) NULL,
	SZALLAS_FK int NULL
);
GO

ALTER TABLE dbo.Szoba ADD CONSTRAINT PK_Szoba PRIMARY KEY (SZOBA_ID);
GO


IF OBJECT_ID('dbo.Szallashely', 'U') IS NOT NULL AND OBJECT_ID('dbo.Szallashely', 'U') IS NOT NULL
	ALTER TABLE dbo.Szoba
	ADD CONSTRAINT FK_Szoba_Szallashely
	FOREIGN KEY (SZALLAS_FK)
	REFERENCES dbo.Szallashely (SZALLAS_ID);

CREATE TABLE dbo.Vendeg (
	USERNEV nvarchar(20) NOT NULL,
	NEV nvarchar(50) NOT NULL,
	EMAIL nvarchar(60) NOT NULL,
	SZAML_CIM nvarchar(100) NULL,
	SZUL_DAT date NULL
);
GO

ALTER TABLE dbo.Vendeg ADD CONSTRAINT PK_Vendeg PRIMARY KEY (USERNEV);
GO

-- User creation 1 masked 1 and unmasked user with select permission on dbo.Vendeg
CREATE USER MaskedUser WITHOUT LOGIN;
GRANT SELECT ON dbo.Vendeg TO MaskedUser;

	--- QUERIES
	--Random query 1 Returns masked data
	SELECT * FROM dbo.Vendeg;

CREATE USER UnMaskedUser WITHOUT LOGIN;
GRANT SELECT ON dbo.Vendeg TO UnMaskedUser;
GRANT UNMASK TO UnMaskedUser;

	--- QUERIES
	--Random query 2 Returns unmasked data
	SELECT * FROM dbo.Vendeg;

