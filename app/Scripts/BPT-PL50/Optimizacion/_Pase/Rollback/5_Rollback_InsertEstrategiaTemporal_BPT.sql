GO
USE BelcorpPeru
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO
CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
	@NumeroLoteAnt int = 0,
	@NroLote int = 0 out
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	DECLARE @NumeroLote INT = isnull(@NumeroLoteAnt, 0)
	if @NumeroLote <= 0
	begin
		SELECT @NumeroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal

		if	@NumeroLote < 0
			set @NumeroLote = 1
		else
			SET @NumeroLote = @NumeroLote + 1
	end
	INSERT INTO EstrategiaTemporal
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles
	FROM @EstrategiaTemporal

	set @NroLote = @NumeroLote
END
GO

GO
USE BelcorpMexico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO
CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
	@NumeroLoteAnt int = 0,
	@NroLote int = 0 out
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	DECLARE @NumeroLote INT = isnull(@NumeroLoteAnt, 0)
	if @NumeroLote <= 0
	begin
		SELECT @NumeroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal

		if	@NumeroLote < 0
			set @NumeroLote = 1
		else
			SET @NumeroLote = @NumeroLote + 1
	end
	INSERT INTO EstrategiaTemporal
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles
	FROM @EstrategiaTemporal

	set @NroLote = @NumeroLote
END
GO

GO
USE BelcorpColombia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO
CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
	@NumeroLoteAnt int = 0,
	@NroLote int = 0 out
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	DECLARE @NumeroLote INT = isnull(@NumeroLoteAnt, 0)
	if @NumeroLote <= 0
	begin
		SELECT @NumeroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal

		if	@NumeroLote < 0
			set @NumeroLote = 1
		else
			SET @NumeroLote = @NumeroLote + 1
	end
	INSERT INTO EstrategiaTemporal
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles
	FROM @EstrategiaTemporal

	set @NroLote = @NumeroLote
END
GO

GO
USE BelcorpSalvador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO
CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
	@NumeroLoteAnt int = 0,
	@NroLote int = 0 out
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	DECLARE @NumeroLote INT = isnull(@NumeroLoteAnt, 0)
	if @NumeroLote <= 0
	begin
		SELECT @NumeroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal

		if	@NumeroLote < 0
			set @NumeroLote = 1
		else
			SET @NumeroLote = @NumeroLote + 1
	end
	INSERT INTO EstrategiaTemporal
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles
	FROM @EstrategiaTemporal

	set @NroLote = @NumeroLote
END
GO

GO
USE BelcorpPuertoRico
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO
CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
	@NumeroLoteAnt int = 0,
	@NroLote int = 0 out
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	DECLARE @NumeroLote INT = isnull(@NumeroLoteAnt, 0)
	if @NumeroLote <= 0
	begin
		SELECT @NumeroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal

		if	@NumeroLote < 0
			set @NumeroLote = 1
		else
			SET @NumeroLote = @NumeroLote + 1
	end
	INSERT INTO EstrategiaTemporal
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles
	FROM @EstrategiaTemporal

	set @NroLote = @NumeroLote
END
GO

GO
USE BelcorpPanama
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO
CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
	@NumeroLoteAnt int = 0,
	@NroLote int = 0 out
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	DECLARE @NumeroLote INT = isnull(@NumeroLoteAnt, 0)
	if @NumeroLote <= 0
	begin
		SELECT @NumeroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal

		if	@NumeroLote < 0
			set @NumeroLote = 1
		else
			SET @NumeroLote = @NumeroLote + 1
	end
	INSERT INTO EstrategiaTemporal
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles
	FROM @EstrategiaTemporal

	set @NroLote = @NumeroLote
END
GO

GO
USE BelcorpGuatemala
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO
CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
	@NumeroLoteAnt int = 0,
	@NroLote int = 0 out
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	DECLARE @NumeroLote INT = isnull(@NumeroLoteAnt, 0)
	if @NumeroLote <= 0
	begin
		SELECT @NumeroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal

		if	@NumeroLote < 0
			set @NumeroLote = 1
		else
			SET @NumeroLote = @NumeroLote + 1
	end
	INSERT INTO EstrategiaTemporal
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles
	FROM @EstrategiaTemporal

	set @NroLote = @NumeroLote
END
GO

GO
USE BelcorpEcuador
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO
CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
	@NumeroLoteAnt int = 0,
	@NroLote int = 0 out
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	DECLARE @NumeroLote INT = isnull(@NumeroLoteAnt, 0)
	if @NumeroLote <= 0
	begin
		SELECT @NumeroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal

		if	@NumeroLote < 0
			set @NumeroLote = 1
		else
			SET @NumeroLote = @NumeroLote + 1
	end
	INSERT INTO EstrategiaTemporal
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles
	FROM @EstrategiaTemporal

	set @NroLote = @NumeroLote
END
GO

GO
USE BelcorpDominicana
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO
CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
	@NumeroLoteAnt int = 0,
	@NroLote int = 0 out
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	DECLARE @NumeroLote INT = isnull(@NumeroLoteAnt, 0)
	if @NumeroLote <= 0
	begin
		SELECT @NumeroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal

		if	@NumeroLote < 0
			set @NumeroLote = 1
		else
			SET @NumeroLote = @NumeroLote + 1
	end
	INSERT INTO EstrategiaTemporal
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles
	FROM @EstrategiaTemporal

	set @NroLote = @NumeroLote
END
GO

GO
USE BelcorpCostaRica
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO
CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
	@NumeroLoteAnt int = 0,
	@NroLote int = 0 out
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	DECLARE @NumeroLote INT = isnull(@NumeroLoteAnt, 0)
	if @NumeroLote <= 0
	begin
		SELECT @NumeroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal

		if	@NumeroLote < 0
			set @NumeroLote = 1
		else
			SET @NumeroLote = @NumeroLote + 1
	end
	INSERT INTO EstrategiaTemporal
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles
	FROM @EstrategiaTemporal

	set @NroLote = @NumeroLote
END
GO

GO
USE BelcorpChile
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO
CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
	@NumeroLoteAnt int = 0,
	@NroLote int = 0 out
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	DECLARE @NumeroLote INT = isnull(@NumeroLoteAnt, 0)
	if @NumeroLote <= 0
	begin
		SELECT @NumeroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal

		if	@NumeroLote < 0
			set @NumeroLote = 1
		else
			SET @NumeroLote = @NumeroLote + 1
	end
	INSERT INTO EstrategiaTemporal
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles
	FROM @EstrategiaTemporal

	set @NroLote = @NumeroLote
END
GO

GO
USE BelcorpBolivia
GO

GO
IF EXISTS ( SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InsertEstrategiaTemporal') AND type IN ( N'P', N'PC' ) )
	DROP PROCEDURE dbo.InsertEstrategiaTemporal
GO
CREATE PROCEDURE dbo.InsertEstrategiaTemporal
	@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
	@NumeroLoteAnt int = 0,
	@NroLote int = 0 out
AS
BEGIN
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	DECLARE @NumeroLote INT = isnull(@NumeroLoteAnt, 0)
	if @NumeroLote <= 0
	begin
		SELECT @NumeroLote = isnull(max(NumeroLote),0)
		FROM EstrategiaTemporal

		if	@NumeroLote < 0
			set @NumeroLote = 1
		else
			SET @NumeroLote = @NumeroLote + 1
	end
	INSERT INTO EstrategiaTemporal
		(CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		NumeroLote,
		FechaCreacion,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles)
	SELECT
		CampaniaId,
		CUV,
		Descripcion,
		PrecioOferta,
		PrecioTachado,
		CodigoSap,
		OfertaUltimoMinuto,
		LimiteVenta,
		@NumeroLote,
		@FechaGeneral,
		UsuarioCreacion,
		FotoProducto01,
		CodigoEstrategia,
		TieneVariedad,
		PrecioPublico,
		Ganancia,
		Niveles
	FROM @EstrategiaTemporal

	set @NroLote = @NumeroLote
END
GO

GO
