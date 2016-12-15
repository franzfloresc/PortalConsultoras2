

USE BelcorpBolivia
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

CREATE TABLE LogConfiguracionCronograma
(
	IdRegistro INT IDENTITY(1,1) PRIMARY KEY,
	FechaRegistro DATETIME,
	CodigoUsuario VARCHAR(30),
	CodigoRegion INT,
	CodigoZona INT,
	DiasDuracionAnterior INT,
	DiasDuracionActual INT
)
GO

/*end*/

USE BelcorpChile
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

CREATE TABLE LogConfiguracionCronograma
(
	IdRegistro INT IDENTITY(1,1) PRIMARY KEY,
	FechaRegistro DATETIME,
	CodigoUsuario VARCHAR(30),
	CodigoRegion INT,
	CodigoZona INT,
	DiasDuracionAnterior INT,
	DiasDuracionActual INT
)
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

CREATE TABLE LogConfiguracionCronograma
(
	IdRegistro INT IDENTITY(1,1) PRIMARY KEY,
	FechaRegistro DATETIME,
	CodigoUsuario VARCHAR(30),
	CodigoRegion INT,
	CodigoZona INT,
	DiasDuracionAnterior INT,
	DiasDuracionActual INT
)
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

CREATE TABLE LogConfiguracionCronograma
(
	IdRegistro INT IDENTITY(1,1) PRIMARY KEY,
	FechaRegistro DATETIME,
	CodigoUsuario VARCHAR(30),
	CodigoRegion INT,
	CodigoZona INT,
	DiasDuracionAnterior INT,
	DiasDuracionActual INT
)
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

CREATE TABLE LogConfiguracionCronograma
(
	IdRegistro INT IDENTITY(1,1) PRIMARY KEY,
	FechaRegistro DATETIME,
	CodigoUsuario VARCHAR(30),
	CodigoRegion INT,
	CodigoZona INT,
	DiasDuracionAnterior INT,
	DiasDuracionActual INT
)
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

CREATE TABLE LogConfiguracionCronograma
(
	IdRegistro INT IDENTITY(1,1) PRIMARY KEY,
	FechaRegistro DATETIME,
	CodigoUsuario VARCHAR(30),
	CodigoRegion INT,
	CodigoZona INT,
	DiasDuracionAnterior INT,
	DiasDuracionActual INT
)
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

CREATE TABLE LogConfiguracionCronograma
(
	IdRegistro INT IDENTITY(1,1) PRIMARY KEY,
	FechaRegistro DATETIME,
	CodigoUsuario VARCHAR(30),
	CodigoRegion INT,
	CodigoZona INT,
	DiasDuracionAnterior INT,
	DiasDuracionActual INT
)
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

CREATE TABLE LogConfiguracionCronograma
(
	IdRegistro INT IDENTITY(1,1) PRIMARY KEY,
	FechaRegistro DATETIME,
	CodigoUsuario VARCHAR(30),
	CodigoRegion INT,
	CodigoZona INT,
	DiasDuracionAnterior INT,
	DiasDuracionActual INT
)
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

CREATE TABLE LogConfiguracionCronograma
(
	IdRegistro INT IDENTITY(1,1) PRIMARY KEY,
	FechaRegistro DATETIME,
	CodigoUsuario VARCHAR(30),
	CodigoRegion INT,
	CodigoZona INT,
	DiasDuracionAnterior INT,
	DiasDuracionActual INT
)
GO
/*end*/

USE BelcorpPeru
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

CREATE TABLE LogConfiguracionCronograma
(
	IdRegistro INT IDENTITY(1,1) PRIMARY KEY,
	FechaRegistro DATETIME,
	CodigoUsuario VARCHAR(30),
	CodigoRegion INT,
	CodigoZona INT,
	DiasDuracionAnterior INT,
	DiasDuracionActual INT
)
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

CREATE TABLE LogConfiguracionCronograma
(
	IdRegistro INT IDENTITY(1,1) PRIMARY KEY,
	FechaRegistro DATETIME,
	CodigoUsuario VARCHAR(30),
	CodigoRegion INT,
	CodigoZona INT,
	DiasDuracionAnterior INT,
	DiasDuracionActual INT
)
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

CREATE TABLE LogConfiguracionCronograma
(
	IdRegistro INT IDENTITY(1,1) PRIMARY KEY,
	FechaRegistro DATETIME,
	CodigoUsuario VARCHAR(30),
	CodigoRegion INT,
	CodigoZona INT,
	DiasDuracionAnterior INT,
	DiasDuracionActual INT
)
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES 
           WHERE TABLE_NAME = N'LogConfiguracionCronograma')
BEGIN
	DROP TABLE LogConfiguracionCronograma
END

CREATE TABLE LogConfiguracionCronograma
(
	IdRegistro INT IDENTITY(1,1) PRIMARY KEY,
	FechaRegistro DATETIME,
	CodigoUsuario VARCHAR(30),
	CodigoRegion INT,
	CodigoZona INT,
	DiasDuracionAnterior INT,
	DiasDuracionActual INT
)
GO

