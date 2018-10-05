USE BelcorpPeru_BPT
GO

--USE BelcorpChile_BPT
--GO

--USE BelcorpCostaRica_BPT
--GO
PRINT DB_NAME()

IF EXISTS (	SELECT 1
			FROM SYS.objects SO
			WHERE SO.[name] = 'ListarOfertasPersonalizadas'
			AND SO.[type] = 'P'	)
BEGIN
	PRINT 'DROP PROCEDURE ''ListarOfertasPersonalizadas'''
	DROP PROCEDURE ListarOfertasPersonalizadas
END

GO 

PRINT 'CREATE PROCEDURE ''ListarOfertasPersonalizadas'''
GO

CREATE PROCEDURE ListarOfertasPersonalizadas
(
	@CampaniaID INT = 0,
	@CodigosTipoPersonalizacion varchar(100) = '',
	@CodConsultora VARCHAR(9) = '',
	@MaterialGanancia int = NULL
)

AS
BEGIN
	DECLARE @strCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID);
	--
	DECLARE @TipoPersonalizacion TABLE
	(
		TipoPersonalizacion VARCHAR(3)
	)
	INSERT INTO @TipoPersonalizacion
	SELECT item
	FROM [dbo].[fnSplit](@CodigosTipoPersonalizacion, ';') 

	PRINT @MaterialGanancia

	SELECT 
	Orden = ISNULL(OP.Orden,0) ,
	OP.Cuv,
	OP.TipoPersonalizacion,
	OP.FlagRevista,
	AnioCampanaVenta = CONVERT(INT,op.AnioCampanaVenta)
	FROM @TipoPersonalizacion TP
		JOIN ods.OfertasPersonalizadas op WITH(NOLOCK) 
			ON op.TipoPersonalizacion = TP.TipoPersonalizacion
			AND op.CodConsultora = @CodConsultora
			AND op.AnioCampanaVenta = @strCampaniaID
	WHERE 1 = CASE 
				WHEN @MaterialGanancia IS NULL THEN 1 
				WHEN ISNULL(OP.MaterialGanancia,0) = @MaterialGanancia THEN 1
				ELSE 0
				END
			
END
GO
