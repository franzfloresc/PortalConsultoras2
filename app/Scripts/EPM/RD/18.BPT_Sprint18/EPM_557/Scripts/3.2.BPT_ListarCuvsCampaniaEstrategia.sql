USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarCuvsCampaniaEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
GO

CREATE PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
AS
BEGIN
	DECLARE @CampaniaActual INT;
	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	PRINT @CampaniaActual;

	DECLARE @CampaniaSiguiente INT
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	PRINT @CampaniaSiguiente;

	SELECT CampaniaID, CUV2 FROM Estrategia WHERE CampaniaID in (@CampaniaActual, @CampaniaSiguiente)
	GROUP BY CUV2, CampaniaID
END
GO

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarCuvsCampaniaEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
GO

CREATE PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
AS
BEGIN
	DECLARE @CampaniaActual INT;
	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	PRINT @CampaniaActual;

	DECLARE @CampaniaSiguiente INT
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	PRINT @CampaniaSiguiente;

	SELECT CampaniaID, CUV2 FROM Estrategia WHERE CampaniaID in (@CampaniaActual, @CampaniaSiguiente)
	GROUP BY CUV2, CampaniaID
END
GO

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarCuvsCampaniaEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
GO

CREATE PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
AS
BEGIN
	DECLARE @CampaniaActual INT;
	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	PRINT @CampaniaActual;

	DECLARE @CampaniaSiguiente INT
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	PRINT @CampaniaSiguiente;

	SELECT CampaniaID, CUV2 FROM Estrategia WHERE CampaniaID in (@CampaniaActual, @CampaniaSiguiente)
	GROUP BY CUV2, CampaniaID
END
GO

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarCuvsCampaniaEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
GO

CREATE PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
AS
BEGIN
	DECLARE @CampaniaActual INT;
	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	PRINT @CampaniaActual;

	DECLARE @CampaniaSiguiente INT
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	PRINT @CampaniaSiguiente;

	SELECT CampaniaID, CUV2 FROM Estrategia WHERE CampaniaID in (@CampaniaActual, @CampaniaSiguiente)
	GROUP BY CUV2, CampaniaID
END
GO

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarCuvsCampaniaEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
GO

CREATE PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
AS
BEGIN
	DECLARE @CampaniaActual INT;
	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	PRINT @CampaniaActual;

	DECLARE @CampaniaSiguiente INT
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	PRINT @CampaniaSiguiente;

	SELECT CampaniaID, CUV2 FROM Estrategia WHERE CampaniaID in (@CampaniaActual, @CampaniaSiguiente)
	GROUP BY CUV2, CampaniaID
END
GO

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarCuvsCampaniaEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
GO

CREATE PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
AS
BEGIN
	DECLARE @CampaniaActual INT;
	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	PRINT @CampaniaActual;

	DECLARE @CampaniaSiguiente INT
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	PRINT @CampaniaSiguiente;

	SELECT CampaniaID, CUV2 FROM Estrategia WHERE CampaniaID in (@CampaniaActual, @CampaniaSiguiente)
	GROUP BY CUV2, CampaniaID
END
GO

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarCuvsCampaniaEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
GO

CREATE PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
AS
BEGIN
	DECLARE @CampaniaActual INT;
	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	PRINT @CampaniaActual;

	DECLARE @CampaniaSiguiente INT
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	PRINT @CampaniaSiguiente;

	SELECT CampaniaID, CUV2 FROM Estrategia WHERE CampaniaID in (@CampaniaActual, @CampaniaSiguiente)
	GROUP BY CUV2, CampaniaID
END
GO

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarCuvsCampaniaEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
GO

CREATE PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
AS
BEGIN
	DECLARE @CampaniaActual INT;
	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	PRINT @CampaniaActual;

	DECLARE @CampaniaSiguiente INT
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	PRINT @CampaniaSiguiente;

	SELECT CampaniaID, CUV2 FROM Estrategia WHERE CampaniaID in (@CampaniaActual, @CampaniaSiguiente)
	GROUP BY CUV2, CampaniaID
END
GO

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarCuvsCampaniaEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
GO

CREATE PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
AS
BEGIN
	DECLARE @CampaniaActual INT;
	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	PRINT @CampaniaActual;

	DECLARE @CampaniaSiguiente INT
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	PRINT @CampaniaSiguiente;

	SELECT CampaniaID, CUV2 FROM Estrategia WHERE CampaniaID in (@CampaniaActual, @CampaniaSiguiente)
	GROUP BY CUV2, CampaniaID
END
GO

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarCuvsCampaniaEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
GO

CREATE PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
AS
BEGIN
	DECLARE @CampaniaActual INT;
	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	PRINT @CampaniaActual;

	DECLARE @CampaniaSiguiente INT
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	PRINT @CampaniaSiguiente;

	SELECT CampaniaID, CUV2 FROM Estrategia WHERE CampaniaID in (@CampaniaActual, @CampaniaSiguiente)
	GROUP BY CUV2, CampaniaID
END
GO

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarCuvsCampaniaEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
GO

CREATE PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
AS
BEGIN
	DECLARE @CampaniaActual INT;
	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	PRINT @CampaniaActual;

	DECLARE @CampaniaSiguiente INT
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	PRINT @CampaniaSiguiente;

	SELECT CampaniaID, CUV2 FROM Estrategia WHERE CampaniaID in (@CampaniaActual, @CampaniaSiguiente)
	GROUP BY CUV2, CampaniaID
END
GO

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarCuvsCampaniaEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
GO

CREATE PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
AS
BEGIN
	DECLARE @CampaniaActual INT;
	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	PRINT @CampaniaActual;

	DECLARE @CampaniaSiguiente INT
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	PRINT @CampaniaSiguiente;

	SELECT CampaniaID, CUV2 FROM Estrategia WHERE CampaniaID in (@CampaniaActual, @CampaniaSiguiente)
	GROUP BY CUV2, CampaniaID
END
GO

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarCuvsCampaniaEstrategia]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
GO

CREATE PROCEDURE [dbo].[ListarCuvsCampaniaEstrategia]
AS
BEGIN
	DECLARE @CampaniaActual INT;
	SET @CampaniaActual = dbo.fnGetCampaniaActualPais();
	PRINT @CampaniaActual;

	DECLARE @CampaniaSiguiente INT
	SET @CampaniaSiguiente = dbo.fnGetCampaniaSiguiente(@CampaniaActual);
	PRINT @CampaniaSiguiente;

	SELECT CampaniaID, CUV2 FROM Estrategia WHERE CampaniaID in (@CampaniaActual, @CampaniaSiguiente)
	GROUP BY CUV2, CampaniaID
END
GO

