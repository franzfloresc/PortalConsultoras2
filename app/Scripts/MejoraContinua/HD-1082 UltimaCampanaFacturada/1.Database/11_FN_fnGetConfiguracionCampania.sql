GO
ALTER FUNCTION dbo.fnGetConfiguracionCampania
(
	@PaisID tinyint,
	@ZonaID int,
	@RegionID int,
	@ConsultoraID bigint
)
RETURNS @TConfiguracionCampania TABLE(
	ID int,
	CampaniaID varchar(6),
	FechaInicioFacturacion datetime,
	FechaFinFacturacion datetime,
	CampaniaDescripcion varchar(6),
	HoraInicio time,
	HoraFin time,
	DiasAntes int,
	ZonaValida int,
	HoraInicioNoFacturable time,
	HoraCierreNoFacturable time,
	ZonaHoraria float,
	HoraCierreZonaNormal time,
	HoraCierreZonaDemAnti time,
	HoraCierreZonaDemAntiCierre time,
	EsZonaDemAnti int,
	DiasDuracionCronograma int,
	HabilitarRestriccionHoraria int,
	HorasDuracionRestriccion int,
	NroCampanias int,
	PROLSinStock bit,
	FechaFinFIC datetime,
	IndicadorOfertaFIC int,
	ImagenURLOfertaFIC varchar(500),
	NuevoPROL bit,
	ZonaNuevoPROL bit,
	EstadoSimplificacionCUV bit,
	EsquemaDAConsultora bit,	
	ValidacionInteractiva bit,
	MensajeValidacionInteractiva varchar(500),
	IndicadorEnviado bit,
	IndicadorGPRSB int,
	FechaActualPais datetime,
	EstadoPedido smallint,
	ValidacionAbierta BIT,
	FechaLimitePago SMALLDATETIME,
	AceptacionConsultoraDA int
)
AS
/*
select * from dbo.fnGetConfiguracionCampania(11,2161,2017,2)
*/
BEGIN
	-- Variables Pais
	DECLARE @CodigoISO CHAR(2)
	DECLARE @ZonaHoraria FLOAT
	DECLARE @HoraCierreZonaNormal TIME(0)
	DECLARE @HoraCierreZonaDemAnti TIME(0)
	DECLARE @NroCampanias INT
	DECLARE @PROLSinStock BIT
	DECLARE @NuevoPROL BIT
	DECLARE @EstadoSimplificacionCUV BIT
	DECLARE @EsquemaDAConsultora BIT
	DECLARE @TipoDA BIT
	DECLARE @PedidoFIC BIT

	select
		@CodigoISO = CodigoISO,
		@ZonaHoraria = ISNULL(ZonaHoraria,0),
		@HoraCierreZonaNormal = HoraCierreZonaNormal,
		@HoraCierreZonaDemAnti = HoraCierreZonaDemAnti,
		@NroCampanias = NroCampanias,
		@PROLSinStock = PROLSinStock,
		@NuevoPROL = NuevoPROL,
		@EstadoSimplificacionCUV = EstadoSimplificacionCUV,
		@EsquemaDAConsultora = EsquemaDAConsultora,
		@TipoDA = TipoDA,
		@PedidoFIC = PedidoFIC
	from Pais (nolock)
	where PaisId = @PaisID

	-- Variables ConfiguracionValidacion
	DECLARE @HoraInicio time(0)
	DECLARE @HoraFin time(0)
	DECLARE @DiasAntes tinyint
	DECLARE @HoraInicioNoFacturable time(0)
	DECLARE @HoraCierreNoFacturable time(0)
	DECLARE @HabilitarRestriccionHoraria bit
	DECLARE @HorasDuracionRestriccion INT
	DECLARE @ValidacionInteractiva bit
	DECLARE @MensajeValidacionInteractiva varchar(500)

	SELECT
		@HoraInicio = HoraInicio,
		@HoraFin = HoraFin,
		@DiasAntes = DiasAntes,
		@HoraInicioNoFacturable = HoraInicioNoFacturable,
		@HoraCierreNoFacturable = HoraCierreNoFacturable,
		@HabilitarRestriccionHoraria = HabilitarRestriccionHoraria,
		@HorasDuracionRestriccion =  ISNULL(HorasDuracionRestriccion,0),
		@ValidacionInteractiva = ValidacionInteractiva,
		@MensajeValidacionInteractiva = MensajeValidacionInteractiva
	FROM [dbo].[ConfiguracionValidacion] (nolock)
	WHERE  PaisID = @PaisID

	 -- Variables ConfiguracionValidacionZona
	DECLARE @DiasDuracionCronograma tinyint
	SET @DiasDuracionCronograma = 1
	DECLARE @ZonaValida int
	DECLARE @IndicadorDias bit
	SET @IndicadorDias = 0

	select
		@DiasDuracionCronograma = DiasDuracionCronograma,
		@ZonaValida = ZonaID,
		@IndicadorDias = ValidacionActiva
	from ConfiguracionValidacionZona with(nolock)
	where CampaniaID = 201301 and ZonaID = @ZonaID

	-- Dias Duracion Cronograma para Nuevas (CR)
	IF @PaisID = 5 OR @PaisID = 8 OR @PaisID = 7 OR @PaisID = 10
	BEGIN
		declare @UCF int = 0;
		declare @SID int = 0;

		select
			@UCF = ISNULL(UltimaCampanaFacturada,0),
			@SID = ISNULL(SegmentoId,0)
		from ods.Consultora with(nolock)
		where ConsultoraID = @ConsultoraID

		IF @UCF = 0 AND @SID = 0 and @DiasDuracionCronograma > 1
			SET @DiasDuracionCronograma = 2
	END

	-- Variables ConfiguracionValidacionNuevoPROL
	DECLARE @ZonaNuevoPROL BIT = 0;
	DECLARE @ContNuevoPROL INT = 0;

	IF @NuevoPROL = 1
	BEGIN
		SELECT @ContNuevoPROL = COUNT(ZonaId)
		FROM ConfiguracionValidacionNuevoPROL with(nolock)
		WHERE ZonaId = @ZonaId

		IF @ContNuevoPROL > 0
			SET @ZonaNuevoPROL = 1
	END

	-- Otras Configuraciones
	IF @IndicadorDias = 0
		SET @DiasAntes = 0

	DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	DECLARE @AceptacionConsultoraDA INT
	SET @AceptacionConsultoraDA = -1

	-- Obtener Campania Anterior
	DECLARE @Campania INT
	DECLARE @Anio INT
	SET @Campania = 0

	IF @EsquemaDAConsultora = 0
	BEGIN
		IF @TipoDA = 0
		BEGIN
			SELECT TOP 1
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
			WHERE
				c.ZonaID = @ZonaID AND
				c.RegionID = @RegionID AND
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
		ELSE
		BEGIN
			SELECT TOP 1	
				@Campania = ca.Codigo,
				@Anio = ca.Anio * 100
			FROM [ods].[Cronograma] c (nolock)
			INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
			INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID		
			LEFT JOIN [dbo].[Cronograma] cr (nolock) ON 
				c.CampaniaID = cr.CampaniaID AND
				c.RegionID = cr.RegionID AND
				c.ZonaID = cr.ZonaID
			WHERE 
				c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
				IIF(@PaisID = 4,
					ISNULL(CONVERT(datetime, cr.FechaInicioDD) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioReFacturacion) + CONVERT(datetime, @HoraCierreZonaNormal)),
					ISNULL(CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti),
							CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
								ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
								CONVERT(datetime, @HoraCierreZonaNormal))
				) < @FechaGeneral
			ORDER BY c.CampaniaID DESC
		END
	END
	ELSE
	BEGIN

		DECLARE @Campania_temp INT
		DECLARE @Anio_temp INT
		SET @Campania_temp = 0

		SELECT TOP 1
			@Campania_temp = ca.Codigo,
			@Anio_temp = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
				ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal) < @FechaGeneral
		ORDER BY c.CampaniaID DESC

		IF(@Campania_temp <> 0)
		BEGIN
			SET @Campania_temp = @Campania_temp - @Anio_temp
			IF(@Campania_temp = @NroCampanias)
				SET @Campania_temp = @Anio_temp + 101
			ELSE
				SET @Campania_temp = @Anio_temp + @Campania_temp + 1

			SELECT @AceptacionConsultoraDA = TipoConfiguracion
			FROM ConfiguracionConsultoraDA with(nolock)
			WHERE			
				ConsultoraId = @ConsultoraId and
				ZonaId = @ZonaId and
				CampaniaId = cast(@Campania_temp as int)
		END

		SELECT TOP 1
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE
			c.ZonaID = @ZonaID AND c.RegionID = @RegionID AND
			IIF(@AceptacionConsultoraDA < 1,
				CONVERT(datetime, c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)) + 
				CONVERT(datetime, @HoraCierreZonaNormal),
				CONVERT(datetime, cr.FechaInicioWeb) + CONVERT(datetime, @HoraCierreZonaDemAnti)) < @FechaGeneral
		ORDER BY c.CampaniaID DESC
	END
	
	--Obtiene UltimaCampaniaFacturada
	declare @UltimaCampanaFacturada int;
	declare @TipoFacturacion char(2);
	declare @ConsultoraIdAsociada bigint;

	select
		@UltimaCampanaFacturada = ISNULL(UltimaCampanaFacturada,0),
		@TipoFacturacion = ISNULL(TipoFacturacion,'')
	From ods.consultora (nolock)
	Where consultoraid = @consultoraid

	--Obtiene UltimaCampaniaFacturada x UsuarioPrueba
	IF @UltimaCampanaFacturada IS NULL
	BEGIN
		SELECT
			@UltimaCampanaFacturada = ISNULL(c.UltimaCampanaFacturada,0),
			@TipoFacturacion = ISNULL(c.TipoFacturacion,''),
			@ConsultoraIdAsociada = ISNULL(c.ConsultoraId,0)
		FROM ConsultoraFicticia cf with(nolock)
		INNER JOIN UsuarioPrueba up with(nolock) on cf.Codigo = up.CodigoFicticio
		INNER JOIN ods.Consultora c with(nolock) on up.CodigoConsultoraAsociada = c.Codigo
		WHERE cf.ConsultoraId = @consultoraid
	END

	IF @TipoFacturacion <> 'FA'
	BEGIN
		SET @UltimaCampanaFacturada = fnAddCampaniaAndNumero(@CodigoISO,@UltimaCampanaFacturada,-1);
	END

	-- Valida Campania Anterior
	IF(@Campania <> 0)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1

		IF @EsquemaDAConsultora = 1 AND @Campania > @Campania_temp
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
		
		-- validar si pertenece a una zona DA
		DECLARE @EsZonaDA BIT;
		SELECT @EsZonaDA = IIF(ISNULL(c.CampaniaID,0) = 0,0,1)
		FROM dbo.Cronograma c 
		INNER JOIN ods.Campania ca ON c.CampaniaID = ca.CampaniaID 
		WHERE
			ca.Codigo = @Campania_temp AND
			c.RegionID = @RegionID AND
			c.ZonaID = @ZonaID AND
			c.TipoCronograma = 2

		-- si el esquema es de DA y la zona es de DA y ya facturo en la campa�a actual 
		-- y la consultora respondio que no en la DA anterior
		-- se resetea la variable
		IF (@EsquemaDAConsultora = 1 AND @EsZonaDA = 1 AND @UltimaCampanaFacturada = @Campania_temp AND @AceptacionConsultoraDA = 0) 
		BEGIN
			SET @AceptacionConsultoraDA = -1
		END
	END
	ELSE
	BEGIN
		SELECT TOP 1 
			@Campania = ca.Codigo,
			@Anio = ca.Anio * 100
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON z.RegionID = c.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		WHERE z.ZonaID = @ZonaID AND z.RegionID = @RegionID
		ORDER BY c.FechaInicioFacturacion ASC
	END

	--Valida UltimaCampaniaFacturada
	IF (@UltimaCampanaFacturada = @Campania)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1
	END
	ELSE
	BEGIN
		DECLARE @IndicadorEnviado BIT= 0, @ValidacionAbierta BIT = 0
		DECLARE @IndicadorGPR TINYINT = 0
		DECLARE @EstadoPedido SMALLINT
  
		SELECT	@IndicadorEnviado  = IndicadorEnviado,  
				@IndicadorGPR = GPRSB, 
				@EstadoPedido = EstadoPedido, 
				@ValidacionAbierta = ValidacionAbierta
		FROM	Pedidoweb (nolock)
		WHERE	CampaniaID = @campania and consultoraid = ISNULL(@ConsultoraIdAsociada,@consultoraid)	

		If(@IndicadorEnviado = 1 AND @IndicadorGPR = 0)
		BEGIN
			SET @Campania = @Campania - @Anio
			IF(@Campania = @NroCampanias)
				SET @Campania = @Anio + 101
			ELSE
				SET @Campania = @Anio + @Campania + 1
		END
	END

	-- Pedido FIC
	DECLARE @FechaFinFIC datetime;
	DECLARE @IndicadorOfertaFIC int = 0;
	DECLARE @ImagenURLOfertaFIC varchar(500) = '';

	IF @PedidoFIC = 1
	BEGIN
		DECLARE @campaniaFIC INT
		IF substring(cast(@Campania as varchar(6)),5,2)=cast(@NroCampanias as char(2))
			set @campaniaFIC=cast(cast( cast(substring(cast(@Campania as varchar(6)),1,4)as int)+1 as varchar(4)) + '01' as int)
		ELSE
			set @campaniaFIC= @Campania +1

		SELECT @FechaFinFIC=isnull(FechaFin,GETDATE())
		FROM CronogramaFIC with(nolock)
		WHERE 
			ZonaID=@ZonaID and 
			CampaniaID = (				
				SELECT CampaniaID
				FROM ods.Campania with(nolock)
				WHERE Codigo=@campaniaFIC
			);

		select top 1
			@IndicadorOfertaFIC = 1,
			@ImagenURLOfertaFIC = isnull(ImagenUrl,'')
		from OfertaFIC (nolock)
		where CampaniaID = @campaniaFIC;
	END
			
	-- Listar Variables
	IF @EsquemaDAConsultora = 0
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@TipoDA = 0,c.FechaInicioFacturacion,ISNULL(cr.FechaInicioWeb, c.FechaInicioFacturacion)) AS FechaInicioFacturacion,
			IIF(@TipoDA = 0,
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				IIF(@PaisID = 4,
					ISNULL(cr.FechaInicioDD,c.FechaInicioReFacturacion),
					ISNULL(cr.FechaInicioWeb,c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
						ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0)))
			) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@TipoDA = 0, @HoraFin,IIF(ISNULL(cr.CampaniaId,0) = 0,@HoraFin,@HoraCierreZonaDemAnti)) as HoraFin,
			@DiasAntes AS DiasAntes,
			ISNULL(@ZonaValida,-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(@TipoDA = 0, 0, IIF(ISNULL(cr.CampaniaId,0) = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END
	ELSE
	BEGIN
		INSERT @TConfiguracionCampania
		SELECT
			ca.CampaniaID as ID,
			ca.Codigo AS CampaniaID,
			IIF(@AceptacionConsultoraDA < 1, c.FechaInicioFacturacion, cr.FechaInicioWeb) AS FechaInicioFacturacion,
			IIF(@AceptacionConsultoraDA < 1, 
				c.FechaInicioFacturacion + @DiasDuracionCronograma - 1 + 
					ISNULL(dbo.GetHorasDuracionRestriccion(@ZonaID, @DiasDuracionCronograma, c.FechaInicioFacturacion), 0),
				cr.FechaInicioWeb) AS FechaFinFacturacion,
			ca.NombreCorto AS CampaniaDescripcion,
			@HoraInicio AS HoraInicio,
			IIF(@AceptacionConsultoraDA < 1, @HoraFin, @HoraCierreZonaDemAnti) as HoraFin,
			@DiasAntes AS DiasAntes,
			IIF(@AceptacionConsultoraDA < 1,ISNULL(@ZonaValida,-1),-1) AS ZonaValida,
			@HoraInicioNoFacturable AS HoraInicioNoFacturable,
			@HoraCierreNoFacturable AS HoraCierreNoFacturable,
			@ZonaHoraria AS ZonaHoraria,
			@HoraCierreZonaNormal AS HoraCierreZonaNormal,
			IIF(@AceptacionConsultoraDA < 1,@HoraCierreZonaNormal,@HoraCierreZonaDemAnti) AS HoraCierreZonaDemAnti,
			@HoraCierreZonaDemAnti AS HoraCierreZonaDemAntiCierre,
			IIF(ISNULL(cr.CampaniaId,0) = 0,0,IIF(@AceptacionConsultoraDA = 0,0,1)) as EsZonaDemAnti,
			ISNULL(@DiasDuracionCronograma,1) As DiasDuracionCronograma,
			@HabilitarRestriccionHoraria As HabilitarRestriccionHoraria,
			@HorasDuracionRestriccion As HorasDuracionRestriccion,
			@NroCampanias as NroCampanias,
			@PROLSinStock as PROLSinStock,
			ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			@IndicadorOfertaFIC as IndicadorOfertaFIC,
			@ImagenURLOfertaFIC as ImagenURLOfertaFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			@ValidacionInteractiva AS ValidacionInteractiva,
			@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			c.FechaConferencia as FechaLimitePago,
			@AceptacionConsultoraDA as AceptacionConsultoraDA
		FROM [ods].[Cronograma] c (nolock)
		INNER JOIN [ods].[Zona] z (nolock) ON c.RegionID = z.RegionID AND c.ZonaID = z.ZonaID
		INNER JOIN [ods].[Campania] ca (nolock) ON c.CampaniaID = ca.CampaniaID
		LEFT JOIN [dbo].[Cronograma] cr (nolock) ON
			c.CampaniaID = cr.CampaniaID AND
			c.RegionID = cr.RegionID AND
			c.ZonaID = cr.ZonaID
		WHERE c.ZonaID = @ZonaID AND c.RegionID = @RegionID  AND ca.Codigo = @Campania
	END

	RETURN
END
GO