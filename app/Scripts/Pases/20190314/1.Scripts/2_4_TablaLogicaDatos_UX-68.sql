USE BelcorpPeru
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblImgResize TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblImgResize
VALUES ('_mdpi'),('_hdpi'),('_xhdpi'),('_xxhdpi'),('_xxxhdpi')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos
SELECT 16200 + (ROW_NUMBER()OVER(ORDER BY A.ConfiguracionPaisID)),162,A.Codigo + B.Codigo,
	CASE WHEN A.Codigo IN('PN','DP') 
	THEN
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '210x140'
			WHEN B.Codigo = '_hdpi' THEN '315x210'
			WHEN B.Codigo = '_xhdpi' THEN '420x280'
			WHEN B.Codigo = '_xxhdpi' THEN '630x420'
			WHEN B.Codigo = '_xxxhdpi' THEN '840x560' END
	ELSE
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '95x215'
			WHEN B.Codigo = '_hdpi' THEN '142x322'
			WHEN B.Codigo = '_xhdpi' THEN '190x430'
			WHEN B.Codigo = '_xxhdpi' THEN '285x645'
			WHEN B.Codigo = '_xxxhdpi' THEN '380x860' END
	END, NULL
FROM @TBLConfigPais A
INNER JOIN @TblImgResize B
ON 1 = 1
GO

USE BelcorpMexico
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblImgResize TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblImgResize
VALUES ('_mdpi'),('_hdpi'),('_xhdpi'),('_xxhdpi'),('_xxxhdpi')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos
SELECT 16200 + (ROW_NUMBER()OVER(ORDER BY A.ConfiguracionPaisID)),162,A.Codigo + B.Codigo,
	CASE WHEN A.Codigo IN('PN','DP') 
	THEN
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '210x140'
			WHEN B.Codigo = '_hdpi' THEN '315x210'
			WHEN B.Codigo = '_xhdpi' THEN '420x280'
			WHEN B.Codigo = '_xxhdpi' THEN '630x420'
			WHEN B.Codigo = '_xxxhdpi' THEN '840x560' END
	ELSE
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '95x215'
			WHEN B.Codigo = '_hdpi' THEN '142x322'
			WHEN B.Codigo = '_xhdpi' THEN '190x430'
			WHEN B.Codigo = '_xxhdpi' THEN '285x645'
			WHEN B.Codigo = '_xxxhdpi' THEN '380x860' END
	END, NULL
FROM @TBLConfigPais A
INNER JOIN @TblImgResize B
ON 1 = 1
GO

USE BelcorpColombia
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblImgResize TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblImgResize
VALUES ('_mdpi'),('_hdpi'),('_xhdpi'),('_xxhdpi'),('_xxxhdpi')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos
SELECT 16200 + (ROW_NUMBER()OVER(ORDER BY A.ConfiguracionPaisID)),162,A.Codigo + B.Codigo,
	CASE WHEN A.Codigo IN('PN','DP') 
	THEN
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '210x140'
			WHEN B.Codigo = '_hdpi' THEN '315x210'
			WHEN B.Codigo = '_xhdpi' THEN '420x280'
			WHEN B.Codigo = '_xxhdpi' THEN '630x420'
			WHEN B.Codigo = '_xxxhdpi' THEN '840x560' END
	ELSE
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '95x215'
			WHEN B.Codigo = '_hdpi' THEN '142x322'
			WHEN B.Codigo = '_xhdpi' THEN '190x430'
			WHEN B.Codigo = '_xxhdpi' THEN '285x645'
			WHEN B.Codigo = '_xxxhdpi' THEN '380x860' END
	END, NULL
FROM @TBLConfigPais A
INNER JOIN @TblImgResize B
ON 1 = 1
GO

USE BelcorpSalvador
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblImgResize TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblImgResize
VALUES ('_mdpi'),('_hdpi'),('_xhdpi'),('_xxhdpi'),('_xxxhdpi')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos
SELECT 16200 + (ROW_NUMBER()OVER(ORDER BY A.ConfiguracionPaisID)),162,A.Codigo + B.Codigo,
	CASE WHEN A.Codigo IN('PN','DP') 
	THEN
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '210x140'
			WHEN B.Codigo = '_hdpi' THEN '315x210'
			WHEN B.Codigo = '_xhdpi' THEN '420x280'
			WHEN B.Codigo = '_xxhdpi' THEN '630x420'
			WHEN B.Codigo = '_xxxhdpi' THEN '840x560' END
	ELSE
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '95x215'
			WHEN B.Codigo = '_hdpi' THEN '142x322'
			WHEN B.Codigo = '_xhdpi' THEN '190x430'
			WHEN B.Codigo = '_xxhdpi' THEN '285x645'
			WHEN B.Codigo = '_xxxhdpi' THEN '380x860' END
	END, NULL
FROM @TBLConfigPais A
INNER JOIN @TblImgResize B
ON 1 = 1
GO

USE BelcorpPuertoRico
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblImgResize TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblImgResize
VALUES ('_mdpi'),('_hdpi'),('_xhdpi'),('_xxhdpi'),('_xxxhdpi')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos
SELECT 16200 + (ROW_NUMBER()OVER(ORDER BY A.ConfiguracionPaisID)),162,A.Codigo + B.Codigo,
	CASE WHEN A.Codigo IN('PN','DP') 
	THEN
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '210x140'
			WHEN B.Codigo = '_hdpi' THEN '315x210'
			WHEN B.Codigo = '_xhdpi' THEN '420x280'
			WHEN B.Codigo = '_xxhdpi' THEN '630x420'
			WHEN B.Codigo = '_xxxhdpi' THEN '840x560' END
	ELSE
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '95x215'
			WHEN B.Codigo = '_hdpi' THEN '142x322'
			WHEN B.Codigo = '_xhdpi' THEN '190x430'
			WHEN B.Codigo = '_xxhdpi' THEN '285x645'
			WHEN B.Codigo = '_xxxhdpi' THEN '380x860' END
	END, NULL
FROM @TBLConfigPais A
INNER JOIN @TblImgResize B
ON 1 = 1
GO

USE BelcorpPanama
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblImgResize TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblImgResize
VALUES ('_mdpi'),('_hdpi'),('_xhdpi'),('_xxhdpi'),('_xxxhdpi')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos
SELECT 16200 + (ROW_NUMBER()OVER(ORDER BY A.ConfiguracionPaisID)),162,A.Codigo + B.Codigo,
	CASE WHEN A.Codigo IN('PN','DP') 
	THEN
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '210x140'
			WHEN B.Codigo = '_hdpi' THEN '315x210'
			WHEN B.Codigo = '_xhdpi' THEN '420x280'
			WHEN B.Codigo = '_xxhdpi' THEN '630x420'
			WHEN B.Codigo = '_xxxhdpi' THEN '840x560' END
	ELSE
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '95x215'
			WHEN B.Codigo = '_hdpi' THEN '142x322'
			WHEN B.Codigo = '_xhdpi' THEN '190x430'
			WHEN B.Codigo = '_xxhdpi' THEN '285x645'
			WHEN B.Codigo = '_xxxhdpi' THEN '380x860' END
	END, NULL
FROM @TBLConfigPais A
INNER JOIN @TblImgResize B
ON 1 = 1
GO

USE BelcorpGuatemala
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblImgResize TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblImgResize
VALUES ('_mdpi'),('_hdpi'),('_xhdpi'),('_xxhdpi'),('_xxxhdpi')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos
SELECT 16200 + (ROW_NUMBER()OVER(ORDER BY A.ConfiguracionPaisID)),162,A.Codigo + B.Codigo,
	CASE WHEN A.Codigo IN('PN','DP') 
	THEN
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '210x140'
			WHEN B.Codigo = '_hdpi' THEN '315x210'
			WHEN B.Codigo = '_xhdpi' THEN '420x280'
			WHEN B.Codigo = '_xxhdpi' THEN '630x420'
			WHEN B.Codigo = '_xxxhdpi' THEN '840x560' END
	ELSE
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '95x215'
			WHEN B.Codigo = '_hdpi' THEN '142x322'
			WHEN B.Codigo = '_xhdpi' THEN '190x430'
			WHEN B.Codigo = '_xxhdpi' THEN '285x645'
			WHEN B.Codigo = '_xxxhdpi' THEN '380x860' END
	END, NULL
FROM @TBLConfigPais A
INNER JOIN @TblImgResize B
ON 1 = 1
GO

USE BelcorpEcuador
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblImgResize TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblImgResize
VALUES ('_mdpi'),('_hdpi'),('_xhdpi'),('_xxhdpi'),('_xxxhdpi')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos
SELECT 16200 + (ROW_NUMBER()OVER(ORDER BY A.ConfiguracionPaisID)),162,A.Codigo + B.Codigo,
	CASE WHEN A.Codigo IN('PN','DP') 
	THEN
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '210x140'
			WHEN B.Codigo = '_hdpi' THEN '315x210'
			WHEN B.Codigo = '_xhdpi' THEN '420x280'
			WHEN B.Codigo = '_xxhdpi' THEN '630x420'
			WHEN B.Codigo = '_xxxhdpi' THEN '840x560' END
	ELSE
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '95x215'
			WHEN B.Codigo = '_hdpi' THEN '142x322'
			WHEN B.Codigo = '_xhdpi' THEN '190x430'
			WHEN B.Codigo = '_xxhdpi' THEN '285x645'
			WHEN B.Codigo = '_xxxhdpi' THEN '380x860' END
	END, NULL
FROM @TBLConfigPais A
INNER JOIN @TblImgResize B
ON 1 = 1
GO

USE BelcorpDominicana
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblImgResize TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblImgResize
VALUES ('_mdpi'),('_hdpi'),('_xhdpi'),('_xxhdpi'),('_xxxhdpi')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos
SELECT 16200 + (ROW_NUMBER()OVER(ORDER BY A.ConfiguracionPaisID)),162,A.Codigo + B.Codigo,
	CASE WHEN A.Codigo IN('PN','DP') 
	THEN
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '210x140'
			WHEN B.Codigo = '_hdpi' THEN '315x210'
			WHEN B.Codigo = '_xhdpi' THEN '420x280'
			WHEN B.Codigo = '_xxhdpi' THEN '630x420'
			WHEN B.Codigo = '_xxxhdpi' THEN '840x560' END
	ELSE
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '95x215'
			WHEN B.Codigo = '_hdpi' THEN '142x322'
			WHEN B.Codigo = '_xhdpi' THEN '190x430'
			WHEN B.Codigo = '_xxhdpi' THEN '285x645'
			WHEN B.Codigo = '_xxxhdpi' THEN '380x860' END
	END, NULL
FROM @TBLConfigPais A
INNER JOIN @TblImgResize B
ON 1 = 1
GO

USE BelcorpCostaRica
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblImgResize TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblImgResize
VALUES ('_mdpi'),('_hdpi'),('_xhdpi'),('_xxhdpi'),('_xxxhdpi')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos
SELECT 16200 + (ROW_NUMBER()OVER(ORDER BY A.ConfiguracionPaisID)),162,A.Codigo + B.Codigo,
	CASE WHEN A.Codigo IN('PN','DP') 
	THEN
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '210x140'
			WHEN B.Codigo = '_hdpi' THEN '315x210'
			WHEN B.Codigo = '_xhdpi' THEN '420x280'
			WHEN B.Codigo = '_xxhdpi' THEN '630x420'
			WHEN B.Codigo = '_xxxhdpi' THEN '840x560' END
	ELSE
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '95x215'
			WHEN B.Codigo = '_hdpi' THEN '142x322'
			WHEN B.Codigo = '_xhdpi' THEN '190x430'
			WHEN B.Codigo = '_xxhdpi' THEN '285x645'
			WHEN B.Codigo = '_xxxhdpi' THEN '380x860' END
	END, NULL
FROM @TBLConfigPais A
INNER JOIN @TblImgResize B
ON 1 = 1
GO

USE BelcorpChile
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblImgResize TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblImgResize
VALUES ('_mdpi'),('_hdpi'),('_xhdpi'),('_xxhdpi'),('_xxxhdpi')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos
SELECT 16200 + (ROW_NUMBER()OVER(ORDER BY A.ConfiguracionPaisID)),162,A.Codigo + B.Codigo,
	CASE WHEN A.Codigo IN('PN','DP') 
	THEN
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '210x140'
			WHEN B.Codigo = '_hdpi' THEN '315x210'
			WHEN B.Codigo = '_xhdpi' THEN '420x280'
			WHEN B.Codigo = '_xxhdpi' THEN '630x420'
			WHEN B.Codigo = '_xxxhdpi' THEN '840x560' END
	ELSE
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '95x215'
			WHEN B.Codigo = '_hdpi' THEN '142x322'
			WHEN B.Codigo = '_xhdpi' THEN '190x430'
			WHEN B.Codigo = '_xxhdpi' THEN '285x645'
			WHEN B.Codigo = '_xxxhdpi' THEN '380x860' END
	END, NULL
FROM @TBLConfigPais A
INNER JOIN @TblImgResize B
ON 1 = 1
GO

USE BelcorpBolivia
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblImgResize TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblImgResize
VALUES ('_mdpi'),('_hdpi'),('_xhdpi'),('_xxhdpi'),('_xxxhdpi')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.TablaLogicaDatos WHERE TablaLogicaID = 162

INSERT INTO dbo.TablaLogicaDatos
SELECT 16200 + (ROW_NUMBER()OVER(ORDER BY A.ConfiguracionPaisID)),162,A.Codigo + B.Codigo,
	CASE WHEN A.Codigo IN('PN','DP') 
	THEN
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '210x140'
			WHEN B.Codigo = '_hdpi' THEN '315x210'
			WHEN B.Codigo = '_xhdpi' THEN '420x280'
			WHEN B.Codigo = '_xxhdpi' THEN '630x420'
			WHEN B.Codigo = '_xxxhdpi' THEN '840x560' END
	ELSE
		CASE 
			WHEN B.Codigo = '_mdpi' THEN '95x215'
			WHEN B.Codigo = '_hdpi' THEN '142x322'
			WHEN B.Codigo = '_xhdpi' THEN '190x430'
			WHEN B.Codigo = '_xxhdpi' THEN '285x645'
			WHEN B.Codigo = '_xxxhdpi' THEN '380x860' END
	END, NULL
FROM @TBLConfigPais A
INNER JOIN @TblImgResize B
ON 1 = 1
GO

