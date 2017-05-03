
USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.IndicadorPedidoAutentico')
BEGIN
  DROP TABLE dbo.IndicadorPedidoAutentico
END
GO

CREATE TABLE IndicadorPedidoAutentico
(
	PedidoID INT NOT NULL,
	CampaniaID INT NOT NULL,
	PedidoDetalleID INT NOT NULL,
	IndicadorIPUsuario VARCHAR(30) NULL,
	IndicadorFingerprint VARCHAR(50) NULL,
	IndicadorToken VARCHAR(50) NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL,
	PRIMARY KEY(PedidoID,CampaniaID,PedidoDetalleID)
)
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.IndicadorPedidoAutentico')
BEGIN
  DROP TABLE dbo.IndicadorPedidoAutentico
END
GO

CREATE TABLE IndicadorPedidoAutentico
(
	PedidoID INT NOT NULL,
	CampaniaID INT NOT NULL,
	PedidoDetalleID INT NOT NULL,
	IndicadorIPUsuario VARCHAR(30) NULL,
	IndicadorFingerprint VARCHAR(50) NULL,
	IndicadorToken VARCHAR(50) NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL,
	PRIMARY KEY(PedidoID,CampaniaID,PedidoDetalleID)
)
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.IndicadorPedidoAutentico')
BEGIN
  DROP TABLE dbo.IndicadorPedidoAutentico
END
GO

CREATE TABLE IndicadorPedidoAutentico
(
	PedidoID INT NOT NULL,
	CampaniaID INT NOT NULL,
	PedidoDetalleID INT NOT NULL,
	IndicadorIPUsuario VARCHAR(30) NULL,
	IndicadorFingerprint VARCHAR(50) NULL,
	IndicadorToken VARCHAR(50) NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL,
	PRIMARY KEY(PedidoID,CampaniaID,PedidoDetalleID)
)
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.IndicadorPedidoAutentico')
BEGIN
  DROP TABLE dbo.IndicadorPedidoAutentico
END
GO

CREATE TABLE IndicadorPedidoAutentico
(
	PedidoID INT NOT NULL,
	CampaniaID INT NOT NULL,
	PedidoDetalleID INT NOT NULL,
	IndicadorIPUsuario VARCHAR(30) NULL,
	IndicadorFingerprint VARCHAR(50) NULL,
	IndicadorToken VARCHAR(50) NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL,
	PRIMARY KEY(PedidoID,CampaniaID,PedidoDetalleID)
)
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.IndicadorPedidoAutentico')
BEGIN
  DROP TABLE dbo.IndicadorPedidoAutentico
END
GO

CREATE TABLE IndicadorPedidoAutentico
(
	PedidoID INT NOT NULL,
	CampaniaID INT NOT NULL,
	PedidoDetalleID INT NOT NULL,
	IndicadorIPUsuario VARCHAR(30) NULL,
	IndicadorFingerprint VARCHAR(50) NULL,
	IndicadorToken VARCHAR(50) NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL,
	PRIMARY KEY(PedidoID,CampaniaID,PedidoDetalleID)
)
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.IndicadorPedidoAutentico')
BEGIN
  DROP TABLE dbo.IndicadorPedidoAutentico
END
GO

CREATE TABLE IndicadorPedidoAutentico
(
	PedidoID INT NOT NULL,
	CampaniaID INT NOT NULL,
	PedidoDetalleID INT NOT NULL,
	IndicadorIPUsuario VARCHAR(30) NULL,
	IndicadorFingerprint VARCHAR(50) NULL,
	IndicadorToken VARCHAR(50) NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL,
	PRIMARY KEY(PedidoID,CampaniaID,PedidoDetalleID)
)
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.IndicadorPedidoAutentico')
BEGIN
  DROP TABLE dbo.IndicadorPedidoAutentico
END
GO

CREATE TABLE IndicadorPedidoAutentico
(
	PedidoID INT NOT NULL,
	CampaniaID INT NOT NULL,
	PedidoDetalleID INT NOT NULL,
	IndicadorIPUsuario VARCHAR(30) NULL,
	IndicadorFingerprint VARCHAR(50) NULL,
	IndicadorToken VARCHAR(50) NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL,
	PRIMARY KEY(PedidoID,CampaniaID,PedidoDetalleID)
)
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.IndicadorPedidoAutentico')
BEGIN
  DROP TABLE dbo.IndicadorPedidoAutentico
END
GO

CREATE TABLE IndicadorPedidoAutentico
(
	PedidoID INT NOT NULL,
	CampaniaID INT NOT NULL,
	PedidoDetalleID INT NOT NULL,
	IndicadorIPUsuario VARCHAR(30) NULL,
	IndicadorFingerprint VARCHAR(50) NULL,
	IndicadorToken VARCHAR(50) NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL,
	PRIMARY KEY(PedidoID,CampaniaID,PedidoDetalleID)
)
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.IndicadorPedidoAutentico')
BEGIN
  DROP TABLE dbo.IndicadorPedidoAutentico
END
GO

CREATE TABLE IndicadorPedidoAutentico
(
	PedidoID INT NOT NULL,
	CampaniaID INT NOT NULL,
	PedidoDetalleID INT NOT NULL,
	IndicadorIPUsuario VARCHAR(30) NULL,
	IndicadorFingerprint VARCHAR(50) NULL,
	IndicadorToken VARCHAR(50) NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL,
	PRIMARY KEY(PedidoID,CampaniaID,PedidoDetalleID)
)
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.IndicadorPedidoAutentico')
BEGIN
  DROP TABLE dbo.IndicadorPedidoAutentico
END
GO

CREATE TABLE IndicadorPedidoAutentico
(
	PedidoID INT NOT NULL,
	CampaniaID INT NOT NULL,
	PedidoDetalleID INT NOT NULL,
	IndicadorIPUsuario VARCHAR(30) NULL,
	IndicadorFingerprint VARCHAR(50) NULL,
	IndicadorToken VARCHAR(50) NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL,
	PRIMARY KEY(PedidoID,CampaniaID,PedidoDetalleID)
)
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.IndicadorPedidoAutentico')
BEGIN
  DROP TABLE dbo.IndicadorPedidoAutentico
END
GO

CREATE TABLE IndicadorPedidoAutentico
(
	PedidoID INT NOT NULL,
	CampaniaID INT NOT NULL,
	PedidoDetalleID INT NOT NULL,
	IndicadorIPUsuario VARCHAR(30) NULL,
	IndicadorFingerprint VARCHAR(50) NULL,
	IndicadorToken VARCHAR(50) NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL,
	PRIMARY KEY(PedidoID,CampaniaID,PedidoDetalleID)
)
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.IndicadorPedidoAutentico')
BEGIN
  DROP TABLE dbo.IndicadorPedidoAutentico
END
GO

CREATE TABLE IndicadorPedidoAutentico
(
	PedidoID INT NOT NULL,
	CampaniaID INT NOT NULL,
	PedidoDetalleID INT NOT NULL,
	IndicadorIPUsuario VARCHAR(30) NULL,
	IndicadorFingerprint VARCHAR(50) NULL,
	IndicadorToken VARCHAR(50) NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL,
	PRIMARY KEY(PedidoID,CampaniaID,PedidoDetalleID)
)
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'dbo.IndicadorPedidoAutentico')
BEGIN
  DROP TABLE dbo.IndicadorPedidoAutentico
END
GO

CREATE TABLE IndicadorPedidoAutentico
(
	PedidoID INT NOT NULL,
	CampaniaID INT NOT NULL,
	PedidoDetalleID INT NOT NULL,
	IndicadorIPUsuario VARCHAR(30) NULL,
	IndicadorFingerprint VARCHAR(50) NULL,
	IndicadorToken VARCHAR(50) NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL,
	PRIMARY KEY(PedidoID,CampaniaID,PedidoDetalleID)
)
GO

