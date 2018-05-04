USE [BelcorpPeru_BPT]
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[ListarEstrategiasForzadas]') 
	AND type in (N'FN',N'TF')
) 
	DROP FUNCTION [dbo].[ListarEstrategiasForzadas]
GO

CREATE FUNCTION [dbo].[ListarEstrategiasForzadas]
(
	@CampaniaID INT,
	@EstrategiaCodigo varchar(100)
)
RETURNS @OfertasPersonalizadas TABLE (
	Orden int,
	CUV char(6),
	TipoPersonalizacion char(3),
	FlagRevista int,
	AnioCampanaVenta int
)
AS
BEGIN

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID);
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	DECLARE @TipoPersonalizacion varchar(5) = ''

	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SET @TipoPersonalizacion = [dbo].[fnGetTipoPersonalizacion](@EstrategiaCodigo)

	INSERT INTO @OfertasPersonalizadas
	SELECT isnull(Orden,0) Orden,CUV,TipoPersonalizacion,FlagRevista,convert(int,AnioCampanaVenta) AnioCampanaVenta FROM ods.OfertasPersonalizadas op with(nolock) where
	op.CodConsultora = @codConsultoraDefault
	and op.AnioCampanaVenta = @StrCampaniaID
	and op.TipoPersonalizacion = @TipoPersonalizacion
	
	RETURN
END