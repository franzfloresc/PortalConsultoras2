USE BelcorpBolivia
GO

CREATE PROCEDURE [dbo].[GetReporteValidacion]
	@PaisISO varchar(2),
	@CampaniaID int,
	@TipoEstrategia int
AS
--exec [dbo].[GetReporteValidacion] 'PE', 201710, 4
BEGIN
	/*
	SELECT top 1 * FROM ods.OfertasPersonalizadas;
	select top 1 * from ods.Campania;
	select top 1 * from ods.Consultora;
	select top 1 * from Estrategia;
	select top 1 * from ods.ProductoComercial; 
	*/
	BEGIN TRY
	DECLARE @TipoPersonalizacion varchar(3);

		IF @TipoEstrategia = 4 
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'OPT';
		END 
		IF @TipoEstrategia = 7
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'ODD';
		END 

		SELECT op.TipoPersonalizacion, op.AnioCampanaVenta, op.CodPais, e.CUV2, e.DescripcionCUV2, 
		CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
		e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, op.LimUnidades, e.Activo, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado FROM ods.OfertasPersonalizadas op
		inner join Estrategia e on op.AnioCampanaVenta = e.CampaniaID and op.CUV = e.CUV2
		left join ods.Campania c on c.Codigo = e.CampaniaID
		inner join ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
		where op.CodPais = @PaisISO 
		and op.AnioCampanaVenta = @CampaniaID
		and op.TipoPersonalizacion = @TipoPersonalizacion;
		END TRY

	BEGIN CATCH

		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT

		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

	END CATCH
END
GO

USE BelcorpChile
GO

CREATE PROCEDURE [dbo].[GetReporteValidacion]
	@PaisISO varchar(2),
	@CampaniaID int,
	@TipoEstrategia int
AS
--exec [dbo].[GetReporteValidacion] 'PE', 201710, 4
BEGIN
	/*
	SELECT top 1 * FROM ods.OfertasPersonalizadas;
	select top 1 * from ods.Campania;
	select top 1 * from ods.Consultora;
	select top 1 * from Estrategia;
	select top 1 * from ods.ProductoComercial; 
	*/
	BEGIN TRY
	DECLARE @TipoPersonalizacion varchar(3);

		IF @TipoEstrategia = 4 
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'OPT';
		END 
		IF @TipoEstrategia = 7
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'ODD';
		END 

		SELECT op.TipoPersonalizacion, op.AnioCampanaVenta, op.CodPais, e.CUV2, e.DescripcionCUV2, 
		CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
		e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, op.LimUnidades, e.Activo, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado FROM ods.OfertasPersonalizadas op
		inner join Estrategia e on op.AnioCampanaVenta = e.CampaniaID and op.CUV = e.CUV2
		left join ods.Campania c on c.Codigo = e.CampaniaID
		inner join ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
		where op.CodPais = @PaisISO 
		and op.AnioCampanaVenta = @CampaniaID
		and op.TipoPersonalizacion = @TipoPersonalizacion;
		END TRY

	BEGIN CATCH

		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT

		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

	END CATCH
END
GO

USE BelcorpColombia
GO

CREATE PROCEDURE [dbo].[GetReporteValidacion]
	@PaisISO varchar(2),
	@CampaniaID int,
	@TipoEstrategia int
AS
--exec [dbo].[GetReporteValidacion] 'PE', 201710, 4
BEGIN
	/*
	SELECT top 1 * FROM ods.OfertasPersonalizadas;
	select top 1 * from ods.Campania;
	select top 1 * from ods.Consultora;
	select top 1 * from Estrategia;
	select top 1 * from ods.ProductoComercial; 
	*/
	BEGIN TRY
	DECLARE @TipoPersonalizacion varchar(3);

		IF @TipoEstrategia = 4 
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'OPT';
		END 
		IF @TipoEstrategia = 7
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'ODD';
		END 

		SELECT op.TipoPersonalizacion, op.AnioCampanaVenta, op.CodPais, e.CUV2, e.DescripcionCUV2, 
		CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
		e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, op.LimUnidades, e.Activo, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado FROM ods.OfertasPersonalizadas op
		inner join Estrategia e on op.AnioCampanaVenta = e.CampaniaID and op.CUV = e.CUV2
		left join ods.Campania c on c.Codigo = e.CampaniaID
		inner join ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
		where op.CodPais = @PaisISO 
		and op.AnioCampanaVenta = @CampaniaID
		and op.TipoPersonalizacion = @TipoPersonalizacion;
		END TRY

	BEGIN CATCH

		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT

		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

	END CATCH
END
GO

USE BelcorpCostaRica
GO

CREATE PROCEDURE [dbo].[GetReporteValidacion]
	@PaisISO varchar(2),
	@CampaniaID int,
	@TipoEstrategia int
AS
--exec [dbo].[GetReporteValidacion] 'PE', 201710, 4
BEGIN
	/*
	SELECT top 1 * FROM ods.OfertasPersonalizadas;
	select top 1 * from ods.Campania;
	select top 1 * from ods.Consultora;
	select top 1 * from Estrategia;
	select top 1 * from ods.ProductoComercial; 
	*/
	BEGIN TRY
	DECLARE @TipoPersonalizacion varchar(3);

		IF @TipoEstrategia = 4 
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'OPT';
		END 
		IF @TipoEstrategia = 7
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'ODD';
		END 

		SELECT op.TipoPersonalizacion, op.AnioCampanaVenta, op.CodPais, e.CUV2, e.DescripcionCUV2, 
		CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
		e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, op.LimUnidades, e.Activo, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado FROM ods.OfertasPersonalizadas op
		inner join Estrategia e on op.AnioCampanaVenta = e.CampaniaID and op.CUV = e.CUV2
		left join ods.Campania c on c.Codigo = e.CampaniaID
		inner join ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
		where op.CodPais = @PaisISO 
		and op.AnioCampanaVenta = @CampaniaID
		and op.TipoPersonalizacion = @TipoPersonalizacion;
		END TRY

	BEGIN CATCH

		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT

		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

	END CATCH
END
GO

USE BelcorpDominicana
GO

CREATE PROCEDURE [dbo].[GetReporteValidacion]
	@PaisISO varchar(2),
	@CampaniaID int,
	@TipoEstrategia int
AS
--exec [dbo].[GetReporteValidacion] 'PE', 201710, 4
BEGIN
	/*
	SELECT top 1 * FROM ods.OfertasPersonalizadas;
	select top 1 * from ods.Campania;
	select top 1 * from ods.Consultora;
	select top 1 * from Estrategia;
	select top 1 * from ods.ProductoComercial; 
	*/
	BEGIN TRY
	DECLARE @TipoPersonalizacion varchar(3);

		IF @TipoEstrategia = 4 
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'OPT';
		END 
		IF @TipoEstrategia = 7
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'ODD';
		END 

		SELECT op.TipoPersonalizacion, op.AnioCampanaVenta, op.CodPais, e.CUV2, e.DescripcionCUV2, 
		CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
		e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, op.LimUnidades, e.Activo, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado FROM ods.OfertasPersonalizadas op
		inner join Estrategia e on op.AnioCampanaVenta = e.CampaniaID and op.CUV = e.CUV2
		left join ods.Campania c on c.Codigo = e.CampaniaID
		inner join ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
		where op.CodPais = @PaisISO 
		and op.AnioCampanaVenta = @CampaniaID
		and op.TipoPersonalizacion = @TipoPersonalizacion;
		END TRY

	BEGIN CATCH

		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT

		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

	END CATCH
END
GO

USE BelcorpEcuador
GO

CREATE PROCEDURE [dbo].[GetReporteValidacion]
	@PaisISO varchar(2),
	@CampaniaID int,
	@TipoEstrategia int
AS
--exec [dbo].[GetReporteValidacion] 'PE', 201710, 4
BEGIN
	/*
	SELECT top 1 * FROM ods.OfertasPersonalizadas;
	select top 1 * from ods.Campania;
	select top 1 * from ods.Consultora;
	select top 1 * from Estrategia;
	select top 1 * from ods.ProductoComercial; 
	*/
	BEGIN TRY
	DECLARE @TipoPersonalizacion varchar(3);

		IF @TipoEstrategia = 4 
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'OPT';
		END 
		IF @TipoEstrategia = 7
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'ODD';
		END 

		SELECT op.TipoPersonalizacion, op.AnioCampanaVenta, op.CodPais, e.CUV2, e.DescripcionCUV2, 
		CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
		e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, op.LimUnidades, e.Activo, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado FROM ods.OfertasPersonalizadas op
		inner join Estrategia e on op.AnioCampanaVenta = e.CampaniaID and op.CUV = e.CUV2
		left join ods.Campania c on c.Codigo = e.CampaniaID
		inner join ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
		where op.CodPais = @PaisISO 
		and op.AnioCampanaVenta = @CampaniaID
		and op.TipoPersonalizacion = @TipoPersonalizacion;
		END TRY

	BEGIN CATCH

		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT

		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

	END CATCH
END
GO

USE BelcorpGuatemala
GO

CREATE PROCEDURE [dbo].[GetReporteValidacion]
	@PaisISO varchar(2),
	@CampaniaID int,
	@TipoEstrategia int
AS
--exec [dbo].[GetReporteValidacion] 'PE', 201710, 4
BEGIN
	/*
	SELECT top 1 * FROM ods.OfertasPersonalizadas;
	select top 1 * from ods.Campania;
	select top 1 * from ods.Consultora;
	select top 1 * from Estrategia;
	select top 1 * from ods.ProductoComercial; 
	*/
	BEGIN TRY
	DECLARE @TipoPersonalizacion varchar(3);

		IF @TipoEstrategia = 4 
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'OPT';
		END 
		IF @TipoEstrategia = 7
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'ODD';
		END 

		SELECT op.TipoPersonalizacion, op.AnioCampanaVenta, op.CodPais, e.CUV2, e.DescripcionCUV2, 
		CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
		e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, op.LimUnidades, e.Activo, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado FROM ods.OfertasPersonalizadas op
		inner join Estrategia e on op.AnioCampanaVenta = e.CampaniaID and op.CUV = e.CUV2
		left join ods.Campania c on c.Codigo = e.CampaniaID
		inner join ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
		where op.CodPais = @PaisISO 
		and op.AnioCampanaVenta = @CampaniaID
		and op.TipoPersonalizacion = @TipoPersonalizacion;
		END TRY

	BEGIN CATCH

		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT

		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

	END CATCH
END
GO

USE BelcorpMexico
GO

CREATE PROCEDURE [dbo].[GetReporteValidacion]
	@PaisISO varchar(2),
	@CampaniaID int,
	@TipoEstrategia int
AS
--exec [dbo].[GetReporteValidacion] 'PE', 201710, 4
BEGIN
	/*
	SELECT top 1 * FROM ods.OfertasPersonalizadas;
	select top 1 * from ods.Campania;
	select top 1 * from ods.Consultora;
	select top 1 * from Estrategia;
	select top 1 * from ods.ProductoComercial; 
	*/
	BEGIN TRY
	DECLARE @TipoPersonalizacion varchar(3);

		IF @TipoEstrategia = 4 
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'OPT';
		END 
		IF @TipoEstrategia = 7
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'ODD';
		END 

		SELECT op.TipoPersonalizacion, op.AnioCampanaVenta, op.CodPais, e.CUV2, e.DescripcionCUV2, 
		CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
		e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, op.LimUnidades, e.Activo, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado FROM ods.OfertasPersonalizadas op
		inner join Estrategia e on op.AnioCampanaVenta = e.CampaniaID and op.CUV = e.CUV2
		left join ods.Campania c on c.Codigo = e.CampaniaID
		inner join ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
		where op.CodPais = @PaisISO 
		and op.AnioCampanaVenta = @CampaniaID
		and op.TipoPersonalizacion = @TipoPersonalizacion;
		END TRY

	BEGIN CATCH

		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT

		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

	END CATCH
END
GO

USE BelcorpPanama
GO

CREATE PROCEDURE [dbo].[GetReporteValidacion]
	@PaisISO varchar(2),
	@CampaniaID int,
	@TipoEstrategia int
AS
--exec [dbo].[GetReporteValidacion] 'PE', 201710, 4
BEGIN
	/*
	SELECT top 1 * FROM ods.OfertasPersonalizadas;
	select top 1 * from ods.Campania;
	select top 1 * from ods.Consultora;
	select top 1 * from Estrategia;
	select top 1 * from ods.ProductoComercial; 
	*/
	BEGIN TRY
	DECLARE @TipoPersonalizacion varchar(3);

		IF @TipoEstrategia = 4 
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'OPT';
		END 
		IF @TipoEstrategia = 7
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'ODD';
		END 

		SELECT op.TipoPersonalizacion, op.AnioCampanaVenta, op.CodPais, e.CUV2, e.DescripcionCUV2, 
		CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
		e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, op.LimUnidades, e.Activo, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado FROM ods.OfertasPersonalizadas op
		inner join Estrategia e on op.AnioCampanaVenta = e.CampaniaID and op.CUV = e.CUV2
		left join ods.Campania c on c.Codigo = e.CampaniaID
		inner join ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
		where op.CodPais = @PaisISO 
		and op.AnioCampanaVenta = @CampaniaID
		and op.TipoPersonalizacion = @TipoPersonalizacion;
		END TRY

	BEGIN CATCH

		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT

		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

	END CATCH
END
GO

USE BelcorpPeru
GO

CREATE PROCEDURE [dbo].[GetReporteValidacion]
	@PaisISO varchar(2),
	@CampaniaID int,
	@TipoEstrategia int
AS
--exec [dbo].[GetReporteValidacion] 'PE', 201710, 4
BEGIN
	/*
	SELECT top 1 * FROM ods.OfertasPersonalizadas;
	select top 1 * from ods.Campania;
	select top 1 * from ods.Consultora;
	select top 1 * from Estrategia;
	select top 1 * from ods.ProductoComercial; 
	*/
	BEGIN TRY
	DECLARE @TipoPersonalizacion varchar(3);

		IF @TipoEstrategia = 4 
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'OPT';
		END 
		IF @TipoEstrategia = 7
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'ODD';
		END 

		SELECT op.TipoPersonalizacion, op.AnioCampanaVenta, op.CodPais, e.CUV2, e.DescripcionCUV2, 
		CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
		e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, op.LimUnidades, e.Activo, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado FROM ods.OfertasPersonalizadas op
		inner join Estrategia e on op.AnioCampanaVenta = e.CampaniaID and op.CUV = e.CUV2
		left join ods.Campania c on c.Codigo = e.CampaniaID
		inner join ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
		where op.CodPais = @PaisISO 
		and op.AnioCampanaVenta = @CampaniaID
		and op.TipoPersonalizacion = @TipoPersonalizacion;
		END TRY

	BEGIN CATCH

		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT

		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

	END CATCH
END
GO

USE BelcorpPuertoRico
GO

CREATE PROCEDURE [dbo].[GetReporteValidacion]
	@PaisISO varchar(2),
	@CampaniaID int,
	@TipoEstrategia int
AS
--exec [dbo].[GetReporteValidacion] 'PE', 201710, 4
BEGIN
	/*
	SELECT top 1 * FROM ods.OfertasPersonalizadas;
	select top 1 * from ods.Campania;
	select top 1 * from ods.Consultora;
	select top 1 * from Estrategia;
	select top 1 * from ods.ProductoComercial; 
	*/
	BEGIN TRY
	DECLARE @TipoPersonalizacion varchar(3);

		IF @TipoEstrategia = 4 
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'OPT';
		END 
		IF @TipoEstrategia = 7
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'ODD';
		END 

		SELECT op.TipoPersonalizacion, op.AnioCampanaVenta, op.CodPais, e.CUV2, e.DescripcionCUV2, 
		CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
		e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, op.LimUnidades, e.Activo, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado FROM ods.OfertasPersonalizadas op
		inner join Estrategia e on op.AnioCampanaVenta = e.CampaniaID and op.CUV = e.CUV2
		left join ods.Campania c on c.Codigo = e.CampaniaID
		inner join ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
		where op.CodPais = @PaisISO 
		and op.AnioCampanaVenta = @CampaniaID
		and op.TipoPersonalizacion = @TipoPersonalizacion;
		END TRY

	BEGIN CATCH

		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT

		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

	END CATCH
END
GO

USE BelcorpSalvador
GO

CREATE PROCEDURE [dbo].[GetReporteValidacion]
	@PaisISO varchar(2),
	@CampaniaID int,
	@TipoEstrategia int
AS
--exec [dbo].[GetReporteValidacion] 'PE', 201710, 4
BEGIN
	/*
	SELECT top 1 * FROM ods.OfertasPersonalizadas;
	select top 1 * from ods.Campania;
	select top 1 * from ods.Consultora;
	select top 1 * from Estrategia;
	select top 1 * from ods.ProductoComercial; 
	*/
	BEGIN TRY
	DECLARE @TipoPersonalizacion varchar(3);

		IF @TipoEstrategia = 4 
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'OPT';
		END 
		IF @TipoEstrategia = 7
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'ODD';
		END 

		SELECT op.TipoPersonalizacion, op.AnioCampanaVenta, op.CodPais, e.CUV2, e.DescripcionCUV2, 
		CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
		e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, op.LimUnidades, e.Activo, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado FROM ods.OfertasPersonalizadas op
		inner join Estrategia e on op.AnioCampanaVenta = e.CampaniaID and op.CUV = e.CUV2
		left join ods.Campania c on c.Codigo = e.CampaniaID
		inner join ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
		where op.CodPais = @PaisISO 
		and op.AnioCampanaVenta = @CampaniaID
		and op.TipoPersonalizacion = @TipoPersonalizacion;
		END TRY

	BEGIN CATCH

		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT

		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

	END CATCH
END
GO
USE BelcorpVenezuela
GO

CREATE PROCEDURE [dbo].[GetReporteValidacion]
	@PaisISO varchar(2),
	@CampaniaID int,
	@TipoEstrategia int
AS
--exec [dbo].[GetReporteValidacion] 'PE', 201710, 4
BEGIN
	/*
	SELECT top 1 * FROM ods.OfertasPersonalizadas;
	select top 1 * from ods.Campania;
	select top 1 * from ods.Consultora;
	select top 1 * from Estrategia;
	select top 1 * from ods.ProductoComercial; 
	*/
	BEGIN TRY
	DECLARE @TipoPersonalizacion varchar(3);

		IF @TipoEstrategia = 4 
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'OPT';
		END 
		IF @TipoEstrategia = 7
		BEGIN
			SELECT  @TipoPersonalizacion = TipoPersonalizacion from ods.OfertasPersonalizadas where TipoPersonalizacion = 'ODD';
		END 

		SELECT op.TipoPersonalizacion, op.AnioCampanaVenta, op.CodPais, e.CUV2, e.DescripcionCUV2, 
		CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
		e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, op.LimUnidades, e.Activo, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado FROM ods.OfertasPersonalizadas op
		inner join Estrategia e on op.AnioCampanaVenta = e.CampaniaID and op.CUV = e.CUV2
		left join ods.Campania c on c.Codigo = e.CampaniaID
		inner join ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
		where op.CodPais = @PaisISO 
		and op.AnioCampanaVenta = @CampaniaID
		and op.TipoPersonalizacion = @TipoPersonalizacion;
		END TRY

	BEGIN CATCH

		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT

		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

	END CATCH
END
GO



