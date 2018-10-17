USE BelcorpPeru
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

USE BelcorpMexico
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

USE BelcorpColombia
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

USE BelcorpVenezuela
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

USE BelcorpSalvador
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

USE BelcorpPuertoRico
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

USE BelcorpPanama
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

USE BelcorpGuatemala
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

USE BelcorpEcuador
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

USE BelcorpDominicana
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

USE BelcorpCostaRica
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

USE BelcorpChile
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

USE BelcorpBolivia
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

