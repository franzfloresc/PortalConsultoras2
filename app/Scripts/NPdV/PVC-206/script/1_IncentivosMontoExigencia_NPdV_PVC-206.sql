USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'U' and id = OBJECT_ID('dbo.IncentivosMontoExigencia'))
	DROP TABLE dbo.IncentivosMontoExigencia
GO
CREATE TABLE dbo.IncentivosMontoExigencia(
	MontoID INT IDENTITY(1,1),
	CodigoCampania VARCHAR(8),
	CodigoRegion varchar(8),
	CodigoZona varchar(8),
	Monto money,
	AlcansoIncentivo varchar(1),
	FechaRegistro datetime,  
	FechaModificacion datetime  
	PRIMARY KEY (MontoID)
)
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'U' and id = OBJECT_ID('dbo.IncentivosMontoExigencia'))
	DROP TABLE dbo.IncentivosMontoExigencia
GO
CREATE TABLE dbo.IncentivosMontoExigencia(
	MontoID INT IDENTITY(1,1),
	CodigoCampania VARCHAR(8),
	CodigoRegion varchar(8),
	CodigoZona varchar(8),
	Monto money,
	AlcansoIncentivo varchar(1),
	FechaRegistro datetime,  
	FechaModificacion datetime  
	PRIMARY KEY (MontoID)
)
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'U' and id = OBJECT_ID('dbo.IncentivosMontoExigencia'))
	DROP TABLE dbo.IncentivosMontoExigencia
GO
CREATE TABLE dbo.IncentivosMontoExigencia(
	MontoID INT IDENTITY(1,1),
	CodigoCampania VARCHAR(8),
	CodigoRegion varchar(8),
	CodigoZona varchar(8),
	Monto money,
	AlcansoIncentivo varchar(1),
	FechaRegistro datetime,  
	FechaModificacion datetime  
	PRIMARY KEY (MontoID)
)
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'U' and id = OBJECT_ID('dbo.IncentivosMontoExigencia'))
	DROP TABLE dbo.IncentivosMontoExigencia
GO
CREATE TABLE dbo.IncentivosMontoExigencia(
	MontoID INT IDENTITY(1,1),
	CodigoCampania VARCHAR(8),
	CodigoRegion varchar(8),
	CodigoZona varchar(8),
	Monto money,
	AlcansoIncentivo varchar(1),
	FechaRegistro datetime,  
	FechaModificacion datetime  
	PRIMARY KEY (MontoID)
)
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'U' and id = OBJECT_ID('dbo.IncentivosMontoExigencia'))
	DROP TABLE dbo.IncentivosMontoExigencia
GO
CREATE TABLE dbo.IncentivosMontoExigencia(
	MontoID INT IDENTITY(1,1),
	CodigoCampania VARCHAR(8),
	CodigoRegion varchar(8),
	CodigoZona varchar(8),
	Monto money,
	AlcansoIncentivo varchar(1),
	FechaRegistro datetime,  
	FechaModificacion datetime  
	PRIMARY KEY (MontoID)
)
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'U' and id = OBJECT_ID('dbo.IncentivosMontoExigencia'))
	DROP TABLE dbo.IncentivosMontoExigencia
GO
CREATE TABLE dbo.IncentivosMontoExigencia(
	MontoID INT IDENTITY(1,1),
	CodigoCampania VARCHAR(8),
	CodigoRegion varchar(8),
	CodigoZona varchar(8),
	Monto money,
	AlcansoIncentivo varchar(1),
	FechaRegistro datetime,  
	FechaModificacion datetime  
	PRIMARY KEY (MontoID)
)
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'U' and id = OBJECT_ID('dbo.IncentivosMontoExigencia'))
	DROP TABLE dbo.IncentivosMontoExigencia
GO
CREATE TABLE dbo.IncentivosMontoExigencia(
	MontoID INT IDENTITY(1,1),
	CodigoCampania VARCHAR(8),
	CodigoRegion varchar(8),
	CodigoZona varchar(8),
	Monto money,
	AlcansoIncentivo varchar(1),
	FechaRegistro datetime,  
	FechaModificacion datetime  
	PRIMARY KEY (MontoID)
)
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'U' and id = OBJECT_ID('dbo.IncentivosMontoExigencia'))
	DROP TABLE dbo.IncentivosMontoExigencia
GO
CREATE TABLE dbo.IncentivosMontoExigencia(
	MontoID INT IDENTITY(1,1),
	CodigoCampania VARCHAR(8),
	CodigoRegion varchar(8),
	CodigoZona varchar(8),
	Monto money,
	AlcansoIncentivo varchar(1),
	FechaRegistro datetime,  
	FechaModificacion datetime  
	PRIMARY KEY (MontoID)
)
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'U' and id = OBJECT_ID('dbo.IncentivosMontoExigencia'))
	DROP TABLE dbo.IncentivosMontoExigencia
GO
CREATE TABLE dbo.IncentivosMontoExigencia(
	MontoID INT IDENTITY(1,1),
	CodigoCampania VARCHAR(8),
	CodigoRegion varchar(8),
	CodigoZona varchar(8),
	Monto money,
	AlcansoIncentivo varchar(1),
	FechaRegistro datetime,  
	FechaModificacion datetime  
	PRIMARY KEY (MontoID)
)
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'U' and id = OBJECT_ID('dbo.IncentivosMontoExigencia'))
	DROP TABLE dbo.IncentivosMontoExigencia
GO
CREATE TABLE dbo.IncentivosMontoExigencia(
	MontoID INT IDENTITY(1,1),
	CodigoCampania VARCHAR(8),
	CodigoRegion varchar(8),
	CodigoZona varchar(8),
	Monto money,
	AlcansoIncentivo varchar(1),
	FechaRegistro datetime,  
	FechaModificacion datetime  
	PRIMARY KEY (MontoID)
)
GO

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'U' and id = OBJECT_ID('dbo.IncentivosMontoExigencia'))
	DROP TABLE dbo.IncentivosMontoExigencia
GO
CREATE TABLE dbo.IncentivosMontoExigencia(
	MontoID INT IDENTITY(1,1),
	CodigoCampania VARCHAR(8),
	CodigoRegion varchar(8),
	CodigoZona varchar(8),
	Monto money,
	AlcansoIncentivo varchar(1),
	FechaRegistro datetime,  
	FechaModificacion datetime  
	PRIMARY KEY (MontoID)
)
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM SYSOBJECTS WHERE TYPE = 'U' and id = OBJECT_ID('dbo.IncentivosMontoExigencia'))
	DROP TABLE dbo.IncentivosMontoExigencia
GO
CREATE TABLE dbo.IncentivosMontoExigencia(
	MontoID INT IDENTITY(1,1),
	CodigoCampania VARCHAR(8),
	CodigoRegion varchar(8),
	CodigoZona varchar(8),
	Monto money,
	AlcansoIncentivo varchar(1),
	FechaRegistro datetime,  
	FechaModificacion datetime  
	PRIMARY KEY (MontoID)
)
GO

