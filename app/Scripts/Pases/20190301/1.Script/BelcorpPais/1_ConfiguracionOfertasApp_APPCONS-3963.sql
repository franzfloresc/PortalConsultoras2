USE BelcorpPeru
GO

IF OBJECT_ID('ConfiguracionOfertasHomeApp') IS NOT NULL
	DROP TABLE dbo.ConfiguracionOfertasHomeApp
GO
IF OBJECT_ID('PK_ConfiguracionOfertasHome') IS NOT NULL
	ALTER TABLE dbo.ConfiguracionOfertasHome DROP CONSTRAINT PK_ConfiguracionOfertasHome
GO
CREATE TABLE dbo.ConfiguracionOfertasHomeApp
(
	ConfiguracionOfertasHomeAppID INT IDENTITY(1,1) NOT NULL,
	ConfiguracionOfertasHomeID INT NOT NULL,
	AppActivo BIT NOT NULL,
	AppTitulo VARCHAR(250) NOT NULL,
	AppColorFondo VARCHAR(10) NOT NULL,
	AppColorTexto VARCHAR(10) NOT NULL,
	AppBannerInformativo VARCHAR(250) NOT NULL,
	AppOrden INT NOT NULL,
	AppCantidadProductos INT NOT NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL
)
GO
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT PK_ConfiguracionOfertasHomeApp PRIMARY KEY(ConfiguracionOfertasHomeAppID)
ALTER TABLE dbo.ConfiguracionOfertasHome ADD CONSTRAINT PK_ConfiguracionOfertasHome PRIMARY KEY(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT FK_ConfiguracionOfertasHomeApp FOREIGN KEY(ConfiguracionOfertasHomeID) REFERENCES dbo.ConfiguracionOfertasHome(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT DF_ConfiguracionOfertasHomeApp_FechaCreacion DEFAULT(GETDATE()) FOR FechaCreacion
GO

USE BelcorpMexico
GO

IF OBJECT_ID('ConfiguracionOfertasHomeApp') IS NOT NULL
	DROP TABLE dbo.ConfiguracionOfertasHomeApp
GO
IF OBJECT_ID('PK_ConfiguracionOfertasHome') IS NOT NULL
	ALTER TABLE dbo.ConfiguracionOfertasHome DROP CONSTRAINT PK_ConfiguracionOfertasHome
GO
CREATE TABLE dbo.ConfiguracionOfertasHomeApp
(
	ConfiguracionOfertasHomeAppID INT IDENTITY(1,1) NOT NULL,
	ConfiguracionOfertasHomeID INT NOT NULL,
	AppActivo BIT NOT NULL,
	AppTitulo VARCHAR(250) NOT NULL,
	AppColorFondo VARCHAR(10) NOT NULL,
	AppColorTexto VARCHAR(10) NOT NULL,
	AppBannerInformativo VARCHAR(250) NOT NULL,
	AppOrden INT NOT NULL,
	AppCantidadProductos INT NOT NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL
)
GO
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT PK_ConfiguracionOfertasHomeApp PRIMARY KEY(ConfiguracionOfertasHomeAppID)
ALTER TABLE dbo.ConfiguracionOfertasHome ADD CONSTRAINT PK_ConfiguracionOfertasHome PRIMARY KEY(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT FK_ConfiguracionOfertasHomeApp FOREIGN KEY(ConfiguracionOfertasHomeID) REFERENCES dbo.ConfiguracionOfertasHome(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT DF_ConfiguracionOfertasHomeApp_FechaCreacion DEFAULT(GETDATE()) FOR FechaCreacion
GO

USE BelcorpColombia
GO

IF OBJECT_ID('ConfiguracionOfertasHomeApp') IS NOT NULL
	DROP TABLE dbo.ConfiguracionOfertasHomeApp
GO
IF OBJECT_ID('PK_ConfiguracionOfertasHome') IS NOT NULL
	ALTER TABLE dbo.ConfiguracionOfertasHome DROP CONSTRAINT PK_ConfiguracionOfertasHome
GO
CREATE TABLE dbo.ConfiguracionOfertasHomeApp
(
	ConfiguracionOfertasHomeAppID INT IDENTITY(1,1) NOT NULL,
	ConfiguracionOfertasHomeID INT NOT NULL,
	AppActivo BIT NOT NULL,
	AppTitulo VARCHAR(250) NOT NULL,
	AppColorFondo VARCHAR(10) NOT NULL,
	AppColorTexto VARCHAR(10) NOT NULL,
	AppBannerInformativo VARCHAR(250) NOT NULL,
	AppOrden INT NOT NULL,
	AppCantidadProductos INT NOT NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL
)
GO
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT PK_ConfiguracionOfertasHomeApp PRIMARY KEY(ConfiguracionOfertasHomeAppID)
ALTER TABLE dbo.ConfiguracionOfertasHome ADD CONSTRAINT PK_ConfiguracionOfertasHome PRIMARY KEY(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT FK_ConfiguracionOfertasHomeApp FOREIGN KEY(ConfiguracionOfertasHomeID) REFERENCES dbo.ConfiguracionOfertasHome(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT DF_ConfiguracionOfertasHomeApp_FechaCreacion DEFAULT(GETDATE()) FOR FechaCreacion
GO

USE BelcorpSalvador
GO

IF OBJECT_ID('ConfiguracionOfertasHomeApp') IS NOT NULL
	DROP TABLE dbo.ConfiguracionOfertasHomeApp
GO
IF OBJECT_ID('PK_ConfiguracionOfertasHome') IS NOT NULL
	ALTER TABLE dbo.ConfiguracionOfertasHome DROP CONSTRAINT PK_ConfiguracionOfertasHome
GO
CREATE TABLE dbo.ConfiguracionOfertasHomeApp
(
	ConfiguracionOfertasHomeAppID INT IDENTITY(1,1) NOT NULL,
	ConfiguracionOfertasHomeID INT NOT NULL,
	AppActivo BIT NOT NULL,
	AppTitulo VARCHAR(250) NOT NULL,
	AppColorFondo VARCHAR(10) NOT NULL,
	AppColorTexto VARCHAR(10) NOT NULL,
	AppBannerInformativo VARCHAR(250) NOT NULL,
	AppOrden INT NOT NULL,
	AppCantidadProductos INT NOT NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL
)
GO
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT PK_ConfiguracionOfertasHomeApp PRIMARY KEY(ConfiguracionOfertasHomeAppID)
ALTER TABLE dbo.ConfiguracionOfertasHome ADD CONSTRAINT PK_ConfiguracionOfertasHome PRIMARY KEY(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT FK_ConfiguracionOfertasHomeApp FOREIGN KEY(ConfiguracionOfertasHomeID) REFERENCES dbo.ConfiguracionOfertasHome(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT DF_ConfiguracionOfertasHomeApp_FechaCreacion DEFAULT(GETDATE()) FOR FechaCreacion
GO

USE BelcorpPuertoRico
GO

IF OBJECT_ID('ConfiguracionOfertasHomeApp') IS NOT NULL
	DROP TABLE dbo.ConfiguracionOfertasHomeApp
GO
IF OBJECT_ID('PK_ConfiguracionOfertasHome') IS NOT NULL
	ALTER TABLE dbo.ConfiguracionOfertasHome DROP CONSTRAINT PK_ConfiguracionOfertasHome
GO
CREATE TABLE dbo.ConfiguracionOfertasHomeApp
(
	ConfiguracionOfertasHomeAppID INT IDENTITY(1,1) NOT NULL,
	ConfiguracionOfertasHomeID INT NOT NULL,
	AppActivo BIT NOT NULL,
	AppTitulo VARCHAR(250) NOT NULL,
	AppColorFondo VARCHAR(10) NOT NULL,
	AppColorTexto VARCHAR(10) NOT NULL,
	AppBannerInformativo VARCHAR(250) NOT NULL,
	AppOrden INT NOT NULL,
	AppCantidadProductos INT NOT NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL
)
GO
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT PK_ConfiguracionOfertasHomeApp PRIMARY KEY(ConfiguracionOfertasHomeAppID)
ALTER TABLE dbo.ConfiguracionOfertasHome ADD CONSTRAINT PK_ConfiguracionOfertasHome PRIMARY KEY(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT FK_ConfiguracionOfertasHomeApp FOREIGN KEY(ConfiguracionOfertasHomeID) REFERENCES dbo.ConfiguracionOfertasHome(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT DF_ConfiguracionOfertasHomeApp_FechaCreacion DEFAULT(GETDATE()) FOR FechaCreacion
GO

USE BelcorpPanama
GO

IF OBJECT_ID('ConfiguracionOfertasHomeApp') IS NOT NULL
	DROP TABLE dbo.ConfiguracionOfertasHomeApp
GO
IF OBJECT_ID('PK_ConfiguracionOfertasHome') IS NOT NULL
	ALTER TABLE dbo.ConfiguracionOfertasHome DROP CONSTRAINT PK_ConfiguracionOfertasHome
GO
CREATE TABLE dbo.ConfiguracionOfertasHomeApp
(
	ConfiguracionOfertasHomeAppID INT IDENTITY(1,1) NOT NULL,
	ConfiguracionOfertasHomeID INT NOT NULL,
	AppActivo BIT NOT NULL,
	AppTitulo VARCHAR(250) NOT NULL,
	AppColorFondo VARCHAR(10) NOT NULL,
	AppColorTexto VARCHAR(10) NOT NULL,
	AppBannerInformativo VARCHAR(250) NOT NULL,
	AppOrden INT NOT NULL,
	AppCantidadProductos INT NOT NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL
)
GO
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT PK_ConfiguracionOfertasHomeApp PRIMARY KEY(ConfiguracionOfertasHomeAppID)
ALTER TABLE dbo.ConfiguracionOfertasHome ADD CONSTRAINT PK_ConfiguracionOfertasHome PRIMARY KEY(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT FK_ConfiguracionOfertasHomeApp FOREIGN KEY(ConfiguracionOfertasHomeID) REFERENCES dbo.ConfiguracionOfertasHome(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT DF_ConfiguracionOfertasHomeApp_FechaCreacion DEFAULT(GETDATE()) FOR FechaCreacion
GO

USE BelcorpGuatemala
GO

IF OBJECT_ID('ConfiguracionOfertasHomeApp') IS NOT NULL
	DROP TABLE dbo.ConfiguracionOfertasHomeApp
GO
IF OBJECT_ID('PK_ConfiguracionOfertasHome') IS NOT NULL
	ALTER TABLE dbo.ConfiguracionOfertasHome DROP CONSTRAINT PK_ConfiguracionOfertasHome
GO
CREATE TABLE dbo.ConfiguracionOfertasHomeApp
(
	ConfiguracionOfertasHomeAppID INT IDENTITY(1,1) NOT NULL,
	ConfiguracionOfertasHomeID INT NOT NULL,
	AppActivo BIT NOT NULL,
	AppTitulo VARCHAR(250) NOT NULL,
	AppColorFondo VARCHAR(10) NOT NULL,
	AppColorTexto VARCHAR(10) NOT NULL,
	AppBannerInformativo VARCHAR(250) NOT NULL,
	AppOrden INT NOT NULL,
	AppCantidadProductos INT NOT NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL
)
GO
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT PK_ConfiguracionOfertasHomeApp PRIMARY KEY(ConfiguracionOfertasHomeAppID)
ALTER TABLE dbo.ConfiguracionOfertasHome ADD CONSTRAINT PK_ConfiguracionOfertasHome PRIMARY KEY(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT FK_ConfiguracionOfertasHomeApp FOREIGN KEY(ConfiguracionOfertasHomeID) REFERENCES dbo.ConfiguracionOfertasHome(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT DF_ConfiguracionOfertasHomeApp_FechaCreacion DEFAULT(GETDATE()) FOR FechaCreacion
GO

USE BelcorpEcuador
GO

IF OBJECT_ID('ConfiguracionOfertasHomeApp') IS NOT NULL
	DROP TABLE dbo.ConfiguracionOfertasHomeApp
GO
IF OBJECT_ID('PK_ConfiguracionOfertasHome') IS NOT NULL
	ALTER TABLE dbo.ConfiguracionOfertasHome DROP CONSTRAINT PK_ConfiguracionOfertasHome
GO
CREATE TABLE dbo.ConfiguracionOfertasHomeApp
(
	ConfiguracionOfertasHomeAppID INT IDENTITY(1,1) NOT NULL,
	ConfiguracionOfertasHomeID INT NOT NULL,
	AppActivo BIT NOT NULL,
	AppTitulo VARCHAR(250) NOT NULL,
	AppColorFondo VARCHAR(10) NOT NULL,
	AppColorTexto VARCHAR(10) NOT NULL,
	AppBannerInformativo VARCHAR(250) NOT NULL,
	AppOrden INT NOT NULL,
	AppCantidadProductos INT NOT NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL
)
GO
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT PK_ConfiguracionOfertasHomeApp PRIMARY KEY(ConfiguracionOfertasHomeAppID)
ALTER TABLE dbo.ConfiguracionOfertasHome ADD CONSTRAINT PK_ConfiguracionOfertasHome PRIMARY KEY(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT FK_ConfiguracionOfertasHomeApp FOREIGN KEY(ConfiguracionOfertasHomeID) REFERENCES dbo.ConfiguracionOfertasHome(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT DF_ConfiguracionOfertasHomeApp_FechaCreacion DEFAULT(GETDATE()) FOR FechaCreacion
GO

USE BelcorpDominicana
GO

IF OBJECT_ID('ConfiguracionOfertasHomeApp') IS NOT NULL
	DROP TABLE dbo.ConfiguracionOfertasHomeApp
GO
IF OBJECT_ID('PK_ConfiguracionOfertasHome') IS NOT NULL
	ALTER TABLE dbo.ConfiguracionOfertasHome DROP CONSTRAINT PK_ConfiguracionOfertasHome
GO
CREATE TABLE dbo.ConfiguracionOfertasHomeApp
(
	ConfiguracionOfertasHomeAppID INT IDENTITY(1,1) NOT NULL,
	ConfiguracionOfertasHomeID INT NOT NULL,
	AppActivo BIT NOT NULL,
	AppTitulo VARCHAR(250) NOT NULL,
	AppColorFondo VARCHAR(10) NOT NULL,
	AppColorTexto VARCHAR(10) NOT NULL,
	AppBannerInformativo VARCHAR(250) NOT NULL,
	AppOrden INT NOT NULL,
	AppCantidadProductos INT NOT NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL
)
GO
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT PK_ConfiguracionOfertasHomeApp PRIMARY KEY(ConfiguracionOfertasHomeAppID)
ALTER TABLE dbo.ConfiguracionOfertasHome ADD CONSTRAINT PK_ConfiguracionOfertasHome PRIMARY KEY(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT FK_ConfiguracionOfertasHomeApp FOREIGN KEY(ConfiguracionOfertasHomeID) REFERENCES dbo.ConfiguracionOfertasHome(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT DF_ConfiguracionOfertasHomeApp_FechaCreacion DEFAULT(GETDATE()) FOR FechaCreacion
GO

USE BelcorpCostaRica
GO

IF OBJECT_ID('ConfiguracionOfertasHomeApp') IS NOT NULL
	DROP TABLE dbo.ConfiguracionOfertasHomeApp
GO
IF OBJECT_ID('PK_ConfiguracionOfertasHome') IS NOT NULL
	ALTER TABLE dbo.ConfiguracionOfertasHome DROP CONSTRAINT PK_ConfiguracionOfertasHome
GO
CREATE TABLE dbo.ConfiguracionOfertasHomeApp
(
	ConfiguracionOfertasHomeAppID INT IDENTITY(1,1) NOT NULL,
	ConfiguracionOfertasHomeID INT NOT NULL,
	AppActivo BIT NOT NULL,
	AppTitulo VARCHAR(250) NOT NULL,
	AppColorFondo VARCHAR(10) NOT NULL,
	AppColorTexto VARCHAR(10) NOT NULL,
	AppBannerInformativo VARCHAR(250) NOT NULL,
	AppOrden INT NOT NULL,
	AppCantidadProductos INT NOT NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL
)
GO
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT PK_ConfiguracionOfertasHomeApp PRIMARY KEY(ConfiguracionOfertasHomeAppID)
ALTER TABLE dbo.ConfiguracionOfertasHome ADD CONSTRAINT PK_ConfiguracionOfertasHome PRIMARY KEY(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT FK_ConfiguracionOfertasHomeApp FOREIGN KEY(ConfiguracionOfertasHomeID) REFERENCES dbo.ConfiguracionOfertasHome(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT DF_ConfiguracionOfertasHomeApp_FechaCreacion DEFAULT(GETDATE()) FOR FechaCreacion
GO

USE BelcorpChile
GO

IF OBJECT_ID('ConfiguracionOfertasHomeApp') IS NOT NULL
	DROP TABLE dbo.ConfiguracionOfertasHomeApp
GO
IF OBJECT_ID('PK_ConfiguracionOfertasHome') IS NOT NULL
	ALTER TABLE dbo.ConfiguracionOfertasHome DROP CONSTRAINT PK_ConfiguracionOfertasHome
GO
CREATE TABLE dbo.ConfiguracionOfertasHomeApp
(
	ConfiguracionOfertasHomeAppID INT IDENTITY(1,1) NOT NULL,
	ConfiguracionOfertasHomeID INT NOT NULL,
	AppActivo BIT NOT NULL,
	AppTitulo VARCHAR(250) NOT NULL,
	AppColorFondo VARCHAR(10) NOT NULL,
	AppColorTexto VARCHAR(10) NOT NULL,
	AppBannerInformativo VARCHAR(250) NOT NULL,
	AppOrden INT NOT NULL,
	AppCantidadProductos INT NOT NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL
)
GO
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT PK_ConfiguracionOfertasHomeApp PRIMARY KEY(ConfiguracionOfertasHomeAppID)
ALTER TABLE dbo.ConfiguracionOfertasHome ADD CONSTRAINT PK_ConfiguracionOfertasHome PRIMARY KEY(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT FK_ConfiguracionOfertasHomeApp FOREIGN KEY(ConfiguracionOfertasHomeID) REFERENCES dbo.ConfiguracionOfertasHome(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT DF_ConfiguracionOfertasHomeApp_FechaCreacion DEFAULT(GETDATE()) FOR FechaCreacion
GO

USE BelcorpBolivia
GO

IF OBJECT_ID('ConfiguracionOfertasHomeApp') IS NOT NULL
	DROP TABLE dbo.ConfiguracionOfertasHomeApp
GO
IF OBJECT_ID('PK_ConfiguracionOfertasHome') IS NOT NULL
	ALTER TABLE dbo.ConfiguracionOfertasHome DROP CONSTRAINT PK_ConfiguracionOfertasHome
GO
CREATE TABLE dbo.ConfiguracionOfertasHomeApp
(
	ConfiguracionOfertasHomeAppID INT IDENTITY(1,1) NOT NULL,
	ConfiguracionOfertasHomeID INT NOT NULL,
	AppActivo BIT NOT NULL,
	AppTitulo VARCHAR(250) NOT NULL,
	AppColorFondo VARCHAR(10) NOT NULL,
	AppColorTexto VARCHAR(10) NOT NULL,
	AppBannerInformativo VARCHAR(250) NOT NULL,
	AppOrden INT NOT NULL,
	AppCantidadProductos INT NOT NULL,
	FechaCreacion DATETIME NOT NULL,
	FechaModificacion DATETIME NULL
)
GO
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT PK_ConfiguracionOfertasHomeApp PRIMARY KEY(ConfiguracionOfertasHomeAppID)
ALTER TABLE dbo.ConfiguracionOfertasHome ADD CONSTRAINT PK_ConfiguracionOfertasHome PRIMARY KEY(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT FK_ConfiguracionOfertasHomeApp FOREIGN KEY(ConfiguracionOfertasHomeID) REFERENCES dbo.ConfiguracionOfertasHome(ConfiguracionOfertasHomeID)
ALTER TABLE dbo.ConfiguracionOfertasHomeApp ADD CONSTRAINT DF_ConfiguracionOfertasHomeApp_FechaCreacion DEFAULT(GETDATE()) FOR FechaCreacion
GO

