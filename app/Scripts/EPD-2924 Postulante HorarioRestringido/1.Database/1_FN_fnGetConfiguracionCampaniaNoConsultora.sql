GO
ALTER FUNCTION [dbo].[fnGetConfiguracionCampaniaNoConsultora]
(
	@PaisID tinyint,
	@ZonaID int,
	@RegionID int
	--@ConsultoraID bigint
	--@CodigoUsuario VARCHAR(20)
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
	/* CC
	
	*/

	-- Variables ConfiguracionValidacionNuevoPROL
	DECLARE @ZonaNuevoPROL BIT
	DECLARE @ContNuevoPROL INT
	SET @ZonaNuevoPROL = 0
	SET @ContNuevoPROL = 0

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

			/* CC
			*/
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

	-- Valida Campania Anterior
	IF(@Campania <> 0)
	BEGIN
		SET @Campania = @Campania - @Anio
		IF(@Campania = @NroCampanias)
			SET @Campania = @Anio + 101
		ELSE
			SET @Campania = @Anio + @Campania + 1

		/* CC
		*/

		-- ultima campania facturada de la consultora
		/* CC
		*/
		-- validar si pertenece a una zona DA
		/* CC
		*/
		
		/* EPD-167 - FIN */
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

	--Obtiene UltimaCampaniaFacturada

	declare @UltimaCampanaFacturada int
		
	/* CC			
	*/

	--Obtiene UltimaCampaniaFacturada x UsuarioPrueba
	declare @ConsultoraIdAsociada bigint

	/* CC
	*/

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
  
		/* CC
		*/	

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
	/* CC
	*/	
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
			--ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			NULL AS FechaFinFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			--@ValidacionInteractiva AS ValidacionInteractiva,
			0 AS ValidacionInteractiva,
			--@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			NULL AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			--c.FechaConferencia as FechaLimitePago,
			NULL AS FechaLimitePago,
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
			--ISNULL(@FechaFinFIC,GETDATE()) as FechaFinFIC,
			NULL AS FechaFinFIC,
			@NuevoPROL as NuevoPROL,
			@ZonaNuevoPROL as ZonaNuevoPROL,
			@EstadoSimplificacionCUV AS EstadoSimplificacionCUV,
			@EsquemaDAConsultora AS EsquemaDAConsultora,
			--@ValidacionInteractiva AS ValidacionInteractiva,
			0 AS ValidacionInteractiva,
			--@MensajeValidacionInteractiva AS MensajeValidacionInteractiva,
			NULL AS MensajeValidacionInteractiva,
			@IndicadorEnviado,-- AS IndicadorEnviado,
			@IndicadorGPR AS IndicadorGPRSB, 
			GETDATE(),
			@EstadoPedido AS EstadoPedido,
			@ValidacionAbierta AS ValidacionAbierta,
			--c.FechaConferencia as FechaLimitePago,
			NULL AS FechaLimitePago,
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