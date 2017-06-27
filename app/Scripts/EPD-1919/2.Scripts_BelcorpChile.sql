
USE BELCORPCHILE
GO

--1. adding missing table columns

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TieneCDRExpress'
          AND Object_ID = Object_ID(N'dbo.pais'))
BEGIN
	ALTER TABLE pais add TieneCDRExpress bit NULL
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'MensajeCDRExpress'
          AND Object_ID = Object_ID(N'dbo.pais'))
BEGIN
	ALTER TABLE pais add MensajeCDRExpress varchar(200) null
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'MensajeCDRExpressNueva'
          AND Object_ID = Object_ID(N'dbo.pais'))
BEGIN
	ALTER TABLE pais add MensajeCDRExpressNueva varchar(200) null
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TipoDespacho'
          AND Object_ID = Object_ID(N'dbo.cdrweb'))
BEGIN
	ALTER TABLE cdrweb add TipoDespacho bit NULL -- 0,1, NULL
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'FleteDespacho'
          AND Object_ID = Object_ID(N'dbo.cdrweb'))
BEGIN
	ALTER TABLE cdrweb add FleteDespacho decimal(15,2) null -- 0.00, 213.00, NULL
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'MensajeDespacho'
          AND Object_ID = Object_ID(N'dbo.cdrweb'))
BEGIN
	ALTER table cdrweb add MensajeDespacho varchar(200) null -- ABC, NULL
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'TipoDespacho'
          AND Object_ID = Object_ID(N'interfaces.LogCDRWeb'))
BEGIN
	ALTER TABLE interfaces.LogCDRWeb add TipoDespacho bit NULL -- 0,1, NULL
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'FleteDespacho'
          AND Object_ID = Object_ID(N'interfaces.LogCDRWeb'))
BEGIN
	ALTER TABLE interfaces.LogCDRWeb add FleteDespacho decimal(15,2) null -- 0.00, 213.00, NULL
END
GO

IF NOT EXISTS(SELECT 1 FROM sys.columns 
          WHERE Name = N'MensajeDespacho'
          AND Object_ID = Object_ID(N'interfaces.LogCDRWeb'))
BEGIN
	alter table interfaces.LogCDRWeb add MensajeDespacho varchar(200) null -- ABC, NULL
END
GO


--2. information data testing for pais
--modify if it's necesary: 

update pais set TieneCDRExpress = 0, 
				MensajeCDRExpress = 'Solo aplicable a cambios. Tiene un costo de envió {0} {1}.', 
				MensajeCDRExpressNueva = 'Por se consultora nueva en esta oportunidad tu envio es gratis.'
go

ALTER PROCEDURE [dbo].[GetSesionUsuario_SB2]
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
			isnull(si.Abreviatura,'Sin Seg.') as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneCDRExpress,0) As TieneCDRExpress, --EPD-1919  
			isnull(p.MensajeCDRExpress,'') As MensajeCDRExpress, --EPD-1919  
			isnull(p.MensajeCDRExpressNueva,'') As MensajeCDRExpressNueva --EPD-1919 
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
			'Sin Seg.' as SegmentoAbreviatura,
			ISNULL(u.TipoUsuario,0) AS TipoUsuario,
			ISNULL((SELECT 1 FROM UsuarioExterno WHERE CodigoUsuario = u.CodigoUsuario AND Estado = 1),0) AS TieneLoginExterno,
			isnull(p.TieneCupon,0) as TieneCupon,
			isnull(p.TieneCDRExpress,0) As TieneCDRExpress, --EPD-1919  
			isnull(p.MensajeCDRExpress,'') As MensajeCDRExpress, --EPD-1919  
			isnull(p.MensajeCDRExpressNueva,'') As MensajeCDRExpressNueva --EPD-1919 
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

alter PROCEDURE [dbo].[GetCDRWeb]
@ConsultoraID BIGINT
,@PedidoID INT = 0
,@CampaniaID INT = 0
,@CDRWebID INT = 0
as
/*
GetCDRWeb 2
GetCDRWeb 2,708495691,0
GetCDRWeb 2,0,0,3013
*/
BEGIN
	SELECT top 20
			C.CDRWebID,
			C.PedidoID,
			C.PedidoNumero,
			C.CampaniaID,
			C.ConsultoraID,
			C.FechaRegistro,
			C.Estado,
			C.FechaCulminado,
			C.FechaAtencion,
			C.Importe,
			(select count(*) from CDRWebDetalle where CDRWebID = C.CDRWebID) as CantidadDetalle
			,ISNULL(
				(SELECT TOP 1 ConsultoraSaldo 
				FROM [interfaces].[LogCDRWeb] 
				WHERE CDRWebId = C.CDRWebId 
				AND Estado = 2 AND EstadoCDR = 3
				ORDER BY FechaRegistro DESC)
			,0) AS ConsultoraSaldo
			,isnull(c.TipoDespacho,0) TipoDespacho --EPD-1919
			,isnull(c.FleteDespacho,0.00) FleteDespacho--EPD-1919
			,isnull(c.MensajeDespacho,'') MensajeDespacho --EPD-1919
	FROM CDRWeb C
	WHERE C.ConsultoraID = @ConsultoraID
		AND (C.PedidoID = @PedidoID OR @PedidoID = 0)
		AND (C.CampaniaID = @CampaniaID OR @CampaniaID = 0)
		AND (C.CDRWebID = @CDRWebID OR @CDRWebID = 0)
		--and (C.CDRWebID IN (SELECT CDRWebID FROM CDRWebDetalle DD WHERE DD.CDRWebID = C.CDRWebID))
	ORDER BY C.CDRWebID DESC

END


GO

alter PROCEDURE dbo.InsCDRWeb
(
	 @CDRWebID int
	,@PedidoID int
	,@PedidoNumero int
	,@CampaniaID int
	,@ConsultoraID int
	--,@FechaRegistro datetime
	--,@Estado int
	--,@FechaCulminado datetime
	,@Importe decimal(9,2)

	---EPD-1919 INICIO
	,@TipoDespacho bit  = null
	,@FleteDespacho decimal(15,2) = null
	,@MensajeDespacho varchar(200) = null
	---EPD-1919 FIN

	,@RetornoID int output
)
AS

BEGIN
	
	SET @RetornoID = 0
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	if	@CDRWebID = 0
	begin
		insert into CDRWeb(
				PedidoID
				,PedidoNumero
				,CampaniaID
				,ConsultoraID
				,FechaRegistro
				,Estado
				,FechaCulminado
				,Importe
					,TipoDespacho --EPD-1919
				,FleteDespacho --EPD-1919
				,MensajeDespacho -- EPD-1919
		) values(
				 @PedidoID
				,@PedidoNumero
				,@CampaniaID
				,@ConsultoraID
				,@FechaGeneral
				,'1'
				,NULL
				,NULL
				,@TipoDespacho -- EPD-1919
				,@FleteDespacho --EPD-1919
				,@MensajeDespacho --EPD-1919
		)

		SET @RetornoID = SCOPE_IDENTITY()
	end
	else
		SET @RetornoID = @CDRWebID
END


GO

alter PROCEDURE dbo.UpdEstadoCDRWeb
(
	 @CDRWebID int
	 ,@Estado int
	 	 ---EPD-1919 INICIO
	,@TipoDespacho bit  = null
	,@FleteDespacho decimal(15,2) = null
	,@MensajeDespacho varchar(200) = null
	---EPD-1919 FIN
	,@RetornoID int output
)
AS
/*
declare @retorno int
execute UpdEstadoCDRWeb 1,2,@retorno output
*/
BEGIN
	
	SET @RetornoID = 0
	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	set @CDRWebID = isnull(@CDRWebID, 0)
	set @Estado = isnull(@Estado, 0)

	if	@CDRWebID > 0 and @Estado > 0
	begin
		update CDRWeb
		set Estado = @Estado
		, FechaCulminado = case when @Estado = 2 then @FechaGeneral else FechaCulminado end
		, FechaAtencion = case when @Estado = 2 then null else FechaAtencion end

		 ---EPD-1919 INICIO
		 ,TipoDespacho = isnull(@TipoDespacho,0)
		 ,FleteDespacho = isnull(@FleteDespacho,0.00)
		 ,MensajeDespacho = isnull(@MensajeDespacho,'') 
		  ---EPD-1919 FIN

		where CDRWebID = @CDRWebID
		
		if @Estado = 2 or @Estado = 1
		begin				
			update CDRWebDetalle
			set Estado = @Estado
			where CDRWebID = @CDRWebID
			
			SET @RetornoID = 1
		end

	end

END


GO

alter PROCEDURE interfaces.GetLogCDRWeb
	@ProcesoAutomaticoId BIGINT
AS
BEGIN
	INSERT INTO interfaces.LogCDRWeb(
		ProcesoAutomaticoId,
		CDRWebId,
		CampaniaId,
		PedidoId,
		PedidoFacturadoId,		
		ConsultoraId,
		CodigoConsultora,
		CodigoRegion,
		CodigoZona,
		FechaRegistro,
		FechaCulminado,
		Estado,
		TipoDespacho,--EPD-1919
		FleteDespacho,--EPD-1919
		MensajeDespacho--EPD-1919
	)
	SELECT
		@ProcesoAutomaticoId,
		CDRW.CDRWebID,
		CDRW.CampaniaID,
		CDRW.PedidoId,
		CDRW.PedidoNumero,
		CDRW.ConsultoraID,
		LEFT(C.Codigo,15),
		LEFT(R.Codigo,2),
		LEFT(Z.Codigo,4),
		CDRW.FechaRegistro,
		CDRW.FechaCulminado,
		1,
		TipoDespacho, --EPD-1919
		FleteDespacho, --EPD-1919
		MensajeDespacho --EPD-1919
	FROM CDRWeb CDRW
	INNER JOIN ods.Consultora C ON CDRW.ConsultoraID = C.ConsultoraID
	INNER JOIN ods.Region R ON R.RegionID = C.RegionID
	INNER JOIN ods.Zona Z ON Z.RegionID = C.RegionID AND Z.ZonaID = C.ZonaID
	WHERE CDRW.Estado = 2 --CULMINADOS
 
	SELECT		
		l.LogCDRWebId,
		l.ProcesoAutomaticoId,
		l.CDRWebId,
		l.CampaniaId,
		l.PedidoId,
		l.PedidoFacturadoId,
		l.CodigoConsultora,
		l.CodigoRegion,
		l.CodigoZona,
		l.FechaRegistro,
		l.FechaCulminado,
		isnull(u.Email,'') as Email,
		isnull(u.Nombre,u.Sobrenombre) as NombreCompleto,
		TipoDespacho, --EPD-1919
		FleteDespacho, -- EPD-1919
		MensajeDespacho --EPD-1919
	FROM interfaces.LogCDRWeb l
	LEFT JOIN usuario u on
		l.CodigoConsultora = u.CodigoConsultora		
	WHERE l.ProcesoAutomaticoId = @ProcesoAutomaticoId
	
END

GO

/****** Object:  Synonym [ods].[CdrWebFlete]    Script Date: 14/06/2017 12:19:37 ******/
IF NOT EXISTS (SELECT * FROM sys.synonyms WHERE name = N'CdrWebFlete' AND schema_id = SCHEMA_ID(N'ods'))
	CREATE SYNONYM [ods].[CdrWebFlete] FOR [ODS_PE].[dbo].[CDRWEBFLETE]
GO


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMontoFletePorZonaId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetMontoFletePorZonaId] AS' 
END
GO
--exec GetMontoFletePorZonaId 5111
ALTER procedure [dbo].[GetMontoFletePorZonaId]
(@ZonaId varchar(8) = null)
as
begin

	select top 1 '' Moneda, 
				Montoflete Monto,*
	from ods.cdrwebflete c
	inner join ods.zona z on c.codigozona = z.codigo
	where c.codigozona = @ZonaId
	
end
GO

