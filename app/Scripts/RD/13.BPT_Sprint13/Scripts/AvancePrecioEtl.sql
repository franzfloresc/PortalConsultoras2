USE [BelcorpPeru_BPT]
GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ObtenerCampaniaCuvEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ObtenerCampaniaCuvEstrategia
GO

CREATE PROCEDURE dbo.ObtenerCampaniaCuvEstrategia
AS 
BEGIN 

	DECLARE @Campania INT
	SET @Campania = dbo.fnGetCampaniaActualPais()

	DECLARE @CampaniaSiguiente INT
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@Campania)

	SELECT CampaniaID, CUV2 FROM Estrategia WHERE CampaniaID in (@Campania, @CampaniaSiguiente)
	GROUP BY CUV2, CampaniaID
END
GO 

EXEC ObtenerCampaniaCuv
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EstrategiaPrecioTemporal]') AND type in (N'U'))
	DROP TABLE [dbo].[EstrategiaPrecioTemporal]
GO

CREATE TABLE [dbo].[EstrategiaPrecioTemporal](
	[Campania] [int] NOT NULL,
	[Cuv] [varchar](6) NOT NULL,
	[Precio] [decimal](18,2) NOT NULL,
	[Ganancia] [decimal](18,2) NOT NULL
)
GO

INSERT INTO [dbo].[EstrategiaPrecioTemporal] VALUES (201716, '01958', 100.50, 20.50)
INSERT INTO [dbo].[EstrategiaPrecioTemporal] VALUES (201716, '01966', 100.50, 20.50)
INSERT INTO [dbo].[EstrategiaPrecioTemporal] VALUES (201716, '02905', 100.50, 20.50)
INSERT INTO [dbo].[EstrategiaPrecioTemporal] VALUES (201716, '03034', 100.50, 20.50)
INSERT INTO [dbo].[EstrategiaPrecioTemporal] VALUES (201716, '10091', 100.50, 20.50)
INSERT INTO [dbo].[EstrategiaPrecioTemporal] VALUES (201716, '15224', 100.50, 20.50)
GO

SELECT * FROM EstrategiaPrecioTemporal
GO

IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'ActualizarPrecioEstrategia') AND type IN ( N'P', N'PC' ) ) 
DROP PROCEDURE dbo.ActualizarPrecioEstrategia
GO

CREATE PROCEDURE ActualizarPrecioEstrategia
AS
BEGIN 
	UPDATE Estrategia 
		SET Precio2 = ET.Precio,
		Ganancia = ET.Ganancia,
		Precio = ET.Precio + ET.Ganancia
	FROM Estrategia E
		INNER JOIN EstrategiaPrecioTemporal ET  
		ON E.CampaniaID = ET.Campania AND E.CUV2 = ET.Cuv
END
GO

EXEC ActualizarPrecioEstrategia
GO

SELECT * FROM Estrategia WHERE CampaniaID = 201716 AND CUV2 = '01958'
GO