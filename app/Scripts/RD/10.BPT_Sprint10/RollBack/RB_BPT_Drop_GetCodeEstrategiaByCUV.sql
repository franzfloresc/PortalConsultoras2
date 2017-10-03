
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