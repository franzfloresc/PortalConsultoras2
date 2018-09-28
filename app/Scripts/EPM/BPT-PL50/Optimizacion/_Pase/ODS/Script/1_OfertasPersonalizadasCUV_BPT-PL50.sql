GO
USE ODS_PE
GO

PRINT DB_NAME()
GO
IF EXISTS(	SELECT 1
			FROM SYS.TABLES T
			WHERE T.TYPE = 'U'
			AND T.NAME = 'OfertasPersonalizadasCUV')
BEGIN
	PRINT 'ELIMINANDO TABLA OfertasPersonalizadasCUV'
	DROP TABLE OfertasPersonalizadasCUV
END

go
PRINT 'CREANDO TABLA OfertasPersonalizadasCUV'
go
CREATE TABLE dbo.OfertasPersonalizadasCUV (
	AnioCampanaVenta INT
	,TipoPersonalizacion VARCHAR(10)
	,CUV VARCHAR(6)
	,FlagUltMinuto INT
	,LimUnidades INT
	,CONSTRAINT PK_OfertasPersonalizadasCUV PRIMARY KEY (AnioCampanaVenta, TipoPersonalizacion, CUV)
)
GO

GO
USE ODS_MX
GO

PRINT DB_NAME()
GO
IF EXISTS(	SELECT 1
			FROM SYS.TABLES T
			WHERE T.TYPE = 'U'
			AND T.NAME = 'OfertasPersonalizadasCUV')
BEGIN
	PRINT 'ELIMINANDO TABLA OfertasPersonalizadasCUV'
	DROP TABLE OfertasPersonalizadasCUV
END

go
PRINT 'CREANDO TABLA OfertasPersonalizadasCUV'
go
CREATE TABLE dbo.OfertasPersonalizadasCUV (
	AnioCampanaVenta INT
	,TipoPersonalizacion VARCHAR(10)
	,CUV VARCHAR(6)
	,FlagUltMinuto INT
	,LimUnidades INT
	,CONSTRAINT PK_OfertasPersonalizadasCUV PRIMARY KEY (AnioCampanaVenta, TipoPersonalizacion, CUV)
)
GO

GO
USE ODS_CO
GO

PRINT DB_NAME()
GO
IF EXISTS(	SELECT 1
			FROM SYS.TABLES T
			WHERE T.TYPE = 'U'
			AND T.NAME = 'OfertasPersonalizadasCUV')
BEGIN
	PRINT 'ELIMINANDO TABLA OfertasPersonalizadasCUV'
	DROP TABLE OfertasPersonalizadasCUV
END

go
PRINT 'CREANDO TABLA OfertasPersonalizadasCUV'
go
CREATE TABLE dbo.OfertasPersonalizadasCUV (
	AnioCampanaVenta INT
	,TipoPersonalizacion VARCHAR(10)
	,CUV VARCHAR(6)
	,FlagUltMinuto INT
	,LimUnidades INT
	,CONSTRAINT PK_OfertasPersonalizadasCUV PRIMARY KEY (AnioCampanaVenta, TipoPersonalizacion, CUV)
)
GO

GO
USE ODS_VE
GO

PRINT DB_NAME()
GO
IF EXISTS(	SELECT 1
			FROM SYS.TABLES T
			WHERE T.TYPE = 'U'
			AND T.NAME = 'OfertasPersonalizadasCUV')
BEGIN
	PRINT 'ELIMINANDO TABLA OfertasPersonalizadasCUV'
	DROP TABLE OfertasPersonalizadasCUV
END

go
PRINT 'CREANDO TABLA OfertasPersonalizadasCUV'
go
CREATE TABLE dbo.OfertasPersonalizadasCUV (
	AnioCampanaVenta INT
	,TipoPersonalizacion VARCHAR(10)
	,CUV VARCHAR(6)
	,FlagUltMinuto INT
	,LimUnidades INT
	,CONSTRAINT PK_OfertasPersonalizadasCUV PRIMARY KEY (AnioCampanaVenta, TipoPersonalizacion, CUV)
)
GO

GO
USE ODS_SV
GO

PRINT DB_NAME()
GO
IF EXISTS(	SELECT 1
			FROM SYS.TABLES T
			WHERE T.TYPE = 'U'
			AND T.NAME = 'OfertasPersonalizadasCUV')
BEGIN
	PRINT 'ELIMINANDO TABLA OfertasPersonalizadasCUV'
	DROP TABLE OfertasPersonalizadasCUV
END

go
PRINT 'CREANDO TABLA OfertasPersonalizadasCUV'
go
CREATE TABLE dbo.OfertasPersonalizadasCUV (
	AnioCampanaVenta INT
	,TipoPersonalizacion VARCHAR(10)
	,CUV VARCHAR(6)
	,FlagUltMinuto INT
	,LimUnidades INT
	,CONSTRAINT PK_OfertasPersonalizadasCUV PRIMARY KEY (AnioCampanaVenta, TipoPersonalizacion, CUV)
)
GO

GO
USE ODS_PR
GO

PRINT DB_NAME()
GO
IF EXISTS(	SELECT 1
			FROM SYS.TABLES T
			WHERE T.TYPE = 'U'
			AND T.NAME = 'OfertasPersonalizadasCUV')
BEGIN
	PRINT 'ELIMINANDO TABLA OfertasPersonalizadasCUV'
	DROP TABLE OfertasPersonalizadasCUV
END

go
PRINT 'CREANDO TABLA OfertasPersonalizadasCUV'
go
CREATE TABLE dbo.OfertasPersonalizadasCUV (
	AnioCampanaVenta INT
	,TipoPersonalizacion VARCHAR(10)
	,CUV VARCHAR(6)
	,FlagUltMinuto INT
	,LimUnidades INT
	,CONSTRAINT PK_OfertasPersonalizadasCUV PRIMARY KEY (AnioCampanaVenta, TipoPersonalizacion, CUV)
)
GO

GO
USE ODS_PA
GO

PRINT DB_NAME()
GO
IF EXISTS(	SELECT 1
			FROM SYS.TABLES T
			WHERE T.TYPE = 'U'
			AND T.NAME = 'OfertasPersonalizadasCUV')
BEGIN
	PRINT 'ELIMINANDO TABLA OfertasPersonalizadasCUV'
	DROP TABLE OfertasPersonalizadasCUV
END

go
PRINT 'CREANDO TABLA OfertasPersonalizadasCUV'
go
CREATE TABLE dbo.OfertasPersonalizadasCUV (
	AnioCampanaVenta INT
	,TipoPersonalizacion VARCHAR(10)
	,CUV VARCHAR(6)
	,FlagUltMinuto INT
	,LimUnidades INT
	,CONSTRAINT PK_OfertasPersonalizadasCUV PRIMARY KEY (AnioCampanaVenta, TipoPersonalizacion, CUV)
)
GO

GO
USE ODS_GT
GO

PRINT DB_NAME()
GO
IF EXISTS(	SELECT 1
			FROM SYS.TABLES T
			WHERE T.TYPE = 'U'
			AND T.NAME = 'OfertasPersonalizadasCUV')
BEGIN
	PRINT 'ELIMINANDO TABLA OfertasPersonalizadasCUV'
	DROP TABLE OfertasPersonalizadasCUV
END

go
PRINT 'CREANDO TABLA OfertasPersonalizadasCUV'
go
CREATE TABLE dbo.OfertasPersonalizadasCUV (
	AnioCampanaVenta INT
	,TipoPersonalizacion VARCHAR(10)
	,CUV VARCHAR(6)
	,FlagUltMinuto INT
	,LimUnidades INT
	,CONSTRAINT PK_OfertasPersonalizadasCUV PRIMARY KEY (AnioCampanaVenta, TipoPersonalizacion, CUV)
)
GO

GO
USE ODS_EC
GO

PRINT DB_NAME()
GO
IF EXISTS(	SELECT 1
			FROM SYS.TABLES T
			WHERE T.TYPE = 'U'
			AND T.NAME = 'OfertasPersonalizadasCUV')
BEGIN
	PRINT 'ELIMINANDO TABLA OfertasPersonalizadasCUV'
	DROP TABLE OfertasPersonalizadasCUV
END

go
PRINT 'CREANDO TABLA OfertasPersonalizadasCUV'
go
CREATE TABLE dbo.OfertasPersonalizadasCUV (
	AnioCampanaVenta INT
	,TipoPersonalizacion VARCHAR(10)
	,CUV VARCHAR(6)
	,FlagUltMinuto INT
	,LimUnidades INT
	,CONSTRAINT PK_OfertasPersonalizadasCUV PRIMARY KEY (AnioCampanaVenta, TipoPersonalizacion, CUV)
)
GO

GO
USE ODS_DO
GO

PRINT DB_NAME()
GO
IF EXISTS(	SELECT 1
			FROM SYS.TABLES T
			WHERE T.TYPE = 'U'
			AND T.NAME = 'OfertasPersonalizadasCUV')
BEGIN
	PRINT 'ELIMINANDO TABLA OfertasPersonalizadasCUV'
	DROP TABLE OfertasPersonalizadasCUV
END

go
PRINT 'CREANDO TABLA OfertasPersonalizadasCUV'
go
CREATE TABLE dbo.OfertasPersonalizadasCUV (
	AnioCampanaVenta INT
	,TipoPersonalizacion VARCHAR(10)
	,CUV VARCHAR(6)
	,FlagUltMinuto INT
	,LimUnidades INT
	,CONSTRAINT PK_OfertasPersonalizadasCUV PRIMARY KEY (AnioCampanaVenta, TipoPersonalizacion, CUV)
)
GO

GO
USE ODS_CR
GO

PRINT DB_NAME()
GO
IF EXISTS(	SELECT 1
			FROM SYS.TABLES T
			WHERE T.TYPE = 'U'
			AND T.NAME = 'OfertasPersonalizadasCUV')
BEGIN
	PRINT 'ELIMINANDO TABLA OfertasPersonalizadasCUV'
	DROP TABLE OfertasPersonalizadasCUV
END

go
PRINT 'CREANDO TABLA OfertasPersonalizadasCUV'
go
CREATE TABLE dbo.OfertasPersonalizadasCUV (
	AnioCampanaVenta INT
	,TipoPersonalizacion VARCHAR(10)
	,CUV VARCHAR(6)
	,FlagUltMinuto INT
	,LimUnidades INT
	,CONSTRAINT PK_OfertasPersonalizadasCUV PRIMARY KEY (AnioCampanaVenta, TipoPersonalizacion, CUV)
)
GO

GO
USE ODS_CL
GO

PRINT DB_NAME()
GO
IF EXISTS(	SELECT 1
			FROM SYS.TABLES T
			WHERE T.TYPE = 'U'
			AND T.NAME = 'OfertasPersonalizadasCUV')
BEGIN
	PRINT 'ELIMINANDO TABLA OfertasPersonalizadasCUV'
	DROP TABLE OfertasPersonalizadasCUV
END

go
PRINT 'CREANDO TABLA OfertasPersonalizadasCUV'
go
CREATE TABLE dbo.OfertasPersonalizadasCUV (
	AnioCampanaVenta INT
	,TipoPersonalizacion VARCHAR(10)
	,CUV VARCHAR(6)
	,FlagUltMinuto INT
	,LimUnidades INT
	,CONSTRAINT PK_OfertasPersonalizadasCUV PRIMARY KEY (AnioCampanaVenta, TipoPersonalizacion, CUV)
)
GO

GO
USE ODS_BO
GO

PRINT DB_NAME()
GO
IF EXISTS(	SELECT 1
			FROM SYS.TABLES T
			WHERE T.TYPE = 'U'
			AND T.NAME = 'OfertasPersonalizadasCUV')
BEGIN
	PRINT 'ELIMINANDO TABLA OfertasPersonalizadasCUV'
	DROP TABLE OfertasPersonalizadasCUV
END

go
PRINT 'CREANDO TABLA OfertasPersonalizadasCUV'
go
CREATE TABLE dbo.OfertasPersonalizadasCUV (
	AnioCampanaVenta INT
	,TipoPersonalizacion VARCHAR(10)
	,CUV VARCHAR(6)
	,FlagUltMinuto INT
	,LimUnidades INT
	,CONSTRAINT PK_OfertasPersonalizadasCUV PRIMARY KEY (AnioCampanaVenta, TipoPersonalizacion, CUV)
)
GO

GO
