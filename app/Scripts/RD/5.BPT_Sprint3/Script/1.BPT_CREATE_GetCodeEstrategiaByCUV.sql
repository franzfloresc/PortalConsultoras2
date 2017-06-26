USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
GO

CREATE PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
	@CampaniaID		  INT,
	@Cuv			  VARCHAR(20)
AS
BEGIN
	SELECT TE.Codigo
	FROM Estrategia E 
	INNER JOIN TipoEstrategia TE on E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE E.CUV2 = @Cuv and CampaniaID = @CampaniaID
END
GO
/*end*/

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
GO

CREATE PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
	@CampaniaID		  INT,
	@Cuv			  VARCHAR(20)
AS
BEGIN
	SELECT TE.Codigo
	FROM Estrategia E 
	INNER JOIN TipoEstrategia TE on E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE E.CUV2 = @Cuv and CampaniaID = @CampaniaID
END
GO
/*end*/

USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
GO

CREATE PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
	@CampaniaID		  INT,
	@Cuv			  VARCHAR(20)
AS
BEGIN
	SELECT TE.Codigo
	FROM Estrategia E 
	INNER JOIN TipoEstrategia TE on E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE E.CUV2 = @Cuv and CampaniaID = @CampaniaID
END
GO
/*end*/

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
GO

CREATE PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
	@CampaniaID		  INT,
	@Cuv			  VARCHAR(20)
AS
BEGIN
	SELECT TE.Codigo
	FROM Estrategia E 
	INNER JOIN TipoEstrategia TE on E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE E.CUV2 = @Cuv and CampaniaID = @CampaniaID
END
GO
/*end*/

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
GO

CREATE PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
	@CampaniaID		  INT,
	@Cuv			  VARCHAR(20)
AS
BEGIN
	SELECT TE.Codigo
	FROM Estrategia E 
	INNER JOIN TipoEstrategia TE on E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE E.CUV2 = @Cuv and CampaniaID = @CampaniaID
END
GO
/*end*/

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
GO

CREATE PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
	@CampaniaID		  INT,
	@Cuv			  VARCHAR(20)
AS
BEGIN
	SELECT TE.Codigo
	FROM Estrategia E 
	INNER JOIN TipoEstrategia TE on E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE E.CUV2 = @Cuv and CampaniaID = @CampaniaID
END
GO
/*end*/

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
GO

CREATE PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
	@CampaniaID		  INT,
	@Cuv			  VARCHAR(20)
AS
BEGIN
	SELECT TE.Codigo
	FROM Estrategia E 
	INNER JOIN TipoEstrategia TE on E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE E.CUV2 = @Cuv and CampaniaID = @CampaniaID
END
GO
/*end*/

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
GO

CREATE PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
	@CampaniaID		  INT,
	@Cuv			  VARCHAR(20)
AS
BEGIN
	SELECT TE.Codigo
	FROM Estrategia E 
	INNER JOIN TipoEstrategia TE on E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE E.CUV2 = @Cuv and CampaniaID = @CampaniaID
END
GO
/*end*/

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
GO

CREATE PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
	@CampaniaID		  INT,
	@Cuv			  VARCHAR(20)
AS
BEGIN
	SELECT TE.Codigo
	FROM Estrategia E 
	INNER JOIN TipoEstrategia TE on E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE E.CUV2 = @Cuv and CampaniaID = @CampaniaID
END
GO
/*end*/

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
GO

CREATE PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
	@CampaniaID		  INT,
	@Cuv			  VARCHAR(20)
AS
BEGIN
	SELECT TE.Codigo
	FROM Estrategia E 
	INNER JOIN TipoEstrategia TE on E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE E.CUV2 = @Cuv and CampaniaID = @CampaniaID
END
GO
/*end*/

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
GO

CREATE PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
	@CampaniaID		  INT,
	@Cuv			  VARCHAR(20)
AS
BEGIN
	SELECT TE.Codigo
	FROM Estrategia E 
	INNER JOIN TipoEstrategia TE on E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE E.CUV2 = @Cuv and CampaniaID = @CampaniaID
END
GO
/*end*/

USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
GO

CREATE PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
	@CampaniaID		  INT,
	@Cuv			  VARCHAR(20)
AS
BEGIN
	SELECT TE.Codigo
	FROM Estrategia E 
	INNER JOIN TipoEstrategia TE on E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE E.CUV2 = @Cuv and CampaniaID = @CampaniaID
END
GO
/*end*/

USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
GO

CREATE PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
	@CampaniaID		  INT,
	@Cuv			  VARCHAR(20)
AS
BEGIN
	SELECT TE.Codigo
	FROM Estrategia E 
	INNER JOIN TipoEstrategia TE on E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE E.CUV2 = @Cuv and CampaniaID = @CampaniaID
END
GO
/*end*/

