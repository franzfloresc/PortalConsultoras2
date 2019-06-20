USE BelcorpPeru
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblConfigPaisDatos TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblConfigPaisDatos
VALUES ('AppOfertasHomeActivo'),('AppOfertasHomeImgExtension'),('AppOfertasHomeImgAncho'),('AppOfertasHomeImgAlto'),('AppOfertasHomeMsjMedida'),('AppOfertasHomeMsjFormato')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.ConfiguracionPaisDatos
WHERE CODIGO IN (SELECT Codigo FROM @TblConfigPaisDatos)

INSERT INTO dbo.ConfiguracionPaisDatos
SELECT A.ConfiguracionPaisID,B.Codigo,0,CASE WHEN B.ID = 1 THEN '1' 
											WHEN B.ID = 2 THEN 'jpg'
											WHEN B.ID = 3 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '840' ELSE '380' END
											WHEN B.ID = 4 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '560' ELSE '860' END
											WHEN B.ID = 5 THEN 'Las medidas no son correctas. Vuelve a intentar, por favor.'
											WHEN B.ID = 6 THEN 'El formato no es correcto. Vuelve a intentar, por favor.'
											ELSE '0' END,NULL,NULL,NULL,1,NULL
FROM @TBLConfigPais A
INNER JOIN @TblConfigPaisDatos B
ON 1 = 1
ORDER BY 1
GO

USE BelcorpMexico
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblConfigPaisDatos TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblConfigPaisDatos
VALUES ('AppOfertasHomeActivo'),('AppOfertasHomeImgExtension'),('AppOfertasHomeImgAncho'),('AppOfertasHomeImgAlto'),('AppOfertasHomeMsjMedida'),('AppOfertasHomeMsjFormato')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.ConfiguracionPaisDatos
WHERE CODIGO IN (SELECT Codigo FROM @TblConfigPaisDatos)

INSERT INTO dbo.ConfiguracionPaisDatos
SELECT A.ConfiguracionPaisID,B.Codigo,0,CASE WHEN B.ID = 1 THEN '1' 
											WHEN B.ID = 2 THEN 'jpg'
											WHEN B.ID = 3 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '840' ELSE '380' END
											WHEN B.ID = 4 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '560' ELSE '860' END
											WHEN B.ID = 5 THEN 'Las medidas no son correctas. Vuelve a intentar, por favor.'
											WHEN B.ID = 6 THEN 'El formato no es correcto. Vuelve a intentar, por favor.'
											ELSE '0' END,NULL,NULL,NULL,1,NULL
FROM @TBLConfigPais A
INNER JOIN @TblConfigPaisDatos B
ON 1 = 1
ORDER BY 1
GO

USE BelcorpColombia
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblConfigPaisDatos TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblConfigPaisDatos
VALUES ('AppOfertasHomeActivo'),('AppOfertasHomeImgExtension'),('AppOfertasHomeImgAncho'),('AppOfertasHomeImgAlto'),('AppOfertasHomeMsjMedida'),('AppOfertasHomeMsjFormato')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.ConfiguracionPaisDatos
WHERE CODIGO IN (SELECT Codigo FROM @TblConfigPaisDatos)

INSERT INTO dbo.ConfiguracionPaisDatos
SELECT A.ConfiguracionPaisID,B.Codigo,0,CASE WHEN B.ID = 1 THEN '1' 
											WHEN B.ID = 2 THEN 'jpg'
											WHEN B.ID = 3 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '840' ELSE '380' END
											WHEN B.ID = 4 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '560' ELSE '860' END
											WHEN B.ID = 5 THEN 'Las medidas no son correctas. Vuelve a intentar, por favor.'
											WHEN B.ID = 6 THEN 'El formato no es correcto. Vuelve a intentar, por favor.'
											ELSE '0' END,NULL,NULL,NULL,1,NULL
FROM @TBLConfigPais A
INNER JOIN @TblConfigPaisDatos B
ON 1 = 1
ORDER BY 1
GO

USE BelcorpSalvador
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblConfigPaisDatos TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblConfigPaisDatos
VALUES ('AppOfertasHomeActivo'),('AppOfertasHomeImgExtension'),('AppOfertasHomeImgAncho'),('AppOfertasHomeImgAlto'),('AppOfertasHomeMsjMedida'),('AppOfertasHomeMsjFormato')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.ConfiguracionPaisDatos
WHERE CODIGO IN (SELECT Codigo FROM @TblConfigPaisDatos)

INSERT INTO dbo.ConfiguracionPaisDatos
SELECT A.ConfiguracionPaisID,B.Codigo,0,CASE WHEN B.ID = 1 THEN '1' 
											WHEN B.ID = 2 THEN 'jpg'
											WHEN B.ID = 3 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '840' ELSE '380' END
											WHEN B.ID = 4 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '560' ELSE '860' END
											WHEN B.ID = 5 THEN 'Las medidas no son correctas. Vuelve a intentar, por favor.'
											WHEN B.ID = 6 THEN 'El formato no es correcto. Vuelve a intentar, por favor.'
											ELSE '0' END,NULL,NULL,NULL,1,NULL
FROM @TBLConfigPais A
INNER JOIN @TblConfigPaisDatos B
ON 1 = 1
ORDER BY 1
GO

USE BelcorpPuertoRico
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblConfigPaisDatos TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblConfigPaisDatos
VALUES ('AppOfertasHomeActivo'),('AppOfertasHomeImgExtension'),('AppOfertasHomeImgAncho'),('AppOfertasHomeImgAlto'),('AppOfertasHomeMsjMedida'),('AppOfertasHomeMsjFormato')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.ConfiguracionPaisDatos
WHERE CODIGO IN (SELECT Codigo FROM @TblConfigPaisDatos)

INSERT INTO dbo.ConfiguracionPaisDatos
SELECT A.ConfiguracionPaisID,B.Codigo,0,CASE WHEN B.ID = 1 THEN '1' 
											WHEN B.ID = 2 THEN 'jpg'
											WHEN B.ID = 3 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '840' ELSE '380' END
											WHEN B.ID = 4 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '560' ELSE '860' END
											WHEN B.ID = 5 THEN 'Las medidas no son correctas. Vuelve a intentar, por favor.'
											WHEN B.ID = 6 THEN 'El formato no es correcto. Vuelve a intentar, por favor.'
											ELSE '0' END,NULL,NULL,NULL,1,NULL
FROM @TBLConfigPais A
INNER JOIN @TblConfigPaisDatos B
ON 1 = 1
ORDER BY 1
GO

USE BelcorpPanama
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblConfigPaisDatos TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblConfigPaisDatos
VALUES ('AppOfertasHomeActivo'),('AppOfertasHomeImgExtension'),('AppOfertasHomeImgAncho'),('AppOfertasHomeImgAlto'),('AppOfertasHomeMsjMedida'),('AppOfertasHomeMsjFormato')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.ConfiguracionPaisDatos
WHERE CODIGO IN (SELECT Codigo FROM @TblConfigPaisDatos)

INSERT INTO dbo.ConfiguracionPaisDatos
SELECT A.ConfiguracionPaisID,B.Codigo,0,CASE WHEN B.ID = 1 THEN '1' 
											WHEN B.ID = 2 THEN 'jpg'
											WHEN B.ID = 3 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '840' ELSE '380' END
											WHEN B.ID = 4 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '560' ELSE '860' END
											WHEN B.ID = 5 THEN 'Las medidas no son correctas. Vuelve a intentar, por favor.'
											WHEN B.ID = 6 THEN 'El formato no es correcto. Vuelve a intentar, por favor.'
											ELSE '0' END,NULL,NULL,NULL,1,NULL
FROM @TBLConfigPais A
INNER JOIN @TblConfigPaisDatos B
ON 1 = 1
ORDER BY 1
GO

USE BelcorpGuatemala
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblConfigPaisDatos TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblConfigPaisDatos
VALUES ('AppOfertasHomeActivo'),('AppOfertasHomeImgExtension'),('AppOfertasHomeImgAncho'),('AppOfertasHomeImgAlto'),('AppOfertasHomeMsjMedida'),('AppOfertasHomeMsjFormato')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.ConfiguracionPaisDatos
WHERE CODIGO IN (SELECT Codigo FROM @TblConfigPaisDatos)

INSERT INTO dbo.ConfiguracionPaisDatos
SELECT A.ConfiguracionPaisID,B.Codigo,0,CASE WHEN B.ID = 1 THEN '1' 
											WHEN B.ID = 2 THEN 'jpg'
											WHEN B.ID = 3 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '840' ELSE '380' END
											WHEN B.ID = 4 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '560' ELSE '860' END
											WHEN B.ID = 5 THEN 'Las medidas no son correctas. Vuelve a intentar, por favor.'
											WHEN B.ID = 6 THEN 'El formato no es correcto. Vuelve a intentar, por favor.'
											ELSE '0' END,NULL,NULL,NULL,1,NULL
FROM @TBLConfigPais A
INNER JOIN @TblConfigPaisDatos B
ON 1 = 1
ORDER BY 1
GO

USE BelcorpEcuador
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblConfigPaisDatos TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblConfigPaisDatos
VALUES ('AppOfertasHomeActivo'),('AppOfertasHomeImgExtension'),('AppOfertasHomeImgAncho'),('AppOfertasHomeImgAlto'),('AppOfertasHomeMsjMedida'),('AppOfertasHomeMsjFormato')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.ConfiguracionPaisDatos
WHERE CODIGO IN (SELECT Codigo FROM @TblConfigPaisDatos)

INSERT INTO dbo.ConfiguracionPaisDatos
SELECT A.ConfiguracionPaisID,B.Codigo,0,CASE WHEN B.ID = 1 THEN '1' 
											WHEN B.ID = 2 THEN 'jpg'
											WHEN B.ID = 3 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '840' ELSE '380' END
											WHEN B.ID = 4 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '560' ELSE '860' END
											WHEN B.ID = 5 THEN 'Las medidas no son correctas. Vuelve a intentar, por favor.'
											WHEN B.ID = 6 THEN 'El formato no es correcto. Vuelve a intentar, por favor.'
											ELSE '0' END,NULL,NULL,NULL,1,NULL
FROM @TBLConfigPais A
INNER JOIN @TblConfigPaisDatos B
ON 1 = 1
ORDER BY 1
GO

USE BelcorpDominicana
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblConfigPaisDatos TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblConfigPaisDatos
VALUES ('AppOfertasHomeActivo'),('AppOfertasHomeImgExtension'),('AppOfertasHomeImgAncho'),('AppOfertasHomeImgAlto'),('AppOfertasHomeMsjMedida'),('AppOfertasHomeMsjFormato')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.ConfiguracionPaisDatos
WHERE CODIGO IN (SELECT Codigo FROM @TblConfigPaisDatos)

INSERT INTO dbo.ConfiguracionPaisDatos
SELECT A.ConfiguracionPaisID,B.Codigo,0,CASE WHEN B.ID = 1 THEN '1' 
											WHEN B.ID = 2 THEN 'jpg'
											WHEN B.ID = 3 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '840' ELSE '380' END
											WHEN B.ID = 4 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '560' ELSE '860' END
											WHEN B.ID = 5 THEN 'Las medidas no son correctas. Vuelve a intentar, por favor.'
											WHEN B.ID = 6 THEN 'El formato no es correcto. Vuelve a intentar, por favor.'
											ELSE '0' END,NULL,NULL,NULL,1,NULL
FROM @TBLConfigPais A
INNER JOIN @TblConfigPaisDatos B
ON 1 = 1
ORDER BY 1
GO

USE BelcorpCostaRica
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblConfigPaisDatos TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblConfigPaisDatos
VALUES ('AppOfertasHomeActivo'),('AppOfertasHomeImgExtension'),('AppOfertasHomeImgAncho'),('AppOfertasHomeImgAlto'),('AppOfertasHomeMsjMedida'),('AppOfertasHomeMsjFormato')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.ConfiguracionPaisDatos
WHERE CODIGO IN (SELECT Codigo FROM @TblConfigPaisDatos)

INSERT INTO dbo.ConfiguracionPaisDatos
SELECT A.ConfiguracionPaisID,B.Codigo,0,CASE WHEN B.ID = 1 THEN '1' 
											WHEN B.ID = 2 THEN 'jpg'
											WHEN B.ID = 3 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '840' ELSE '380' END
											WHEN B.ID = 4 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '560' ELSE '860' END
											WHEN B.ID = 5 THEN 'Las medidas no son correctas. Vuelve a intentar, por favor.'
											WHEN B.ID = 6 THEN 'El formato no es correcto. Vuelve a intentar, por favor.'
											ELSE '0' END,NULL,NULL,NULL,1,NULL
FROM @TBLConfigPais A
INNER JOIN @TblConfigPaisDatos B
ON 1 = 1
ORDER BY 1
GO

USE BelcorpChile
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblConfigPaisDatos TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblConfigPaisDatos
VALUES ('AppOfertasHomeActivo'),('AppOfertasHomeImgExtension'),('AppOfertasHomeImgAncho'),('AppOfertasHomeImgAlto'),('AppOfertasHomeMsjMedida'),('AppOfertasHomeMsjFormato')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.ConfiguracionPaisDatos
WHERE CODIGO IN (SELECT Codigo FROM @TblConfigPaisDatos)

INSERT INTO dbo.ConfiguracionPaisDatos
SELECT A.ConfiguracionPaisID,B.Codigo,0,CASE WHEN B.ID = 1 THEN '1' 
											WHEN B.ID = 2 THEN 'jpg'
											WHEN B.ID = 3 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '840' ELSE '380' END
											WHEN B.ID = 4 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '560' ELSE '860' END
											WHEN B.ID = 5 THEN 'Las medidas no son correctas. Vuelve a intentar, por favor.'
											WHEN B.ID = 6 THEN 'El formato no es correcto. Vuelve a intentar, por favor.'
											ELSE '0' END,NULL,NULL,NULL,1,NULL
FROM @TBLConfigPais A
INNER JOIN @TblConfigPaisDatos B
ON 1 = 1
ORDER BY 1
GO

USE BelcorpBolivia
GO

DECLARE @TBLConfigPais TABLE
(
	ConfiguracionPaisID INT NOT NULL,
	Codigo VARCHAR(100) NOT NULL

	PRIMARY KEY (ConfiguracionPaisID)
)
DECLARE @TblConfigPaisDatos TABLE
(
	ID INT IDENTITY(1,1) NOT NULL,
	Codigo VARCHAR(50)NOT NULL,

	PRIMARY KEY(ID)
)

INSERT INTO @TblConfigPaisDatos
VALUES ('AppOfertasHomeActivo'),('AppOfertasHomeImgExtension'),('AppOfertasHomeImgAncho'),('AppOfertasHomeImgAlto'),('AppOfertasHomeMsjMedida'),('AppOfertasHomeMsjFormato')

INSERT INTO @TBLConfigPais (ConfiguracionPaisID,Codigo)
SELECT ConfiguracionPaisID,Codigo FROM CONFIGURACIONPAIS WHERE ConfiguracionPaisID IN(SELECT DISTINCT ConfiguracionPaisID FROM ConfiguracionOfertasHome with(nolock))

DELETE FROM dbo.ConfiguracionPaisDatos
WHERE CODIGO IN (SELECT Codigo FROM @TblConfigPaisDatos)

INSERT INTO dbo.ConfiguracionPaisDatos
SELECT A.ConfiguracionPaisID,B.Codigo,0,CASE WHEN B.ID = 1 THEN '1' 
											WHEN B.ID = 2 THEN 'jpg'
											WHEN B.ID = 3 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '840' ELSE '380' END
											WHEN B.ID = 4 THEN CASE WHEN A.Codigo IN('PN','DP') THEN '560' ELSE '860' END
											WHEN B.ID = 5 THEN 'Las medidas no son correctas. Vuelve a intentar, por favor.'
											WHEN B.ID = 6 THEN 'El formato no es correcto. Vuelve a intentar, por favor.'
											ELSE '0' END,NULL,NULL,NULL,1,NULL
FROM @TBLConfigPais A
INNER JOIN @TblConfigPaisDatos B
ON 1 = 1
ORDER BY 1
GO

