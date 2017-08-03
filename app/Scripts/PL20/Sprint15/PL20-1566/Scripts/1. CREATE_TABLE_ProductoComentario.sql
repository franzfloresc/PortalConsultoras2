
USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentario')
BEGIN
  DROP TABLE dbo.ProductoComentario
END
GO

CREATE TABLE dbo.ProductoComentario
(
	ProdComentarioId INT PRIMARY KEY IDENTITY(1,1) NOT NULL, 	
	CodigoSap VARCHAR(20) NOT NULL,
	CodigoGenerico VARCHAR(20) NULL,
	CantAprobados INT NULL,
	CantRecomendados INT NULL,
	PromValorizado INT NULL,
	FechaRegistro DATETIME NOT NULL,
	Estado TINYINT NOT NULL
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentario_CodigoSap   
ON ProductoComentario (CodigoSap);

GO
/*end*/

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentario')
BEGIN
  DROP TABLE dbo.ProductoComentario
END
GO

CREATE TABLE dbo.ProductoComentario
(
	ProdComentarioId INT PRIMARY KEY IDENTITY(1,1) NOT NULL, 	
	CodigoSap VARCHAR(20) NOT NULL,
	CodigoGenerico VARCHAR(20) NULL,
	CantAprobados INT NULL,
	CantRecomendados INT NULL,
	PromValorizado INT NULL,
	FechaRegistro DATETIME NOT NULL,
	Estado TINYINT NOT NULL
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentario_CodigoSap   
ON ProductoComentario (CodigoSap);

GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentario')
BEGIN
  DROP TABLE dbo.ProductoComentario
END
GO

CREATE TABLE dbo.ProductoComentario
(
	ProdComentarioId INT PRIMARY KEY IDENTITY(1,1) NOT NULL, 	
	CodigoSap VARCHAR(20) NOT NULL,
	CodigoGenerico VARCHAR(20) NULL,
	CantAprobados INT NULL,
	CantRecomendados INT NULL,
	PromValorizado INT NULL,
	FechaRegistro DATETIME NOT NULL,
	Estado TINYINT NOT NULL
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentario_CodigoSap   
ON ProductoComentario (CodigoSap);

GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentario')
BEGIN
  DROP TABLE dbo.ProductoComentario
END
GO

CREATE TABLE dbo.ProductoComentario
(
	ProdComentarioId INT PRIMARY KEY IDENTITY(1,1) NOT NULL, 	
	CodigoSap VARCHAR(20) NOT NULL,
	CodigoGenerico VARCHAR(20) NULL,
	CantAprobados INT NULL,
	CantRecomendados INT NULL,
	PromValorizado INT NULL,
	FechaRegistro DATETIME NOT NULL,
	Estado TINYINT NOT NULL
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentario_CodigoSap   
ON ProductoComentario (CodigoSap);

GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentario')
BEGIN
  DROP TABLE dbo.ProductoComentario
END
GO

CREATE TABLE dbo.ProductoComentario
(
	ProdComentarioId INT PRIMARY KEY IDENTITY(1,1) NOT NULL, 	
	CodigoSap VARCHAR(20) NOT NULL,
	CodigoGenerico VARCHAR(20) NULL,
	CantAprobados INT NULL,
	CantRecomendados INT NULL,
	PromValorizado INT NULL,
	FechaRegistro DATETIME NOT NULL,
	Estado TINYINT NOT NULL
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentario_CodigoSap   
ON ProductoComentario (CodigoSap);

GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentario')
BEGIN
  DROP TABLE dbo.ProductoComentario
END
GO

CREATE TABLE dbo.ProductoComentario
(
	ProdComentarioId INT PRIMARY KEY IDENTITY(1,1) NOT NULL, 	
	CodigoSap VARCHAR(20) NOT NULL,
	CodigoGenerico VARCHAR(20) NULL,
	CantAprobados INT NULL,
	CantRecomendados INT NULL,
	PromValorizado INT NULL,
	FechaRegistro DATETIME NOT NULL,
	Estado TINYINT NOT NULL
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentario_CodigoSap   
ON ProductoComentario (CodigoSap);

GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentario')
BEGIN
  DROP TABLE dbo.ProductoComentario
END
GO

CREATE TABLE dbo.ProductoComentario
(
	ProdComentarioId INT PRIMARY KEY IDENTITY(1,1) NOT NULL, 	
	CodigoSap VARCHAR(20) NOT NULL,
	CodigoGenerico VARCHAR(20) NULL,
	CantAprobados INT NULL,
	CantRecomendados INT NULL,
	PromValorizado INT NULL,
	FechaRegistro DATETIME NOT NULL,
	Estado TINYINT NOT NULL
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentario_CodigoSap   
ON ProductoComentario (CodigoSap);

GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentario')
BEGIN
  DROP TABLE dbo.ProductoComentario
END
GO

CREATE TABLE dbo.ProductoComentario
(
	ProdComentarioId INT PRIMARY KEY IDENTITY(1,1) NOT NULL, 	
	CodigoSap VARCHAR(20) NOT NULL,
	CodigoGenerico VARCHAR(20) NULL,
	CantAprobados INT NULL,
	CantRecomendados INT NULL,
	PromValorizado INT NULL,
	FechaRegistro DATETIME NOT NULL,
	Estado TINYINT NOT NULL
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentario_CodigoSap   
ON ProductoComentario (CodigoSap);

GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentario')
BEGIN
  DROP TABLE dbo.ProductoComentario
END
GO

CREATE TABLE dbo.ProductoComentario
(
	ProdComentarioId INT PRIMARY KEY IDENTITY(1,1) NOT NULL, 	
	CodigoSap VARCHAR(20) NOT NULL,
	CodigoGenerico VARCHAR(20) NULL,
	CantAprobados INT NULL,
	CantRecomendados INT NULL,
	PromValorizado INT NULL,
	FechaRegistro DATETIME NOT NULL,
	Estado TINYINT NOT NULL
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentario_CodigoSap   
ON ProductoComentario (CodigoSap);

GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentario')
BEGIN
  DROP TABLE dbo.ProductoComentario
END
GO

CREATE TABLE dbo.ProductoComentario
(
	ProdComentarioId INT PRIMARY KEY IDENTITY(1,1) NOT NULL, 	
	CodigoSap VARCHAR(20) NOT NULL,
	CodigoGenerico VARCHAR(20) NULL,
	CantAprobados INT NULL,
	CantRecomendados INT NULL,
	PromValorizado INT NULL,
	FechaRegistro DATETIME NOT NULL,
	Estado TINYINT NOT NULL
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentario_CodigoSap   
ON ProductoComentario (CodigoSap);

GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentario')
BEGIN
  DROP TABLE dbo.ProductoComentario
END
GO

CREATE TABLE dbo.ProductoComentario
(
	ProdComentarioId INT PRIMARY KEY IDENTITY(1,1) NOT NULL, 	
	CodigoSap VARCHAR(20) NOT NULL,
	CodigoGenerico VARCHAR(20) NULL,
	CantAprobados INT NULL,
	CantRecomendados INT NULL,
	PromValorizado INT NULL,
	FechaRegistro DATETIME NOT NULL,
	Estado TINYINT NOT NULL
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentario_CodigoSap   
ON ProductoComentario (CodigoSap);

GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentario')
BEGIN
  DROP TABLE dbo.ProductoComentario
END
GO

CREATE TABLE dbo.ProductoComentario
(
	ProdComentarioId INT PRIMARY KEY IDENTITY(1,1) NOT NULL, 	
	CodigoSap VARCHAR(20) NOT NULL,
	CodigoGenerico VARCHAR(20) NULL,
	CantAprobados INT NULL,
	CantRecomendados INT NULL,
	PromValorizado INT NULL,
	FechaRegistro DATETIME NOT NULL,
	Estado TINYINT NOT NULL
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentario_CodigoSap   
ON ProductoComentario (CodigoSap);

GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentario')
BEGIN
  DROP TABLE dbo.ProductoComentario
END
GO

CREATE TABLE dbo.ProductoComentario
(
	ProdComentarioId INT PRIMARY KEY IDENTITY(1,1) NOT NULL, 	
	CodigoSap VARCHAR(20) NOT NULL,
	CodigoGenerico VARCHAR(20) NULL,
	CantAprobados INT NULL,
	CantRecomendados INT NULL,
	PromValorizado INT NULL,
	FechaRegistro DATETIME NOT NULL,
	Estado TINYINT NOT NULL
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentario_CodigoSap   
ON ProductoComentario (CodigoSap);
