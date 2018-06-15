ALTER PROCEDURE GetNotificacionesConsultora
	@ConsultoraId bigint,
	@ShowCDR bit = 0,
	@ShowPayOnline bit = 0
AS
BEGIN
	declare @Temporal table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidación datetime,
		EnvioCorreo bit,
		Proceso varchar(20),
		Estado int,
		Observaciones varchar(500),
		FechaFacturacion date,
		Asunto varchar(500),
		FacturaHoy bit,
		Visualizado bit,
		EsMontoMinino bit,
		FlagProcedencia bit,
		RowsCount int
	);

	insert into @Temporal
	select
		ValAutomaticaPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,
		ISNULL(EnvioCorreo,0) as EnvioCorreo, 'VALAUTO' as Proceso, Estado, Observaciones, FechaFacturacion,
		case Estado
			when 4 then 'Pedido reservado con éxito' 
			when 5 then 'Pedido reservado con observaciones'
			when 2 then
				case 
					when EsDeuda = 1 then 'Pedido no reservado por deuda'
					when EsMontoMinino = 1 then 'Pedido no reservado por monto mínimo'
					else 'Pedido no reservado por monto máximo'
				end
			when 3 then 'Pedido no reservado por observaciones'
		end as Asunto, 
		ISNULL(FacturaHoy,0) as FacturaHoy,
		ISNULL(Visualizado,0) as Visualizado, EsMontoMinino, 0 as 'FlagProcedencia', 1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId


	UNION ALL
	--
	select
		SolicitudClienteID as ProcesoId,
		Campania as CampaniaId,
		'' as EstadoPROL,
		FechaSolicitud as FechaHoraValidación,
		cast(1 as bit) as EnvioCorreo,
		'BUSCACONS' as Proceso,
		IIF(Estado IS NULL, 0, 1) as Estado,
		'' as Observaciones,
		GETDATE()  as FechaFacturacion,
		CONCAT('Pedido de nuevo cliente ',UPPER(NombreCompleto)) as Asunto,
		cast(0 as bit) as FacturaHoy,
		Leido as Visualizado,
		cast(0 as bit) as EsMontoMinino,
		1 as 'FlagProcedencia',
		1
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId, --ProcesoValidacionPedidoRechazadoId 
			ISNULL(LGPRV.Campania, '201601')   AS CampaniaId,
			'' AS EstadoPROL,
			LGPRV.FechaFinValidacion AS FechaHoraValidación,
			CAST(0 AS BIT) as EnvioCorreo,
			'PEDREC' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			--CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
			(CASE 
				when ISNULL(LGPRV.DescripcionRechazo, '') = 'OCC-19' then 'Pedido rechazado por deuda'
				when ISNULL(LGPRV.DescripcionRechazo, '') = 'OCC-16' then 'Pedido rechazado por monto mínimo' 
				when ISNULL(LGPRV.DescripcionRechazo, '') = 'OCC-17' then 'Pedido rechazado por monto máximo' 
				when ISNULL(LGPRV.DescripcionRechazo, '') = 'OCC-51' then 'Pedido rechazado por monto mínimo' 
				when ISNULL(LGPRV.DescripcionRechazo, '') = 'OCC-17,OCC-19' OR ISNULL(LGPRV.DescripcionRechazo, '') = 'OCC-19,OCC-17' then 'Pedido rechazado por monto máximo y deuda' 
				when ISNULL(LGPRV.DescripcionRechazo, '') = 'OCC-51,OCC-19' OR ISNULL(LGPRV.DescripcionRechazo, '') = 'OCC-19,OCC-51' then 'Pedido rechazado por monto mínimo y deuda' 
				when ISNULL(LGPRV.DescripcionRechazo, '') = 'OCC-16,OCC-19' OR ISNULL(LGPRV.DescripcionRechazo, '') = 'OCC-19,OCC-16' then 'Pedido rechazado por monto mínimo y deuda' 
				else '' 
			END) AS Asunto, 
			CAST(0 AS BIT) AS FacturaHoy,
			LGPRV.Visualizado AS Visualizado,
			CAST(0 AS BIT) AS EsMontoMinino,
			1 AS FlagProcedencia,
			row_number() over (partition by LGPRV.ProcesoValidacionPedidoRechazadoId order by LGPRV.ProcesoValidacionPedidoRechazadoId) as row_number
		FROM GPR.LogGPRValidacion LGPRV
		WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId)
	as rows 
	where row_number = 1

	IF(@ShowCDR = 1)
	BEGIN

		insert into @Temporal
		SELECT
			LCDRW.LogCDRWebId AS ProcesoId,
			LCDRW.CampaniaId,
			'' AS EstadoPROL,
			LCDRW.FechaAtencion AS FechaHoraValidación,
			LCDRW.EnvioCorreo,
			'CDR' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE() AS FechaFacturacion,
			CONCAT('CDR: ', IIF(LCDRW.EstadoCDR = 3, 'APROBADO', 'RECHAZADO')) AS Asunto,
			CAST(0 AS BIT) AS FacturaHoy,
			LCDRW.Visualizado AS Visualizado,
			CAST(0 AS BIT) AS EsMontoMinino,
			1 AS FlagProcedencia,
			1
		FROM interfaces.LogCDRWeb LCDRW WITH(NOLOCK)
		WHERE LCDRW.Estado = 2 AND LCDRW.ConsultoraId = @ConsultoraId

		UNION ALL	

		SELECT
			LCDRWC.LogCDRWebCulminadoId AS ProcesoId,
			LCDRWC.CampaniaId,
			'' AS EstadoPROL,
			LCDRWC.FechaCulminado AS FechaHoraValidación,
			CAST(0 AS BIT) as EnvioCorreo,
			'CDR-CULM' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			'CDR: EN EVALUACIÓN' AS Asunto,
			CAST(0 AS BIT) AS FacturaHoy,
			LCDRWC.Visualizado,
			CAST(0 AS BIT) AS EsMontoMinino,
			1 AS FlagProcedencia,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	if (@ShowPayOnline = 1)
	begin

		insert into @Temporal
		select 
			PagoEnLineaResultadoLogId as ProcesoId,
			CampaniaId,
			'' AS EstadoPROL,
			FechaCreacion AS FechaHoraValidación,
			CAST(0 AS BIT) as EnvioCorreo,
			'PAYONLINE' AS Proceso,
			1 as Estado,
			'' as Observaciones,
			GETDATE()  AS FechaFacturacion,
			'PAGO EN LINEA' AS Asunto,
			CAST(0 AS BIT) AS FacturaHoy,
			Visualizado,
			CAST(0 AS BIT) AS EsMontoMinino,
			1 AS FlagProcedencia,
			1
		from dbo.PagoEnLineaResultadoLog
		where ConsultoraId = @ConsultoraId
			and CodigoError = '0' and CodigoAccion = '000'

	end

	SELECT top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
		Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
	FROM @Temporal
	ORDER by FechaHoraValidación desc;
END


