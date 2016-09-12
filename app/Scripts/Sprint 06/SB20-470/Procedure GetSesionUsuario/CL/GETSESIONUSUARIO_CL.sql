ALTER PROCEDURE dbo.GetSesionUsuario_SB2
 @CodigoConsultora varchar(25)  
AS  
/*
GetSesionUsuario_SB2 '071346927'
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
  
	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),  
		@PaisID = IsNull(PaisID,0),  
		@CodConsultora = CodigoConsultora  
	from usuario with(nolock)  
	where codigousuario = @CodigoConsultora  
   
	declare @CountCodigoNivel bigint  
	
	/*Oferta Final*/	
	declare @EsOfertaFinalZonaValida bit = 0
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
	
	if exists (select 1 from OfertaFinalRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOfertaFinalZonaValida = 1
	/*Fin Oferta Final*/

	IF @UsuarioPrueba = 0  
	BEGIN  
		select @ZonaID = IsNull(ZonaID,0),  
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
		SET @FechaLimitePago = (SELECT FECHALIMITEPAGO FROM ODS.Cronograma WHERE CampaniaID=@ODSCampaniaID-1 AND RegionID=@RegionID AND ZonaID = @ZonaID  AND EstadoActivo=1)  
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
			ISNULL(u.VioTutorial, 0) as VioTutorial
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
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida
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
