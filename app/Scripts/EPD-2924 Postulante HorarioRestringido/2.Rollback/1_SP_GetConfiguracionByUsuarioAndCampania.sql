GO
ALTER PROCEDURE GetConfiguracionByUsuarioAndCampania
	@PaisID tinyint,
	@ConsultoraID bigint,
	@Campania int,
	@UsuarioPrueba bit = 0,
	@AceptacionConsultoraDA int
AS
BEGIN
	declare @ZonaID int;
	declare @RegionID int;
	declare @CodigoConsultora varchar(20);
	declare @PrimerNombre varchar(25);
	declare @MontoMinimoPedido numeric(15,2);
	declare @MontoMaximoPedido numeric(15,2);
	declare @IdEstadoActividad int;
	declare @ConsultoraAsociadoID bigint;
	declare @ConsultoraAsociada varchar(20);

	IF @UsuarioPrueba = 0
	BEGIN
		select
			@ZonaID = ZonaID,
			@RegionID = RegionID,
			@CodigoConsultora = Codigo,
			@PrimerNombre = PrimerNombre,
			@MontoMinimoPedido = MontoMinimoPedido,
			@MontoMaximoPedido = MontoMaximoPedido,
			@IdEstadoActividad = IdEstadoActividad
		from ods.Consultora (nolock)
		where ConsultoraID = @ConsultoraID
	END
	ELSE
	BEGIN
		select
			@ZonaID = CF.ZonaID,
			@RegionID = CF.RegionID,
			@CodigoConsultora = CF.Codigo,
			@PrimerNombre = CF.PrimerNombre,
			@MontoMinimoPedido = CF.MontoMinimoPedido,
			@MontoMaximoPedido = CF.MontoMaximoPedido,
			@IdEstadoActividad = CF.IdEstadoActividad,
			@ConsultoraAsociadoID = C.ConsultoraID,
			@ConsultoraAsociada = C.Codigo
		from ConsultoraFicticia CF (nolock)
		inner join Usuario U (nolock) on U.CodigoConsultora = CF.Codigo
		left join usuarioprueba UP (nolock) on U.CodigoUsuario = UP.CodigoUsuario
		left join ods.Consultora C (nolock) on UP.CodigoConsultoraAsociada = C.Codigo
		where CF.ConsultoraID = @ConsultoraID
	END

	declare @DiasDuracionCronograma tinyint = 1;	
	declare @ZonaValida int;
	declare @IndicadorDias bit = 0;

	select
		@DiasDuracionCronograma = DiasDuracionCronograma,
		@ZonaValida = ZonaID,
		@IndicadorDias = ValidacionActiva
	from ConfiguracionValidacionZona with(nolock)
	where ZonaID = @ZonaID;

	-- Dias Duracion Cronograma para Nuevas (CR)
	IF @DiasDuracionCronograma > 1 and @PaisID in (5,7,8,10)
	BEGIN
		declare @UCF int = 0, @SID int = 0;
		select
			@UCF = isnull(UltimaCampanaFacturada,0),
			@SID = isnull(SegmentoId,0)
		from ods.Consultora with(nolock)
		where ConsultoraID = @ConsultoraID;

		IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
			SET @DiasDuracionCronograma = 2
	END

	SELECT
		P.PaisID,
		P.CodigoISO,
		isnull(P.TieneHana,0) as TieneHana,
		P.Simbolo,
		P.EstadoSimplificacionCUV,
		isnull(P.ZonaHoraria,0) as ZonaHoraria,
		P.PROLSinStock,
		P.NuevoPROL,
		isnull(p.TieneODD,0) as TieneODD,
		iif(
			P.NuevoPROL = 0,
			0,
			isnull((select top 1 1 from ConfiguracionValidacionNuevoPROL with(nolock) where ZonaId = @ZonaId), 0)
		) as ZonaNuevoPROL,
		iif(
			P.EsquemaDAConsultora = 0 or @AceptacionConsultoraDA < 1,
			isnull(@ZonaValida,-1),
			-1
		) as ZonaValida,
		iif(@IndicadorDias = 0, 0, CV.DiasAntes) as DiasAntes,
		CV.HoraInicio,
		iif(
			P.EsquemaDAConsultora = 0,
			iif(P.TipoDA = 0 or isnull(cr.CampaniaId,0) = 0, CV.HoraFin, P.HoraCierreZonaDemAnti),
			iif(@AceptacionConsultoraDA < 1, CV.HoraFin, P.HoraCierreZonaDemAnti)
		) as HoraFin,
		CV.HoraInicioNoFacturable,
		CV.HoraCierreNoFacturable,
		CV.ValidacionInteractiva,
		CV.HabilitarRestriccionHoraria,
		ISNULL(CV.HorasDuracionRestriccion,0) as HorasDuracionRestriccion,
		@Campania as CampaniaID,
		@ConsultoraID as ConsultoraID,
		isnull(@PrimerNombre,'') as PrimerNombre,
		@MontoMinimoPedido as MontoMinimoPedido,
		@MontoMaximoPedido as MontoMaximoPedido,
		isnull(@IdEstadoActividad,0) as ConsultoraNueva,
		isnull(U.TipoUsuario,0) AS TipoUsuario,
		U.CodigoConsultora,
		U.CodigoUsuario,
		U.Nombre as NombreCompleto,
		isnull(U.Email,'') as Email,
		@UsuarioPrueba as UsuarioPrueba,
		isnull(R.RegionID,0) as RegionID,
		isnull(R.Codigo,'') as CodigorRegion,
		isnull(Z.ZonaID,0) as ZonaID,
		isnull(Z.Codigo,'') as CodigoZona,
		isnull(@ConsultoraAsociadoID,0) as ConsultoraAsociadoID,
		@ConsultoraAsociada as ConsultoraAsociada,
		IIF(
			P.EsquemaDAConsultora = 0,
			IIF(P.TipoDA = 0,oCr.FechaInicioFacturacion,ISNULL(Cr.FechaInicioWeb, oCr.FechaInicioFacturacion)),
			IIF(@AceptacionConsultoraDA < 1, oCr.FechaInicioFacturacion, Cr.FechaInicioWeb)
		) as FechaInicioFacturacion,
		IIF(
			P.EsquemaDAConsultora = 0,
			IIF(
				P.TipoDA = 0,
				oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
				IIF(
					@PaisID = 4,
					ISNULL(Cr.FechaInicioDD,oCr.FechaInicioReFacturacion),
					ISNULL(Cr.FechaInicioWeb,oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0))
				)
			),
			IIF(
				@AceptacionConsultoraDA < 1,
				oCr.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, oCr.FechaInicioFacturacion), 0),
				Cr.FechaInicioWeb
			)
		) AS FechaFinFacturacion,
		P.HoraCierreZonaNormal AS HoraCierreZonaNormal,
		IIF(
			P.EsquemaDAConsultora <> 0 AND @AceptacionConsultoraDA < 1,
			P.HoraCierreZonaNormal,
			P.HoraCierreZonaDemAnti
		) AS HoraCierreZonaDemAnti,		
		IIF(
			P.EsquemaDAConsultora = 0,
			iif(P.TipoDA = 0 or isnull(Cr.CampaniaId,0) = 0, 0, 1),
			iif(@AceptacionConsultoraDA = 0 or isnull(Cr.CampaniaId,0) = 0,0,1)
		) AS EsZonaDemAnti
	FROM Pais P (nolock)
	inner join ConfiguracionValidacion CV (nolock) on CV.PaisID = P.PaisID
	inner join Usuario U (nolock) on U.CodigoConsultora = @CodigoConsultora
	left join usuarioprueba UP (nolock) on U.CodigoUsuario = UP.CodigoUsuario
	left join ods.Consultora C (nolock) on UP.CodigoConsultoraAsociada = C.Codigo
	inner join ods.Region R (nolock) on R.RegionID = @RegionID
	inner join ods.Zona Z (nolock) on Z.ZonaID = @ZonaID
	inner join ods.Cronograma oCr (nolock) on oCr.ZonaID = @ZonaID AND oCr.RegionID = @RegionID
	inner join ods.Campania Ca (nolock) on oCr.CampaniaID = Ca.CampaniaID
	left join Cronograma Cr (nolock) on oCr.RegionID = Cr.RegionID and oCr.ZonaID = Cr.ZonaID and oCr.CampaniaID = Cr.CampaniaID
	WHERE P.PaisID = @PaisID and Ca.Codigo = @Campania;
END
GO