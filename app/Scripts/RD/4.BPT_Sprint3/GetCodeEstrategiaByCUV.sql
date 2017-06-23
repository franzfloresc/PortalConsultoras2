USE [BelcorpPeru]
GO
/****** Object:  StoredProcedure [dbo].[GetCodeEstrategiaByCUV]    Script Date: 23/06/2017 12:11:31 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[GetCodeEstrategiaByCUV]
	@CampaniaID		  INT,
	@Cuv			  VARCHAR(20)
AS
BEGIN
	SELECT TE.Codigo
	FROM Estrategia E 
	INNER JOIN TipoEstrategia TE on E.TipoEstrategiaID = TE.TipoEstrategiaID
	WHERE E.CUV2 = @Cuv and CampaniaID = @CampaniaID
END