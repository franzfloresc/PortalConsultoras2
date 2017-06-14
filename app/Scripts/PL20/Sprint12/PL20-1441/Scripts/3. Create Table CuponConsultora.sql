

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'CuponConsultora')
BEGIN
  DROP TABLE dbo.CuponConsultora
END
GO

CREATE TABLE dbo.CuponConsultora
(
	CuponConsultoraId INT IDENTITY(1,1) PRIMARY KEY,
	CodigoConsultora VARCHAR(50),
	CampaniaId INT,
	CuponId INT,
	ValorAsociado DECIMAL(18,2),
	EstadoCupon INT,
	EnvioCorreo BIT,
	FechaCreacion DATETIME,
	FechaModificacion DATETIME,
	UsuarioCreacion VARCHAR(50),
	UsuarioModificacion VARCHAR(50)
)
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'CuponConsultora')
BEGIN
  DROP TABLE dbo.CuponConsultora
END
GO

CREATE TABLE dbo.CuponConsultora
(
	CuponConsultoraId INT IDENTITY(1,1) PRIMARY KEY,
	CodigoConsultora VARCHAR(50),
	CampaniaId INT,
	CuponId INT,
	ValorAsociado DECIMAL(18,2),
	EstadoCupon INT,
	EnvioCorreo BIT,
	FechaCreacion DATETIME,
	FechaModificacion DATETIME,
	UsuarioCreacion VARCHAR(50),
	UsuarioModificacion VARCHAR(50)
)
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'CuponConsultora')
BEGIN
  DROP TABLE dbo.CuponConsultora
END
GO

CREATE TABLE dbo.CuponConsultora
(
	CuponConsultoraId INT IDENTITY(1,1) PRIMARY KEY,
	CodigoConsultora VARCHAR(50),
	CampaniaId INT,
	CuponId INT,
	ValorAsociado DECIMAL(18,2),
	EstadoCupon INT,
	EnvioCorreo BIT,
	FechaCreacion DATETIME,
	FechaModificacion DATETIME,
	UsuarioCreacion VARCHAR(50),
	UsuarioModificacion VARCHAR(50)
)
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'CuponConsultora')
BEGIN
  DROP TABLE dbo.CuponConsultora
END
GO

CREATE TABLE dbo.CuponConsultora
(
	CuponConsultoraId INT IDENTITY(1,1) PRIMARY KEY,
	CodigoConsultora VARCHAR(50),
	CampaniaId INT,
	CuponId INT,
	ValorAsociado DECIMAL(18,2),
	EstadoCupon INT,
	EnvioCorreo BIT,
	FechaCreacion DATETIME,
	FechaModificacion DATETIME,
	UsuarioCreacion VARCHAR(50),
	UsuarioModificacion VARCHAR(50)
)
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'CuponConsultora')
BEGIN
  DROP TABLE dbo.CuponConsultora
END
GO

CREATE TABLE dbo.CuponConsultora
(
	CuponConsultoraId INT IDENTITY(1,1) PRIMARY KEY,
	CodigoConsultora VARCHAR(50),
	CampaniaId INT,
	CuponId INT,
	ValorAsociado DECIMAL(18,2),
	EstadoCupon INT,
	EnvioCorreo BIT,
	FechaCreacion DATETIME,
	FechaModificacion DATETIME,
	UsuarioCreacion VARCHAR(50),
	UsuarioModificacion VARCHAR(50)
)
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'CuponConsultora')
BEGIN
  DROP TABLE dbo.CuponConsultora
END
GO

CREATE TABLE dbo.CuponConsultora
(
	CuponConsultoraId INT IDENTITY(1,1) PRIMARY KEY,
	CodigoConsultora VARCHAR(50),
	CampaniaId INT,
	CuponId INT,
	ValorAsociado DECIMAL(18,2),
	EstadoCupon INT,
	EnvioCorreo BIT,
	FechaCreacion DATETIME,
	FechaModificacion DATETIME,
	UsuarioCreacion VARCHAR(50),
	UsuarioModificacion VARCHAR(50)
)
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'CuponConsultora')
BEGIN
  DROP TABLE dbo.CuponConsultora
END
GO

CREATE TABLE dbo.CuponConsultora
(
	CuponConsultoraId INT IDENTITY(1,1) PRIMARY KEY,
	CodigoConsultora VARCHAR(50),
	CampaniaId INT,
	CuponId INT,
	ValorAsociado DECIMAL(18,2),
	EstadoCupon INT,
	EnvioCorreo BIT,
	FechaCreacion DATETIME,
	FechaModificacion DATETIME,
	UsuarioCreacion VARCHAR(50),
	UsuarioModificacion VARCHAR(50)
)
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'CuponConsultora')
BEGIN
  DROP TABLE dbo.CuponConsultora
END
GO

CREATE TABLE dbo.CuponConsultora
(
	CuponConsultoraId INT IDENTITY(1,1) PRIMARY KEY,
	CodigoConsultora VARCHAR(50),
	CampaniaId INT,
	CuponId INT,
	ValorAsociado DECIMAL(18,2),
	EstadoCupon INT,
	EnvioCorreo BIT,
	FechaCreacion DATETIME,
	FechaModificacion DATETIME,
	UsuarioCreacion VARCHAR(50),
	UsuarioModificacion VARCHAR(50)
)
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'CuponConsultora')
BEGIN
  DROP TABLE dbo.CuponConsultora
END
GO

CREATE TABLE dbo.CuponConsultora
(
	CuponConsultoraId INT IDENTITY(1,1) PRIMARY KEY,
	CodigoConsultora VARCHAR(50),
	CampaniaId INT,
	CuponId INT,
	ValorAsociado DECIMAL(18,2),
	EstadoCupon INT,
	EnvioCorreo BIT,
	FechaCreacion DATETIME,
	FechaModificacion DATETIME,
	UsuarioCreacion VARCHAR(50),
	UsuarioModificacion VARCHAR(50)
)
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'CuponConsultora')
BEGIN
  DROP TABLE dbo.CuponConsultora
END
GO

CREATE TABLE dbo.CuponConsultora
(
	CuponConsultoraId INT IDENTITY(1,1) PRIMARY KEY,
	CodigoConsultora VARCHAR(50),
	CampaniaId INT,
	CuponId INT,
	ValorAsociado DECIMAL(18,2),
	EstadoCupon INT,
	EnvioCorreo BIT,
	FechaCreacion DATETIME,
	FechaModificacion DATETIME,
	UsuarioCreacion VARCHAR(50),
	UsuarioModificacion VARCHAR(50)
)
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'CuponConsultora')
BEGIN
  DROP TABLE dbo.CuponConsultora
END
GO

CREATE TABLE dbo.CuponConsultora
(
	CuponConsultoraId INT IDENTITY(1,1) PRIMARY KEY,
	CodigoConsultora VARCHAR(50),
	CampaniaId INT,
	CuponId INT,
	ValorAsociado DECIMAL(18,2),
	EstadoCupon INT,
	EnvioCorreo BIT,
	FechaCreacion DATETIME,
	FechaModificacion DATETIME,
	UsuarioCreacion VARCHAR(50),
	UsuarioModificacion VARCHAR(50)
)
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'CuponConsultora')
BEGIN
  DROP TABLE dbo.CuponConsultora
END
GO

CREATE TABLE dbo.CuponConsultora
(
	CuponConsultoraId INT IDENTITY(1,1) PRIMARY KEY,
	CodigoConsultora VARCHAR(50),
	CampaniaId INT,
	CuponId INT,
	ValorAsociado DECIMAL(18,2),
	EstadoCupon INT,
	EnvioCorreo BIT,
	FechaCreacion DATETIME,
	FechaModificacion DATETIME,
	UsuarioCreacion VARCHAR(50),
	UsuarioModificacion VARCHAR(50)
)
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
		WHERE TABLE_NAME = N'CuponConsultora')
BEGIN
  DROP TABLE dbo.CuponConsultora
END
GO

CREATE TABLE dbo.CuponConsultora
(
	CuponConsultoraId INT IDENTITY(1,1) PRIMARY KEY,
	CodigoConsultora VARCHAR(50),
	CampaniaId INT,
	CuponId INT,
	ValorAsociado DECIMAL(18,2),
	EstadoCupon INT,
	EnvioCorreo BIT,
	FechaCreacion DATETIME,
	FechaModificacion DATETIME,
	UsuarioCreacion VARCHAR(50),
	UsuarioModificacion VARCHAR(50)
)
GO

