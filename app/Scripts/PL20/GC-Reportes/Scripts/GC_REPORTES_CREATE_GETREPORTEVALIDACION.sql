USE BelcorpBolivia
GO

CREATE PROCEDURE [dbo].[GetReporteValidacion]
	@CampaniaID int
AS
--exec [dbo].[GetReporteValidacion]  201710
BEGIN
	BEGIN TRY
	DECLARE @teIDBolivia int;
	DECLARE @teIDChile int;
	DECLARE @teIDColombia int;
	DECLARE @teIDCostaRica int;
	DECLARE @teIDDominicana int;
	DECLARE @teIDEcuador int;
	DECLARE @teIDGuatemala int;
	DECLARE @teIDMexico int;
	DECLARE @teIDPanama int;
	DECLARE @teIDPeru int;
	DECLARE @teIDPuertoRico int;
	DECLARE @teIDSalvador int;
	DECLARE @teIDVenezuela int;

	DECLARE @TipoPersonalizacion varchar(10);

			SELECT  @teIDBolivia = TipoEstrategiaID from BelcorpBolivia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDChile = TipoEstrategiaID from BelcorpChile.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDColombia = TipoEstrategiaID from BelcorpColombia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDCostaRica = TipoEstrategiaID from BelcorpCostaRica.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDDominicana = TipoEstrategiaID from BelcorpDominicana.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDEcuador = TipoEstrategiaID from BelcorpEcuador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDGuatemala = TipoEstrategiaID from BelcorpGuatemala.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDMexico = TipoEstrategiaID from BelcorpMexico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPanama = TipoEstrategiaID from BelcorpPanama.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPeru = TipoEstrategiaID from BelcorpPeru.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPuertoRico = TipoEstrategiaID from BelcorpPuertoRico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDSalvador = TipoEstrategiaID from BelcorpSalvador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDVenezuela = TipoEstrategiaID from BelcorpVenezuela.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';

			SET @TipoPersonalizacion = 'OPT';

			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'BO' as Pais, e.CUV2, e.DescripcionCUV2, 
			CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
			e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
			, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpBolivia.dbo.Estrategia e 
			inner join BelcorpBolivia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpBolivia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDBolivia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CL' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpChile.dbo.Estrategia e 
			inner join BelcorpChile.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpChile.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDChile
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpColombia.dbo.Estrategia e 
			inner join BelcorpColombia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpColombia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDColombia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpCostaRica.dbo.Estrategia e 
			inner join BelcorpCostaRica.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpCostaRica.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDCostaRica
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'DO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpDominicana.dbo.Estrategia e 
			inner join BelcorpDominicana.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpDominicana.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDDominicana
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'EC' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpEcuador.dbo.Estrategia e 
			inner join BelcorpEcuador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpEcuador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDEcuador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'GT' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpGuatemala.dbo.Estrategia e 
			inner join BelcorpGuatemala.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpGuatemala.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDGuatemala
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'MX' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpMexico.dbo.Estrategia e 
			inner join BelcorpMexico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpMexico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDMexico
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PA' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPanama.dbo.Estrategia e 
			inner join BelcorpPanama.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPanama.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPanama
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPeru.dbo.Estrategia e 
			inner join BelcorpPeru.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPeru.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPeru
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPuertoRico.dbo.Estrategia e 
			inner join BelcorpPuertoRico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPuertoRico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPuertoRico
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'SV' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpSalvador.dbo.Estrategia e 
			inner join BelcorpSalvador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpSalvador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDSalvador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'VE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpVenezuela.dbo.Estrategia e 
			inner join BelcorpVenezuela.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpVenezuela.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
			and e.TipoEstrategiaID = @teIDVenezuela

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
	@CampaniaID int
AS
--exec [dbo].[GetReporteValidacion]  201710
BEGIN
	BEGIN TRY
	DECLARE @teIDBolivia int;
	DECLARE @teIDChile int;
	DECLARE @teIDColombia int;
	DECLARE @teIDCostaRica int;
	DECLARE @teIDDominicana int;
	DECLARE @teIDEcuador int;
	DECLARE @teIDGuatemala int;
	DECLARE @teIDMexico int;
	DECLARE @teIDPanama int;
	DECLARE @teIDPeru int;
	DECLARE @teIDPuertoRico int;
	DECLARE @teIDSalvador int;
	DECLARE @teIDVenezuela int;

	DECLARE @TipoPersonalizacion varchar(10);

			SELECT  @teIDBolivia = TipoEstrategiaID from BelcorpBolivia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDChile = TipoEstrategiaID from BelcorpChile.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDColombia = TipoEstrategiaID from BelcorpColombia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDCostaRica = TipoEstrategiaID from BelcorpCostaRica.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDDominicana = TipoEstrategiaID from BelcorpDominicana.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDEcuador = TipoEstrategiaID from BelcorpEcuador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDGuatemala = TipoEstrategiaID from BelcorpGuatemala.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDMexico = TipoEstrategiaID from BelcorpMexico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPanama = TipoEstrategiaID from BelcorpPanama.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPeru = TipoEstrategiaID from BelcorpPeru.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPuertoRico = TipoEstrategiaID from BelcorpPuertoRico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDSalvador = TipoEstrategiaID from BelcorpSalvador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDVenezuela = TipoEstrategiaID from BelcorpVenezuela.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';

			SET @TipoPersonalizacion = 'OPT';

			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'BO' as Pais, e.CUV2, e.DescripcionCUV2, 
			CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
			e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
			, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpBolivia.dbo.Estrategia e 
			inner join BelcorpBolivia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpBolivia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDBolivia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CL' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpChile.dbo.Estrategia e 
			inner join BelcorpChile.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpChile.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDChile
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpColombia.dbo.Estrategia e 
			inner join BelcorpColombia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpColombia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDColombia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpCostaRica.dbo.Estrategia e 
			inner join BelcorpCostaRica.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpCostaRica.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDCostaRica
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'DO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpDominicana.dbo.Estrategia e 
			inner join BelcorpDominicana.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpDominicana.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDDominicana
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'EC' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpEcuador.dbo.Estrategia e 
			inner join BelcorpEcuador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpEcuador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDEcuador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'GT' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpGuatemala.dbo.Estrategia e 
			inner join BelcorpGuatemala.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpGuatemala.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDGuatemala
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'MX' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpMexico.dbo.Estrategia e 
			inner join BelcorpMexico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpMexico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDMexico
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PA' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPanama.dbo.Estrategia e 
			inner join BelcorpPanama.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPanama.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPanama
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPeru.dbo.Estrategia e 
			inner join BelcorpPeru.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPeru.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPeru
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPuertoRico.dbo.Estrategia e 
			inner join BelcorpPuertoRico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPuertoRico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPuertoRico
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'SV' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpSalvador.dbo.Estrategia e 
			inner join BelcorpSalvador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpSalvador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDSalvador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'VE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpVenezuela.dbo.Estrategia e 
			inner join BelcorpVenezuela.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpVenezuela.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
			and e.TipoEstrategiaID = @teIDVenezuela

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
	@CampaniaID int
AS
--exec [dbo].[GetReporteValidacion]  201710
BEGIN
	BEGIN TRY
	DECLARE @teIDBolivia int;
	DECLARE @teIDChile int;
	DECLARE @teIDColombia int;
	DECLARE @teIDCostaRica int;
	DECLARE @teIDDominicana int;
	DECLARE @teIDEcuador int;
	DECLARE @teIDGuatemala int;
	DECLARE @teIDMexico int;
	DECLARE @teIDPanama int;
	DECLARE @teIDPeru int;
	DECLARE @teIDPuertoRico int;
	DECLARE @teIDSalvador int;
	DECLARE @teIDVenezuela int;

	DECLARE @TipoPersonalizacion varchar(10);

			SELECT  @teIDBolivia = TipoEstrategiaID from BelcorpBolivia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDChile = TipoEstrategiaID from BelcorpChile.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDColombia = TipoEstrategiaID from BelcorpColombia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDCostaRica = TipoEstrategiaID from BelcorpCostaRica.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDDominicana = TipoEstrategiaID from BelcorpDominicana.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDEcuador = TipoEstrategiaID from BelcorpEcuador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDGuatemala = TipoEstrategiaID from BelcorpGuatemala.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDMexico = TipoEstrategiaID from BelcorpMexico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPanama = TipoEstrategiaID from BelcorpPanama.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPeru = TipoEstrategiaID from BelcorpPeru.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPuertoRico = TipoEstrategiaID from BelcorpPuertoRico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDSalvador = TipoEstrategiaID from BelcorpSalvador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDVenezuela = TipoEstrategiaID from BelcorpVenezuela.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';

			SET @TipoPersonalizacion = 'OPT';

			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'BO' as Pais, e.CUV2, e.DescripcionCUV2, 
			CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
			e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
			, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpBolivia.dbo.Estrategia e 
			inner join BelcorpBolivia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpBolivia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDBolivia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CL' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpChile.dbo.Estrategia e 
			inner join BelcorpChile.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpChile.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDChile
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpColombia.dbo.Estrategia e 
			inner join BelcorpColombia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpColombia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDColombia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpCostaRica.dbo.Estrategia e 
			inner join BelcorpCostaRica.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpCostaRica.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDCostaRica
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'DO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpDominicana.dbo.Estrategia e 
			inner join BelcorpDominicana.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpDominicana.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDDominicana
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'EC' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpEcuador.dbo.Estrategia e 
			inner join BelcorpEcuador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpEcuador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDEcuador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'GT' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpGuatemala.dbo.Estrategia e 
			inner join BelcorpGuatemala.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpGuatemala.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDGuatemala
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'MX' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpMexico.dbo.Estrategia e 
			inner join BelcorpMexico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpMexico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDMexico
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PA' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPanama.dbo.Estrategia e 
			inner join BelcorpPanama.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPanama.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPanama
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPeru.dbo.Estrategia e 
			inner join BelcorpPeru.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPeru.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPeru
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPuertoRico.dbo.Estrategia e 
			inner join BelcorpPuertoRico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPuertoRico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPuertoRico
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'SV' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpSalvador.dbo.Estrategia e 
			inner join BelcorpSalvador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpSalvador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDSalvador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'VE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpVenezuela.dbo.Estrategia e 
			inner join BelcorpVenezuela.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpVenezuela.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
			and e.TipoEstrategiaID = @teIDVenezuela

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
	@CampaniaID int
AS
--exec [dbo].[GetReporteValidacion]  201710
BEGIN
	BEGIN TRY
	DECLARE @teIDBolivia int;
	DECLARE @teIDChile int;
	DECLARE @teIDColombia int;
	DECLARE @teIDCostaRica int;
	DECLARE @teIDDominicana int;
	DECLARE @teIDEcuador int;
	DECLARE @teIDGuatemala int;
	DECLARE @teIDMexico int;
	DECLARE @teIDPanama int;
	DECLARE @teIDPeru int;
	DECLARE @teIDPuertoRico int;
	DECLARE @teIDSalvador int;
	DECLARE @teIDVenezuela int;

	DECLARE @TipoPersonalizacion varchar(10);

			SELECT  @teIDBolivia = TipoEstrategiaID from BelcorpBolivia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDChile = TipoEstrategiaID from BelcorpChile.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDColombia = TipoEstrategiaID from BelcorpColombia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDCostaRica = TipoEstrategiaID from BelcorpCostaRica.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDDominicana = TipoEstrategiaID from BelcorpDominicana.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDEcuador = TipoEstrategiaID from BelcorpEcuador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDGuatemala = TipoEstrategiaID from BelcorpGuatemala.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDMexico = TipoEstrategiaID from BelcorpMexico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPanama = TipoEstrategiaID from BelcorpPanama.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPeru = TipoEstrategiaID from BelcorpPeru.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPuertoRico = TipoEstrategiaID from BelcorpPuertoRico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDSalvador = TipoEstrategiaID from BelcorpSalvador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDVenezuela = TipoEstrategiaID from BelcorpVenezuela.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';

			SET @TipoPersonalizacion = 'OPT';

			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'BO' as Pais, e.CUV2, e.DescripcionCUV2, 
			CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
			e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
			, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpBolivia.dbo.Estrategia e 
			inner join BelcorpBolivia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpBolivia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDBolivia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CL' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpChile.dbo.Estrategia e 
			inner join BelcorpChile.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpChile.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDChile
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpColombia.dbo.Estrategia e 
			inner join BelcorpColombia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpColombia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDColombia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpCostaRica.dbo.Estrategia e 
			inner join BelcorpCostaRica.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpCostaRica.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDCostaRica
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'DO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpDominicana.dbo.Estrategia e 
			inner join BelcorpDominicana.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpDominicana.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDDominicana
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'EC' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpEcuador.dbo.Estrategia e 
			inner join BelcorpEcuador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpEcuador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDEcuador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'GT' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpGuatemala.dbo.Estrategia e 
			inner join BelcorpGuatemala.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpGuatemala.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDGuatemala
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'MX' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpMexico.dbo.Estrategia e 
			inner join BelcorpMexico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpMexico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDMexico
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PA' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPanama.dbo.Estrategia e 
			inner join BelcorpPanama.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPanama.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPanama
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPeru.dbo.Estrategia e 
			inner join BelcorpPeru.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPeru.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPeru
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPuertoRico.dbo.Estrategia e 
			inner join BelcorpPuertoRico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPuertoRico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPuertoRico
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'SV' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpSalvador.dbo.Estrategia e 
			inner join BelcorpSalvador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpSalvador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDSalvador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'VE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpVenezuela.dbo.Estrategia e 
			inner join BelcorpVenezuela.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpVenezuela.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
			and e.TipoEstrategiaID = @teIDVenezuela

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
	@CampaniaID int
AS
--exec [dbo].[GetReporteValidacion]  201710
BEGIN
	BEGIN TRY
	DECLARE @teIDBolivia int;
	DECLARE @teIDChile int;
	DECLARE @teIDColombia int;
	DECLARE @teIDCostaRica int;
	DECLARE @teIDDominicana int;
	DECLARE @teIDEcuador int;
	DECLARE @teIDGuatemala int;
	DECLARE @teIDMexico int;
	DECLARE @teIDPanama int;
	DECLARE @teIDPeru int;
	DECLARE @teIDPuertoRico int;
	DECLARE @teIDSalvador int;
	DECLARE @teIDVenezuela int;

	DECLARE @TipoPersonalizacion varchar(10);

			SELECT  @teIDBolivia = TipoEstrategiaID from BelcorpBolivia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDChile = TipoEstrategiaID from BelcorpChile.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDColombia = TipoEstrategiaID from BelcorpColombia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDCostaRica = TipoEstrategiaID from BelcorpCostaRica.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDDominicana = TipoEstrategiaID from BelcorpDominicana.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDEcuador = TipoEstrategiaID from BelcorpEcuador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDGuatemala = TipoEstrategiaID from BelcorpGuatemala.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDMexico = TipoEstrategiaID from BelcorpMexico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPanama = TipoEstrategiaID from BelcorpPanama.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPeru = TipoEstrategiaID from BelcorpPeru.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPuertoRico = TipoEstrategiaID from BelcorpPuertoRico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDSalvador = TipoEstrategiaID from BelcorpSalvador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDVenezuela = TipoEstrategiaID from BelcorpVenezuela.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';

			SET @TipoPersonalizacion = 'OPT';

			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'BO' as Pais, e.CUV2, e.DescripcionCUV2, 
			CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
			e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
			, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpBolivia.dbo.Estrategia e 
			inner join BelcorpBolivia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpBolivia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDBolivia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CL' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpChile.dbo.Estrategia e 
			inner join BelcorpChile.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpChile.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDChile
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpColombia.dbo.Estrategia e 
			inner join BelcorpColombia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpColombia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDColombia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpCostaRica.dbo.Estrategia e 
			inner join BelcorpCostaRica.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpCostaRica.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDCostaRica
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'DO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpDominicana.dbo.Estrategia e 
			inner join BelcorpDominicana.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpDominicana.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDDominicana
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'EC' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpEcuador.dbo.Estrategia e 
			inner join BelcorpEcuador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpEcuador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDEcuador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'GT' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpGuatemala.dbo.Estrategia e 
			inner join BelcorpGuatemala.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpGuatemala.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDGuatemala
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'MX' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpMexico.dbo.Estrategia e 
			inner join BelcorpMexico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpMexico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDMexico
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PA' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPanama.dbo.Estrategia e 
			inner join BelcorpPanama.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPanama.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPanama
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPeru.dbo.Estrategia e 
			inner join BelcorpPeru.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPeru.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPeru
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPuertoRico.dbo.Estrategia e 
			inner join BelcorpPuertoRico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPuertoRico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPuertoRico
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'SV' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpSalvador.dbo.Estrategia e 
			inner join BelcorpSalvador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpSalvador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDSalvador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'VE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpVenezuela.dbo.Estrategia e 
			inner join BelcorpVenezuela.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpVenezuela.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
			and e.TipoEstrategiaID = @teIDVenezuela

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
	@CampaniaID int
AS
--exec [dbo].[GetReporteValidacion]  201710
BEGIN
	BEGIN TRY
	DECLARE @teIDBolivia int;
	DECLARE @teIDChile int;
	DECLARE @teIDColombia int;
	DECLARE @teIDCostaRica int;
	DECLARE @teIDDominicana int;
	DECLARE @teIDEcuador int;
	DECLARE @teIDGuatemala int;
	DECLARE @teIDMexico int;
	DECLARE @teIDPanama int;
	DECLARE @teIDPeru int;
	DECLARE @teIDPuertoRico int;
	DECLARE @teIDSalvador int;
	DECLARE @teIDVenezuela int;

	DECLARE @TipoPersonalizacion varchar(10);

			SELECT  @teIDBolivia = TipoEstrategiaID from BelcorpBolivia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDChile = TipoEstrategiaID from BelcorpChile.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDColombia = TipoEstrategiaID from BelcorpColombia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDCostaRica = TipoEstrategiaID from BelcorpCostaRica.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDDominicana = TipoEstrategiaID from BelcorpDominicana.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDEcuador = TipoEstrategiaID from BelcorpEcuador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDGuatemala = TipoEstrategiaID from BelcorpGuatemala.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDMexico = TipoEstrategiaID from BelcorpMexico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPanama = TipoEstrategiaID from BelcorpPanama.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPeru = TipoEstrategiaID from BelcorpPeru.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPuertoRico = TipoEstrategiaID from BelcorpPuertoRico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDSalvador = TipoEstrategiaID from BelcorpSalvador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDVenezuela = TipoEstrategiaID from BelcorpVenezuela.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';

			SET @TipoPersonalizacion = 'OPT';

			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'BO' as Pais, e.CUV2, e.DescripcionCUV2, 
			CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
			e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
			, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpBolivia.dbo.Estrategia e 
			inner join BelcorpBolivia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpBolivia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDBolivia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CL' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpChile.dbo.Estrategia e 
			inner join BelcorpChile.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpChile.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDChile
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpColombia.dbo.Estrategia e 
			inner join BelcorpColombia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpColombia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDColombia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpCostaRica.dbo.Estrategia e 
			inner join BelcorpCostaRica.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpCostaRica.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDCostaRica
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'DO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpDominicana.dbo.Estrategia e 
			inner join BelcorpDominicana.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpDominicana.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDDominicana
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'EC' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpEcuador.dbo.Estrategia e 
			inner join BelcorpEcuador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpEcuador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDEcuador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'GT' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpGuatemala.dbo.Estrategia e 
			inner join BelcorpGuatemala.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpGuatemala.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDGuatemala
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'MX' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpMexico.dbo.Estrategia e 
			inner join BelcorpMexico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpMexico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDMexico
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PA' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPanama.dbo.Estrategia e 
			inner join BelcorpPanama.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPanama.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPanama
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPeru.dbo.Estrategia e 
			inner join BelcorpPeru.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPeru.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPeru
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPuertoRico.dbo.Estrategia e 
			inner join BelcorpPuertoRico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPuertoRico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPuertoRico
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'SV' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpSalvador.dbo.Estrategia e 
			inner join BelcorpSalvador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpSalvador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDSalvador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'VE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpVenezuela.dbo.Estrategia e 
			inner join BelcorpVenezuela.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpVenezuela.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
			and e.TipoEstrategiaID = @teIDVenezuela

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
	@CampaniaID int
AS
--exec [dbo].[GetReporteValidacion]  201710
BEGIN
	BEGIN TRY
	DECLARE @teIDBolivia int;
	DECLARE @teIDChile int;
	DECLARE @teIDColombia int;
	DECLARE @teIDCostaRica int;
	DECLARE @teIDDominicana int;
	DECLARE @teIDEcuador int;
	DECLARE @teIDGuatemala int;
	DECLARE @teIDMexico int;
	DECLARE @teIDPanama int;
	DECLARE @teIDPeru int;
	DECLARE @teIDPuertoRico int;
	DECLARE @teIDSalvador int;
	DECLARE @teIDVenezuela int;

	DECLARE @TipoPersonalizacion varchar(10);

			SELECT  @teIDBolivia = TipoEstrategiaID from BelcorpBolivia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDChile = TipoEstrategiaID from BelcorpChile.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDColombia = TipoEstrategiaID from BelcorpColombia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDCostaRica = TipoEstrategiaID from BelcorpCostaRica.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDDominicana = TipoEstrategiaID from BelcorpDominicana.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDEcuador = TipoEstrategiaID from BelcorpEcuador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDGuatemala = TipoEstrategiaID from BelcorpGuatemala.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDMexico = TipoEstrategiaID from BelcorpMexico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPanama = TipoEstrategiaID from BelcorpPanama.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPeru = TipoEstrategiaID from BelcorpPeru.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPuertoRico = TipoEstrategiaID from BelcorpPuertoRico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDSalvador = TipoEstrategiaID from BelcorpSalvador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDVenezuela = TipoEstrategiaID from BelcorpVenezuela.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';

			SET @TipoPersonalizacion = 'OPT';

			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'BO' as Pais, e.CUV2, e.DescripcionCUV2, 
			CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
			e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
			, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpBolivia.dbo.Estrategia e 
			inner join BelcorpBolivia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpBolivia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDBolivia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CL' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpChile.dbo.Estrategia e 
			inner join BelcorpChile.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpChile.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDChile
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpColombia.dbo.Estrategia e 
			inner join BelcorpColombia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpColombia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDColombia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpCostaRica.dbo.Estrategia e 
			inner join BelcorpCostaRica.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpCostaRica.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDCostaRica
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'DO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpDominicana.dbo.Estrategia e 
			inner join BelcorpDominicana.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpDominicana.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDDominicana
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'EC' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpEcuador.dbo.Estrategia e 
			inner join BelcorpEcuador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpEcuador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDEcuador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'GT' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpGuatemala.dbo.Estrategia e 
			inner join BelcorpGuatemala.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpGuatemala.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDGuatemala
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'MX' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpMexico.dbo.Estrategia e 
			inner join BelcorpMexico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpMexico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDMexico
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PA' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPanama.dbo.Estrategia e 
			inner join BelcorpPanama.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPanama.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPanama
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPeru.dbo.Estrategia e 
			inner join BelcorpPeru.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPeru.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPeru
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPuertoRico.dbo.Estrategia e 
			inner join BelcorpPuertoRico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPuertoRico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPuertoRico
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'SV' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpSalvador.dbo.Estrategia e 
			inner join BelcorpSalvador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpSalvador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDSalvador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'VE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpVenezuela.dbo.Estrategia e 
			inner join BelcorpVenezuela.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpVenezuela.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
			and e.TipoEstrategiaID = @teIDVenezuela

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
	@CampaniaID int
AS
--exec [dbo].[GetReporteValidacion]  201710
BEGIN
	BEGIN TRY
	DECLARE @teIDBolivia int;
	DECLARE @teIDChile int;
	DECLARE @teIDColombia int;
	DECLARE @teIDCostaRica int;
	DECLARE @teIDDominicana int;
	DECLARE @teIDEcuador int;
	DECLARE @teIDGuatemala int;
	DECLARE @teIDMexico int;
	DECLARE @teIDPanama int;
	DECLARE @teIDPeru int;
	DECLARE @teIDPuertoRico int;
	DECLARE @teIDSalvador int;
	DECLARE @teIDVenezuela int;

	DECLARE @TipoPersonalizacion varchar(10);

			SELECT  @teIDBolivia = TipoEstrategiaID from BelcorpBolivia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDChile = TipoEstrategiaID from BelcorpChile.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDColombia = TipoEstrategiaID from BelcorpColombia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDCostaRica = TipoEstrategiaID from BelcorpCostaRica.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDDominicana = TipoEstrategiaID from BelcorpDominicana.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDEcuador = TipoEstrategiaID from BelcorpEcuador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDGuatemala = TipoEstrategiaID from BelcorpGuatemala.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDMexico = TipoEstrategiaID from BelcorpMexico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPanama = TipoEstrategiaID from BelcorpPanama.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPeru = TipoEstrategiaID from BelcorpPeru.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPuertoRico = TipoEstrategiaID from BelcorpPuertoRico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDSalvador = TipoEstrategiaID from BelcorpSalvador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDVenezuela = TipoEstrategiaID from BelcorpVenezuela.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';

			SET @TipoPersonalizacion = 'OPT';

			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'BO' as Pais, e.CUV2, e.DescripcionCUV2, 
			CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
			e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
			, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpBolivia.dbo.Estrategia e 
			inner join BelcorpBolivia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpBolivia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDBolivia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CL' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpChile.dbo.Estrategia e 
			inner join BelcorpChile.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpChile.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDChile
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpColombia.dbo.Estrategia e 
			inner join BelcorpColombia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpColombia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDColombia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpCostaRica.dbo.Estrategia e 
			inner join BelcorpCostaRica.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpCostaRica.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDCostaRica
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'DO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpDominicana.dbo.Estrategia e 
			inner join BelcorpDominicana.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpDominicana.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDDominicana
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'EC' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpEcuador.dbo.Estrategia e 
			inner join BelcorpEcuador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpEcuador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDEcuador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'GT' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpGuatemala.dbo.Estrategia e 
			inner join BelcorpGuatemala.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpGuatemala.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDGuatemala
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'MX' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpMexico.dbo.Estrategia e 
			inner join BelcorpMexico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpMexico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDMexico
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PA' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPanama.dbo.Estrategia e 
			inner join BelcorpPanama.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPanama.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPanama
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPeru.dbo.Estrategia e 
			inner join BelcorpPeru.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPeru.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPeru
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPuertoRico.dbo.Estrategia e 
			inner join BelcorpPuertoRico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPuertoRico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPuertoRico
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'SV' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpSalvador.dbo.Estrategia e 
			inner join BelcorpSalvador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpSalvador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDSalvador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'VE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpVenezuela.dbo.Estrategia e 
			inner join BelcorpVenezuela.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpVenezuela.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
			and e.TipoEstrategiaID = @teIDVenezuela

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
	@CampaniaID int
AS
--exec [dbo].[GetReporteValidacion]  201710
BEGIN
	BEGIN TRY
	DECLARE @teIDBolivia int;
	DECLARE @teIDChile int;
	DECLARE @teIDColombia int;
	DECLARE @teIDCostaRica int;
	DECLARE @teIDDominicana int;
	DECLARE @teIDEcuador int;
	DECLARE @teIDGuatemala int;
	DECLARE @teIDMexico int;
	DECLARE @teIDPanama int;
	DECLARE @teIDPeru int;
	DECLARE @teIDPuertoRico int;
	DECLARE @teIDSalvador int;
	DECLARE @teIDVenezuela int;

	DECLARE @TipoPersonalizacion varchar(10);

			SELECT  @teIDBolivia = TipoEstrategiaID from BelcorpBolivia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDChile = TipoEstrategiaID from BelcorpChile.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDColombia = TipoEstrategiaID from BelcorpColombia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDCostaRica = TipoEstrategiaID from BelcorpCostaRica.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDDominicana = TipoEstrategiaID from BelcorpDominicana.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDEcuador = TipoEstrategiaID from BelcorpEcuador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDGuatemala = TipoEstrategiaID from BelcorpGuatemala.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDMexico = TipoEstrategiaID from BelcorpMexico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPanama = TipoEstrategiaID from BelcorpPanama.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPeru = TipoEstrategiaID from BelcorpPeru.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPuertoRico = TipoEstrategiaID from BelcorpPuertoRico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDSalvador = TipoEstrategiaID from BelcorpSalvador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDVenezuela = TipoEstrategiaID from BelcorpVenezuela.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';

			SET @TipoPersonalizacion = 'OPT';

			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'BO' as Pais, e.CUV2, e.DescripcionCUV2, 
			CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
			e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
			, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpBolivia.dbo.Estrategia e 
			inner join BelcorpBolivia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpBolivia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDBolivia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CL' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpChile.dbo.Estrategia e 
			inner join BelcorpChile.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpChile.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDChile
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpColombia.dbo.Estrategia e 
			inner join BelcorpColombia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpColombia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDColombia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpCostaRica.dbo.Estrategia e 
			inner join BelcorpCostaRica.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpCostaRica.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDCostaRica
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'DO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpDominicana.dbo.Estrategia e 
			inner join BelcorpDominicana.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpDominicana.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDDominicana
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'EC' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpEcuador.dbo.Estrategia e 
			inner join BelcorpEcuador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpEcuador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDEcuador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'GT' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpGuatemala.dbo.Estrategia e 
			inner join BelcorpGuatemala.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpGuatemala.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDGuatemala
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'MX' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpMexico.dbo.Estrategia e 
			inner join BelcorpMexico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpMexico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDMexico
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PA' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPanama.dbo.Estrategia e 
			inner join BelcorpPanama.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPanama.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPanama
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPeru.dbo.Estrategia e 
			inner join BelcorpPeru.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPeru.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPeru
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPuertoRico.dbo.Estrategia e 
			inner join BelcorpPuertoRico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPuertoRico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPuertoRico
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'SV' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpSalvador.dbo.Estrategia e 
			inner join BelcorpSalvador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpSalvador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDSalvador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'VE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpVenezuela.dbo.Estrategia e 
			inner join BelcorpVenezuela.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpVenezuela.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
			and e.TipoEstrategiaID = @teIDVenezuela

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
	@CampaniaID int
AS
--exec [dbo].[GetReporteValidacion]  201710
BEGIN
	BEGIN TRY
	DECLARE @teIDBolivia int;
	DECLARE @teIDChile int;
	DECLARE @teIDColombia int;
	DECLARE @teIDCostaRica int;
	DECLARE @teIDDominicana int;
	DECLARE @teIDEcuador int;
	DECLARE @teIDGuatemala int;
	DECLARE @teIDMexico int;
	DECLARE @teIDPanama int;
	DECLARE @teIDPeru int;
	DECLARE @teIDPuertoRico int;
	DECLARE @teIDSalvador int;
	DECLARE @teIDVenezuela int;

	DECLARE @TipoPersonalizacion varchar(10);

			SELECT  @teIDBolivia = TipoEstrategiaID from BelcorpBolivia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDChile = TipoEstrategiaID from BelcorpChile.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDColombia = TipoEstrategiaID from BelcorpColombia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDCostaRica = TipoEstrategiaID from BelcorpCostaRica.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDDominicana = TipoEstrategiaID from BelcorpDominicana.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDEcuador = TipoEstrategiaID from BelcorpEcuador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDGuatemala = TipoEstrategiaID from BelcorpGuatemala.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDMexico = TipoEstrategiaID from BelcorpMexico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPanama = TipoEstrategiaID from BelcorpPanama.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPeru = TipoEstrategiaID from BelcorpPeru.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPuertoRico = TipoEstrategiaID from BelcorpPuertoRico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDSalvador = TipoEstrategiaID from BelcorpSalvador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDVenezuela = TipoEstrategiaID from BelcorpVenezuela.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';

			SET @TipoPersonalizacion = 'OPT';

			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'BO' as Pais, e.CUV2, e.DescripcionCUV2, 
			CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
			e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
			, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpBolivia.dbo.Estrategia e 
			inner join BelcorpBolivia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpBolivia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDBolivia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CL' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpChile.dbo.Estrategia e 
			inner join BelcorpChile.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpChile.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDChile
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpColombia.dbo.Estrategia e 
			inner join BelcorpColombia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpColombia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDColombia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpCostaRica.dbo.Estrategia e 
			inner join BelcorpCostaRica.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpCostaRica.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDCostaRica
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'DO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpDominicana.dbo.Estrategia e 
			inner join BelcorpDominicana.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpDominicana.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDDominicana
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'EC' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpEcuador.dbo.Estrategia e 
			inner join BelcorpEcuador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpEcuador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDEcuador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'GT' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpGuatemala.dbo.Estrategia e 
			inner join BelcorpGuatemala.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpGuatemala.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDGuatemala
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'MX' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpMexico.dbo.Estrategia e 
			inner join BelcorpMexico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpMexico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDMexico
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PA' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPanama.dbo.Estrategia e 
			inner join BelcorpPanama.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPanama.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPanama
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPeru.dbo.Estrategia e 
			inner join BelcorpPeru.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPeru.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPeru
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPuertoRico.dbo.Estrategia e 
			inner join BelcorpPuertoRico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPuertoRico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPuertoRico
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'SV' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpSalvador.dbo.Estrategia e 
			inner join BelcorpSalvador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpSalvador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDSalvador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'VE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpVenezuela.dbo.Estrategia e 
			inner join BelcorpVenezuela.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpVenezuela.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
			and e.TipoEstrategiaID = @teIDVenezuela

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
	@CampaniaID int
AS
--exec [dbo].[GetReporteValidacion]  201710
BEGIN
	BEGIN TRY
	DECLARE @teIDBolivia int;
	DECLARE @teIDChile int;
	DECLARE @teIDColombia int;
	DECLARE @teIDCostaRica int;
	DECLARE @teIDDominicana int;
	DECLARE @teIDEcuador int;
	DECLARE @teIDGuatemala int;
	DECLARE @teIDMexico int;
	DECLARE @teIDPanama int;
	DECLARE @teIDPeru int;
	DECLARE @teIDPuertoRico int;
	DECLARE @teIDSalvador int;
	DECLARE @teIDVenezuela int;

	DECLARE @TipoPersonalizacion varchar(10);

			SELECT  @teIDBolivia = TipoEstrategiaID from BelcorpBolivia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDChile = TipoEstrategiaID from BelcorpChile.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDColombia = TipoEstrategiaID from BelcorpColombia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDCostaRica = TipoEstrategiaID from BelcorpCostaRica.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDDominicana = TipoEstrategiaID from BelcorpDominicana.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDEcuador = TipoEstrategiaID from BelcorpEcuador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDGuatemala = TipoEstrategiaID from BelcorpGuatemala.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDMexico = TipoEstrategiaID from BelcorpMexico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPanama = TipoEstrategiaID from BelcorpPanama.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPeru = TipoEstrategiaID from BelcorpPeru.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPuertoRico = TipoEstrategiaID from BelcorpPuertoRico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDSalvador = TipoEstrategiaID from BelcorpSalvador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDVenezuela = TipoEstrategiaID from BelcorpVenezuela.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';

			SET @TipoPersonalizacion = 'OPT';

			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'BO' as Pais, e.CUV2, e.DescripcionCUV2, 
			CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
			e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
			, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpBolivia.dbo.Estrategia e 
			inner join BelcorpBolivia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpBolivia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDBolivia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CL' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpChile.dbo.Estrategia e 
			inner join BelcorpChile.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpChile.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDChile
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpColombia.dbo.Estrategia e 
			inner join BelcorpColombia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpColombia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDColombia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpCostaRica.dbo.Estrategia e 
			inner join BelcorpCostaRica.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpCostaRica.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDCostaRica
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'DO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpDominicana.dbo.Estrategia e 
			inner join BelcorpDominicana.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpDominicana.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDDominicana
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'EC' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpEcuador.dbo.Estrategia e 
			inner join BelcorpEcuador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpEcuador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDEcuador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'GT' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpGuatemala.dbo.Estrategia e 
			inner join BelcorpGuatemala.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpGuatemala.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDGuatemala
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'MX' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpMexico.dbo.Estrategia e 
			inner join BelcorpMexico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpMexico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDMexico
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PA' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPanama.dbo.Estrategia e 
			inner join BelcorpPanama.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPanama.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPanama
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPeru.dbo.Estrategia e 
			inner join BelcorpPeru.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPeru.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPeru
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPuertoRico.dbo.Estrategia e 
			inner join BelcorpPuertoRico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPuertoRico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPuertoRico
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'SV' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpSalvador.dbo.Estrategia e 
			inner join BelcorpSalvador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpSalvador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDSalvador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'VE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpVenezuela.dbo.Estrategia e 
			inner join BelcorpVenezuela.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpVenezuela.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
			and e.TipoEstrategiaID = @teIDVenezuela

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
	@CampaniaID int
AS
--exec [dbo].[GetReporteValidacion]  201710
BEGIN
	BEGIN TRY
	DECLARE @teIDBolivia int;
	DECLARE @teIDChile int;
	DECLARE @teIDColombia int;
	DECLARE @teIDCostaRica int;
	DECLARE @teIDDominicana int;
	DECLARE @teIDEcuador int;
	DECLARE @teIDGuatemala int;
	DECLARE @teIDMexico int;
	DECLARE @teIDPanama int;
	DECLARE @teIDPeru int;
	DECLARE @teIDPuertoRico int;
	DECLARE @teIDSalvador int;
	DECLARE @teIDVenezuela int;

	DECLARE @TipoPersonalizacion varchar(10);

			SELECT  @teIDBolivia = TipoEstrategiaID from BelcorpBolivia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDChile = TipoEstrategiaID from BelcorpChile.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDColombia = TipoEstrategiaID from BelcorpColombia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDCostaRica = TipoEstrategiaID from BelcorpCostaRica.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDDominicana = TipoEstrategiaID from BelcorpDominicana.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDEcuador = TipoEstrategiaID from BelcorpEcuador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDGuatemala = TipoEstrategiaID from BelcorpGuatemala.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDMexico = TipoEstrategiaID from BelcorpMexico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPanama = TipoEstrategiaID from BelcorpPanama.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPeru = TipoEstrategiaID from BelcorpPeru.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPuertoRico = TipoEstrategiaID from BelcorpPuertoRico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDSalvador = TipoEstrategiaID from BelcorpSalvador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDVenezuela = TipoEstrategiaID from BelcorpVenezuela.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';

			SET @TipoPersonalizacion = 'OPT';

			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'BO' as Pais, e.CUV2, e.DescripcionCUV2, 
			CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
			e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
			, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpBolivia.dbo.Estrategia e 
			inner join BelcorpBolivia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpBolivia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDBolivia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CL' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpChile.dbo.Estrategia e 
			inner join BelcorpChile.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpChile.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDChile
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpColombia.dbo.Estrategia e 
			inner join BelcorpColombia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpColombia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDColombia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpCostaRica.dbo.Estrategia e 
			inner join BelcorpCostaRica.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpCostaRica.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDCostaRica
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'DO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpDominicana.dbo.Estrategia e 
			inner join BelcorpDominicana.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpDominicana.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDDominicana
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'EC' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpEcuador.dbo.Estrategia e 
			inner join BelcorpEcuador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpEcuador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDEcuador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'GT' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpGuatemala.dbo.Estrategia e 
			inner join BelcorpGuatemala.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpGuatemala.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDGuatemala
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'MX' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpMexico.dbo.Estrategia e 
			inner join BelcorpMexico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpMexico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDMexico
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PA' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPanama.dbo.Estrategia e 
			inner join BelcorpPanama.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPanama.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPanama
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPeru.dbo.Estrategia e 
			inner join BelcorpPeru.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPeru.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPeru
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPuertoRico.dbo.Estrategia e 
			inner join BelcorpPuertoRico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPuertoRico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPuertoRico
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'SV' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpSalvador.dbo.Estrategia e 
			inner join BelcorpSalvador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpSalvador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDSalvador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'VE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpVenezuela.dbo.Estrategia e 
			inner join BelcorpVenezuela.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpVenezuela.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
			and e.TipoEstrategiaID = @teIDVenezuela

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
	@CampaniaID int
AS
--exec [dbo].[GetReporteValidacion]  201710
BEGIN
	BEGIN TRY
	DECLARE @teIDBolivia int;
	DECLARE @teIDChile int;
	DECLARE @teIDColombia int;
	DECLARE @teIDCostaRica int;
	DECLARE @teIDDominicana int;
	DECLARE @teIDEcuador int;
	DECLARE @teIDGuatemala int;
	DECLARE @teIDMexico int;
	DECLARE @teIDPanama int;
	DECLARE @teIDPeru int;
	DECLARE @teIDPuertoRico int;
	DECLARE @teIDSalvador int;
	DECLARE @teIDVenezuela int;

	DECLARE @TipoPersonalizacion varchar(10);

			SELECT  @teIDBolivia = TipoEstrategiaID from BelcorpBolivia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDChile = TipoEstrategiaID from BelcorpChile.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDColombia = TipoEstrategiaID from BelcorpColombia.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDCostaRica = TipoEstrategiaID from BelcorpCostaRica.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDDominicana = TipoEstrategiaID from BelcorpDominicana.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDEcuador = TipoEstrategiaID from BelcorpEcuador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDGuatemala = TipoEstrategiaID from BelcorpGuatemala.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDMexico = TipoEstrategiaID from BelcorpMexico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPanama = TipoEstrategiaID from BelcorpPanama.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPeru = TipoEstrategiaID from BelcorpPeru.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDPuertoRico = TipoEstrategiaID from BelcorpPuertoRico.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDSalvador = TipoEstrategiaID from BelcorpSalvador.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';
			SELECT  @teIDVenezuela = TipoEstrategiaID from BelcorpVenezuela.dbo.TipoEstrategia where DescripcionEstrategia like '%Oferta para ti%';

			SET @TipoPersonalizacion = 'OPT';

			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'BO' as Pais, e.CUV2, e.DescripcionCUV2, 
			CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
			e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
			, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpBolivia.dbo.Estrategia e 
			inner join BelcorpBolivia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpBolivia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDBolivia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CL' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpChile.dbo.Estrategia e 
			inner join BelcorpChile.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpChile.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDChile
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpColombia.dbo.Estrategia e 
			inner join BelcorpColombia.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpColombia.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDColombia
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'CR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpCostaRica.dbo.Estrategia e 
			inner join BelcorpCostaRica.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpCostaRica.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDCostaRica
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'DO' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpDominicana.dbo.Estrategia e 
			inner join BelcorpDominicana.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpDominicana.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDDominicana
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'EC' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpEcuador.dbo.Estrategia e 
			inner join BelcorpEcuador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpEcuador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDEcuador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'GT' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpGuatemala.dbo.Estrategia e 
			inner join BelcorpGuatemala.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpGuatemala.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDGuatemala
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'MX' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpMexico.dbo.Estrategia e 
			inner join BelcorpMexico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpMexico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDMexico
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PA' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPanama.dbo.Estrategia e 
			inner join BelcorpPanama.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPanama.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPanama
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPeru.dbo.Estrategia e 
			inner join BelcorpPeru.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPeru.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPeru
			UNION
			select @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'PR' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpPuertoRico.dbo.Estrategia e 
			inner join BelcorpPuertoRico.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpPuertoRico.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDPuertoRico
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'SV' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpSalvador.dbo.Estrategia e 
			inner join BelcorpSalvador.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpSalvador.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
				and e.TipoEstrategiaID = @teIDSalvador
			UNION
			select  @TipoPersonalizacion as TipoEstrategia, e.CampaniaID, 'VE' as Pais, e.CUV2, e.DescripcionCUV2, 
					CASE WHEN LEN(e.DescripcionCUV2) > 40 THEN SUBSTRING(e.DescripcionCUV2, 1, 40) ELSE e.DescripcionCUV2 END as DescripcionCorta,
					e.ImagenUrl, e.Precio as PrecioNormal, e.Precio2 as PrecioOfertaDigital, e.LimiteVenta, e.Activo
					, pc.CUV as CUVPrecioTachado, pc.PrecioCatalogo as PrecioTachado 
			 from BelcorpVenezuela.dbo.Estrategia e 
			inner join BelcorpVenezuela.ods.Campania c on c.Codigo = e.CampaniaID
			inner join BelcorpVenezuela.ods.ProductoComercial pc on c.CampaniaID = pc.CampaniaID and pc.CUV = e.CUV2
			where 
				 e.CampaniaID = @CampaniaID
			and e.TipoEstrategiaID = @teIDVenezuela

		END TRY

	BEGIN CATCH

		DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT

		SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

	END CATCH
END
GO

