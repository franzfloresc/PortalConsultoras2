GO
USE BelcorpPeru
GO


GO
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
	AnioCampanaVenta = CONVERT(INT,op.AnioCampanaVenta),
	--CodigoTipoEstrategia = dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion),
	TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion))
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


GO
USE BelcorpMexico
GO


GO
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
	AnioCampanaVenta = CONVERT(INT,op.AnioCampanaVenta),
	--CodigoTipoEstrategia = dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion),
	TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion))
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


GO
USE BelcorpColombia
GO


GO
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
	AnioCampanaVenta = CONVERT(INT,op.AnioCampanaVenta),
	--CodigoTipoEstrategia = dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion),
	TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion))
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


GO
USE BelcorpSalvador
GO


GO
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
	AnioCampanaVenta = CONVERT(INT,op.AnioCampanaVenta),
	--CodigoTipoEstrategia = dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion),
	TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion))
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


GO
USE BelcorpPuertoRico
GO


GO
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
	AnioCampanaVenta = CONVERT(INT,op.AnioCampanaVenta),
	--CodigoTipoEstrategia = dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion),
	TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion))
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


GO
USE BelcorpPanama
GO


GO
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
	AnioCampanaVenta = CONVERT(INT,op.AnioCampanaVenta),
	--CodigoTipoEstrategia = dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion),
	TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion))
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


GO
USE BelcorpGuatemala
GO


GO
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
	AnioCampanaVenta = CONVERT(INT,op.AnioCampanaVenta),
	--CodigoTipoEstrategia = dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion),
	TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion))
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


GO
USE BelcorpEcuador
GO


GO
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
	AnioCampanaVenta = CONVERT(INT,op.AnioCampanaVenta),
	--CodigoTipoEstrategia = dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion),
	TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion))
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


GO
USE BelcorpDominicana
GO


GO
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
	AnioCampanaVenta = CONVERT(INT,op.AnioCampanaVenta),
	--CodigoTipoEstrategia = dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion),
	TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion))
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


GO
USE BelcorpCostaRica
GO


GO
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
	AnioCampanaVenta = CONVERT(INT,op.AnioCampanaVenta),
	--CodigoTipoEstrategia = dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion),
	TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion))
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


GO
USE BelcorpChile
GO


GO
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
	AnioCampanaVenta = CONVERT(INT,op.AnioCampanaVenta),
	--CodigoTipoEstrategia = dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion),
	TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion))
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


GO
USE BelcorpBolivia
GO


GO
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
	AnioCampanaVenta = CONVERT(INT,op.AnioCampanaVenta),
	--CodigoTipoEstrategia = dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion),
	TipoEstrategiaId = dbo.fnGetTipoEstrategiaId(dbo.fnGetCodigoTipoEstrategia(OP.TipoPersonalizacion))
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


GO
