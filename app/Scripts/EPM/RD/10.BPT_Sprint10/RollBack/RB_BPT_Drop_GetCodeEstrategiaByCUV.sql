USE BelcorpPeru
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetCodeEstrategiaByCUV
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

go

GO

USE BelcorpMexico
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetCodeEstrategiaByCUV
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

go

GO

USE BelcorpColombia
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetCodeEstrategiaByCUV
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

go

GO

USE BelcorpVenezuela
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetCodeEstrategiaByCUV
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

go

GO

USE BelcorpSalvador
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetCodeEstrategiaByCUV
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

go

GO

USE BelcorpPuertoRico
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetCodeEstrategiaByCUV
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

go

GO

USE BelcorpPanama
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetCodeEstrategiaByCUV
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

go

GO

USE BelcorpGuatemala
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetCodeEstrategiaByCUV
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

go

GO

USE BelcorpEcuador
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetCodeEstrategiaByCUV
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

go

GO

USE BelcorpDominicana
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetCodeEstrategiaByCUV
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

go

GO

USE BelcorpCostaRica
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetCodeEstrategiaByCUV
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

go

GO

USE BelcorpChile
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetCodeEstrategiaByCUV
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

go

GO

USE BelcorpBolivia
GO

GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCodeEstrategiaByCUV]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetCodeEstrategiaByCUV
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

go

GO

