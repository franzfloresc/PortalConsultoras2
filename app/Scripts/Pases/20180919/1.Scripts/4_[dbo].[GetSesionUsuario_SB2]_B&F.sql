GO
USE BelcorpPeru
GO
ALTER PROCEDURE [dbo].[GetSesionUsuario_SB2]
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	DECLARE @IndicadorContrato INT -- HD-2430
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
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario
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
	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1
	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/
	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'FA')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)
	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919
	set @IndicadorContrato = (isnull( ( select  AceptoContrato from dbo.contrato where codigoConsultora =@CodConsultora),0)); -- HD-2430
	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)
		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0
		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;
		/* Se toma en cuenta la Fecha de Vencimiento sobre la ultima campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,1), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1
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
			ISNULL(c.indicadorConsultoraOficina,0) as IndicadorConsultoraOficina,
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
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			@IndicadorContrato as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(CASE WHEN c.ConsecutivoNueva = 6 THEN 1 ELSE 0 END AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(c.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u with(nolock)
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
		LEFT JOIN [ods].[Territorio] t with(nolock) ON			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
	WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
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
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			0 as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(0 AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(cons.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END


GO
USE BelcorpMexico
GO
ALTER PROCEDURE [dbo].[GetSesionUsuario_SB2]
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	DECLARE @IndicadorContrato INT -- HD-2430
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
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario
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
	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1
	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/
	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'FA')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)
	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919
	set @IndicadorContrato = (isnull( ( select  AceptoContrato from dbo.contrato where codigoConsultora =@CodConsultora),0)); -- HD-2430
	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)
		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0
		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;
		/* Se toma en cuenta la Fecha de Vencimiento sobre la ultima campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,1), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1
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
			ISNULL(c.indicadorConsultoraOficina,0) as IndicadorConsultoraOficina,
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
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			@IndicadorContrato as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(CASE WHEN c.ConsecutivoNueva = 6 THEN 1 ELSE 0 END AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(c.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u with(nolock)
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
		LEFT JOIN [ods].[Territorio] t with(nolock) ON			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
	WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
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
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			0 as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(0 AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(cons.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END


GO
USE BelcorpColombia
GO
ALTER PROCEDURE [dbo].[GetSesionUsuario_SB2]
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	DECLARE @IndicadorContrato INT -- HD-2430
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
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario
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
	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1
	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/
	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'FA')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)
	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919
	set @IndicadorContrato = (isnull( ( select  AceptoContrato from dbo.contrato where codigoConsultora =@CodConsultora),0)); -- HD-2430
	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)
		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0
		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;
		/* Se toma en cuenta la Fecha de Vencimiento sobre la ultima campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,1), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1
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
			ISNULL(c.indicadorConsultoraOficina,0) as IndicadorConsultoraOficina,
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
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			@IndicadorContrato as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(CASE WHEN c.ConsecutivoNueva = 6 THEN 1 ELSE 0 END AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(c.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u with(nolock)
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
		LEFT JOIN [ods].[Territorio] t with(nolock) ON			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
	WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
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
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			0 as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(0 AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(cons.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END


GO
USE BelcorpSalvador
GO
ALTER PROCEDURE [dbo].[GetSesionUsuario_SB2]
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	DECLARE @IndicadorContrato INT -- HD-2430
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
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario
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
	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1
	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/
	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'FA')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)
	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919
	set @IndicadorContrato = (isnull( ( select  AceptoContrato from dbo.contrato where codigoConsultora =@CodConsultora),0)); -- HD-2430
	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)
		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0
		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;
		/* Se toma en cuenta la Fecha de Vencimiento sobre la ultima campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,1), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1
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
			ISNULL(c.indicadorConsultoraOficina,0) as IndicadorConsultoraOficina,
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
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			@IndicadorContrato as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(CASE WHEN c.ConsecutivoNueva = 6 THEN 1 ELSE 0 END AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(c.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u with(nolock)
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
		LEFT JOIN [ods].[Territorio] t with(nolock) ON			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
	WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
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
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			0 as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(0 AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(cons.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END


GO
USE BelcorpPuertoRico
GO
ALTER PROCEDURE [dbo].[GetSesionUsuario_SB2]
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	DECLARE @IndicadorContrato INT -- HD-2430
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
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario
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
	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1
	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/
	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'FA')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)
	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919
	set @IndicadorContrato = (isnull( ( select  AceptoContrato from dbo.contrato where codigoConsultora =@CodConsultora),0)); -- HD-2430
	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)
		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0
		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;
		/* Se toma en cuenta la Fecha de Vencimiento sobre la ultima campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,1), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1
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
			ISNULL(c.indicadorConsultoraOficina,0) as IndicadorConsultoraOficina,
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
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			@IndicadorContrato as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(CASE WHEN c.ConsecutivoNueva = 6 THEN 1 ELSE 0 END AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(c.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u with(nolock)
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
		LEFT JOIN [ods].[Territorio] t with(nolock) ON			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
	WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
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
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			0 as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(0 AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(cons.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END


GO
USE BelcorpPanama
GO
ALTER PROCEDURE [dbo].[GetSesionUsuario_SB2]
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	DECLARE @IndicadorContrato INT -- HD-2430
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
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario
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
	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1
	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/
	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'FA')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)
	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919
	set @IndicadorContrato = (isnull( ( select  AceptoContrato from dbo.contrato where codigoConsultora =@CodConsultora),0)); -- HD-2430
	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)
		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0
		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;
		/* Se toma en cuenta la Fecha de Vencimiento sobre la ultima campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,1), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1
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
			ISNULL(c.indicadorConsultoraOficina,0) as IndicadorConsultoraOficina,
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
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			@IndicadorContrato as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(CASE WHEN c.ConsecutivoNueva = 6 THEN 1 ELSE 0 END AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(c.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u with(nolock)
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
		LEFT JOIN [ods].[Territorio] t with(nolock) ON			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
	WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
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
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			0 as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(0 AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(cons.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END


GO
USE BelcorpGuatemala
GO
ALTER PROCEDURE [dbo].[GetSesionUsuario_SB2]
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	DECLARE @IndicadorContrato INT -- HD-2430
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
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario
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
	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1
	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/
	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'FA')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)
	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919
	set @IndicadorContrato = (isnull( ( select  AceptoContrato from dbo.contrato where codigoConsultora =@CodConsultora),0)); -- HD-2430
	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)
		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0
		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;
		/* Se toma en cuenta la Fecha de Vencimiento sobre la ultima campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,1), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1
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
			ISNULL(c.indicadorConsultoraOficina,0) as IndicadorConsultoraOficina,
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
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			@IndicadorContrato as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(CASE WHEN c.ConsecutivoNueva = 6 THEN 1 ELSE 0 END AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(c.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u with(nolock)
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
		LEFT JOIN [ods].[Territorio] t with(nolock) ON			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
	WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
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
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			0 as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(0 AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(cons.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END


GO
USE BelcorpEcuador
GO
ALTER PROCEDURE [dbo].[GetSesionUsuario_SB2]
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	DECLARE @IndicadorContrato INT -- HD-2430
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
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario
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
	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1
	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/
	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'FA')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)
	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919
	set @IndicadorContrato = (isnull( ( select  AceptoContrato from dbo.contrato where codigoConsultora =@CodConsultora),0)); -- HD-2430
	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)
		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0
		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;
		/* Se toma en cuenta la Fecha de Vencimiento sobre la ultima campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,1), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1
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
			ISNULL(c.indicadorConsultoraOficina,0) as IndicadorConsultoraOficina,
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
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			@IndicadorContrato as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(CASE WHEN c.ConsecutivoNueva = 6 THEN 1 ELSE 0 END AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(c.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u with(nolock)
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
		LEFT JOIN [ods].[Territorio] t with(nolock) ON			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
	WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
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
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			0 as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(0 AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(cons.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END


GO
USE BelcorpDominicana
GO
ALTER PROCEDURE [dbo].[GetSesionUsuario_SB2]
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	DECLARE @IndicadorContrato INT -- HD-2430
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
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario
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
	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1
	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/
	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'FA')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)
	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919
	set @IndicadorContrato = (isnull( ( select  AceptoContrato from dbo.contrato where codigoConsultora =@CodConsultora),0)); -- HD-2430
	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)
		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0
		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;
		/* Se toma en cuenta la Fecha de Vencimiento sobre la ultima campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,1), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1
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
			ISNULL(c.indicadorConsultoraOficina,0) as IndicadorConsultoraOficina,
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
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			@IndicadorContrato as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(CASE WHEN c.ConsecutivoNueva = 6 THEN 1 ELSE 0 END AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(c.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u with(nolock)
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
		LEFT JOIN [ods].[Territorio] t with(nolock) ON			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
	WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
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
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			0 as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(0 AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(cons.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END


GO
USE BelcorpCostaRica
GO
ALTER PROCEDURE [dbo].[GetSesionUsuario_SB2]
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	DECLARE @IndicadorContrato INT -- HD-2430
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
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario
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
	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1
	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/
	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'FA')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)
	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919
	set @IndicadorContrato = (isnull( ( select  AceptoContrato from dbo.contrato where codigoConsultora =@CodConsultora),0)); -- HD-2430
	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)
		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0
		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;
		/* Se toma en cuenta la Fecha de Vencimiento sobre la ultima campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,1), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1
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
			ISNULL(c.indicadorConsultoraOficina,0) as IndicadorConsultoraOficina,
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
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			@IndicadorContrato as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(CASE WHEN c.ConsecutivoNueva = 6 THEN 1 ELSE 0 END AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(c.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u with(nolock)
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
		LEFT JOIN [ods].[Territorio] t with(nolock) ON			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
	WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
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
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			0 as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(0 AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(cons.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END


GO
USE BelcorpChile
GO
ALTER PROCEDURE [dbo].[GetSesionUsuario_SB2]
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	DECLARE @IndicadorContrato INT -- HD-2430
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
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario
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
	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1
	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/
	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'FA')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)
	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919
	set @IndicadorContrato = (isnull( ( select  AceptoContrato from dbo.contrato where codigoConsultora =@CodConsultora),0)); -- HD-2430
	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)
		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0
		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;
		/* Se toma en cuenta la Fecha de Vencimiento sobre la ultima campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,1), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1
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
			ISNULL(c.indicadorConsultoraOficina,0) as IndicadorConsultoraOficina,
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
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			@IndicadorContrato as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(CASE WHEN c.ConsecutivoNueva = 6 THEN 1 ELSE 0 END AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(c.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u with(nolock)
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
		LEFT JOIN [ods].[Territorio] t with(nolock) ON			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
	WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
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
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			0 as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(0 AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(cons.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END


GO
USE BelcorpBolivia
GO
ALTER PROCEDURE [dbo].[GetSesionUsuario_SB2]
	@CodigoUsuario varchar(25)
AS
BEGIN
	DECLARE @PasePedidoWeb int
	DECLARE @TipoOferta2 int
	DECLARE @CompraOfertaEspecial int
	DECLARE @IndicadorMeta int
	DECLARE @IndicadorContrato INT -- HD-2430
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
	declare @TipoFacturacion char(2)

	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),
		@PaisID = IsNull(PaisID,0),
		@CodConsultora = CodigoConsultora
	from usuario with(nolock)
	where codigousuario = @CodigoUsuario
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
	if not exists (select 1 from CatalogoPersonalizadoRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCatalogoPersonalizadoZonaValida = 1
	if not exists (select 1 from OFGanaMasRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOFGanaMasZonaValida = 1
	if not exists (select 1 from CDRWebRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsCDRWebZonaValida = 1
	/*Fin Oferta Final, Catalogo Personalizado, CDR*/
	select @ZonaID = IsNull(ZonaID,0),
		@RegionID = IsNull(RegionID,0),
		@ConsultoraID = IsNull(ConsultoraID,0),
		@UltimaCampanaFacturada = IsNull(UltimaCampanaFacturada,0),
		@TipoFacturacion = IsNull(TipoFacturacion,'FA')
	from ods.consultora with(nolock)
	where codigo = @CodConsultora;

	select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)
	declare @IndicadorPermiso int = dbo.GetPermisoFIC(@CodConsultora,@ZonaID,@CampaniaID);
	declare @TieneCDRExpress bit = isnull((select top 1 Estado from ConfiguracionPais where Codigo = 'CDR-EXP'),0);	--EPD-1919
	set @IndicadorContrato = (isnull( ( select  AceptoContrato from dbo.contrato where codigoConsultora =@CodConsultora),0)); -- HD-2430
	IF @UsuarioPrueba = 0
	BEGIN
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))
		SET @ODSCampaniaID = (SELECT campaniaID from ods.campania where codigo=@CampaniaID)
		-- obtener la ultima CampaniaID( @CampaniaFacturada) de los pedidos facturados
		declare @CampaniaFacturada int = 0
		select top 1 @CampaniaFacturada = p.CampaniaID
		FROM ods.Pedido(NOLOCK) P
		INNER JOIN ods.Consultora(NOLOCK) CO ON	P.ConsultoraID=CO.ConsultoraID
		WHERE
			co.ConsultoraID=@ConsultoraID and P.CampaniaID <> @ODSCampaniaID and
			co.RegionID=@RegionID and CO.ZonaID=@ZonaID
		order by PedidoID desc;
		/* Se toma en cuenta la Fecha de Vencimiento sobre la ultima campaña facturada */
		declare @CampaniaSiguiente int = iif(@TipoFacturacion = 'FA', dbo.fnAddCampaniaAndNumero(null,@UltimaCampanaFacturada,1), @UltimaCampanaFacturada);
		DECLARE @CampaniaSiguienteChar VARCHAR(6) = cast(@CampaniaSiguiente as varchar(6));
		DECLARE @CampaniaSiguienteID INT = (select top 1 campaniaid from ods.campania where codigo = @CampaniaSiguienteChar);

		SET @FechaLimitePago = (
			SELECT FechaConferencia
			FROM ODS.Cronograma
			WHERE CampaniaID = @CampaniaSiguienteID AND RegionID=@RegionID AND ZonaID = @ZonaID AND EstadoActivo=1
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
			ISNULL(c.indicadorConsultoraOficina,0) as IndicadorConsultoraOficina,
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
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			isnull(c.IndicadorBloqueoCDR,0) as IndicadorBloqueoCDR,
			@IndicadorContrato as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			0 as ConsultoraAsociadoID,
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			iif(c.ConsecutivoNueva > 0, 1, 0) As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(CASE WHEN c.ConsecutivoNueva = 6 THEN 1 ELSE 0 END AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(c.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u with(nolock)
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
		LEFT JOIN [ods].[Territorio] t with(nolock) ON			c.TerritorioID = t.TerritorioID AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = c.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
	WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
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
			case
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589
				when ISNULL(cl.ConsultoraID,0)>0 then 1
			End as Lider,--1589
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589
			isnull(p.PortalLideres,0) PortalLideres,--1589
			isnull(p.LogoLideres,null) LogoLideres, --1589
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688
			u.EMailActivo, --2532
			0 as OfertaFinal,
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
			0 AS OfertaFinalGanaMas,
			ISNULL(@EsOFGanaMasZonaValida,0) AS EsOFGanaMasZonaValida,
			0 as IndicadorBloqueoCDR,
			0 as IndicadorContrato, -- HD-2430
			isnull(@EsCDRWebZonaValida,0) as EsCDRWebZonaValida,
			isnull(p.TieneCDR,0) as TieneCDR,
			ISNULL(p.TieneODD,0) AS TieneODD,
			cons.ConsultoraID as ConsultoraAsociadoID,
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneMasVendidos,0) as TieneMasVendidos,
			isnull(p.TieneAsesoraOnline,0) as TieneAsesoraOnline,
			@IndicadorPermiso as IndicadorPermisoFIC,
			isnull(i.Numero,'') as DocumentoIdentidad,
			@TieneCDRExpress as TieneCDRExpress, --EPD-1919
			0 As EsConsecutivoNueva, --EPD-1919
			p.NroCampanias,
			p.PedidoFIC as PedidoFICActivo,
			u.FotoPerfil,
			CAST(0 AS BIT) AS PasoSextoPedido,
			ISNULL(ctd.CompraVDirecta, 0) CompraVDirecta, /*HD-2192*/
			ISNULL(ctd.IVACompraVDirecta, 0) IVACompraVDirecta, /*HD-2192*/
			ISNULL(ctd.Retail, 0) Retail, /*HD-2192*/
			ISNULL(ctd.IVARetail, 0) IVARetail, /*HD-2192*/
			ISNULL(ctd.TotalCompra, 0) TotalCompra, /*HD-2192*/
			ISNULL(ctd.IvaTotal, 0) IvaTotal, /*HD-2192*/
			ISNULL(cons.promedioVenta, 0) PromedioVenta,
			ISNULL(u.NovedadBuscador, 0) NovedadBuscador
		FROM dbo.Usuario u (nolock)
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID
		LEFT JOIN [ods].[Territorio] t (nolock) ON
			c.TerritorioID = t.TerritorioID	AND
			c.SeccionID = t.SeccionID AND
			c.ZonaID = t.ZonaID AND
			c.RegionID = t.RegionID
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario
		left join ods.Consultora cons (nolock) on up.CodigoConsultoraAsociada = cons.Codigo
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora
		left join ods.Identificacion I with(nolock) on i.ConsultoraId = cons.ConsultoraId and i.DocumentoPrincipal = 1 --EPD-2993
		LEFT JOIN CertificadoTributarioDetalle ctd ON ctd.Cedula = u.CodigoUsuario AND ctd.Anio = (YEAR(GETDATE()) - 1) /*HD-2192*/
		WHERE ro.Sistema = 1 and u.CodigoUsuario = @CodigoUsuario
	END
END


GO
