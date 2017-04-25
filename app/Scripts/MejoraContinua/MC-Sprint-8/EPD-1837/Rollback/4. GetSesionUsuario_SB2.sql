
USE BelcorpBolivia
GO

CREATE PROCEDURE [dbo].[GetSesionUsuario_SB2]

	@CodigoConsultora varchar(25)

AS

/*

GetSesionUsuario_SB2 '0000210'

*/

BEGIN

	DECLARE @PasePedidoWeb int

	DECLARE @TipoOferta2 int

	DECLARE @CompraOfertaEspecial int

	DECLARE @IndicadorMeta int



	DECLARE @FechaLimitePago SMALLDATETIME

	DECLARE @ODSCampaniaID INT



	declare @PaisID int

	declare @UsuarioPrueba bit

	declare @CodConsultora varchar(20)

	declare @CampaniaID int

	declare @ZonaID int

	declare @RegionID int

	declare @ConsultoraID bigint

	declare @UltimaCampanaFacturada int
	
	declare @CodUltimaCampFact int



	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),

		@PaisID = IsNull(PaisID,0),

		@CodConsultora = CodigoConsultora

	from usuario with(nolock)

	where codigousuario = @CodigoConsultora



	declare @CountCodigoNivel bigint



	/*Oferta Final, Catalogo Personalizado, CDR*/

	declare @EsOfertaFinalZonaValida bit = 0

	declare @EsOFGanaMasZonaValida bit = 0

	declare @EsCatalogoPersonalizadoZonaValida bit = 0

	declare @EsCDRWebZonaValida  bit = 0

	declare @CodigoZona varchar(4) = ''

	declare @CodigoRegion varchar(2) = ''



	select

		@CodigoZona = IsNull(z.Codigo,''),

		@CodigoRegion = IsNull(r.Codigo,'')

	from ods.consultora c with(nolock)

	inner join ods.Region r on

		c.RegionID = r.RegionID

	inner join ods.Zona z on

		c.ZonaID = z.ZonaID

	where c.codigo = @CodConsultora



	if not exists (select 1 from OfertaFinalRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOfertaFinalZonaValida = 1



	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCatalogoPersonalizadoZonaValida = 1

		

	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOFGanaMasZonaValida = 1

	

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCDRWebZonaValida = 1

	/*Fin Oferta Final, Catalogo Personalizado, CDR*/



	IF @UsuarioPrueba = 0

	BEGIN

		select @ZonaID = IsNull(ZonaID,0),

			@RegionID = IsNull(RegionID,0),

			@ConsultoraID = IsNull(ConsultoraID,0),

			@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0)

		from ods.consultora with(nolock)

		where codigo = @CodConsultora



		select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))

		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))

		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))

		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))

		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		SET @CodUltimaCampFact = (select campaniaid from ods.campania where codigo = @UltimaCampanaFacturada )



		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados

		declare @CampaniaFacturada int = 0



		select top 1 @CampaniaFacturada = p.CampaniaID

		FROM ods.Pedido(NOLOCK) P

			INNER JOIN ods.Consultora(NOLOCK) CO ON

				P.ConsultoraID=CO.ConsultoraID

			WHERE

				co.ConsultoraID=@ConsultoraID

				and	P.CampaniaID <> @ODSCampaniaID

				and	CO.RegionID=@RegionID

				and	CO.ZonaID=@ZonaID

		order by PedidoID desc



		/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */

		SET @FechaLimitePago = (

			SELECT FechaLimitePago

			FROM ODS.Cronograma

			WHERE CampaniaID = @CodUltimaCampFact AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
		)



		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID



		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			ro.Descripcion as RolDescripcion,

			isnull(c.EsJoven,0) EsJoven,

			(case

				when @CountCodigoNivel =0 then 0  --1589

				when @CountCodigoNivel>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			null as ConsultoraAsociada, --1688

			isnull(si.descripcion,null) SegmentoConstancia, --2469

			isnull(se.Codigo,null) Seccion, --2469

			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469

			case When cl.ConsultoraID is null then 0

				else 1 end esConsultoraLider,

			u.EMailActivo, --2532

			si.SegmentoInternoId,

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			0 as ConsultoraAsociadoID,

			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura

		FROM dbo.Usuario u with(nolock)

		LEFT JOIN (

			select *

			from ods.consultora with(nolock)

			where ConsultoraId = @ConsultoraID

		) c ON

			u.CodigoConsultora = c.Codigo

		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID

		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469

		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469

		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t with(nolock) ON c.TerritorioID = t.TerritorioID  

          AND c.SeccionID = t.SeccionID

            AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid

		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID

		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469

		WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

	ELSE

	BEGIN

		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			ro.Descripcion as RolDescripcion,

			(case

				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589

				when ISNULL(cl.ConsultoraID,0)>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688

			u.EMailActivo, --2532

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			0 as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,

			'Sin Seg.' as SegmentoAbreviatura

		FROM dbo.Usuario u (nolock)

		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID

		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t (nolock) ON c.TerritorioID = t.TerritorioID

			AND c.SeccionID = t.SeccionID

			AND c.ZonaID = t.ZonaID

			AND c.RegionID = t.RegionID

		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid

		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario

		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo

		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora	

	WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

END




GO

/*end*/

USE BelcorpChile
GO


CREATE PROCEDURE [dbo].[GetSesionUsuario_SB2]

	@CodigoConsultora varchar(25)

AS

/*

GetSesionUsuario_SB2 '115802968'

*/

BEGIN

	DECLARE @PasePedidoWeb int

	DECLARE @TipoOferta2 int

	DECLARE @CompraOfertaEspecial int

	DECLARE @IndicadorMeta int



	DECLARE @FechaLimitePago SMALLDATETIME

	DECLARE @ODSCampaniaID INT



	declare @PaisID int

	declare @UsuarioPrueba bit

	declare @CodConsultora varchar(20)

	declare @CampaniaID int

	declare @ZonaID int

	declare @RegionID int

	declare @ConsultoraID bigint

	declare @valorInscrita int

	declare @UltimaCampanaFacturada int
	
	declare @CodUltimaCampFact int



	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),

		@PaisID = IsNull(PaisID,0),

		@CodConsultora = CodigoConsultora

	from usuario with(nolock)

	where codigousuario = @CodigoConsultora



	declare @CountCodigoNivel bigint



	/*Oferta Final, Catalogo Personalizado, CDR*/

	declare @EsOfertaFinalZonaValida bit = 0

	declare @EsOFGanaMasZonaValida bit = 0

	declare @EsCatalogoPersonalizadoZonaValida bit = 0

	declare @EsCDRWebZonaValida  bit = 0

	declare @CodigoZona varchar(4) = ''

	declare @CodigoRegion varchar(2) = ''



	select

		@CodigoZona = IsNull(z.Codigo,''),

		@CodigoRegion = IsNull(r.Codigo,'')

	from ods.consultora c with(nolock)

	inner join ods.Region r on

		c.RegionID = r.RegionID

	inner join ods.Zona z on

		c.ZonaID = z.ZonaID

	where c.codigo = @CodConsultora



	if not exists (select 1 from OfertaFinalRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOfertaFinalZonaValida = 1



	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCatalogoPersonalizadoZonaValida = 1

		

	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOFGanaMasZonaValida = 1

		

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCDRWebZonaValida = 1

	/*Fin Oferta Final, Catalogo Personalizado, CDR*/



	IF @UsuarioPrueba = 0

	BEGIN

		select @ZonaID = IsNull(ZonaID,0),

			@RegionID = IsNull(RegionID,0),

			@ConsultoraID = IsNull(ConsultoraID,0),

			@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0)

		from ods.consultora with(nolock)

		where codigo = @CodConsultora



		select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))

		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))

		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))

		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))

		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		SET @CodUltimaCampFact = (select campaniaid from ods.campania where codigo = @UltimaCampanaFacturada )


		-- obtener la ultima CampaniaID(@CampaniaFacturada) de los pedidos facturados

			declare @CampaniaFacturada int = 0



			select top 1 @CampaniaFacturada = p.CampaniaID

			FROM ods.Pedido(NOLOCK) P

				INNER JOIN ods.Consultora(NOLOCK) CO ON

					P.ConsultoraID=CO.ConsultoraID

				WHERE

					co.ConsultoraID=@ConsultoraID

					and	P.CampaniaID <> @ODSCampaniaID

					and	CO.RegionID=@RegionID

					and	CO.ZonaID=@ZonaID

			order by PedidoID desc



			/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */

			SET @FechaLimitePago = (

				SELECT FechaLimitePago

				FROM ODS.Cronograma

				WHERE CampaniaID = @CodUltimaCampFact AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
			)



		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID

		select top 1 @valorInscrita=isnull(IndicadorActiva,0)

		from ods.ConsultoraFlexipago with(nolock)

		where PeriodoFacturado= @CampaniaID and ConsultoraID=@ConsultoraID



		if @valorInscrita=0

		BEGIN

			select top 1 @valorInscrita = isnull(Estado,0) from [dbo].[FlexipagoInsDes] with(nolock)

			where CodigoConsultora = @CodConsultora

			order by FlexipagoInsDesID desc



			Set @valorInscrita = isnull(@valorInscrita,0)

		End



		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,		

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			--ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			ISNULL((select top 1 Invitado from ods.ConsultoraFlexipago with(nolock)

				where PeriodoFacturado= @CampaniaID and ConsultoraID=@ConsultoraID),0) as IndicadorFlexiPago,--2461

			ISNULL(u.InvitacionRechazada,0) As InvitacionRechazada,--2416

			@valorInscrita InscritaFlexipago,--2461

			isnull(c.CampanaInvitada,0)  CampanaInvitada, --2461

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			ro.Descripcion as RolDescripcion,

			isnull(c.EsJoven,0) EsJoven,

			(case

				when @CountCodigoNivel =0 then 0  --1589

				when @CountCodigoNivel>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			null as ConsultoraAsociada, --1688

			isnull(si.descripcion,null) SegmentoConstancia, --2469

			isnull(se.Codigo,null) Seccion, --2469

			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469

			case When cl.ConsultoraID is null then 0

				else 1 end esConsultoraLider,

			si.SegmentoInternoId,

			u.EMailActivo, --2532

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			0 as ConsultoraAsociadoID,

			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura

		FROM dbo.Usuario u with(nolock)

		LEFT JOIN (

			select *

			from ods.consultora with(nolock)

			where ConsultoraId = @ConsultoraID

		) c ON

			u.CodigoConsultora = c.Codigo

		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID

		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469

		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469

		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t with(nolock) ON c.TerritorioID = t.TerritorioID

			AND c.SeccionID = t.SeccionID

            AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid

		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID

		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469

		WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

	ELSE

	BEGIN

		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,		

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			ISNULL(u.InvitacionRechazada,0) As InvitacionRechazada,--2461

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			ro.Descripcion as RolDescripcion,

			(case

				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589

				when ISNULL(cl.ConsultoraID,0)>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688

			u.EMailActivo, --2532

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			0 as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			cons.ConsultoraID as ConsultoraAsociadoID,

			'Sin Seg.' as SegmentoAbreviatura

		FROM dbo.Usuario u (nolock)

		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID

		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t (nolock) ON c.TerritorioID = t.TerritorioID

            AND c.SeccionID = t.SeccionID

            AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid

		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario

		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo

		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora

		WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

END




GO

/*end*/

USE BelcorpColombia
GO


CREATE PROCEDURE dbo.GetSesionUsuario_SB2

	@CodigoConsultora varchar(25)

AS

/*

GetSesionUsuario_SB2 '0000000075'

*/

BEGIN

	DECLARE @PasePedidoWeb int

	DECLARE @TipoOferta2 int

	DECLARE @CompraOfertaEspecial int

	DECLARE @IndicadorMeta int



	DECLARE @FechaLimitePago SMALLDATETIME

	DECLARE @ODSCampaniaID INT



	declare @PaisID int

	declare @UsuarioPrueba bit

	declare @CodConsultora varchar(20)

	declare @CampaniaID int

	declare @ZonaID int

	declare @RegionID int

	declare @ConsultoraID bigint

	declare @UltimaCampanaFacturada int
	
	declare @CodUltimaCampFact int



	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),

		@PaisID = IsNull(PaisID,0),

		@CodConsultora = CodigoConsultora

	from usuario with(nolock)

	where codigousuario = @CodigoConsultora



	declare @indicadorContrato bigint

	declare @CountCodigoNivel bigint

	declare @valorInscrita int



	/*Oferta Final, Catalogo Personalizado, CDR*/

	declare @EsOfertaFinalZonaValida bit = 0

	declare @EsOFGanaMasZonaValida bit = 0

	declare @EsCatalogoPersonalizadoZonaValida bit = 0

	declare @EsCDRWebZonaValida  bit = 0

	declare @CodigoZona varchar(4) = ''

	declare @CodigoRegion varchar(2) = ''



	select

		@CodigoZona = IsNull(z.Codigo,''),

		@CodigoRegion = IsNull(r.Codigo,'')

	from ods.consultora c with(nolock)

	inner join ods.Region r on

		c.RegionID = r.RegionID

	inner join ods.Zona z on

		c.ZonaID = z.ZonaID

	where c.codigo = @CodConsultora



	if not exists (select 1 from OfertaFinalRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOfertaFinalZonaValida = 1



	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCatalogoPersonalizadoZonaValida = 1

		

	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOFGanaMasZonaValida = 1

	

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCDRWebZonaValida = 1

	/*Fin Oferta Final, Catalogo Personalizado, CDR*/



	IF @UsuarioPrueba = 0

	BEGIN

		select @ZonaID = IsNull(ZonaID,0),

			@RegionID = IsNull(RegionID,0),

			@ConsultoraID = IsNull(ConsultoraID,0),

			@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0)

		from ods.consultora with(nolock)

		where codigo = @CodConsultora

		

		select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

			SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))

			SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))

			SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))

			SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))

			SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

			SET @CodUltimaCampFact = (select campaniaid from ods.campania where codigo = @UltimaCampanaFacturada )



			-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados

			declare @CampaniaFacturada int = 0



			select top 1 @CampaniaFacturada = p.CampaniaID

			FROM ods.Pedido(NOLOCK) P

				INNER JOIN ods.Consultora(NOLOCK) CO ON

					P.ConsultoraID=CO.ConsultoraID

				WHERE

					co.ConsultoraID=@ConsultoraID

					and	P.CampaniaID <> @ODSCampaniaID

					and	CO.RegionID=@RegionID

					and	CO.ZonaID=@ZonaID

			order by PedidoID desc



			/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */

			SET @FechaLimitePago = (

				SELECT FechaLimitePago

				FROM ODS.Cronograma

				WHERE CampaniaID = @CodUltimaCampFact AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
			)



		select top 1 @indicadorContrato= count(*) from Contrato where ConsultoraID=@ConsultoraID and aceptocontrato=1

		select @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID

		select top 1 @valorInscrita=isnull(IndicadorActiva,0)

		from ods.ConsultoraFlexipago with(nolock)

		where PeriodoFacturado= @CampaniaID and ConsultoraID=@ConsultoraID



		if @valorInscrita=0

			select top 1 @valorInscrita = isnull(Estado,0) from [dbo].[FlexipagoInsDes] with(nolock)

			where CodigoConsultora = @CodConsultora

			order by FlexipagoInsDesID desc

			Set @valorInscrita = isnull(@valorInscrita,0)

		

		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			isnull((select top 1 Invitado from ods.ConsultoraFlexipago with(nolock)

				where PeriodoFacturado= @CampaniaID and ConsultoraID=@ConsultoraID),0) as IndicadorFlexiPago,--1969

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,			

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			ro.Descripcion as RolDescripcion,

			@indicadorContrato IndicadorContrato,

			isnull(c.EsJoven,0) EsJoven,

			(case

				when @CountCodigoNivel =0 then 0  --1589

				when @CountCodigoNivel>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			null as ConsultoraAsociada, --1688

			isnull(si.descripcion,null) SegmentoConstancia, --2469

			isnull(se.Codigo,null) Seccion, --2469

			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469

			case When cl.ConsultoraID is null then 0

			else 1 end esConsultoraLider,

			isnull(c.CampanaInvitada,0)  CampanaInvitada, --1796

			@valorInscrita InscritaFlexipago,    --1796

			isnull(u.InvitacionRechazada,0)  InvitacionRechazada, --1796

			u.EMailActivo, --2532

			si.SegmentoInternoId,

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) as TieneODD,

			0 as ConsultoraAsociadoID,

			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura

		FROM dbo.Usuario u with(nolock)

		LEFT JOIN (

			select *

			from ods.consultora with(nolock)

			where ConsultoraId = @ConsultoraID

		) c ON

			u.CodigoConsultora = c.Codigo

		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID

		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469

		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469

		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t with(nolock) ON c.TerritorioID = t.TerritorioID

            AND c.SeccionID = t.SeccionID

            AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid

		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID

		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469

		WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

	ELSE

	BEGIN

		select top 1 @indicadorContrato= count(*) from Contrato where ConsultoraID=@ConsultoraID and aceptocontrato=1



		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,			

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			ro.Descripcion as RolDescripcion,

			@indicadorContrato IndicadorContrato,

			(case

				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589

				when ISNULL(cl.ConsultoraID,0)>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688

			isnull(u.InvitacionRechazada,0)  InvitacionRechazada, --1796

			u.EMailActivo, --2532

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			0 as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) as TieneODD,

			cons.ConsultoraID as ConsultoraAsociadoID,

			'Sin Seg.' as SegmentoAbreviatura

		FROM dbo.Usuario u (nolock)

		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID



		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID

		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t (nolock) ON c.TerritorioID = t.TerritorioID

			AND c.SeccionID = t.SeccionID

			AND c.ZonaID = t.ZonaID

			AND c.RegionID = t.RegionID

		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid

		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario

		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo

		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora

		WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

END





GO

/*end*/

USE BelcorpCostaRica
GO



CREATE PROCEDURE dbo.GetSesionUsuario_SB2

	@CodigoConsultora varchar(25)

AS

/*

GetSesionUsuario_SB2 '0000002'

*/

BEGIN

	DECLARE @PasePedidoWeb int

	DECLARE @TipoOferta2 int

	DECLARE @CompraOfertaEspecial int

	DECLARE @IndicadorMeta int



	DECLARE @FechaLimitePago SMALLDATETIME

	DECLARE @ODSCampaniaID INT



	declare @PaisID int

	declare @UsuarioPrueba bit

	declare @CodConsultora varchar(20)

	declare @CampaniaID int

	declare @ZonaID int

	declare @RegionID int

	declare @ConsultoraID bigint

	declare @IndicadorPermiso int

	declare @CodigoFicticio varchar(20)

	declare @UltimaCampanaFacturada int
	
	declare @CodUltimaCampFact int

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),

		@PaisID = IsNull(PaisID,0),

		@CodConsultora = CodigoConsultora

	from usuario with(nolock)

	where codigousuario = @CodigoConsultora

	declare @CountCodigoNivel bigint



	/*Oferta Final, Catalogo Personalizado, CDR*/

	declare @EsOfertaFinalZonaValida bit = 0

	declare @EsOFGanaMasZonaValida bit = 0

	declare @EsCatalogoPersonalizadoZonaValida bit = 0

	declare @EsCDRWebZonaValida  bit = 0

	declare @CodigoZona varchar(4) = ''

	declare @CodigoRegion varchar(2) = ''



	select

		@CodigoZona = IsNull(z.Codigo,''),

		@CodigoRegion = IsNull(r.Codigo,'')

	from ods.consultora c with(nolock)

	inner join ods.Region r on

		c.RegionID = r.RegionID

	inner join ods.Zona z on

		c.ZonaID = z.ZonaID

	where c.codigo = @CodConsultora



	if not exists (select 1 from OfertaFinalRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOfertaFinalZonaValida = 1



	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCatalogoPersonalizadoZonaValida = 1

	

	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOFGanaMasZonaValida = 1

	

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCDRWebZonaValida = 1

	/*Fin Oferta Final, Catalogo Personalizado, CDR*/



	IF @UsuarioPrueba = 0

	BEGIN

		select @ZonaID = IsNull(ZonaID,0),

			@RegionID = IsNull(RegionID,0),

			@ConsultoraID = IsNull(ConsultoraID,0),

			@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0)

		from ods.consultora with(nolock)

		where codigo = @CodConsultora

	

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))

		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))

		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))

		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))

		SET @IndicadorPermiso = (Select dbo.GetPermisoFIC(@CodigoConsultora,@ZonaID,@CampaniaID))

		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		SET @CodUltimaCampFact = (select campaniaid from ods.campania where codigo = @UltimaCampanaFacturada )



			-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados

			declare @CampaniaFacturada int = 0



			select top 1 @CampaniaFacturada = p.CampaniaID

			FROM ods.Pedido(NOLOCK) P

			INNER JOIN ods.Consultora(NOLOCK) CO ON

				P.ConsultoraID=CO.ConsultoraID

			WHERE

				co.ConsultoraID=@ConsultoraID

				and	P.CampaniaID <> @ODSCampaniaID

				and	CO.RegionID=@RegionID

				and	CO.ZonaID=@ZonaID

			order by PedidoID desc



			/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */

			SET @FechaLimitePago = (

				SELECT FechaLimitePago

				FROM ODS.Cronograma

				WHERE CampaniaID = @CodUltimaCampFact AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
			)



		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID

		--SSAP CGI(Id Solicitud=1402)

		--begin

		declare @IndicadorOfertaFIC int

		declare @ImagenUrlOfertaFIC varchar(500)

		SET @IndicadorOfertaFIC = (SELECT dbo.GetIndicadorOfertaFIC(@CampaniaID))

		if @IndicadorOfertaFIC>=1

		begin

			SET @ImagenUrlOfertaFIC = (SELECT dbo.GetImagenOfertaFIC(@CampaniaID))

		end

		else

		begin

			SET @ImagenUrlOfertaFIC = ''

		end

		--end



		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			@IndicadorPermiso IndicadorPermisoFIC,

			ro.Descripcion as RolDescripcion,

			@IndicadorOfertaFIC IndicadorOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			@ImagenUrlOfertaFIC ImagenUrlOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			(select top 1 isnull(NroCampanias,0) from pais where CodigoISO=p.CodigoISO) NroCampanias,

			isnull(c.EsJoven,0) EsJoven,

			(case

				when @CountCodigoNivel =0 then 0  --1589

				when @CountCodigoNivel>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			null as ConsultoraAsociada, --1688

			isnull(si.descripcion,null) SegmentoConstancia, --2469

			isnull(se.Codigo,null) Seccion, --2469

			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469

			case When cl.ConsultoraID is null then 0

				else 1 end esConsultoraLider,

			u.EMailActivo, --2532

			si.SegmentoInternoId,

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			0 as ConsultoraAsociadoID,

			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura

		FROM dbo.Usuario u with(nolock)

		LEFT JOIN (

			select *

			from ods.consultora with(nolock)

			where ConsultoraId = @ConsultoraID

		) c ON

			u.CodigoConsultora = c.Codigo

		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID

		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469

		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469

		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t with(nolock) ON c.TerritorioID = t.TerritorioID

            AND c.SeccionID = t.SeccionID

			AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid

		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID

		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469

		WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

	ELSE

	BEGIN

		SET @CodigoFicticio = (SELECT TOP 1 CodigoConsultoraAsociada FROM UsuarioPrueba with(nolock) WHERE CodigoFicticio = @CodConsultora)

		SET @IndicadorPermiso = (SELECT dbo.GetPermisoFIC(@CodigoConsultora,@ZonaID,@CampaniaID))



		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,		

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			@IndicadorPermiso IndicadorPermisoFIC,

			ro.Descripcion as RolDescripcion,

			@IndicadorOfertaFIC IndicadorOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			@ImagenUrlOfertaFIC ImagenUrlOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			(select top 1 isnull(NroCampanias,0) from pais where CodigoISO=p.CodigoISO) NroCampanias,

			(case

				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589

				when ISNULL(cl.ConsultoraID,0)>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688

			u.EMailActivo, --2532

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,			

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			0 as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			cons.ConsultoraID as ConsultoraAsociadoID,

			'Sin Seg.' as SegmentoAbreviatura

		FROM dbo.[Usuario] u (nolock)

		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID

		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t (nolock) ON c.TerritorioID = t.TerritorioID

            AND c.SeccionID = t.SeccionID        

			AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid

		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario

		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo

		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora

		WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

END




GO

/*end*/

USE BelcorpDominicana
GO



CREATE PROCEDURE [dbo].[GetSesionUsuario_SB2]

	@CodigoConsultora varchar(25)

AS

/*

GetSesionUsuario_SB2 '0000227'

*/

BEGIN

	DECLARE @PasePedidoWeb int

	DECLARE @TipoOferta2 int

	DECLARE @CompraOfertaEspecial int

	DECLARE @IndicadorMeta int



	DECLARE @FechaLimitePago SMALLDATETIME

	DECLARE @ODSCampaniaID INT



	DECLARE @PaisID int

	DECLARE @UsuarioPrueba bit

	DECLARE @CodConsultora varchar(20)

	DECLARE @CampaniaID int

	DECLARE @ZonaID int

	DECLARE @RegionID int

	DECLARE @ConsultoraID bigint

	DECLARE @IndicadorPermiso int

	DECLARE @CodigoFicticio varchar(20)

	declare @UltimaCampanaFacturada int
	
	declare @CodUltimaCampFact int



	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),

		@PaisID = IsNull(PaisID,0),

		@CodConsultora = CodigoConsultora

	from usuario with(nolock)

	where codigousuario = @CodigoConsultora

	declare @CountCodigoNivel bigint



	/*Oferta Final, Catalogo Personalizado, CDR*/

	declare @EsOfertaFinalZonaValida bit = 0

	declare @EsOFGanaMasZonaValida bit = 0

	declare @EsCatalogoPersonalizadoZonaValida bit = 0

	declare @EsCDRWebZonaValida  bit = 0

	declare @CodigoZona varchar(4) = ''

	declare @CodigoRegion varchar(2) = ''



	select

		@CodigoZona = IsNull(z.Codigo,''),

		@CodigoRegion = IsNull(r.Codigo,'')

	from ods.consultora c with(nolock)

	inner join ods.Region r on

		c.RegionID = r.RegionID

	inner join ods.Zona z on

		c.ZonaID = z.ZonaID

	where c.codigo = @CodConsultora



	if not exists (select 1 from OfertaFinalRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOfertaFinalZonaValida = 1



	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCatalogoPersonalizadoZonaValida = 1

		

	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOFGanaMasZonaValida = 1

	

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCDRWebZonaValida = 1

	/*Fin Oferta Final, Catalogo Personalizado, CDR*/



	IF @UsuarioPrueba = 0

	BEGIN

		select @ZonaID = IsNull(ZonaID,0),

			@RegionID = IsNull(RegionID,0),

			@ConsultoraID = IsNull(ConsultoraID,0),

			@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0)

		from ods.consultora with(nolock)

		where codigo = @CodConsultora





		select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))

		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))

		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))

		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))

		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		SET @CodUltimaCampFact = (select campaniaid from ods.campania where codigo = @UltimaCampanaFacturada )



		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados

		declare @CampaniaFacturada int = 0



		select top 1 @CampaniaFacturada = p.CampaniaID

		FROM ods.Pedido(NOLOCK) P

			INNER JOIN ods.Consultora(NOLOCK) CO ON					

				P.ConsultoraID=CO.ConsultoraID

			WHERE

				co.ConsultoraID=@ConsultoraID

				and	P.CampaniaID <> @ODSCampaniaID

				and	CO.RegionID=@RegionID

				and	CO.ZonaID=@ZonaID

		order by PedidoID desc



		/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */

		SET @FechaLimitePago = (

			SELECT FechaLimitePago

			FROM ODS.Cronograma

			WHERE CampaniaID = @CodUltimaCampFact AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
		)



		SET @IndicadorPermiso = (Select dbo.GetPermisoFIC(@CodigoConsultora,@ZonaID,@CampaniaID))

		select @CountCodigoNivel = count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID



		declare @IndicadorOfertaFIC int

		declare @ImagenUrlOfertaFIC varchar(500)

		SET @IndicadorOfertaFIC = (SELECT dbo.GetIndicadorOfertaFIC(@CampaniaID))

		if @IndicadorOfertaFIC>=1

		begin

			SET @ImagenUrlOfertaFIC = (SELECT dbo.GetImagenOfertaFIC(@CampaniaID))

		end

		else

		begin

			SET @ImagenUrlOfertaFIC = ''

		end



		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,			

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			@IndicadorPermiso IndicadorPermisoFIC,

			@IndicadorOfertaFIC IndicadorOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			@ImagenUrlOfertaFIC ImagenUrlOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			ro.Descripcion as RolDescripcion,

			isnull(c.EsJoven,0) EsJoven,

			(case

				when @CountCodigoNivel =0 then 0  --1589

				when @CountCodigoNivel>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			null as ConsultoraAsociada, --1688

			isnull(si.descripcion,null) SegmentoConstancia, --2469

			isnull(se.Codigo,null) Seccion, --2469

			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469

			case When cl.ConsultoraID is null then 0

				else 1 end esConsultoraLider,

			u.EMailActivo, --2532

			si.SegmentoInternoId,

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			0 as ConsultoraAsociadoID,

			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura

		FROM [dbo].[Usuario] u with(nolock)

		LEFT JOIN (

			select *

			from ods.consultora with(nolock)

			where ConsultoraId = @ConsultoraID

		) c ON

			u.CodigoConsultora = c.Codigo

		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID
		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469

		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469

		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t with(nolock) ON c.TerritorioID = t.TerritorioID

            AND c.SeccionID = t.SeccionID

            AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid

		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID

		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469

		WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

	ELSE

	BEGIN

		SET @CodigoFicticio = (SELECT TOP 1 CodigoConsultoraAsociada FROM UsuarioPrueba with(nolock) WHERE CodigoFicticio = @CodConsultora)

		SET @IndicadorPermiso = (SELECT dbo.GetPermisoFIC(@CodigoConsultora,@ZonaID,@CampaniaID))



		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,	

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			@IndicadorPermiso IndicadorPermisoFIC,

			@IndicadorOfertaFIC IndicadorOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			@ImagenUrlOfertaFIC ImagenUrlOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			ro.Descripcion as RolDescripcion,

			(case

				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589

				when ISNULL(cl.ConsultoraID,0)>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688

			u.EMailActivo, --2532

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			0 as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			cons.ConsultoraID as ConsultoraAsociadoID,

			'Sin Seg.' as SegmentoAbreviatura

		FROM [dbo].[Usuario] u (nolock)

		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID

		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t (nolock) ON c.TerritorioID = t.TerritorioID

			AND c.SeccionID = t.SeccionID

            AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid

		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario

		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo

		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora

		WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

END




GO

/*end*/

USE BelcorpEcuador
GO



CREATE PROCEDURE dbo.GetSesionUsuario_SB2 

 @CodigoConsultora varchar(25)  

AS  

/*

GetSesionUsuario_SB2 '0000020426'

*/

BEGIN  

	DECLARE @PasePedidoWeb int  

	DECLARE @TipoOferta2 int  

	DECLARE @CompraOfertaEspecial int  

	DECLARE @IndicadorMeta int  

	

	DECLARE @FechaLimitePago SMALLDATETIME

	DECLARE @ODSCampaniaID INT



	declare @PaisID int  

	declare @UsuarioPrueba bit  

	declare @CodConsultora varchar(20)  

	declare @CampaniaID int  

	declare @ZonaID int  

	declare @RegionID int  

	declare @ConsultoraID bigint  

	declare @UltimaCampanaFacturada int
	
	declare @CodUltimaCampFact int

	  

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),  

		@PaisID = IsNull(PaisID,0),  

		@CodConsultora = CodigoConsultora  

	from usuario with(nolock)  

	where codigousuario = @CodigoConsultora  

     

	declare @CountCodigoNivel bigint  

  

	/*Oferta Final, Catalogo Personalizado, CDR*/

	declare @EsOfertaFinalZonaValida bit = 0

	declare @EsOFGanaMasZonaValida bit = 0

	declare @EsCatalogoPersonalizadoZonaValida bit = 0

	declare @EsCDRWebZonaValida  bit = 0

	declare @CodigoZona varchar(4) = ''

	declare @CodigoRegion varchar(2) = ''



	select 

		@CodigoZona = IsNull(z.Codigo,''),    

		@CodigoRegion = IsNull(r.Codigo,'')   

	from ods.consultora c with(nolock)   

	inner join ods.Region r on

		c.RegionID = r.RegionID

	inner join ods.Zona z on

		c.ZonaID = z.ZonaID

	where c.codigo = @CodConsultora   

	

	if not exists (select 1 from OfertaFinalRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOfertaFinalZonaValida = 1



	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCatalogoPersonalizadoZonaValida = 1

		

	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOFGanaMasZonaValida = 1

	

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCDRWebZonaValida = 1

	/*Fin Oferta Final, Catalogo Personalizado, CDR*/



	IF @UsuarioPrueba = 0  

	BEGIN  

		select @ZonaID = IsNull(ZonaID,0),  

			@RegionID = IsNull(RegionID,0),  

			@ConsultoraID = IsNull(ConsultoraID,0),

			@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0)

		from ods.consultora with(nolock)  

		where codigo = @CodConsultora  

  

		select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)  

		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))  

		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))  

		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))  

		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))

		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		SET @CodUltimaCampFact = (select campaniaid from ods.campania where codigo = @UltimaCampanaFacturada )

		

			-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados

			declare @CampaniaFacturada int = 0

		

			select top 1 @CampaniaFacturada = p.CampaniaID

			FROM ods.Pedido(NOLOCK) P 

			INNER JOIN ods.Consultora(NOLOCK) CO ON 

				P.ConsultoraID=CO.ConsultoraID

			WHERE 

				co.ConsultoraID=@ConsultoraID

				and	P.CampaniaID <> @ODSCampaniaID

				and	CO.RegionID=@RegionID

				and	CO.ZonaID=@ZonaID

			order by PedidoID desc



			/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */

			SET @FechaLimitePago = (

				SELECT FechaLimitePago

				FROM ODS.Cronograma

				WHERE CampaniaID = @CodUltimaCampFact AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
			)

			

			select @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID        

  

		SELECT   

			u.PaisID,  

			p.CodigoISO,  

			c.RegionID,  

			r.Codigo AS CodigorRegion,  

			ISNULL(c.ZonaID,0) AS ZonaID,  

			ISNULL(z.Codigo,'') AS CodigoZona,  

			c.ConsultoraID,  

			u.CodigoUsuario,  

			u.CodigoConsultora,  

			u.Nombre AS NombreCompleto,  

			ISNULL(ur.RolID,0) AS RolID,  

			u.EMail, 

			p.Simbolo,  

			c.TerritorioID,  

			t.Codigo AS CodigoTerritorio,  

			c.MontoMinimoPedido,  

			c.MontoMaximoPedido,  

			p.CodigoFuente,  

			p.BanderaImagen,  

			p.Nombre as NombrePais,  

			u.CambioClave,  

			u.Telefono,  

			u.TelefonoTrabajo,

			u.Celular,  

			ISNULL(s.descripcion,'') as Segmento,  

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,  

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,  

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,  

			u.UsuarioPrueba,  

			ISNULL(u.Sobrenombre,'') as Sobrenombre,  

			ISNULL(c.PrimerNombre,'') as PrimerNombre,  

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,  

			ISNULL(@TipoOferta2,0) as TipoOferta2,  

			1 as CompraKitDupla,  

			1 as CompraOfertaDupla,  

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,  

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,  

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,  

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,  

			0 as ProgramaReconocimiento,  

			ISNULL(s.segmentoid, 0) as segmentoid,  

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,  

			'' as Nivel,  

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,  

			ISNULL(c.PrimerNombre,'') as PrimerNombre,  

			ISNULL(c.PrimerApellido,'') as PrimerApellido,  

			u.MostrarAyudaWebTraking,  

			ro.Descripcion as RolDescripcion,  

			isnull(c.EsJoven,0) EsJoven,  

			(case     

				when @CountCodigoNivel =0 then 0  --1589  

				when @CountCodigoNivel>0 then 1 End) Lider,--1589      

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589  

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589  

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589  

			isnull(p.PortalLideres,0) PortalLideres,--1589  

			isnull(p.LogoLideres,null) LogoLideres, --1589   

			null as ConsultoraAsociada, --1688   

			isnull(si.descripcion,null) SegmentoConstancia, --2469  

			isnull(se.Codigo,null) Seccion, --2469  

			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469  

			case When cl.ConsultoraID is null then 0  

				else 1 end esConsultoraLider,  

			u.EMailActivo, --2532  

			si.SegmentoInternoId,

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida ,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			0 as ConsultoraAsociadoID,

			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura

		FROM dbo.[Usuario] u with(nolock)  

		LEFT JOIN (  

			select *  

			from ods.consultora with(nolock)  

			where ConsultoraId = @ConsultoraID  

		) c ON 

			u.CodigoConsultora = c.Codigo  

		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo  

		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario  

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID  

		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID  

		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469  

		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469  

		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID  

		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID  

		LEFT JOIN [ods].[Territorio] t with(nolock) ON c.TerritorioID = t.TerritorioID  

			AND c.SeccionID = t.SeccionID  

            AND c.ZonaID = t.ZonaID  

            AND c.RegionID = t.RegionID  

		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid  

		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID  

		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469  

		WHERE 

			ro.Sistema = 1 

			and u.CodigoUsuario = @CodigoConsultora 

	END  

	ELSE  

	BEGIN  

		SELECT   

			u.PaisID,  

			p.CodigoISO,  

			c.RegionID,  

			r.Codigo AS CodigorRegion,  

			ISNULL(c.ZonaID,0) AS ZonaID,  

			ISNULL(z.Codigo,'') AS CodigoZona,  

			c.ConsultoraID,  

			u.CodigoUsuario,  

			u.CodigoConsultora,  

			u.Nombre AS NombreCompleto,  

			ISNULL(ur.RolID,0) AS RolID,  

			u.EMail,  

			p.Simbolo,  

			c.TerritorioID,  

			t.Codigo AS CodigoTerritorio,  

			c.MontoMinimoPedido,  

			c.MontoMaximoPedido,  

			p.CodigoFuente,  

			p.BanderaImagen,

			p.Nombre as NombrePais,  

			u.CambioClave,  

			u.Telefono,  

			u.TelefonoTrabajo,

			u.Celular,  

			ISNULL(s.descripcion,'') as Segmento,  

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,  

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,  

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,  

			u.UsuarioPrueba,  

			ISNULL(u.Sobrenombre,'') as Sobrenombre,  

			ISNULL(c.PrimerNombre,'') as PrimerNombre,  

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,  

			ISNULL(@TipoOferta2,0) as TipoOferta2,  

			1 as CompraKitDupla,  

			1 as CompraOfertaDupla,  

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,  

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,  

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,  

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,  

			0 as ProgramaReconocimiento,  

			ISNULL(s.segmentoid, 0) as segmentoid,  

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,  

			'' as Nivel,  

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,  

			ISNULL(c.PrimerNombre,'') as PrimerNombre,  

			ISNULL(c.PrimerApellido,'') as PrimerApellido,  

			u.MostrarAyudaWebTraking,  

			ro.Descripcion as RolDescripcion,  

			(case     

				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589  

				when ISNULL(cl.ConsultoraID,0)>0 then 1 End) Lider,--1589  

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589  

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589  

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589  

			isnull(p.PortalLideres,0) PortalLideres,--1589  

			isnull(p.LogoLideres,null) LogoLideres, --1589   

			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688  

			u.EMailActivo, --2532  

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			0 as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			cons.ConsultoraID as ConsultoraAsociadoID,

			'Sin Seg.' as SegmentoAbreviatura

		FROM [dbo].[Usuario] u (nolock)  

		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo  

		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario  

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID  

		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID  

		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID  

		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID  

		LEFT JOIN [ods].[Territorio] t (nolock) ON c.TerritorioID = t.TerritorioID  

            AND c.SeccionID = t.SeccionID  

            AND c.ZonaID = t.ZonaID  

            AND c.RegionID = t.RegionID  

		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid  

		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario  

		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo

		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora  

		WHERE ro.Sistema = 1 

			and	u.CodigoUsuario = @CodigoConsultora  

	END

END




GO

/*end*/

USE BelcorpGuatemala
GO


CREATE PROCEDURE [dbo].[GetSesionUsuario_SB2]

	@CodigoConsultora varchar(25)

AS

/*

GetSesionUsuario_SB2 '0100007'

*/

BEGIN

	DECLARE @PasePedidoWeb int

	DECLARE @TipoOferta2 int

	DECLARE @CompraOfertaEspecial int

	DECLARE @IndicadorMeta int



	DECLARE @FechaLimitePago SMALLDATETIME

	DECLARE @ODSCampaniaID INT



	declare @PaisID int

	declare @UsuarioPrueba bit

	declare @CodConsultora varchar(20)

	declare @CampaniaID int

	declare @ZonaID int

	declare @RegionID int

	declare @ConsultoraID bigint

	declare @IndicadorPermiso int

	declare @CodigoFicticio varchar(20)

	declare @UltimaCampanaFacturada int
	
	declare @CodUltimaCampFact int


	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),

		@PaisID = IsNull(PaisID,0),

		@CodConsultora = CodigoConsultora

	from usuario with(nolock)

	where codigousuario = @CodigoConsultora



	declare @CountCodigoNivel bigint



	/*Oferta Final, Catalogo Personalizado, CDR*/

	declare @EsOfertaFinalZonaValida bit = 0

	declare @EsOFGanaMasZonaValida bit = 0

	declare @EsCatalogoPersonalizadoZonaValida bit = 0

	declare @EsCDRWebZonaValida  bit = 0

	declare @CodigoZona varchar(4) = ''

	declare @CodigoRegion varchar(2) = ''



	select

		@CodigoZona = IsNull(z.Codigo,''),

		@CodigoRegion = IsNull(r.Codigo,'')

	from ods.consultora c with(nolock)

	inner join ods.Region r on

		c.RegionID = r.RegionID

	inner join ods.Zona z on

		c.ZonaID = z.ZonaID

	where c.codigo = @CodConsultora



	if not exists (select 1 from OfertaFinalRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOfertaFinalZonaValida = 1



	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCatalogoPersonalizadoZonaValida = 1

	

	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOFGanaMasZonaValida = 1

	

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCDRWebZonaValida = 1

	/*Fin Oferta Final, Catalogo Personalizado, CDR*/



	IF @UsuarioPrueba = 0

	BEGIN

		select @ZonaID = IsNull(ZonaID,0),

			@RegionID = IsNull(RegionID,0),

			@ConsultoraID = IsNull(ConsultoraID,0),

			@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0)

		from ods.consultora with(nolock)

		where codigo = @CodConsultora



		select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))

		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))

		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))

		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		SET @CodUltimaCampFact = (select campaniaid from ods.campania where codigo = @UltimaCampanaFacturada )



			-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados

			declare @CampaniaFacturada int = 0



			 select top 1 @CampaniaFacturada = p.CampaniaID

			FROM ods.Pedido(NOLOCK) P

				INNER JOIN ods.Consultora(NOLOCK) CO ON

					P.ConsultoraID=CO.ConsultoraID

				WHERE

					co.ConsultoraID=@ConsultoraID

					and	P.CampaniaID <> @ODSCampaniaID

					and	CO.RegionID=@RegionID

					and	CO.ZonaID=@ZonaID

			order by PedidoID desc



			/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */

			SET @FechaLimitePago = (

				SELECT FechaLimitePago

				FROM ODS.Cronograma

				WHERE CampaniaID = @CodUltimaCampFact AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
			)

			SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))

		SET @IndicadorPermiso = (Select dbo.GetPermisoFIC(@CodigoConsultora,@ZonaID,@CampaniaID))



		--SSAP CGI(Id Solicitud=1402)

		--begin

		declare @IndicadorOfertaFIC int

		declare @ImagenUrlOfertaFIC varchar(500)

		SET @IndicadorOfertaFIC = (SELECT dbo.GetIndicadorOfertaFIC(@CampaniaID))

		if @IndicadorOfertaFIC>=1

		begin

			SET @ImagenUrlOfertaFIC = (SELECT dbo.GetImagenOfertaFIC(@CampaniaID))

		end

		else

		begin

			SET @ImagenUrlOfertaFIC = ''

		end

		--end

		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID



		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			@IndicadorPermiso IndicadorPermisoFIC,

			ro.Descripcion as RolDescripcion,

			@IndicadorOfertaFIC IndicadorOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			@ImagenUrlOfertaFIC ImagenUrlOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			(select top 1 isnull(NroCampanias,0) from pais where CodigoISO=p.CodigoISO) NroCampanias,

			isnull(c.EsJoven,0) EsJoven,

			(case

				when @CountCodigoNivel =0 then 0  --1589

				when @CountCodigoNivel>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			null as ConsultoraAsociada, --1688

			isnull(si.descripcion,null) SegmentoConstancia, --2469

			isnull(se.Codigo,null) Seccion, --2469

			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469

			case When cl.ConsultoraID is null then 0

			else 1 end esConsultoraLider,

			u.EMailActivo, --2532

			si.SegmentoInternoId,

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			0 as ConsultoraAsociadoID,

			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura

		FROM [dbo].[Usuario] u with(nolock)

		LEFT JOIN (

		select *

		from ods.consultora with(nolock)

		where ConsultoraId = @ConsultoraID

		) c ON u.CodigoConsultora = c.Codigo

		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID

		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469

		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469

		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t with(nolock) ON c.TerritorioID = t.TerritorioID

            AND c.SeccionID = t.SeccionID AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid

		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID

		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469

		WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

	ELSE

	BEGIN

		SET @CodigoFicticio = (SELECT TOP 1 CodigoConsultoraAsociada FROM UsuarioPrueba with(nolock) WHERE CodigoFicticio = @CodConsultora)

		SET @IndicadorPermiso = (SELECT dbo.GetPermisoFIC(@CodigoConsultora,@ZonaID,@CampaniaID))



		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			@IndicadorPermiso IndicadorPermisoFIC,

			ro.Descripcion as RolDescripcion,

			@IndicadorOfertaFIC IndicadorOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			@ImagenUrlOfertaFIC ImagenUrlOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			(select top 1 isnull(NroCampanias,0) from pais where CodigoISO=p.CodigoISO) NroCampanias,

			(case

				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589

				when ISNULL(cl.ConsultoraID,0)>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688

			u.EMailActivo, --2532

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			0 as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			cons.ConsultoraID as ConsultoraAsociadoID,

			'Sin Seg.' as SegmentoAbreviatura

		FROM [dbo].[Usuario] u (nolock)

		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID

		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t (nolock) ON c.TerritorioID = t.TerritorioID

			AND c.SeccionID = t.SeccionID

            AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid

		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario

		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo

		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora

		WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

END




GO

/*end*/

USE BelcorpMexico
GO



CREATE PROCEDURE dbo.GetSesionUsuario_SB2

	@CodigoConsultora varchar(25)

AS

/*

GetSesionUsuario_SB2 '0009852'

*/

BEGIN

	DECLARE @PasePedidoWeb int

	DECLARE @TipoOferta2 int

	DECLARE @CompraOfertaEspecial int

	DECLARE @IndicadorMeta int



	DECLARE @FechaLimitePago SMALLDATETIME

	DECLARE @ODSCampaniaID INT



	declare @PaisID int

	declare @UsuarioPrueba bit

	declare @CodConsultora varchar(20)

	declare @CampaniaID int

	declare @ZonaID int

	declare @RegionID int

	declare @ConsultoraID bigint

	declare @IndicadorPermiso int

	declare @CodigoFicticio varchar(20)

	declare @UltimaCampanaFacturada int
	
	declare @CodUltimaCampFact int

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),

		@PaisID = IsNull(PaisID,0),

		@CodConsultora = CodigoConsultora

	from usuario with(nolock)

	where codigousuario = @CodigoConsultora

	select @ZonaID = IsNull(ZonaID,0),

		@RegionID = IsNull(RegionID,0),

		@ConsultoraID = IsNull(ConsultoraID,0)

	from ods.consultora with(nolock)

	where codigo = @CodConsultora

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

	declare @IndicadorOfertaFIC int

	declare @ImagenUrlOfertaFIC varchar(500)

	SET @IndicadorOfertaFIC = (SELECT dbo.GetIndicadorOfertaFIC(@CampaniaID))

	if @IndicadorOfertaFIC>=1

	begin

		SET @ImagenUrlOfertaFIC = (SELECT dbo.GetImagenOfertaFIC(@CampaniaID))

	end

	else

	begin

		SET @ImagenUrlOfertaFIC = ''

	end

	declare @CountCodigoNivel bigint



	/*Oferta Final, Catalogo Personalizado, CDR*/

	declare @EsOfertaFinalZonaValida bit = 0

	declare @EsOFGanaMasZonaValida bit = 0

	declare @EsCatalogoPersonalizadoZonaValida bit = 0

	declare @EsCDRWebZonaValida  bit = 0

	declare @CodigoZona varchar(4) = ''

	declare @CodigoRegion varchar(2) = ''



	select

		@CodigoZona = IsNull(z.Codigo,''),

		@CodigoRegion = IsNull(r.Codigo,'')

	from ods.consultora c with(nolock)

	inner join ods.Region r on

		c.RegionID = r.RegionID

	inner join ods.Zona z on

		c.ZonaID = z.ZonaID

	where c.codigo = @CodConsultora



	if not exists (select 1 from OfertaFinalRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOfertaFinalZonaValida = 1



	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCatalogoPersonalizadoZonaValida = 1

		

	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOFGanaMasZonaValida = 1

	

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCDRWebZonaValida = 1

	/*Fin Oferta Final, Catalogo Personalizado, CDR*/



	IF @UsuarioPrueba = 0

	BEGIN

		select @UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0)

		from ods.consultora with(nolock)

		where codigo = @CodConsultora


		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))

		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))

		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))

		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		SET @CodUltimaCampFact = (select campaniaid from ods.campania where codigo = @UltimaCampanaFacturada )



			-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados

			declare @CampaniaFacturada int = 0



			 select top 1 @CampaniaFacturada = p.CampaniaID

			FROM ods.Pedido(NOLOCK) P

				INNER JOIN ods.Consultora(NOLOCK) CO ON

					P.ConsultoraID=CO.ConsultoraID

				WHERE

					co.ConsultoraID=@ConsultoraID

					and	P.CampaniaID <> @ODSCampaniaID

					and	CO.RegionID=@RegionID

					and	CO.ZonaID=@ZonaID

			order by PedidoID desc



			/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */

			SET @FechaLimitePago = (

				SELECT FechaLimitePago

				FROM ODS.Cronograma

				WHERE CampaniaID = @CodUltimaCampFact AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
			)

		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))

		SET @IndicadorPermiso = (Select dbo.GetPermisoFIC(@CodigoConsultora,@ZonaID,@CampaniaID))

		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID



		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			isnull(u.EMail,'') as EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			@IndicadorPermiso IndicadorPermisoFIC,

			ro.Descripcion as RolDescripcion,

			@IndicadorOfertaFIC IndicadorOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			@ImagenUrlOfertaFIC ImagenUrlOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			(select top 1 isnull(NroCampanias,0) from pais where CodigoISO=p.CodigoISO) NroCampanias,

			isnull(c.EsJoven,0) EsJoven,

			(case	

				when @CountCodigoNivel =0 then 0  --1589

				when @CountCodigoNivel>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			null as ConsultoraAsociada, --1688

			isnull(si.descripcion,null) SegmentoConstancia, --2469

			isnull(se.Codigo,null) Seccion, --2469

			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469

			case When cl.ConsultoraID is null then 0

			else 1 end esConsultoraLider,

			u.EMailActivo, --2532

			si.SegmentoInternoId,

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			isnull(p.CatalogoPersonalizado,0) as CatalogoPersonalizado ,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) as TieneODD,

			0 as ConsultoraAsociadoID,

			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura

		FROM [dbo].[Usuario] u with(nolock)

		LEFT JOIN (

			select *

			from ods.consultora with(nolock)

			where ConsultoraId = @ConsultoraID	

		) c ON

			u.CodigoConsultora = c.Codigo

		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID

		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469

		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469

		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t with(nolock) ON c.TerritorioID = t.TerritorioID    

        AND c.SeccionID = t.SeccionID

            AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid

		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID

		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469

		WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

	ELSE

	BEGIN

		SET @CodigoFicticio = (SELECT TOP 1 CodigoConsultoraAsociada FROM UsuarioPrueba with(nolock) WHERE CodigoFicticio = @CodConsultora)

		SET @IndicadorPermiso = (SELECT dbo.GetPermisoFIC(@CodigoConsultora,@ZonaID,@CampaniaID))



		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			isnull(u.EMail,'') as EMail,

			p.Simbolo,

			c.TerritorioID,	

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			@IndicadorPermiso IndicadorPermisoFIC,

			ro.Descripcion as RolDescripcion,

			@IndicadorOfertaFIC IndicadorOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			@ImagenUrlOfertaFIC ImagenUrlOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			(select top 1 isnull(NroCampanias,0) from pais where CodigoISO=p.CodigoISO) NroCampanias,

			(case

				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589

				when ISNULL(cl.ConsultoraID,0)>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688

			u.EMailActivo, --2532

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			0 as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) as TieneODD,

			cons.ConsultoraID as ConsultoraAsociadoID,

			'Sin Seg.' as SegmentoAbreviatura

		FROM [dbo].[Usuario] u (nolock)

		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID

		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t (nolock) ON c.TerritorioID = t.TerritorioID

            AND c.SeccionID = t.SeccionID

            AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid

		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario

		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo

		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada=cl.CodigoConsultora

		WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

END




GO

/*end*/

USE BelcorpPanama
GO


CREATE PROCEDURE dbo.GetSesionUsuario_SB2

	@CodigoConsultora varchar(25)

AS

/*

GetSesionUsuario_SB2 '000000019'

*/

BEGIN

	DECLARE @PasePedidoWeb int

	DECLARE @TipoOferta2 int

	DECLARE @CompraOfertaEspecial int

	DECLARE @IndicadorMeta int



	DECLARE @FechaLimitePago SMALLDATETIME

	DECLARE @ODSCampaniaID INT



	DECLARE @PaisID int

	DECLARE @UsuarioPrueba bit

	DECLARE @CodConsultora varchar(20)

	DECLARE @CampaniaID int

	DECLARE @ZonaID int

	DECLARE @RegionID int

	DECLARE @ConsultoraID bigint

	DECLARE @IndicadorPermiso int

	DECLARE @CodigoFicticio varchar(20)

	declare @UltimaCampanaFacturada int
	
	declare @CodUltimaCampFact int



	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),

		@PaisID = IsNull(PaisID,0),

		@CodConsultora = CodigoConsultora

	from usuario with(nolock)

	where codigousuario = @CodigoConsultora

	declare @CountCodigoNivel bigint



	/*Oferta Final, Catalogo Personalizado, CDR*/

	declare @EsOfertaFinalZonaValida bit = 0

	declare @EsOFGanaMasZonaValida bit = 0

	declare @EsCatalogoPersonalizadoZonaValida bit = 0

	declare @EsCDRWebZonaValida  bit = 0

	declare @CodigoZona varchar(4) = ''

	declare @CodigoRegion varchar(2) = ''



	select

		@CodigoZona = IsNull(z.Codigo,''),

		@CodigoRegion = IsNull(r.Codigo,'')

	from ods.consultora c with(nolock)

	inner join ods.Region r on

		c.RegionID = r.RegionID

	inner join ods.Zona z on

		c.ZonaID = z.ZonaID

	where c.codigo = @CodConsultora



	if not exists (select 1 from OfertaFinalRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOfertaFinalZonaValida = 1



	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCatalogoPersonalizadoZonaValida = 1

		

	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOFGanaMasZonaValida = 1

		

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCDRWebZonaValida = 1

	/*Fin Oferta Final, Catalogo Personalizado, CDR*/



	IF @UsuarioPrueba = 0

	BEGIN

		select @ZonaID = IsNull(ZonaID,0),

			@RegionID = IsNull(RegionID,0),

			@ConsultoraID = IsNull(ConsultoraID,0),

			@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0)

		from ods.consultora with(nolock)

		where codigo = @CodConsultora



		select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))

		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))

		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))

		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))

		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		SET @CodUltimaCampFact = (select campaniaid from ods.campania where codigo = @UltimaCampanaFacturada )



			-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados

			declare @CampaniaFacturada int = 0



			 select top 1 @CampaniaFacturada = p.CampaniaID

			FROM ods.Pedido(NOLOCK) P

			INNER JOIN ods.Consultora(NOLOCK) CO ON					

			P.ConsultoraID=CO.ConsultoraID

			WHERE

				co.ConsultoraID=@ConsultoraID

				and	P.CampaniaID <> @ODSCampaniaID

				and	CO.RegionID=@RegionID

				and	CO.ZonaID=@ZonaID

			order by PedidoID desc



			/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */

			SET @FechaLimitePago = (

				SELECT FechaLimitePago

				FROM ODS.Cronograma

				WHERE CampaniaID = @CodUltimaCampFact AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
			)

		SET @IndicadorPermiso = (Select dbo.GetPermisoFIC(@CodigoConsultora,@ZonaID,@CampaniaID))

		select @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID



		declare @IndicadorOfertaFIC int

		declare @ImagenUrlOfertaFIC varchar(500)

		SET @IndicadorOfertaFIC = (SELECT dbo.GetIndicadorOfertaFIC(@CampaniaID))

		if @IndicadorOfertaFIC>=1

		begin

			SET @ImagenUrlOfertaFIC = (SELECT dbo.GetImagenOfertaFIC(@CampaniaID))

		end

		else

		begin

			SET @ImagenUrlOfertaFIC = ''

		end



		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			@IndicadorPermiso IndicadorPermisoFIC,

			@IndicadorOfertaFIC IndicadorOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			@ImagenUrlOfertaFIC ImagenUrlOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			ro.Descripcion as RolDescripcion,

			isnull(c.EsJoven,0) EsJoven,

			(case

				when @CountCodigoNivel =0 then 0  --1589

				when @CountCodigoNivel>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			null as ConsultoraAsociada, --1688

			isnull(si.descripcion,null) SegmentoConstancia, --2469

			isnull(se.Codigo,null) Seccion, --2469

			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469

			case When cl.ConsultoraID is null then 0

				else 1 end esConsultoraLider,

			u.EMailActivo, --2532

			si.SegmentoInternoId,

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,	

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			0 as ConsultoraAsociadoID,

			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura

		FROM [dbo].[Usuario] u with(nolock)		

		LEFT JOIN (

			select *

			from ods.consultora with(nolock)

			where ConsultoraId = @ConsultoraID

		) c ON

			u.CodigoConsultora = c.Codigo

		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID

		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469

		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469

		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t with(nolock) ON c.TerritorioID = t.TerritorioID

            AND c.SeccionID = t.SeccionID

            AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid

		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID

		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469

		WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

	ELSE

	BEGIN

		-- SET @CodigoFicticio = (SELECT TOP 1 CodigoConsultoraAsociada FROM UsuarioPrueba with(nolock) WHERE CodigoFicticio = @CodConsultora)

		-- SET @IndicadorPermiso = 0 --(SELECT dbo.GetPermisoFIC(@CodigoConsultora,@ZonaID,@CampaniaID))

		-- select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID

		SET @CodigoFicticio = (SELECT TOP 1 CodigoConsultoraAsociada FROM UsuarioPrueba with(nolock) WHERE CodigoFicticio = @CodConsultora)

		SET @IndicadorPermiso = (SELECT dbo.GetPermisoFIC(@CodigoConsultora,@ZonaID,@CampaniaID))



		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,			

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			@IndicadorPermiso IndicadorPermisoFIC,

			@IndicadorOfertaFIC IndicadorOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			@ImagenUrlOfertaFIC ImagenUrlOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			ro.Descripcion as RolDescripcion,

			--   (case

			--    when @CountCodigoNivel =0 then 0  --1589

			--   when @CountCodigoNivel>0 then 1 End) Lider,--1589

			(case

				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589

				when ISNULL(cl.ConsultoraID,0)>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688

			u.EMailActivo, --2532

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			0 as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			cons.ConsultoraID as ConsultoraAsociadoID,

			'Sin Seg.' as SegmentoAbreviatura

		FROM [dbo].[Usuario] u (nolock)

		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID

		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t (nolock) ON c.TerritorioID = t.TerritorioID

			AND c.SeccionID = t.SeccionID

            AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid

		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario

		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo

		--left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID

		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada=cl.CodigoConsultora

		WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

END




GO

/*end*/

USE BelcorpPeru
GO


CREATE PROCEDURE dbo.GetSesionUsuario_SB2

	@CodigoConsultora varchar(25)

AS

/*

GetSesionUsuario_SB2 '000758833'

*/

BEGIN

	DECLARE @PasePedidoWeb int

	DECLARE @TipoOferta2 int

	DECLARE @CompraOfertaEspecial int

	DECLARE @IndicadorMeta int



	DECLARE @FechaLimitePago SMALLDATETIME

	DECLARE @ODSCampaniaID INT



	declare @PaisID int

	declare @UsuarioPrueba bit

	declare @CodConsultora varchar(20)

	declare @CampaniaID int

	declare @ZonaID int

	declare @RegionID int

	declare @ConsultoraID bigint

	declare @UltimaCampanaFacturada int
	
	declare @CodUltimaCampFact int



	select TOP 1

		@UsuarioPrueba = ISNULL(UsuarioPrueba,0),

		@PaisID = IsNull(PaisID,0),

		@CodConsultora = CodigoConsultora

	from usuario with(nolock)

	where codigousuario = @CodigoConsultora



	declare @CountCodigoNivel bigint



	/*Oferta Final, Catalogo Personalizado, CDR*/

	declare @EsOfertaFinalZonaValida bit = 0

	declare @EsOFGanaMasZonaValida bit = 0

	declare @EsCatalogoPersonalizadoZonaValida bit = 0

	declare @EsCDRWebZonaValida  bit = 0

	declare @CodigoZona varchar(4) = ''

	declare @CodigoRegion varchar(2) = ''



	select

		@CodigoZona = IsNull(z.Codigo,''),

		@CodigoRegion = IsNull(r.Codigo,'')

	from ods.consultora c with(nolock)

	inner join ods.Region r on

		c.RegionID = r.RegionID

	inner join ods.Zona z on

		c.ZonaID = z.ZonaID

	where c.codigo = @CodConsultora



	if not exists (select 1 from OfertaFinalRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOfertaFinalZonaValida = 1



	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCatalogoPersonalizadoZonaValida = 1

		

	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOFGanaMasZonaValida = 1

	

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCDRWebZonaValida = 1

	/*Fin Oferta Final, Catalogo Personalizado, CDR*/



	IF @UsuarioPrueba = 0

	BEGIN

		select

			@ZonaID = IsNull(ZonaID,0),

			@RegionID = IsNull(RegionID,0),

			@ConsultoraID = IsNull(ConsultoraID,0),

			@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0)

		from ods.consultora with(nolock)

		where codigo = @CodConsultora



		select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

			SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))

			SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))

			SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))

			SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))

			SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

			SET @CodUltimaCampFact = (select campaniaid from ods.campania where codigo = @UltimaCampanaFacturada )



			-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados

			declare @CampaniaFacturada int = 0



			select top 1 @CampaniaFacturada = p.CampaniaID

			FROM ods.Pedido(NOLOCK) P

				INNER JOIN ods.Consultora(NOLOCK) CO ON

					P.ConsultoraID=CO.ConsultoraID

				WHERE

					co.ConsultoraID=@ConsultoraID

					and	P.CampaniaID <> @ODSCampaniaID

					and	CO.RegionID=@RegionID

					and	CO.ZonaID=@ZonaID

			order by PedidoID desc



			/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */

			SET @FechaLimitePago = (

				SELECT FechaLimitePago

				FROM ODS.Cronograma

				WHERE CampaniaID = @CodUltimaCampFact AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
			)



		    select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID



		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			dbo.GetIndicadorFlexipago(c.ConsultoraId,ISNULL(c.UltimaCampanaFacturada,0),'') as IndicadorFlexiPago,

			dbo.GetIndicadorFlexipago(c.ConsultoraId,ISNULL(c.UltimaCampanaFacturada,0),'') as InscritaFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			ro.Descripcion as RolDescripcion,

			isnull(c.EsJoven,0) EsJoven,

			(case

				when @CountCodigoNivel =0 then 0

				when @CountCodigoNivel>0 then 1 End) Lider,

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,

			isnull(cl.CodigoNivelLider,0) NivelLider,

			isnull(p.PortalLideres,0) PortalLideres,

			isnull(p.LogoLideres,null) LogoLideres,

			null as ConsultoraAsociada,

			isnull(si.descripcion,null) SegmentoConstancia,

			isnull(se.Codigo,null) Seccion,

			isnull(nl.DescripcionNivel,null) DescripcionNivel,

			(case

				When cl.ConsultoraID is null

				then 0

				else 1 end) esConsultoraLider,

			u.EMailActivo,

			si.SegmentoInternoId,

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			isnull(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) as TieneODD,

			0 as ConsultoraAsociadoID,

			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura

		FROM dbo.Usuario u with(nolock)

		LEFT JOIN (

			select *

			from ods.consultora with(nolock)

			where ConsultoraId = @ConsultoraID

		) c ON	

		u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID

		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469

		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469

		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t with(nolock) ON c.TerritorioID = t.TerritorioID

            AND c.SeccionID = t.SeccionID

            AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid

		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID

		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469

		WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

	ELSE

	BEGIN

		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,		

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,		

			dbo.GetIndicadorFlexipago(c.ConsultoraId,ISNULL(c.UltimaCampanaFacturada,0),up.CodigoConsultoraAsociada) as IndicadorFlexiPago,

			dbo.GetIndicadorFlexipago(c.ConsultoraId,ISNULL(c.UltimaCampanaFacturada,0),'') as InscritaFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			ro.Descripcion as RolDescripcion,

			(case

				when ISNULL(cl.ConsultoraID,0) =0 then 0

				when ISNULL(cl.ConsultoraID,0)>0 then 1 End) Lider,

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,

			isnull(cl.CodigoNivelLider,0) NivelLider,

			isnull(p.PortalLideres,0) PortalLideres,

			isnull(p.LogoLideres,null) LogoLideres,

			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada,

			u.EMailActivo,

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			0 as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			cons.ConsultoraID as ConsultoraAsociadoID,

			'Sin Seg.' as SegmentoAbreviatura

		FROM dbo.Usuario u (nolock)

		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID

		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t (nolock) ON c.TerritorioID = t.TerritorioID

            AND c.SeccionID = t.SeccionID

            AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid

		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario

		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo

		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora

		WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

END




GO

/*end*/

USE BelcorpPuertoRico
GO



CREATE PROCEDURE dbo.GetSesionUsuario_SB2

	@CodigoConsultora varchar(25)

AS

/*

GetSesionUsuario_SB2 '0000205'

*/

BEGIN

	DECLARE @PasePedidoWeb int

	DECLARE @TipoOferta2 int

	DECLARE @CompraOfertaEspecial int

	DECLARE @IndicadorMeta int



	DECLARE @FechaLimitePago SMALLDATETIME

	DECLARE @ODSCampaniaID INT



	DECLARE @PaisID int

	DECLARE @UsuarioPrueba bit

	DECLARE @CodConsultora varchar(20)

	DECLARE @CampaniaID int

	DECLARE @ZonaID int

	DECLARE @RegionID int

	DECLARE @ConsultoraID bigint

	DECLARE @IndicadorPermiso int

	DECLARE @CodigoFicticio varchar(20)

	declare @UltimaCampanaFacturada int
	
	declare @CodUltimaCampFact int



	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),

		@PaisID = IsNull(PaisID,0),

		@CodConsultora = CodigoConsultora

	from usuario with(nolock)

	where codigousuario = @CodigoConsultora

	declare @CountCodigoNivel bigint



	/*Oferta Final, Catalogo Personalizado, CDR*/

	declare @EsOfertaFinalZonaValida bit = 0

	declare @EsOFGanaMasZonaValida bit = 0

	declare @EsCatalogoPersonalizadoZonaValida bit = 0

	declare @EsCDRWebZonaValida  bit = 0

	declare @CodigoZona varchar(4) = ''

	declare @CodigoRegion varchar(2) = ''



	select

		@CodigoZona = IsNull(z.Codigo,''),

		@CodigoRegion = IsNull(r.Codigo,'')

	from ods.consultora c with(nolock)

	inner join ods.Region r on

		c.RegionID = r.RegionID

	inner join ods.Zona z on

		c.ZonaID = z.ZonaID

	where c.codigo = @CodConsultora



	if not exists (select 1 from OfertaFinalRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOfertaFinalZonaValida = 1



	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCatalogoPersonalizadoZonaValida = 1

		

	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOFGanaMasZonaValida = 1

	

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCDRWebZonaValida = 1

	/*Fin Oferta Final, Catalogo Personalizado, CDR*/



	IF @UsuarioPrueba = 0

	BEGIN

		select @ZonaID = IsNull(ZonaID,0),

			@RegionID = IsNull(RegionID,0),

			@ConsultoraID = IsNull(ConsultoraID,0),

			@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0)

		from ods.consultora with(nolock)

		where codigo = @CodConsultora



		select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))

		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))

		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))

		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))

		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		SET @CodUltimaCampFact = (select campaniaid from ods.campania where codigo = @UltimaCampanaFacturada )



			-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados

			declare @CampaniaFacturada int = 0



			select top 1 @CampaniaFacturada = p.CampaniaID

			FROM ods.Pedido(NOLOCK) P

			INNER JOIN ods.Consultora(NOLOCK) CO ON					

				P.ConsultoraID=CO.ConsultoraID

			WHERE

				co.ConsultoraID=@ConsultoraID

				and	P.CampaniaID <> @ODSCampaniaID

				and	CO.RegionID=@RegionID

				and	CO.ZonaID=@ZonaID

			order by PedidoID desc



			/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */

			SET @FechaLimitePago = (

				SELECT FechaLimitePago

				FROM ODS.Cronograma

				WHERE CampaniaID = @CodUltimaCampFact AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
			)



			SET @IndicadorPermiso = (Select dbo.GetPermisoFIC(@CodigoConsultora,@ZonaID,@CampaniaID))

		select @CountCodigoNivel = count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID



		declare @IndicadorOfertaFIC int

		declare @ImagenUrlOfertaFIC varchar(500)

		SET @IndicadorOfertaFIC = (SELECT dbo.GetIndicadorOfertaFIC(@CampaniaID))

		if @IndicadorOfertaFIC>=1

		begin

			SET @ImagenUrlOfertaFIC = (SELECT dbo.GetImagenOfertaFIC(@CampaniaID))

		end

		else

		begin

			SET @ImagenUrlOfertaFIC = ''

		end



		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,			

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			@IndicadorPermiso IndicadorPermisoFIC,

			@IndicadorOfertaFIC IndicadorOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			@ImagenUrlOfertaFIC ImagenUrlOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			ro.Descripcion as RolDescripcion,

			isnull(c.EsJoven,0) EsJoven,

			(case

				when @CountCodigoNivel =0 then 0  --1589

				when @CountCodigoNivel>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			null as ConsultoraAsociada, --1688

			isnull(si.descripcion,null) SegmentoConstancia, --2469

			isnull(se.Codigo,null) Seccion, --2469

			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469

			case When cl.ConsultoraID is null then 0

				else 1 end esConsultoraLider,

			u.EMailActivo, --2532

			si.SegmentoInternoId,

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			0 as ConsultoraAsociadoID,

			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura

		FROM [dbo].[Usuario] u with(nolock)

		LEFT JOIN (

			select *

			from ods.consultora with(nolock)

			where ConsultoraId = @ConsultoraID

		) c ON u.CodigoConsultora = c.Codigo

		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID

		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469

		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469

		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t with(nolock) ON c.TerritorioID = t.TerritorioID

            AND c.SeccionID = t.SeccionID

            AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid

		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID

		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469

		WHERE ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

	ELSE

	BEGIN

		SET @CodigoFicticio = (SELECT TOP 1 CodigoConsultoraAsociada FROM UsuarioPrueba with(nolock) WHERE CodigoFicticio = @CodConsultora)

		SET @IndicadorPermiso = (SELECT dbo.GetPermisoFIC(@CodigoConsultora,@ZonaID,@CampaniaID))



		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,		

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			@IndicadorPermiso IndicadorPermisoFIC,

			@IndicadorOfertaFIC IndicadorOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			@ImagenUrlOfertaFIC ImagenUrlOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			ro.Descripcion as RolDescripcion,

			(case

				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589

				when ISNULL(cl.ConsultoraID,0)>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688

			u.EMailActivo, --2532

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			0 as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			cons.ConsultoraID as ConsultoraAsociadoID,

			'Sin Seg.' as SegmentoAbreviatura

		FROM [dbo].[Usuario] u (nolock)

		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID

		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t (nolock) ON c.TerritorioID = t.TerritorioID

            AND c.SeccionID = t.SeccionID

            AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid

		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario

		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo

		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora

		WHERE ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

END





GO

/*end*/

USE BelcorpSalvador
GO



CREATE PROCEDURE dbo.GetSesionUsuario_SB2

	@CodigoConsultora varchar(25)

AS

/*

GetSesionUsuario_SB2 '0100059'

*/

BEGIN

	DECLARE @PasePedidoWeb int

	DECLARE @TipoOferta2 int

	DECLARE @CompraOfertaEspecial int

	DECLARE @IndicadorMeta int



	DECLARE @FechaLimitePago SMALLDATETIME

	DECLARE @ODSCampaniaID INT



	declare @PaisID int

	declare @UsuarioPrueba bit

	declare @CodConsultora varchar(20)

	declare @CampaniaID int

	declare @ZonaID int

	declare @RegionID int

	declare @ConsultoraID bigint

	declare @IndicadorPermiso int

	declare @CodigoFicticio varchar(20)

	declare @UltimaCampanaFacturada int
	
	declare @CodUltimaCampFact int

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),

		@PaisID = IsNull(PaisID,0),

		@CodConsultora = CodigoConsultora

	from usuario with(nolock)

	where codigousuario = @CodigoConsultora



	declare @CountCodigoNivel bigint



	/*Oferta Final, Catalogo Personalizado, CDR*/

	declare @EsOfertaFinalZonaValida bit = 0

	declare @EsOFGanaMasZonaValida bit = 0

	declare @EsCatalogoPersonalizadoZonaValida bit = 0

	declare @EsCDRWebZonaValida  bit = 0

	declare @CodigoZona varchar(4) = ''

	declare @CodigoRegion varchar(2) = ''



	select

		@CodigoZona = IsNull(z.Codigo,''),

		@CodigoRegion = IsNull(r.Codigo,'')

	from ods.consultora c with(nolock)

	inner join ods.Region r on

		c.RegionID = r.RegionID

	inner join ods.Zona z on

		c.ZonaID = z.ZonaID

	where c.codigo = @CodConsultora



	if not exists (select 1 from OfertaFinalRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOfertaFinalZonaValida = 1



	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCatalogoPersonalizadoZonaValida = 1

		

	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOFGanaMasZonaValida = 1

	

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCDRWebZonaValida = 1

	/*Fin Oferta Final, Catalogo Personalizado, CDR*/



	IF @UsuarioPrueba = 0

	BEGIN

		select @ZonaID = IsNull(ZonaID,0),

			@RegionID = IsNull(RegionID,0),

			@ConsultoraID = IsNull(ConsultoraID,0),

			@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0)

		from ods.consultora with(nolock)

		where codigo = @CodConsultora



		select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))

		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))

		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))

		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))

		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		SET @CodUltimaCampFact = (select campaniaid from ods.campania where codigo = @UltimaCampanaFacturada )

			-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados

			declare @CampaniaFacturada int = 0



			select top 1 @CampaniaFacturada = p.CampaniaID

			FROM ods.Pedido(NOLOCK) P

				INNER JOIN ods.Consultora(NOLOCK) CO ON

					P.ConsultoraID=CO.ConsultoraID

				WHERE

					co.ConsultoraID=@ConsultoraID

					and	P.CampaniaID <> @ODSCampaniaID

					and	CO.RegionID=@RegionID

					and	CO.ZonaID=@ZonaID

			order by PedidoID desc



			/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */

			SET @FechaLimitePago = (

				SELECT FechaLimitePago

				FROM ODS.Cronograma

				WHERE CampaniaID = @CodUltimaCampFact AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
			)

			SET @IndicadorPermiso = (Select dbo.GetPermisoFIC(@CodigoConsultora,@ZonaID,@CampaniaID))



		--SSAP CGI(Id Solicitud=1402)

		--begin

		declare @IndicadorOfertaFIC int

		declare @ImagenUrlOfertaFIC varchar(500)

		SET @IndicadorOfertaFIC = (SELECT dbo.GetIndicadorOfertaFIC(@CampaniaID))

		if @IndicadorOfertaFIC>=1

		begin

			SET @ImagenUrlOfertaFIC = (SELECT dbo.GetImagenOfertaFIC(@CampaniaID))

		end

		else

		begin

			SET @ImagenUrlOfertaFIC = ''

		end
		--end

		select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID



		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			@IndicadorPermiso IndicadorPermisoFIC,

			ro.Descripcion as RolDescripcion,

			@IndicadorOfertaFIC IndicadorOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			@ImagenUrlOfertaFIC ImagenUrlOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			(select top 1 isnull(NroCampanias,0) from pais where CodigoISO=p.CodigoISO) NroCampanias,

			isnull(c.EsJoven,0) EsJoven,

			(case

				when @CountCodigoNivel =0 then 0  --1589

				when @CountCodigoNivel>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			null as ConsultoraAsociada, --1688

			isnull(si.descripcion,null) SegmentoConstancia, --2469

			isnull(se.Codigo,null) Seccion, --2469

			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469

			case When cl.ConsultoraID is null then 0

				else 1 end esConsultoraLider,

			u.EMailActivo, --2532

			si.SegmentoInternoId,

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			0 as ConsultoraAsociadoID,

			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura

		FROM [dbo].[Usuario] u with(nolock)

		LEFT JOIN (

			select *

			from ods.consultora	with(nolock)

			where ConsultoraId = @ConsultoraID

		) c ON

			u.CodigoConsultora = c.Codigo

		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID

		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469

		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469

		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t with(nolock) ON c.TerritorioID = t.TerritorioID

            AND c.SeccionID = t.SeccionID

         AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid

		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID

		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469

		WHERE ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

	ELSE

	BEGIN

		SET @CodigoFicticio = (SELECT TOP 1 CodigoConsultoraAsociada FROM UsuarioPrueba with(nolock) WHERE CodigoFicticio = @CodConsultora)

		SET @IndicadorPermiso = (SELECT dbo.GetPermisoFIC(@CodigoConsultora,@ZonaID,@CampaniaID))



		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			@IndicadorPermiso IndicadorPermisoFIC,

			ro.Descripcion as RolDescripcion,

			@IndicadorOfertaFIC IndicadorOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			@ImagenUrlOfertaFIC ImagenUrlOfertaFIC,--SSAP CGI(Id Solicitud=1402)

			(select top 1 isnull(NroCampanias,0) from pais where CodigoISO=p.CodigoISO) NroCampanias,

			(case

				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589

				when ISNULL(cl.ConsultoraID,0)>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres, --1589

			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688

			u.EMailActivo, --2532

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			0 as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			cons.ConsultoraID as ConsultoraAsociadoID,

			'Sin Seg.' as SegmentoAbreviatura

		FROM [dbo].[Usuario] u (nolock)

		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID

		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t (nolock) ON c.TerritorioID = t.TerritorioID

            AND c.SeccionID = t.SeccionID

            AND c.ZonaID = t.ZonaID

            AND c.RegionID = t.RegionID

		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid

		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario

		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo

		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora

		WHERE ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

END




GO

/*end*/

USE BelcorpVenezuela
GO



CREATE PROCEDURE [dbo].[GetSesionUsuario_SB2]

	@CodigoConsultora varchar(25)

AS

/*

GetSesionUsuario_SB2 '0000434'

*/

BEGIN

	DECLARE @PasePedidoWeb int

	DECLARE @TipoOferta2 int

	DECLARE @CompraOfertaEspecial int

	DECLARE @IndicadorMeta int



	DECLARE @FechaLimitePago SMALLDATETIME

	DECLARE @ODSCampaniaID INT



	declare @PaisID int

	declare @UsuarioPrueba bit

	declare @CodConsultora varchar(20)

	declare @CampaniaID int

	declare @ZonaID int

	declare @RegionID int

	declare @ConsultoraID bigint

	declare @UltimaCampanaFacturada int
	
	declare @CodUltimaCampFact int



	select TOP 1	@UsuarioPrueba = ISNULL(UsuarioPrueba,0),

					@PaisID = IsNull(PaisID,0),

					@CodConsultora = CodigoConsultora

	from usuario with(nolock)

	where codigousuario = @CodigoConsultora

	declare @CountCodigoNivel bigint



	/*Oferta Final, Catalogo Personalizado, CDR*/

	declare @EsOfertaFinalZonaValida bit = 0

	declare @EsOFGanaMasZonaValida bit = 0

	declare @EsCatalogoPersonalizadoZonaValida bit = 0

	declare @EsCDRWebZonaValida  bit = 0

	declare @CodigoZona varchar(4) = ''

	declare @CodigoRegion varchar(2) = ''



	select

		@CodigoZona = IsNull(z.Codigo,''),

		@CodigoRegion = IsNull(r.Codigo,'')

	from ods.consultora c with(nolock)

	inner join ods.Region r on

		c.RegionID = r.RegionID

	inner join ods.Zona z on

		c.ZonaID = z.ZonaID

	where c.codigo = @CodConsultora



	if not exists (select 1 from OfertaFinalRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOfertaFinalZonaValida = 1



	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCatalogoPersonalizadoZonaValida = 1

		

	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsOFGanaMasZonaValida = 1

	

	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)

		set @EsCDRWebZonaValida = 1

	/*Fin Oferta Final, Catalogo Personalizado, CDR*/



	IF @UsuarioPrueba = 0

	BEGIN

		select	@ZonaID = IsNull(ZonaID,0),

				@RegionID = IsNull(RegionID,0),

				@ConsultoraID = IsNull(ConsultoraID,0),

				@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0)

		from ods.consultora with(nolock)

		where codigo = @CodConsultora



		select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)

		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))

		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))

		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))

		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))

		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

		SET @CodUltimaCampFact = (select campaniaid from ods.campania where codigo = @UltimaCampanaFacturada )

			-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados

			declare @CampaniaFacturada int = 0



			 select top 1 @CampaniaFacturada = p.CampaniaID

			FROM ods.Pedido(NOLOCK) P

				INNER JOIN ods.Consultora(NOLOCK) CO ON

					P.ConsultoraID=CO.ConsultoraID

				WHERE

					co.ConsultoraID=@ConsultoraID

					and	P.CampaniaID <> @ODSCampaniaID

					and	CO.RegionID=@RegionID

					and	CO.ZonaID=@ZonaID

			order by PedidoID desc



			/* Se toma en cuenta la Fecha de Vencimiento sobre la última campaña facturada */

			SET @FechaLimitePago = (

				SELECT FechaLimitePago

				FROM ODS.Cronograma

				WHERE CampaniaID = @CodUltimaCampFact AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1 
			)



			select  @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID



		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			ro.Descripcion as RolDescripcion,

			isnull(c.EsJoven,0) EsJoven,

			(case

				 when @CountCodigoNivel =0 then 0  --1589

				 when @CountCodigoNivel>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres,	--1589

			null as ConsultoraAsociada, --1688

			isnull(si.descripcion,null) SegmentoConstancia, --2469

			isnull(se.Codigo,null) Seccion, --2469

			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469

			case When cl.ConsultoraID is null

				then 0

				else 1 end esConsultoraLider,

			u.EMailActivo, --2532

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			0 as ConsultoraAsociadoID,

			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura

		FROM [dbo].[Usuario] u with(nolock)

		LEFT JOIN (

			select *

			from ods.consultora with(nolock)

			where ConsultoraId = @ConsultoraID

		) c ON u.CodigoConsultora = c.Codigo

		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID

		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469

		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469

		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t with(nolock) ON	c.TerritorioID = t.TerritorioID

			AND	c.SeccionID = t.SeccionID

			AND c.ZonaID = t.ZonaID

			AND	c.RegionID = t.RegionID

		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid

		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID

		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469

		WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

	ELSE

	BEGIN

		SELECT

			u.PaisID,

			p.CodigoISO,

			c.RegionID,

			r.Codigo AS CodigorRegion,

			ISNULL(c.ZonaID,0) AS ZonaID,

			ISNULL(z.Codigo,'') AS CodigoZona,

			c.ConsultoraID,

			u.CodigoUsuario,

			u.CodigoConsultora,

			u.Nombre AS NombreCompleto,

			ISNULL(ur.RolID,0) AS RolID,

			u.EMail,

			p.Simbolo,

			c.TerritorioID,

			t.Codigo AS CodigoTerritorio,

			c.MontoMinimoPedido,

			c.MontoMaximoPedido,

			p.CodigoFuente,

			p.BanderaImagen,

			p.Nombre as NombrePais,

			u.CambioClave,

			u.Telefono,

			u.TelefonoTrabajo,

			u.Celular,

			ISNULL(s.descripcion,'') as Segmento,

			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,

			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,

			isnull(c.IndicadorDupla, 0) as IndicadorDupla,

			u.UsuarioPrueba,

			ISNULL(u.Sobrenombre,'') as Sobrenombre,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,

			ISNULL(@TipoOferta2,0) as TipoOferta2,

			1 as CompraKitDupla,

			1 as CompraOfertaDupla,

			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,

			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,

			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,

			ISNULL(@IndicadorMeta,0) as IndicadorMeta,

			0 as ProgramaReconocimiento,

			ISNULL(s.segmentoid, 0) as segmentoid,

			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,

			'' as Nivel,

			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,

			ISNULL(c.PrimerNombre,'') as PrimerNombre,

			ISNULL(c.PrimerApellido,'') as PrimerApellido,

			u.MostrarAyudaWebTraking,

			ro.Descripcion as RolDescripcion,

			(case			

				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589

				when ISNULL(cl.ConsultoraID,0)>0 then 1 End) Lider,--1589

			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589

			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589

			isnull(cl.CodigoNivelLider,0) NivelLider,--1589

			isnull(p.PortalLideres,0) PortalLideres,--1589

			isnull(p.LogoLideres,null) LogoLideres,	--1589

			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688

			u.EMailActivo, --2532

			isnull(p.OfertaFinal,0) as OfertaFinal,

			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida,

			@FechaLimitePago as FechaLimitePago,

			ISNULL(p.CatalogoPersonalizado,0) as CatalogoPersonalizado,

			ISNULL(u.VioVideo, 0) as VioVideo,

			ISNULL(u.VioTutorial, 0) as VioTutorial,

			ISNULL(u.VioTutorialDesktop, 0) as VioTutorialDesktop,

			isnull(@EsCatalogoPersonalizadoZonaValida,0) as EsCatalogoPersonalizadoZonaValida,

			ISNULL(u.VioTutorialSalvavidas, 0) as VioTutorialSalvavidas,

			ISNULL(p.TieneHana,0) as TieneHana,

			z.GerenteZona,

			ISNULL(p.OFGanaMas,0) AS OfertaFinalGanaMas,

			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,

			0 as IndicadorBloqueoCDR,

			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,

			isnull(p.TieneCDR,0) as TieneCDR,

			ISNULL(p.TieneODD,0) AS TieneODD,

			cons.ConsultoraID as ConsultoraAsociadoID,

			'Sin Seg.' as SegmentoAbreviatura

		FROM [dbo].[Usuario] u (nolock)

		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo

		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario

		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID

		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID

		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID

		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID

		LEFT JOIN [ods].[Territorio] t (nolock) ON	c.TerritorioID = t.TerritorioID

			AND	c.SeccionID = t.SeccionID

			AND c.ZonaID = t.ZonaID

			AND	c.RegionID = t.RegionID

		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid

		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario

		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo

		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora

		WHERE

			ro.Sistema = 1

			and u.CodigoUsuario = @CodigoConsultora

	END

END




GO



