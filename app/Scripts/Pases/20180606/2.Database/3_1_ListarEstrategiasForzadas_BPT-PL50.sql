GO
USE BelcorpPeru
GO

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
	AnioCampanaVenta int,
	DiaInicio int
)
AS
BEGIN

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID);
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	DECLARE @TipoPersonalizacion varchar(5) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SET @TipoPersonalizacion = [dbo].[fnGetTipoPersonalizacion](@EstrategiaCodigo)

	INSERT INTO @OfertasPersonalizadas
	SELECT isnull(Orden,0) Orden,
			CUV,TipoPersonalizacion,
			FlagRevista,
			convert(int,AnioCampanaVenta) AnioCampanaVenta,
			DiaInicio
	FROM ods.OfertasPersonalizadas op with(nolock) where
	op.CodConsultora = @codConsultoraDefault
	and op.AnioCampanaVenta = @StrCampaniaID
	and op.TipoPersonalizacion = @TipoPersonalizacion
	RETURN
END
GO

GO
USE BelcorpMexico
GO

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
	AnioCampanaVenta int,
	DiaInicio int
)
AS
BEGIN

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID);
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	DECLARE @TipoPersonalizacion varchar(5) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SET @TipoPersonalizacion = [dbo].[fnGetTipoPersonalizacion](@EstrategiaCodigo)

	INSERT INTO @OfertasPersonalizadas
	SELECT isnull(Orden,0) Orden,
			CUV,TipoPersonalizacion,
			FlagRevista,
			convert(int,AnioCampanaVenta) AnioCampanaVenta,
			DiaInicio
	FROM ods.OfertasPersonalizadas op with(nolock) where
	op.CodConsultora = @codConsultoraDefault
	and op.AnioCampanaVenta = @StrCampaniaID
	and op.TipoPersonalizacion = @TipoPersonalizacion
	RETURN
END
GO

GO
USE BelcorpColombia
GO

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
	AnioCampanaVenta int,
	DiaInicio int
)
AS
BEGIN

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID);
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	DECLARE @TipoPersonalizacion varchar(5) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SET @TipoPersonalizacion = [dbo].[fnGetTipoPersonalizacion](@EstrategiaCodigo)

	INSERT INTO @OfertasPersonalizadas
	SELECT isnull(Orden,0) Orden,
			CUV,TipoPersonalizacion,
			FlagRevista,
			convert(int,AnioCampanaVenta) AnioCampanaVenta,
			DiaInicio
	FROM ods.OfertasPersonalizadas op with(nolock) where
	op.CodConsultora = @codConsultoraDefault
	and op.AnioCampanaVenta = @StrCampaniaID
	and op.TipoPersonalizacion = @TipoPersonalizacion
	RETURN
END
GO

GO
USE BelcorpSalvador
GO

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
	AnioCampanaVenta int,
	DiaInicio int
)
AS
BEGIN

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID);
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	DECLARE @TipoPersonalizacion varchar(5) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SET @TipoPersonalizacion = [dbo].[fnGetTipoPersonalizacion](@EstrategiaCodigo)

	INSERT INTO @OfertasPersonalizadas
	SELECT isnull(Orden,0) Orden,
			CUV,TipoPersonalizacion,
			FlagRevista,
			convert(int,AnioCampanaVenta) AnioCampanaVenta,
			DiaInicio
	FROM ods.OfertasPersonalizadas op with(nolock) where
	op.CodConsultora = @codConsultoraDefault
	and op.AnioCampanaVenta = @StrCampaniaID
	and op.TipoPersonalizacion = @TipoPersonalizacion
	RETURN
END
GO

GO
USE BelcorpPuertoRico
GO

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
	AnioCampanaVenta int,
	DiaInicio int
)
AS
BEGIN

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID);
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	DECLARE @TipoPersonalizacion varchar(5) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SET @TipoPersonalizacion = [dbo].[fnGetTipoPersonalizacion](@EstrategiaCodigo)

	INSERT INTO @OfertasPersonalizadas
	SELECT isnull(Orden,0) Orden,
			CUV,TipoPersonalizacion,
			FlagRevista,
			convert(int,AnioCampanaVenta) AnioCampanaVenta,
			DiaInicio
	FROM ods.OfertasPersonalizadas op with(nolock) where
	op.CodConsultora = @codConsultoraDefault
	and op.AnioCampanaVenta = @StrCampaniaID
	and op.TipoPersonalizacion = @TipoPersonalizacion
	RETURN
END
GO

GO
USE BelcorpPanama
GO

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
	AnioCampanaVenta int,
	DiaInicio int
)
AS
BEGIN

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID);
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	DECLARE @TipoPersonalizacion varchar(5) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SET @TipoPersonalizacion = [dbo].[fnGetTipoPersonalizacion](@EstrategiaCodigo)

	INSERT INTO @OfertasPersonalizadas
	SELECT isnull(Orden,0) Orden,
			CUV,TipoPersonalizacion,
			FlagRevista,
			convert(int,AnioCampanaVenta) AnioCampanaVenta,
			DiaInicio
	FROM ods.OfertasPersonalizadas op with(nolock) where
	op.CodConsultora = @codConsultoraDefault
	and op.AnioCampanaVenta = @StrCampaniaID
	and op.TipoPersonalizacion = @TipoPersonalizacion
	RETURN
END
GO

GO
USE BelcorpGuatemala
GO

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
	AnioCampanaVenta int,
	DiaInicio int
)
AS
BEGIN

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID);
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	DECLARE @TipoPersonalizacion varchar(5) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SET @TipoPersonalizacion = [dbo].[fnGetTipoPersonalizacion](@EstrategiaCodigo)

	INSERT INTO @OfertasPersonalizadas
	SELECT isnull(Orden,0) Orden,
			CUV,TipoPersonalizacion,
			FlagRevista,
			convert(int,AnioCampanaVenta) AnioCampanaVenta,
			DiaInicio
	FROM ods.OfertasPersonalizadas op with(nolock) where
	op.CodConsultora = @codConsultoraDefault
	and op.AnioCampanaVenta = @StrCampaniaID
	and op.TipoPersonalizacion = @TipoPersonalizacion
	RETURN
END
GO

GO
USE BelcorpEcuador
GO

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
	AnioCampanaVenta int,
	DiaInicio int
)
AS
BEGIN

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID);
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	DECLARE @TipoPersonalizacion varchar(5) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SET @TipoPersonalizacion = [dbo].[fnGetTipoPersonalizacion](@EstrategiaCodigo)

	INSERT INTO @OfertasPersonalizadas
	SELECT isnull(Orden,0) Orden,
			CUV,TipoPersonalizacion,
			FlagRevista,
			convert(int,AnioCampanaVenta) AnioCampanaVenta,
			DiaInicio
	FROM ods.OfertasPersonalizadas op with(nolock) where
	op.CodConsultora = @codConsultoraDefault
	and op.AnioCampanaVenta = @StrCampaniaID
	and op.TipoPersonalizacion = @TipoPersonalizacion
	RETURN
END
GO

GO
USE BelcorpDominicana
GO

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
	AnioCampanaVenta int,
	DiaInicio int
)
AS
BEGIN

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID);
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	DECLARE @TipoPersonalizacion varchar(5) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SET @TipoPersonalizacion = [dbo].[fnGetTipoPersonalizacion](@EstrategiaCodigo)

	INSERT INTO @OfertasPersonalizadas
	SELECT isnull(Orden,0) Orden,
			CUV,TipoPersonalizacion,
			FlagRevista,
			convert(int,AnioCampanaVenta) AnioCampanaVenta,
			DiaInicio
	FROM ods.OfertasPersonalizadas op with(nolock) where
	op.CodConsultora = @codConsultoraDefault
	and op.AnioCampanaVenta = @StrCampaniaID
	and op.TipoPersonalizacion = @TipoPersonalizacion
	RETURN
END
GO

GO
USE BelcorpCostaRica
GO

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
	AnioCampanaVenta int,
	DiaInicio int
)
AS
BEGIN

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID);
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	DECLARE @TipoPersonalizacion varchar(5) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SET @TipoPersonalizacion = [dbo].[fnGetTipoPersonalizacion](@EstrategiaCodigo)

	INSERT INTO @OfertasPersonalizadas
	SELECT isnull(Orden,0) Orden,
			CUV,TipoPersonalizacion,
			FlagRevista,
			convert(int,AnioCampanaVenta) AnioCampanaVenta,
			DiaInicio
	FROM ods.OfertasPersonalizadas op with(nolock) where
	op.CodConsultora = @codConsultoraDefault
	and op.AnioCampanaVenta = @StrCampaniaID
	and op.TipoPersonalizacion = @TipoPersonalizacion
	RETURN
END
GO

GO
USE BelcorpChile
GO

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
	AnioCampanaVenta int,
	DiaInicio int
)
AS
BEGIN

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID);
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	DECLARE @TipoPersonalizacion varchar(5) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SET @TipoPersonalizacion = [dbo].[fnGetTipoPersonalizacion](@EstrategiaCodigo)

	INSERT INTO @OfertasPersonalizadas
	SELECT isnull(Orden,0) Orden,
			CUV,TipoPersonalizacion,
			FlagRevista,
			convert(int,AnioCampanaVenta) AnioCampanaVenta,
			DiaInicio
	FROM ods.OfertasPersonalizadas op with(nolock) where
	op.CodConsultora = @codConsultoraDefault
	and op.AnioCampanaVenta = @StrCampaniaID
	and op.TipoPersonalizacion = @TipoPersonalizacion
	RETURN
END
GO

GO
USE BelcorpBolivia
GO

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
	AnioCampanaVenta int,
	DiaInicio int
)
AS
BEGIN

	DECLARE @StrCampaniaID CHAR(6) = CONVERT(CHAR(6),@CampaniaID);
	DECLARE @codConsultoraDefault VARCHAR(9) = ''
	DECLARE @TipoPersonalizacion varchar(5) = ''
	SELECT @codConsultoraDefault = Codigo FROM TablaLogicaDatos with(nolock) WHERE TablaLogicaDatosID = 10002
	SET @TipoPersonalizacion = [dbo].[fnGetTipoPersonalizacion](@EstrategiaCodigo)

	INSERT INTO @OfertasPersonalizadas
	SELECT isnull(Orden,0) Orden,
			CUV,TipoPersonalizacion,
			FlagRevista,
			convert(int,AnioCampanaVenta) AnioCampanaVenta,
			DiaInicio
	FROM ods.OfertasPersonalizadas op with(nolock) where
	op.CodConsultora = @codConsultoraDefault
	and op.AnioCampanaVenta = @StrCampaniaID
	and op.TipoPersonalizacion = @TipoPersonalizacion
	RETURN
END
GO

GO
