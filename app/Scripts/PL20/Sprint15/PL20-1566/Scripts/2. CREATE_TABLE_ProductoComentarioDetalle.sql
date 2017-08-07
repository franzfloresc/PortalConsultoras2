
USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentarioDetalle')
BEGIN
  DROP TABLE dbo.ProductoComentarioDetalle
END
GO

CREATE TABLE dbo.ProductoComentarioDetalle
(
	ProdComentarioDetalleId BIGINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ProdComentarioId INT NOT NULL,
	Valorizado TINYINT NOT NULL,
	Recomendado BIT NOT NULL,
	Comentario VARCHAR(400) NULL,
	CodigoConsultora VARCHAR(20) NOT NULL,
	CampaniaID INT NOT NULL,
	FechaRegistro DATETIME NOT NULL,
	FechaAprobacion DATETIME NULL,
	CodTipoOrigen INT NULL,
	Estado TINYINT NOT NULL,
	CONSTRAINT FK_ProdComentarioId FOREIGN KEY (ProdComentarioId)
    REFERENCES ProductoComentario(ProdComentarioId)
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentarioDetalle_Estado
ON ProductoComentarioDetalle (Estado); 

GO
/*end*/

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentarioDetalle')
BEGIN
  DROP TABLE dbo.ProductoComentarioDetalle
END
GO

CREATE TABLE dbo.ProductoComentarioDetalle
(
	ProdComentarioDetalleId BIGINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ProdComentarioId INT NOT NULL,
	Valorizado TINYINT NOT NULL,
	Recomendado BIT NOT NULL,
	Comentario VARCHAR(400) NULL,
	CodigoConsultora VARCHAR(20) NOT NULL,
	CampaniaID INT NOT NULL,
	FechaRegistro DATETIME NOT NULL,
	FechaAprobacion DATETIME NULL,
	CodTipoOrigen INT NULL,
	Estado TINYINT NOT NULL,
	CONSTRAINT FK_ProdComentarioId FOREIGN KEY (ProdComentarioId)
    REFERENCES ProductoComentario(ProdComentarioId)
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentarioDetalle_Estado
ON ProductoComentarioDetalle (Estado); 

GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentarioDetalle')
BEGIN
  DROP TABLE dbo.ProductoComentarioDetalle
END
GO

CREATE TABLE dbo.ProductoComentarioDetalle
(
	ProdComentarioDetalleId BIGINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ProdComentarioId INT NOT NULL,
	Valorizado TINYINT NOT NULL,
	Recomendado BIT NOT NULL,
	Comentario VARCHAR(400) NULL,
	CodigoConsultora VARCHAR(20) NOT NULL,
	CampaniaID INT NOT NULL,
	FechaRegistro DATETIME NOT NULL,
	FechaAprobacion DATETIME NULL,
	CodTipoOrigen INT NULL,
	Estado TINYINT NOT NULL,
	CONSTRAINT FK_ProdComentarioId FOREIGN KEY (ProdComentarioId)
    REFERENCES ProductoComentario(ProdComentarioId)
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentarioDetalle_Estado
ON ProductoComentarioDetalle (Estado); 

GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentarioDetalle')
BEGIN
  DROP TABLE dbo.ProductoComentarioDetalle
END
GO

CREATE TABLE dbo.ProductoComentarioDetalle
(
	ProdComentarioDetalleId BIGINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ProdComentarioId INT NOT NULL,
	Valorizado TINYINT NOT NULL,
	Recomendado BIT NOT NULL,
	Comentario VARCHAR(400) NULL,
	CodigoConsultora VARCHAR(20) NOT NULL,
	CampaniaID INT NOT NULL,
	FechaRegistro DATETIME NOT NULL,
	FechaAprobacion DATETIME NULL,
	CodTipoOrigen INT NULL,
	Estado TINYINT NOT NULL,
	CONSTRAINT FK_ProdComentarioId FOREIGN KEY (ProdComentarioId)
    REFERENCES ProductoComentario(ProdComentarioId)
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentarioDetalle_Estado
ON ProductoComentarioDetalle (Estado); 

GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentarioDetalle')
BEGIN
  DROP TABLE dbo.ProductoComentarioDetalle
END
GO

CREATE TABLE dbo.ProductoComentarioDetalle
(
	ProdComentarioDetalleId BIGINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ProdComentarioId INT NOT NULL,
	Valorizado TINYINT NOT NULL,
	Recomendado BIT NOT NULL,
	Comentario VARCHAR(400) NULL,
	CodigoConsultora VARCHAR(20) NOT NULL,
	CampaniaID INT NOT NULL,
	FechaRegistro DATETIME NOT NULL,
	FechaAprobacion DATETIME NULL,
	CodTipoOrigen INT NULL,
	Estado TINYINT NOT NULL,
	CONSTRAINT FK_ProdComentarioId FOREIGN KEY (ProdComentarioId)
    REFERENCES ProductoComentario(ProdComentarioId)
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentarioDetalle_Estado
ON ProductoComentarioDetalle (Estado); 

GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentarioDetalle')
BEGIN
  DROP TABLE dbo.ProductoComentarioDetalle
END
GO

CREATE TABLE dbo.ProductoComentarioDetalle
(
	ProdComentarioDetalleId BIGINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ProdComentarioId INT NOT NULL,
	Valorizado TINYINT NOT NULL,
	Recomendado BIT NOT NULL,
	Comentario VARCHAR(400) NULL,
	CodigoConsultora VARCHAR(20) NOT NULL,
	CampaniaID INT NOT NULL,
	FechaRegistro DATETIME NOT NULL,
	FechaAprobacion DATETIME NULL,
	CodTipoOrigen INT NULL,
	Estado TINYINT NOT NULL,
	CONSTRAINT FK_ProdComentarioId FOREIGN KEY (ProdComentarioId)
    REFERENCES ProductoComentario(ProdComentarioId)
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentarioDetalle_Estado
ON ProductoComentarioDetalle (Estado); 

GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentarioDetalle')
BEGIN
  DROP TABLE dbo.ProductoComentarioDetalle
END
GO

CREATE TABLE dbo.ProductoComentarioDetalle
(
	ProdComentarioDetalleId BIGINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ProdComentarioId INT NOT NULL,
	Valorizado TINYINT NOT NULL,
	Recomendado BIT NOT NULL,
	Comentario VARCHAR(400) NULL,
	CodigoConsultora VARCHAR(20) NOT NULL,
	CampaniaID INT NOT NULL,
	FechaRegistro DATETIME NOT NULL,
	FechaAprobacion DATETIME NULL,
	CodTipoOrigen INT NULL,
	Estado TINYINT NOT NULL,
	CONSTRAINT FK_ProdComentarioId FOREIGN KEY (ProdComentarioId)
    REFERENCES ProductoComentario(ProdComentarioId)
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentarioDetalle_Estado
ON ProductoComentarioDetalle (Estado); 

GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentarioDetalle')
BEGIN
  DROP TABLE dbo.ProductoComentarioDetalle
END
GO

CREATE TABLE dbo.ProductoComentarioDetalle
(
	ProdComentarioDetalleId BIGINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ProdComentarioId INT NOT NULL,
	Valorizado TINYINT NOT NULL,
	Recomendado BIT NOT NULL,
	Comentario VARCHAR(400) NULL,
	CodigoConsultora VARCHAR(20) NOT NULL,
	CampaniaID INT NOT NULL,
	FechaRegistro DATETIME NOT NULL,
	FechaAprobacion DATETIME NULL,
	CodTipoOrigen INT NULL,
	Estado TINYINT NOT NULL,
	CONSTRAINT FK_ProdComentarioId FOREIGN KEY (ProdComentarioId)
    REFERENCES ProductoComentario(ProdComentarioId)
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentarioDetalle_Estado
ON ProductoComentarioDetalle (Estado); 

GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentarioDetalle')
BEGIN
  DROP TABLE dbo.ProductoComentarioDetalle
END
GO

CREATE TABLE dbo.ProductoComentarioDetalle
(
	ProdComentarioDetalleId BIGINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ProdComentarioId INT NOT NULL,
	Valorizado TINYINT NOT NULL,
	Recomendado BIT NOT NULL,
	Comentario VARCHAR(400) NULL,
	CodigoConsultora VARCHAR(20) NOT NULL,
	CampaniaID INT NOT NULL,
	FechaRegistro DATETIME NOT NULL,
	FechaAprobacion DATETIME NULL,
	CodTipoOrigen INT NULL,
	Estado TINYINT NOT NULL,
	CONSTRAINT FK_ProdComentarioId FOREIGN KEY (ProdComentarioId)
    REFERENCES ProductoComentario(ProdComentarioId)
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentarioDetalle_Estado
ON ProductoComentarioDetalle (Estado); 

GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentarioDetalle')
BEGIN
  DROP TABLE dbo.ProductoComentarioDetalle
END
GO

CREATE TABLE dbo.ProductoComentarioDetalle
(
	ProdComentarioDetalleId BIGINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ProdComentarioId INT NOT NULL,
	Valorizado TINYINT NOT NULL,
	Recomendado BIT NOT NULL,
	Comentario VARCHAR(400) NULL,
	CodigoConsultora VARCHAR(20) NOT NULL,
	CampaniaID INT NOT NULL,
	FechaRegistro DATETIME NOT NULL,
	FechaAprobacion DATETIME NULL,
	CodTipoOrigen INT NULL,
	Estado TINYINT NOT NULL,
	CONSTRAINT FK_ProdComentarioId FOREIGN KEY (ProdComentarioId)
    REFERENCES ProductoComentario(ProdComentarioId)
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentarioDetalle_Estado
ON ProductoComentarioDetalle (Estado); 

GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentarioDetalle')
BEGIN
  DROP TABLE dbo.ProductoComentarioDetalle
END
GO

CREATE TABLE dbo.ProductoComentarioDetalle
(
	ProdComentarioDetalleId BIGINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ProdComentarioId INT NOT NULL,
	Valorizado TINYINT NOT NULL,
	Recomendado BIT NOT NULL,
	Comentario VARCHAR(400) NULL,
	CodigoConsultora VARCHAR(20) NOT NULL,
	CampaniaID INT NOT NULL,
	FechaRegistro DATETIME NOT NULL,
	FechaAprobacion DATETIME NULL,
	CodTipoOrigen INT NULL,
	Estado TINYINT NOT NULL,
	CONSTRAINT FK_ProdComentarioId FOREIGN KEY (ProdComentarioId)
    REFERENCES ProductoComentario(ProdComentarioId)
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentarioDetalle_Estado
ON ProductoComentarioDetalle (Estado); 

GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentarioDetalle')
BEGIN
  DROP TABLE dbo.ProductoComentarioDetalle
END
GO

CREATE TABLE dbo.ProductoComentarioDetalle
(
	ProdComentarioDetalleId BIGINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ProdComentarioId INT NOT NULL,
	Valorizado TINYINT NOT NULL,
	Recomendado BIT NOT NULL,
	Comentario VARCHAR(400) NULL,
	CodigoConsultora VARCHAR(20) NOT NULL,
	CampaniaID INT NOT NULL,
	FechaRegistro DATETIME NOT NULL,
	FechaAprobacion DATETIME NULL,
	CodTipoOrigen INT NULL,
	Estado TINYINT NOT NULL,
	CONSTRAINT FK_ProdComentarioId FOREIGN KEY (ProdComentarioId)
    REFERENCES ProductoComentario(ProdComentarioId)
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentarioDetalle_Estado
ON ProductoComentarioDetalle (Estado); 

GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'ProductoComentarioDetalle')
BEGIN
  DROP TABLE dbo.ProductoComentarioDetalle
END
GO

CREATE TABLE dbo.ProductoComentarioDetalle
(
	ProdComentarioDetalleId BIGINT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ProdComentarioId INT NOT NULL,
	Valorizado TINYINT NOT NULL,
	Recomendado BIT NOT NULL,
	Comentario VARCHAR(400) NULL,
	CodigoConsultora VARCHAR(20) NOT NULL,
	CampaniaID INT NOT NULL,
	FechaRegistro DATETIME NOT NULL,
	FechaAprobacion DATETIME NULL,
	CodTipoOrigen INT NULL,
	Estado TINYINT NOT NULL,
	CONSTRAINT FK_ProdComentarioId FOREIGN KEY (ProdComentarioId)
    REFERENCES ProductoComentario(ProdComentarioId)
)
GO

CREATE NONCLUSTERED INDEX IX_ProdComentarioDetalle_Estado
ON ProductoComentarioDetalle (Estado); 
