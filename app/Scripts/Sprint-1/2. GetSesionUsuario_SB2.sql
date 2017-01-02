
USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[GetSesionUsuario_SB2]
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
			@ConsultoraID = IsNull(ConsultoraID,0)
		from ods.consultora with(nolock)
		where codigo = @CodConsultora

		select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)
			SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
			SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
			SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
			SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
			SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)

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

			SET @FechaLimitePago = (
				SELECT FECHALIMITEPAGO
				FROM ODS.Cronograma
				WHERE CampaniaID=@CampaniaFacturada AND RegionID=@RegionID AND ZonaID = @ZonaID  AND EstadoActivo=1
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
			isnull(p.TieneODD,0) as TieneODD
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
			isnull(p.TieneODD,0) as TieneODD
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
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		WHERE
			ro.Sistema = 1
			and u.CodigoUsuario = @CodigoConsultora
	END
END

GO
