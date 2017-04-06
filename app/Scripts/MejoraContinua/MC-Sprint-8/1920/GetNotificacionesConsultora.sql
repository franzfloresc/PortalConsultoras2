USE [BelcorpBolivia]
GO
ALTER PROCEDURE [dbo].[GetNotificacionesConsultora]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN
	declare @Temporal table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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

	declare @TemporalStock table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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
	)

	insert into @TemporalStock
	select MIN(vs.ValidacionStockPROLLogId) as ProcesoId,0 as CampaniaId, '' as EstadoPROL,
	v.FechaHoraInicio as FechaHoraValidaci�n, 0 as EnvioCorreo, 'VALSTOCK' as Proceso, 0 as Estado, cast(vs.ValidacionStockProlId as varchar) as Observaciones,
	'2000-01-01' as FechaFacturacion, 'Validaci�n de Stock' as Asunto , 0 as FacturaHoy, 0 as Visualizado, 0 as EsMontoMinino,0 as 'FlagProcedencia', 1
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.Consultora c with(nolock) on vs.Codigo = c.Codigo
	inner join ValidacionStockPROL v with(nolock) on vs.ValidacionStockProlId = v.ValidacionStockProlId
	where c.ConsultoraId = @ConsultoraId and vs.Enviocorreo = 1
	group by vs.ValidacionStockProlId,v.FechaHOraInicio;

	insert into @Temporal
	select ValAutomaticaPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	ISNULL(EnvioCorreo,0) as EnvioCorreo, 'VALAUTO' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId
	
	UNION ALL
	
	select ValidacionMovilPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	0 as EnvioCorreo, 'VALMOVIL' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionMovilPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL
	
	select st.ProcesoId,
		st.CampaniaId,
		st.EstadoPROL,
		st.FechaHoraValidaci�n,
		st.EnvioCorreo,
		st.Proceso,
		st.Estado,
		st.Observaciones,
		st.FechaFacturacion,
		st.Asunto,
		st.FacturaHoy,
		ISNULL(i.Visualizado,0),
		st.EsMontoMinino,
		0 as 'FlagProcedencia',
		1
	from @TemporalStock st
	left join ValidacionStockPROLInfo i with(nolock) on st.ProcesoId = i.ValidacionStockPROLLogId

	UNION ALL
	--
	select
		SolicitudClienteID as ProcesoId,
		Campania as CampaniaId,
		'' as EstadoPROL,
		FechaSolicitud as FechaHoraValidaci�n,
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

	select 
		S.SolicitudClienteCatalogoID as ProcesoId,
		S.Campania as CampaniaId,
		'' as EstadoPROL,
		S.FechaRegistro as FechaHoraValidaci�n,
		cast(0 as bit) as EnvioCorreo,
		'CATALOGO' as Proceso,
		1 as Estado,
		'' as Observaciones,
		GETDATE()  as FechaFacturacion, 
		S.AsuntoNotificacion as Asunto,
		cast(0 as bit) as FacturaHoy,
		S.Visualizado AS Visualizado,
		cast(0 as bit) as EsMontoMinino,
		1 as FlagProcedencia,
		1
	from SolicitudClienteCatalogo S
	INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId  AND S.CodigoConsultora = C.Codigo	

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId, --ProcesoValidacionPedidoRechazadoId 
			ISNULL(LGPRV.Campania, '201601')   AS CampaniaId,
			'' AS EstadoPROL,
			LGPRV.FechaFinValidacion AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'PEDREC' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			--CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
			(CASE ISNULL(LGPRV.MotivoRechazo, '') 
			when 'DEUDA'  then 'Pedido rechazado por deuda'
			when 'MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO'  then 'Pedido rechazado por monto m�ximo'
			when 'MONTO MINIMO STOCK'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO- DEUDA'  then 'Pedido rechazado por monto m�ximo y deuda'
			when 'MONTO MINIMO STOCK- DEUDA'  then 'Pedido rechazado por monto m�nimo y deuda'
			when 'DEUDA- MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo y deuda'
			else ''
			END)
			AS Asunto,
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
			LCDRW.FechaAtencion AS FechaHoraValidaci�n,
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
			LCDRWC.FechaCulminado AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'CDR-CULM' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			'CDR: EN EVALUACI�N' AS Asunto,
			CAST(0 AS BIT) AS FacturaHoy,
			LCDRWC.Visualizado,
			CAST(0 AS BIT) AS EsMontoMinino,
			1 AS FlagProcedencia,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	SELECT top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
		Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
	FROM @Temporal
	ORDER by FechaHoraValidaci�n desc;
END
GO


USE [BelcorpChile]
GO
ALTER PROCEDURE [dbo].[GetNotificacionesConsultora]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN
	declare @Temporal table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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

	declare @TemporalStock table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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
	)

	insert into @TemporalStock
	select MIN(vs.ValidacionStockPROLLogId) as ProcesoId,0 as CampaniaId, '' as EstadoPROL,
	v.FechaHoraInicio as FechaHoraValidaci�n, 0 as EnvioCorreo, 'VALSTOCK' as Proceso, 0 as Estado, cast(vs.ValidacionStockProlId as varchar) as Observaciones,
	'2000-01-01' as FechaFacturacion, 'Validaci�n de Stock' as Asunto , 0 as FacturaHoy, 0 as Visualizado, 0 as EsMontoMinino,0 as 'FlagProcedencia', 1
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.Consultora c with(nolock) on vs.Codigo = c.Codigo
	inner join ValidacionStockPROL v with(nolock) on vs.ValidacionStockProlId = v.ValidacionStockProlId
	where c.ConsultoraId = @ConsultoraId and vs.Enviocorreo = 1
	group by vs.ValidacionStockProlId,v.FechaHOraInicio;

	insert into @Temporal
	select ValAutomaticaPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	ISNULL(EnvioCorreo,0) as EnvioCorreo, 'VALAUTO' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId
	
	UNION ALL
	
	select ValidacionMovilPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	0 as EnvioCorreo, 'VALMOVIL' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionMovilPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL
	
	select st.ProcesoId,
		st.CampaniaId,
		st.EstadoPROL,
		st.FechaHoraValidaci�n,
		st.EnvioCorreo,
		st.Proceso,
		st.Estado,
		st.Observaciones,
		st.FechaFacturacion,
		st.Asunto,
		st.FacturaHoy,
		ISNULL(i.Visualizado,0),
		st.EsMontoMinino,
		0 as 'FlagProcedencia',
		1
	from @TemporalStock st
	left join ValidacionStockPROLInfo i with(nolock) on st.ProcesoId = i.ValidacionStockPROLLogId

	UNION ALL
	--
	select
		SolicitudClienteID as ProcesoId,
		Campania as CampaniaId,
		'' as EstadoPROL,
		FechaSolicitud as FechaHoraValidaci�n,
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

	select 
		S.SolicitudClienteCatalogoID as ProcesoId,
		S.Campania as CampaniaId,
		'' as EstadoPROL,
		S.FechaRegistro as FechaHoraValidaci�n,
		cast(0 as bit) as EnvioCorreo,
		'CATALOGO' as Proceso,
		1 as Estado,
		'' as Observaciones,
		GETDATE()  as FechaFacturacion, 
		S.AsuntoNotificacion as Asunto,
		cast(0 as bit) as FacturaHoy,
		S.Visualizado AS Visualizado,
		cast(0 as bit) as EsMontoMinino,
		1 as FlagProcedencia,
		1
	from SolicitudClienteCatalogo S
	INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId  AND S.CodigoConsultora = C.Codigo	

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId, --ProcesoValidacionPedidoRechazadoId 
			ISNULL(LGPRV.Campania, '201601')   AS CampaniaId,
			'' AS EstadoPROL,
			LGPRV.FechaFinValidacion AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'PEDREC' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			--CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
			(CASE ISNULL(LGPRV.MotivoRechazo, '') 
			when 'DEUDA'  then 'Pedido rechazado por deuda'
			when 'MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO'  then 'Pedido rechazado por monto m�ximo'
			when 'MONTO MINIMO STOCK'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO- DEUDA'  then 'Pedido rechazado por monto m�ximo y deuda'
			when 'MONTO MINIMO STOCK- DEUDA'  then 'Pedido rechazado por monto m�nimo y deuda'
			when 'DEUDA- MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo y deuda'
			else ''
			END)
			AS Asunto,
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
			LCDRW.FechaAtencion AS FechaHoraValidaci�n,
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
			LCDRWC.FechaCulminado AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'CDR-CULM' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			'CDR: EN EVALUACI�N' AS Asunto,
			CAST(0 AS BIT) AS FacturaHoy,
			LCDRWC.Visualizado,
			CAST(0 AS BIT) AS EsMontoMinino,
			1 AS FlagProcedencia,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	SELECT top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
		Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
	FROM @Temporal
	ORDER by FechaHoraValidaci�n desc;
END
GO


USE [BelcorpColombia]
GO
ALTER PROCEDURE [dbo].[GetNotificacionesConsultora]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN
	declare @Temporal table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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

	declare @TemporalStock table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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
	)

	insert into @TemporalStock
	select MIN(vs.ValidacionStockPROLLogId) as ProcesoId,0 as CampaniaId, '' as EstadoPROL,
	v.FechaHoraInicio as FechaHoraValidaci�n, 0 as EnvioCorreo, 'VALSTOCK' as Proceso, 0 as Estado, cast(vs.ValidacionStockProlId as varchar) as Observaciones,
	'2000-01-01' as FechaFacturacion, 'Validaci�n de Stock' as Asunto , 0 as FacturaHoy, 0 as Visualizado, 0 as EsMontoMinino,0 as 'FlagProcedencia', 1
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.Consultora c with(nolock) on vs.Codigo = c.Codigo
	inner join ValidacionStockPROL v with(nolock) on vs.ValidacionStockProlId = v.ValidacionStockProlId
	where c.ConsultoraId = @ConsultoraId and vs.Enviocorreo = 1
	group by vs.ValidacionStockProlId,v.FechaHOraInicio;

	insert into @Temporal
	select ValAutomaticaPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	ISNULL(EnvioCorreo,0) as EnvioCorreo, 'VALAUTO' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId
	
	UNION ALL
	
	select ValidacionMovilPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	0 as EnvioCorreo, 'VALMOVIL' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionMovilPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL
	
	select st.ProcesoId,
		st.CampaniaId,
		st.EstadoPROL,
		st.FechaHoraValidaci�n,
		st.EnvioCorreo,
		st.Proceso,
		st.Estado,
		st.Observaciones,
		st.FechaFacturacion,
		st.Asunto,
		st.FacturaHoy,
		ISNULL(i.Visualizado,0),
		st.EsMontoMinino,
		0 as 'FlagProcedencia',
		1
	from @TemporalStock st
	left join ValidacionStockPROLInfo i with(nolock) on st.ProcesoId = i.ValidacionStockPROLLogId

	UNION ALL
	--
	select
		SolicitudClienteID as ProcesoId,
		Campania as CampaniaId,
		'' as EstadoPROL,
		FechaSolicitud as FechaHoraValidaci�n,
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

	select 
		S.SolicitudClienteCatalogoID as ProcesoId,
		S.Campania as CampaniaId,
		'' as EstadoPROL,
		S.FechaRegistro as FechaHoraValidaci�n,
		cast(0 as bit) as EnvioCorreo,
		'CATALOGO' as Proceso,
		1 as Estado,
		'' as Observaciones,
		GETDATE()  as FechaFacturacion, 
		S.AsuntoNotificacion as Asunto,
		cast(0 as bit) as FacturaHoy,
		S.Visualizado AS Visualizado,
		cast(0 as bit) as EsMontoMinino,
		1 as FlagProcedencia,
		1
	from SolicitudClienteCatalogo S
	INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId  AND S.CodigoConsultora = C.Codigo	

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId, --ProcesoValidacionPedidoRechazadoId 
			ISNULL(LGPRV.Campania, '201601')   AS CampaniaId,
			'' AS EstadoPROL,
			LGPRV.FechaFinValidacion AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'PEDREC' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			--CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
			(CASE ISNULL(LGPRV.MotivoRechazo, '') 
			when 'DEUDA'  then 'Pedido rechazado por deuda'
			when 'MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO'  then 'Pedido rechazado por monto m�ximo'
			when 'MONTO MINIMO STOCK'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO- DEUDA'  then 'Pedido rechazado por monto m�ximo y deuda'
			when 'MONTO MINIMO STOCK- DEUDA'  then 'Pedido rechazado por monto m�nimo y deuda'
			when 'DEUDA- MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo y deuda'
			else ''
			END)
			AS Asunto,
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
			LCDRW.FechaAtencion AS FechaHoraValidaci�n,
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
			LCDRWC.FechaCulminado AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'CDR-CULM' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			'CDR: EN EVALUACI�N' AS Asunto,
			CAST(0 AS BIT) AS FacturaHoy,
			LCDRWC.Visualizado,
			CAST(0 AS BIT) AS EsMontoMinino,
			1 AS FlagProcedencia,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	SELECT top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
		Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
	FROM @Temporal
	ORDER by FechaHoraValidaci�n desc;
END
GO


USE [BelcorpCostaRica]
GO
ALTER PROCEDURE [dbo].[GetNotificacionesConsultora]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN
	declare @Temporal table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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

	declare @TemporalStock table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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
	)

	insert into @TemporalStock
	select MIN(vs.ValidacionStockPROLLogId) as ProcesoId,0 as CampaniaId, '' as EstadoPROL,
	v.FechaHoraInicio as FechaHoraValidaci�n, 0 as EnvioCorreo, 'VALSTOCK' as Proceso, 0 as Estado, cast(vs.ValidacionStockProlId as varchar) as Observaciones,
	'2000-01-01' as FechaFacturacion, 'Validaci�n de Stock' as Asunto , 0 as FacturaHoy, 0 as Visualizado, 0 as EsMontoMinino,0 as 'FlagProcedencia', 1
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.Consultora c with(nolock) on vs.Codigo = c.Codigo
	inner join ValidacionStockPROL v with(nolock) on vs.ValidacionStockProlId = v.ValidacionStockProlId
	where c.ConsultoraId = @ConsultoraId and vs.Enviocorreo = 1
	group by vs.ValidacionStockProlId,v.FechaHOraInicio;

	insert into @Temporal
	select ValAutomaticaPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	ISNULL(EnvioCorreo,0) as EnvioCorreo, 'VALAUTO' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId
	
	UNION ALL
	
	select ValidacionMovilPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	0 as EnvioCorreo, 'VALMOVIL' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionMovilPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL
	
	select st.ProcesoId,
		st.CampaniaId,
		st.EstadoPROL,
		st.FechaHoraValidaci�n,
		st.EnvioCorreo,
		st.Proceso,
		st.Estado,
		st.Observaciones,
		st.FechaFacturacion,
		st.Asunto,
		st.FacturaHoy,
		ISNULL(i.Visualizado,0),
		st.EsMontoMinino,
		0 as 'FlagProcedencia',
		1
	from @TemporalStock st
	left join ValidacionStockPROLInfo i with(nolock) on st.ProcesoId = i.ValidacionStockPROLLogId

	UNION ALL
	--
	select
		SolicitudClienteID as ProcesoId,
		Campania as CampaniaId,
		'' as EstadoPROL,
		FechaSolicitud as FechaHoraValidaci�n,
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

	select 
		S.SolicitudClienteCatalogoID as ProcesoId,
		S.Campania as CampaniaId,
		'' as EstadoPROL,
		S.FechaRegistro as FechaHoraValidaci�n,
		cast(0 as bit) as EnvioCorreo,
		'CATALOGO' as Proceso,
		1 as Estado,
		'' as Observaciones,
		GETDATE()  as FechaFacturacion, 
		S.AsuntoNotificacion as Asunto,
		cast(0 as bit) as FacturaHoy,
		S.Visualizado AS Visualizado,
		cast(0 as bit) as EsMontoMinino,
		1 as FlagProcedencia,
		1
	from SolicitudClienteCatalogo S
	INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId  AND S.CodigoConsultora = C.Codigo	

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId, --ProcesoValidacionPedidoRechazadoId 
			ISNULL(LGPRV.Campania, '201601')   AS CampaniaId,
			'' AS EstadoPROL,
			LGPRV.FechaFinValidacion AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'PEDREC' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			--CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
			(CASE ISNULL(LGPRV.MotivoRechazo, '') 
			when 'DEUDA'  then 'Pedido rechazado por deuda'
			when 'MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO'  then 'Pedido rechazado por monto m�ximo'
			when 'MONTO MINIMO STOCK'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO- DEUDA'  then 'Pedido rechazado por monto m�ximo y deuda'
			when 'MONTO MINIMO STOCK- DEUDA'  then 'Pedido rechazado por monto m�nimo y deuda'
			when 'DEUDA- MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo y deuda'
			else ''
			END)
			AS Asunto,
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
			LCDRW.FechaAtencion AS FechaHoraValidaci�n,
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
			LCDRWC.FechaCulminado AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'CDR-CULM' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			'CDR: EN EVALUACI�N' AS Asunto,
			CAST(0 AS BIT) AS FacturaHoy,
			LCDRWC.Visualizado,
			CAST(0 AS BIT) AS EsMontoMinino,
			1 AS FlagProcedencia,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	SELECT top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
		Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
	FROM @Temporal
	ORDER by FechaHoraValidaci�n desc;
END
GO


USE [BelcorpDominicana]
GO
ALTER PROCEDURE [dbo].[GetNotificacionesConsultora]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN
	declare @Temporal table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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

	declare @TemporalStock table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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
	)

	insert into @TemporalStock
	select MIN(vs.ValidacionStockPROLLogId) as ProcesoId,0 as CampaniaId, '' as EstadoPROL,
	v.FechaHoraInicio as FechaHoraValidaci�n, 0 as EnvioCorreo, 'VALSTOCK' as Proceso, 0 as Estado, cast(vs.ValidacionStockProlId as varchar) as Observaciones,
	'2000-01-01' as FechaFacturacion, 'Validaci�n de Stock' as Asunto , 0 as FacturaHoy, 0 as Visualizado, 0 as EsMontoMinino,0 as 'FlagProcedencia', 1
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.Consultora c with(nolock) on vs.Codigo = c.Codigo
	inner join ValidacionStockPROL v with(nolock) on vs.ValidacionStockProlId = v.ValidacionStockProlId
	where c.ConsultoraId = @ConsultoraId and vs.Enviocorreo = 1
	group by vs.ValidacionStockProlId,v.FechaHOraInicio;

	insert into @Temporal
	select ValAutomaticaPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	ISNULL(EnvioCorreo,0) as EnvioCorreo, 'VALAUTO' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId
	
	UNION ALL
	
	select ValidacionMovilPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	0 as EnvioCorreo, 'VALMOVIL' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionMovilPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL
	
	select st.ProcesoId,
		st.CampaniaId,
		st.EstadoPROL,
		st.FechaHoraValidaci�n,
		st.EnvioCorreo,
		st.Proceso,
		st.Estado,
		st.Observaciones,
		st.FechaFacturacion,
		st.Asunto,
		st.FacturaHoy,
		ISNULL(i.Visualizado,0),
		st.EsMontoMinino,
		0 as 'FlagProcedencia',
		1
	from @TemporalStock st
	left join ValidacionStockPROLInfo i with(nolock) on st.ProcesoId = i.ValidacionStockPROLLogId

	UNION ALL
	--
	select
		SolicitudClienteID as ProcesoId,
		Campania as CampaniaId,
		'' as EstadoPROL,
		FechaSolicitud as FechaHoraValidaci�n,
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

	select 
		S.SolicitudClienteCatalogoID as ProcesoId,
		S.Campania as CampaniaId,
		'' as EstadoPROL,
		S.FechaRegistro as FechaHoraValidaci�n,
		cast(0 as bit) as EnvioCorreo,
		'CATALOGO' as Proceso,
		1 as Estado,
		'' as Observaciones,
		GETDATE()  as FechaFacturacion, 
		S.AsuntoNotificacion as Asunto,
		cast(0 as bit) as FacturaHoy,
		S.Visualizado AS Visualizado,
		cast(0 as bit) as EsMontoMinino,
		1 as FlagProcedencia,
		1
	from SolicitudClienteCatalogo S
	INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId  AND S.CodigoConsultora = C.Codigo	

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId, --ProcesoValidacionPedidoRechazadoId 
			ISNULL(LGPRV.Campania, '201601')   AS CampaniaId,
			'' AS EstadoPROL,
			LGPRV.FechaFinValidacion AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'PEDREC' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			--CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
			(CASE ISNULL(LGPRV.MotivoRechazo, '') 
			when 'DEUDA'  then 'Pedido rechazado por deuda'
			when 'MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO'  then 'Pedido rechazado por monto m�ximo'
			when 'MONTO MINIMO STOCK'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO- DEUDA'  then 'Pedido rechazado por monto m�ximo y deuda'
			when 'MONTO MINIMO STOCK- DEUDA'  then 'Pedido rechazado por monto m�nimo y deuda'
			when 'DEUDA- MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo y deuda'
			else ''
			END)
			AS Asunto,
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
			LCDRW.FechaAtencion AS FechaHoraValidaci�n,
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
			LCDRWC.FechaCulminado AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'CDR-CULM' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			'CDR: EN EVALUACI�N' AS Asunto,
			CAST(0 AS BIT) AS FacturaHoy,
			LCDRWC.Visualizado,
			CAST(0 AS BIT) AS EsMontoMinino,
			1 AS FlagProcedencia,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	SELECT top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
		Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
	FROM @Temporal
	ORDER by FechaHoraValidaci�n desc;
END
GO


USE [BelcorpEcuador]
GO
ALTER PROCEDURE [dbo].[GetNotificacionesConsultora]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN
	declare @Temporal table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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

	declare @TemporalStock table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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
	)

	insert into @TemporalStock
	select MIN(vs.ValidacionStockPROLLogId) as ProcesoId,0 as CampaniaId, '' as EstadoPROL,
	v.FechaHoraInicio as FechaHoraValidaci�n, 0 as EnvioCorreo, 'VALSTOCK' as Proceso, 0 as Estado, cast(vs.ValidacionStockProlId as varchar) as Observaciones,
	'2000-01-01' as FechaFacturacion, 'Validaci�n de Stock' as Asunto , 0 as FacturaHoy, 0 as Visualizado, 0 as EsMontoMinino,0 as 'FlagProcedencia', 1
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.Consultora c with(nolock) on vs.Codigo = c.Codigo
	inner join ValidacionStockPROL v with(nolock) on vs.ValidacionStockProlId = v.ValidacionStockProlId
	where c.ConsultoraId = @ConsultoraId and vs.Enviocorreo = 1
	group by vs.ValidacionStockProlId,v.FechaHOraInicio;

	insert into @Temporal
	select ValAutomaticaPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	ISNULL(EnvioCorreo,0) as EnvioCorreo, 'VALAUTO' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId
	
	UNION ALL
	
	select ValidacionMovilPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	0 as EnvioCorreo, 'VALMOVIL' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionMovilPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL
	
	select st.ProcesoId,
		st.CampaniaId,
		st.EstadoPROL,
		st.FechaHoraValidaci�n,
		st.EnvioCorreo,
		st.Proceso,
		st.Estado,
		st.Observaciones,
		st.FechaFacturacion,
		st.Asunto,
		st.FacturaHoy,
		ISNULL(i.Visualizado,0),
		st.EsMontoMinino,
		0 as 'FlagProcedencia',
		1
	from @TemporalStock st
	left join ValidacionStockPROLInfo i with(nolock) on st.ProcesoId = i.ValidacionStockPROLLogId

	UNION ALL
	--
	select
		SolicitudClienteID as ProcesoId,
		Campania as CampaniaId,
		'' as EstadoPROL,
		FechaSolicitud as FechaHoraValidaci�n,
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

	select 
		S.SolicitudClienteCatalogoID as ProcesoId,
		S.Campania as CampaniaId,
		'' as EstadoPROL,
		S.FechaRegistro as FechaHoraValidaci�n,
		cast(0 as bit) as EnvioCorreo,
		'CATALOGO' as Proceso,
		1 as Estado,
		'' as Observaciones,
		GETDATE()  as FechaFacturacion, 
		S.AsuntoNotificacion as Asunto,
		cast(0 as bit) as FacturaHoy,
		S.Visualizado AS Visualizado,
		cast(0 as bit) as EsMontoMinino,
		1 as FlagProcedencia,
		1
	from SolicitudClienteCatalogo S
	INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId  AND S.CodigoConsultora = C.Codigo	

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId, --ProcesoValidacionPedidoRechazadoId 
			ISNULL(LGPRV.Campania, '201601')   AS CampaniaId,
			'' AS EstadoPROL,
			LGPRV.FechaFinValidacion AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'PEDREC' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			--CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
			(CASE ISNULL(LGPRV.MotivoRechazo, '') 
			when 'DEUDA'  then 'Pedido rechazado por deuda'
			when 'MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO'  then 'Pedido rechazado por monto m�ximo'
			when 'MONTO MINIMO STOCK'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO- DEUDA'  then 'Pedido rechazado por monto m�ximo y deuda'
			when 'MONTO MINIMO STOCK- DEUDA'  then 'Pedido rechazado por monto m�nimo y deuda'
			when 'DEUDA- MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo y deuda'
			else ''
			END)
			AS Asunto,
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
			LCDRW.FechaAtencion AS FechaHoraValidaci�n,
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
			LCDRWC.FechaCulminado AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'CDR-CULM' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			'CDR: EN EVALUACI�N' AS Asunto,
			CAST(0 AS BIT) AS FacturaHoy,
			LCDRWC.Visualizado,
			CAST(0 AS BIT) AS EsMontoMinino,
			1 AS FlagProcedencia,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	SELECT top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
		Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
	FROM @Temporal
	ORDER by FechaHoraValidaci�n desc;
END
GO


USE [BelcorpGuatemala]
GO
ALTER PROCEDURE [dbo].[GetNotificacionesConsultora]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN
	declare @Temporal table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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

	declare @TemporalStock table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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
	)

	insert into @TemporalStock
	select MIN(vs.ValidacionStockPROLLogId) as ProcesoId,0 as CampaniaId, '' as EstadoPROL,
	v.FechaHoraInicio as FechaHoraValidaci�n, 0 as EnvioCorreo, 'VALSTOCK' as Proceso, 0 as Estado, cast(vs.ValidacionStockProlId as varchar) as Observaciones,
	'2000-01-01' as FechaFacturacion, 'Validaci�n de Stock' as Asunto , 0 as FacturaHoy, 0 as Visualizado, 0 as EsMontoMinino,0 as 'FlagProcedencia', 1
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.Consultora c with(nolock) on vs.Codigo = c.Codigo
	inner join ValidacionStockPROL v with(nolock) on vs.ValidacionStockProlId = v.ValidacionStockProlId
	where c.ConsultoraId = @ConsultoraId and vs.Enviocorreo = 1
	group by vs.ValidacionStockProlId,v.FechaHOraInicio;

	insert into @Temporal
	select ValAutomaticaPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	ISNULL(EnvioCorreo,0) as EnvioCorreo, 'VALAUTO' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId
	
	UNION ALL
	
	select ValidacionMovilPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	0 as EnvioCorreo, 'VALMOVIL' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionMovilPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL
	
	select st.ProcesoId,
		st.CampaniaId,
		st.EstadoPROL,
		st.FechaHoraValidaci�n,
		st.EnvioCorreo,
		st.Proceso,
		st.Estado,
		st.Observaciones,
		st.FechaFacturacion,
		st.Asunto,
		st.FacturaHoy,
		ISNULL(i.Visualizado,0),
		st.EsMontoMinino,
		0 as 'FlagProcedencia',
		1
	from @TemporalStock st
	left join ValidacionStockPROLInfo i with(nolock) on st.ProcesoId = i.ValidacionStockPROLLogId

	UNION ALL
	--
	select
		SolicitudClienteID as ProcesoId,
		Campania as CampaniaId,
		'' as EstadoPROL,
		FechaSolicitud as FechaHoraValidaci�n,
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

	select 
		S.SolicitudClienteCatalogoID as ProcesoId,
		S.Campania as CampaniaId,
		'' as EstadoPROL,
		S.FechaRegistro as FechaHoraValidaci�n,
		cast(0 as bit) as EnvioCorreo,
		'CATALOGO' as Proceso,
		1 as Estado,
		'' as Observaciones,
		GETDATE()  as FechaFacturacion, 
		S.AsuntoNotificacion as Asunto,
		cast(0 as bit) as FacturaHoy,
		S.Visualizado AS Visualizado,
		cast(0 as bit) as EsMontoMinino,
		1 as FlagProcedencia,
		1
	from SolicitudClienteCatalogo S
	INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId  AND S.CodigoConsultora = C.Codigo	

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId, --ProcesoValidacionPedidoRechazadoId 
			ISNULL(LGPRV.Campania, '201601')   AS CampaniaId,
			'' AS EstadoPROL,
			LGPRV.FechaFinValidacion AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'PEDREC' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			--CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
			(CASE ISNULL(LGPRV.MotivoRechazo, '') 
			when 'DEUDA'  then 'Pedido rechazado por deuda'
			when 'MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO'  then 'Pedido rechazado por monto m�ximo'
			when 'MONTO MINIMO STOCK'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO- DEUDA'  then 'Pedido rechazado por monto m�ximo y deuda'
			when 'MONTO MINIMO STOCK- DEUDA'  then 'Pedido rechazado por monto m�nimo y deuda'
			when 'DEUDA- MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo y deuda'
			else ''
			END)
			AS Asunto,
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
			LCDRW.FechaAtencion AS FechaHoraValidaci�n,
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
			LCDRWC.FechaCulminado AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'CDR-CULM' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			'CDR: EN EVALUACI�N' AS Asunto,
			CAST(0 AS BIT) AS FacturaHoy,
			LCDRWC.Visualizado,
			CAST(0 AS BIT) AS EsMontoMinino,
			1 AS FlagProcedencia,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	SELECT top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
		Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
	FROM @Temporal
	ORDER by FechaHoraValidaci�n desc;
END
GO


USE [BelcorpMexico]
GO
ALTER PROCEDURE [dbo].[GetNotificacionesConsultora]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN
	declare @Temporal table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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

	declare @TemporalStock table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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
	)

	insert into @TemporalStock
	select MIN(vs.ValidacionStockPROLLogId) as ProcesoId,0 as CampaniaId, '' as EstadoPROL,
	v.FechaHoraInicio as FechaHoraValidaci�n, 0 as EnvioCorreo, 'VALSTOCK' as Proceso, 0 as Estado, cast(vs.ValidacionStockProlId as varchar) as Observaciones,
	'2000-01-01' as FechaFacturacion, 'Validaci�n de Stock' as Asunto , 0 as FacturaHoy, 0 as Visualizado, 0 as EsMontoMinino,0 as 'FlagProcedencia', 1
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.Consultora c with(nolock) on vs.Codigo = c.Codigo
	inner join ValidacionStockPROL v with(nolock) on vs.ValidacionStockProlId = v.ValidacionStockProlId
	where c.ConsultoraId = @ConsultoraId and vs.Enviocorreo = 1
	group by vs.ValidacionStockProlId,v.FechaHOraInicio;

	insert into @Temporal
	select ValAutomaticaPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	ISNULL(EnvioCorreo,0) as EnvioCorreo, 'VALAUTO' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId
	
	UNION ALL
	
	select ValidacionMovilPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	0 as EnvioCorreo, 'VALMOVIL' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionMovilPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL
	
	select st.ProcesoId,
		st.CampaniaId,
		st.EstadoPROL,
		st.FechaHoraValidaci�n,
		st.EnvioCorreo,
		st.Proceso,
		st.Estado,
		st.Observaciones,
		st.FechaFacturacion,
		st.Asunto,
		st.FacturaHoy,
		ISNULL(i.Visualizado,0),
		st.EsMontoMinino,
		0 as 'FlagProcedencia',
		1
	from @TemporalStock st
	left join ValidacionStockPROLInfo i with(nolock) on st.ProcesoId = i.ValidacionStockPROLLogId

	UNION ALL
	--
	select
		SolicitudClienteID as ProcesoId,
		Campania as CampaniaId,
		'' as EstadoPROL,
		FechaSolicitud as FechaHoraValidaci�n,
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

	select 
		S.SolicitudClienteCatalogoID as ProcesoId,
		S.Campania as CampaniaId,
		'' as EstadoPROL,
		S.FechaRegistro as FechaHoraValidaci�n,
		cast(0 as bit) as EnvioCorreo,
		'CATALOGO' as Proceso,
		1 as Estado,
		'' as Observaciones,
		GETDATE()  as FechaFacturacion, 
		S.AsuntoNotificacion as Asunto,
		cast(0 as bit) as FacturaHoy,
		S.Visualizado AS Visualizado,
		cast(0 as bit) as EsMontoMinino,
		1 as FlagProcedencia,
		1
	from SolicitudClienteCatalogo S
	INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId  AND S.CodigoConsultora = C.Codigo	

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId, --ProcesoValidacionPedidoRechazadoId 
			ISNULL(LGPRV.Campania, '201601')   AS CampaniaId,
			'' AS EstadoPROL,
			LGPRV.FechaFinValidacion AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'PEDREC' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			--CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
			(CASE ISNULL(LGPRV.MotivoRechazo, '') 
			when 'DEUDA'  then 'Pedido rechazado por deuda'
			when 'MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO'  then 'Pedido rechazado por monto m�ximo'
			when 'MONTO MINIMO STOCK'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO- DEUDA'  then 'Pedido rechazado por monto m�ximo y deuda'
			when 'MONTO MINIMO STOCK- DEUDA'  then 'Pedido rechazado por monto m�nimo y deuda'
			when 'DEUDA- MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo y deuda'
			else ''
			END)
			AS Asunto,
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
			LCDRW.FechaAtencion AS FechaHoraValidaci�n,
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
			LCDRWC.FechaCulminado AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'CDR-CULM' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			'CDR: EN EVALUACI�N' AS Asunto,
			CAST(0 AS BIT) AS FacturaHoy,
			LCDRWC.Visualizado,
			CAST(0 AS BIT) AS EsMontoMinino,
			1 AS FlagProcedencia,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	SELECT top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
		Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
	FROM @Temporal
	ORDER by FechaHoraValidaci�n desc;
END
GO


USE [BelcorpPanama]
GO
ALTER PROCEDURE [dbo].[GetNotificacionesConsultora]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN
	declare @Temporal table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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

	declare @TemporalStock table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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
	)

	insert into @TemporalStock
	select MIN(vs.ValidacionStockPROLLogId) as ProcesoId,0 as CampaniaId, '' as EstadoPROL,
	v.FechaHoraInicio as FechaHoraValidaci�n, 0 as EnvioCorreo, 'VALSTOCK' as Proceso, 0 as Estado, cast(vs.ValidacionStockProlId as varchar) as Observaciones,
	'2000-01-01' as FechaFacturacion, 'Validaci�n de Stock' as Asunto , 0 as FacturaHoy, 0 as Visualizado, 0 as EsMontoMinino,0 as 'FlagProcedencia', 1
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.Consultora c with(nolock) on vs.Codigo = c.Codigo
	inner join ValidacionStockPROL v with(nolock) on vs.ValidacionStockProlId = v.ValidacionStockProlId
	where c.ConsultoraId = @ConsultoraId and vs.Enviocorreo = 1
	group by vs.ValidacionStockProlId,v.FechaHOraInicio;

	insert into @Temporal
	select ValAutomaticaPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	ISNULL(EnvioCorreo,0) as EnvioCorreo, 'VALAUTO' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId
	
	UNION ALL
	
	select ValidacionMovilPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	0 as EnvioCorreo, 'VALMOVIL' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionMovilPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL
	
	select st.ProcesoId,
		st.CampaniaId,
		st.EstadoPROL,
		st.FechaHoraValidaci�n,
		st.EnvioCorreo,
		st.Proceso,
		st.Estado,
		st.Observaciones,
		st.FechaFacturacion,
		st.Asunto,
		st.FacturaHoy,
		ISNULL(i.Visualizado,0),
		st.EsMontoMinino,
		0 as 'FlagProcedencia',
		1
	from @TemporalStock st
	left join ValidacionStockPROLInfo i with(nolock) on st.ProcesoId = i.ValidacionStockPROLLogId

	UNION ALL
	--
	select
		SolicitudClienteID as ProcesoId,
		Campania as CampaniaId,
		'' as EstadoPROL,
		FechaSolicitud as FechaHoraValidaci�n,
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

	select 
		S.SolicitudClienteCatalogoID as ProcesoId,
		S.Campania as CampaniaId,
		'' as EstadoPROL,
		S.FechaRegistro as FechaHoraValidaci�n,
		cast(0 as bit) as EnvioCorreo,
		'CATALOGO' as Proceso,
		1 as Estado,
		'' as Observaciones,
		GETDATE()  as FechaFacturacion, 
		S.AsuntoNotificacion as Asunto,
		cast(0 as bit) as FacturaHoy,
		S.Visualizado AS Visualizado,
		cast(0 as bit) as EsMontoMinino,
		1 as FlagProcedencia,
		1
	from SolicitudClienteCatalogo S
	INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId  AND S.CodigoConsultora = C.Codigo	

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId, --ProcesoValidacionPedidoRechazadoId 
			ISNULL(LGPRV.Campania, '201601')   AS CampaniaId,
			'' AS EstadoPROL,
			LGPRV.FechaFinValidacion AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'PEDREC' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			--CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
			(CASE ISNULL(LGPRV.MotivoRechazo, '') 
			when 'DEUDA'  then 'Pedido rechazado por deuda'
			when 'MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO'  then 'Pedido rechazado por monto m�ximo'
			when 'MONTO MINIMO STOCK'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO- DEUDA'  then 'Pedido rechazado por monto m�ximo y deuda'
			when 'MONTO MINIMO STOCK- DEUDA'  then 'Pedido rechazado por monto m�nimo y deuda'
			when 'DEUDA- MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo y deuda'
			else ''
			END)
			AS Asunto,
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
			LCDRW.FechaAtencion AS FechaHoraValidaci�n,
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
			LCDRWC.FechaCulminado AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'CDR-CULM' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			'CDR: EN EVALUACI�N' AS Asunto,
			CAST(0 AS BIT) AS FacturaHoy,
			LCDRWC.Visualizado,
			CAST(0 AS BIT) AS EsMontoMinino,
			1 AS FlagProcedencia,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	SELECT top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
		Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
	FROM @Temporal
	ORDER by FechaHoraValidaci�n desc;
END
GO


USE [BelcorpPeru]
GO
ALTER PROCEDURE [dbo].[GetNotificacionesConsultora]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN
	declare @Temporal table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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

	declare @TemporalStock table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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
	)

	insert into @TemporalStock
	select MIN(vs.ValidacionStockPROLLogId) as ProcesoId,0 as CampaniaId, '' as EstadoPROL,
	v.FechaHoraInicio as FechaHoraValidaci�n, 0 as EnvioCorreo, 'VALSTOCK' as Proceso, 0 as Estado, cast(vs.ValidacionStockProlId as varchar) as Observaciones,
	'2000-01-01' as FechaFacturacion, 'Validaci�n de Stock' as Asunto , 0 as FacturaHoy, 0 as Visualizado, 0 as EsMontoMinino,0 as 'FlagProcedencia', 1
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.Consultora c with(nolock) on vs.Codigo = c.Codigo
	inner join ValidacionStockPROL v with(nolock) on vs.ValidacionStockProlId = v.ValidacionStockProlId
	where c.ConsultoraId = @ConsultoraId and vs.Enviocorreo = 1
	group by vs.ValidacionStockProlId,v.FechaHOraInicio;

	insert into @Temporal
	select ValAutomaticaPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	ISNULL(EnvioCorreo,0) as EnvioCorreo, 'VALAUTO' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId
	
	UNION ALL
	
	select ValidacionMovilPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	0 as EnvioCorreo, 'VALMOVIL' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionMovilPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL
	
	select st.ProcesoId,
		st.CampaniaId,
		st.EstadoPROL,
		st.FechaHoraValidaci�n,
		st.EnvioCorreo,
		st.Proceso,
		st.Estado,
		st.Observaciones,
		st.FechaFacturacion,
		st.Asunto,
		st.FacturaHoy,
		ISNULL(i.Visualizado,0),
		st.EsMontoMinino,
		0 as 'FlagProcedencia',
		1
	from @TemporalStock st
	left join ValidacionStockPROLInfo i with(nolock) on st.ProcesoId = i.ValidacionStockPROLLogId

	UNION ALL
	--
	select
		SolicitudClienteID as ProcesoId,
		Campania as CampaniaId,
		'' as EstadoPROL,
		FechaSolicitud as FechaHoraValidaci�n,
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

	select 
		S.SolicitudClienteCatalogoID as ProcesoId,
		S.Campania as CampaniaId,
		'' as EstadoPROL,
		S.FechaRegistro as FechaHoraValidaci�n,
		cast(0 as bit) as EnvioCorreo,
		'CATALOGO' as Proceso,
		1 as Estado,
		'' as Observaciones,
		GETDATE()  as FechaFacturacion, 
		S.AsuntoNotificacion as Asunto,
		cast(0 as bit) as FacturaHoy,
		S.Visualizado AS Visualizado,
		cast(0 as bit) as EsMontoMinino,
		1 as FlagProcedencia,
		1
	from SolicitudClienteCatalogo S
	INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId  AND S.CodigoConsultora = C.Codigo	

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId, --ProcesoValidacionPedidoRechazadoId 
			ISNULL(LGPRV.Campania, '201601')   AS CampaniaId,
			'' AS EstadoPROL,
			LGPRV.FechaFinValidacion AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'PEDREC' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			--CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
			(CASE ISNULL(LGPRV.MotivoRechazo, '') 
			when 'DEUDA'  then 'Pedido rechazado por deuda'
			when 'MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO'  then 'Pedido rechazado por monto m�ximo'
			when 'MONTO MINIMO STOCK'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO- DEUDA'  then 'Pedido rechazado por monto m�ximo y deuda'
			when 'MONTO MINIMO STOCK- DEUDA'  then 'Pedido rechazado por monto m�nimo y deuda'
			when 'DEUDA- MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo y deuda'
			else ''
			END)
			AS Asunto,
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
			LCDRW.FechaAtencion AS FechaHoraValidaci�n,
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
			LCDRWC.FechaCulminado AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'CDR-CULM' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			'CDR: EN EVALUACI�N' AS Asunto,
			CAST(0 AS BIT) AS FacturaHoy,
			LCDRWC.Visualizado,
			CAST(0 AS BIT) AS EsMontoMinino,
			1 AS FlagProcedencia,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	SELECT top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
		Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
	FROM @Temporal
	ORDER by FechaHoraValidaci�n desc;
END
GO


USE [BelcorpPuertoRico]
GO
ALTER PROCEDURE [dbo].[GetNotificacionesConsultora]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN
	declare @Temporal table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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

	declare @TemporalStock table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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
	)

	insert into @TemporalStock
	select MIN(vs.ValidacionStockPROLLogId) as ProcesoId,0 as CampaniaId, '' as EstadoPROL,
	v.FechaHoraInicio as FechaHoraValidaci�n, 0 as EnvioCorreo, 'VALSTOCK' as Proceso, 0 as Estado, cast(vs.ValidacionStockProlId as varchar) as Observaciones,
	'2000-01-01' as FechaFacturacion, 'Validaci�n de Stock' as Asunto , 0 as FacturaHoy, 0 as Visualizado, 0 as EsMontoMinino,0 as 'FlagProcedencia', 1
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.Consultora c with(nolock) on vs.Codigo = c.Codigo
	inner join ValidacionStockPROL v with(nolock) on vs.ValidacionStockProlId = v.ValidacionStockProlId
	where c.ConsultoraId = @ConsultoraId and vs.Enviocorreo = 1
	group by vs.ValidacionStockProlId,v.FechaHOraInicio;

	insert into @Temporal
	select ValAutomaticaPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	ISNULL(EnvioCorreo,0) as EnvioCorreo, 'VALAUTO' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId
	
	UNION ALL
	
	select ValidacionMovilPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	0 as EnvioCorreo, 'VALMOVIL' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionMovilPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL
	
	select st.ProcesoId,
		st.CampaniaId,
		st.EstadoPROL,
		st.FechaHoraValidaci�n,
		st.EnvioCorreo,
		st.Proceso,
		st.Estado,
		st.Observaciones,
		st.FechaFacturacion,
		st.Asunto,
		st.FacturaHoy,
		ISNULL(i.Visualizado,0),
		st.EsMontoMinino,
		0 as 'FlagProcedencia',
		1
	from @TemporalStock st
	left join ValidacionStockPROLInfo i with(nolock) on st.ProcesoId = i.ValidacionStockPROLLogId

	UNION ALL
	--
	select
		SolicitudClienteID as ProcesoId,
		Campania as CampaniaId,
		'' as EstadoPROL,
		FechaSolicitud as FechaHoraValidaci�n,
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

	select 
		S.SolicitudClienteCatalogoID as ProcesoId,
		S.Campania as CampaniaId,
		'' as EstadoPROL,
		S.FechaRegistro as FechaHoraValidaci�n,
		cast(0 as bit) as EnvioCorreo,
		'CATALOGO' as Proceso,
		1 as Estado,
		'' as Observaciones,
		GETDATE()  as FechaFacturacion, 
		S.AsuntoNotificacion as Asunto,
		cast(0 as bit) as FacturaHoy,
		S.Visualizado AS Visualizado,
		cast(0 as bit) as EsMontoMinino,
		1 as FlagProcedencia,
		1
	from SolicitudClienteCatalogo S
	INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId  AND S.CodigoConsultora = C.Codigo	

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId, --ProcesoValidacionPedidoRechazadoId 
			ISNULL(LGPRV.Campania, '201601')   AS CampaniaId,
			'' AS EstadoPROL,
			LGPRV.FechaFinValidacion AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'PEDREC' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			--CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
			(CASE ISNULL(LGPRV.MotivoRechazo, '') 
			when 'DEUDA'  then 'Pedido rechazado por deuda'
			when 'MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO'  then 'Pedido rechazado por monto m�ximo'
			when 'MONTO MINIMO STOCK'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO- DEUDA'  then 'Pedido rechazado por monto m�ximo y deuda'
			when 'MONTO MINIMO STOCK- DEUDA'  then 'Pedido rechazado por monto m�nimo y deuda'
			when 'DEUDA- MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo y deuda'
			else ''
			END)
			AS Asunto,
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
			LCDRW.FechaAtencion AS FechaHoraValidaci�n,
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
			LCDRWC.FechaCulminado AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'CDR-CULM' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			'CDR: EN EVALUACI�N' AS Asunto,
			CAST(0 AS BIT) AS FacturaHoy,
			LCDRWC.Visualizado,
			CAST(0 AS BIT) AS EsMontoMinino,
			1 AS FlagProcedencia,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	SELECT top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
		Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
	FROM @Temporal
	ORDER by FechaHoraValidaci�n desc;
END
GO


USE [BelcorpSalvador]
GO
ALTER PROCEDURE [dbo].[GetNotificacionesConsultora]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN
	declare @Temporal table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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

	declare @TemporalStock table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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
	)

	insert into @TemporalStock
	select MIN(vs.ValidacionStockPROLLogId) as ProcesoId,0 as CampaniaId, '' as EstadoPROL,
	v.FechaHoraInicio as FechaHoraValidaci�n, 0 as EnvioCorreo, 'VALSTOCK' as Proceso, 0 as Estado, cast(vs.ValidacionStockProlId as varchar) as Observaciones,
	'2000-01-01' as FechaFacturacion, 'Validaci�n de Stock' as Asunto , 0 as FacturaHoy, 0 as Visualizado, 0 as EsMontoMinino,0 as 'FlagProcedencia', 1
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.Consultora c with(nolock) on vs.Codigo = c.Codigo
	inner join ValidacionStockPROL v with(nolock) on vs.ValidacionStockProlId = v.ValidacionStockProlId
	where c.ConsultoraId = @ConsultoraId and vs.Enviocorreo = 1
	group by vs.ValidacionStockProlId,v.FechaHOraInicio;

	insert into @Temporal
	select ValAutomaticaPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	ISNULL(EnvioCorreo,0) as EnvioCorreo, 'VALAUTO' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId
	
	UNION ALL
	
	select ValidacionMovilPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	0 as EnvioCorreo, 'VALMOVIL' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionMovilPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL
	
	select st.ProcesoId,
		st.CampaniaId,
		st.EstadoPROL,
		st.FechaHoraValidaci�n,
		st.EnvioCorreo,
		st.Proceso,
		st.Estado,
		st.Observaciones,
		st.FechaFacturacion,
		st.Asunto,
		st.FacturaHoy,
		ISNULL(i.Visualizado,0),
		st.EsMontoMinino,
		0 as 'FlagProcedencia',
		1
	from @TemporalStock st
	left join ValidacionStockPROLInfo i with(nolock) on st.ProcesoId = i.ValidacionStockPROLLogId

	UNION ALL
	--
	select
		SolicitudClienteID as ProcesoId,
		Campania as CampaniaId,
		'' as EstadoPROL,
		FechaSolicitud as FechaHoraValidaci�n,
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

	select 
		S.SolicitudClienteCatalogoID as ProcesoId,
		S.Campania as CampaniaId,
		'' as EstadoPROL,
		S.FechaRegistro as FechaHoraValidaci�n,
		cast(0 as bit) as EnvioCorreo,
		'CATALOGO' as Proceso,
		1 as Estado,
		'' as Observaciones,
		GETDATE()  as FechaFacturacion, 
		S.AsuntoNotificacion as Asunto,
		cast(0 as bit) as FacturaHoy,
		S.Visualizado AS Visualizado,
		cast(0 as bit) as EsMontoMinino,
		1 as FlagProcedencia,
		1
	from SolicitudClienteCatalogo S
	INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId  AND S.CodigoConsultora = C.Codigo	

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId, --ProcesoValidacionPedidoRechazadoId 
			ISNULL(LGPRV.Campania, '201601')   AS CampaniaId,
			'' AS EstadoPROL,
			LGPRV.FechaFinValidacion AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'PEDREC' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			--CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
			(CASE ISNULL(LGPRV.MotivoRechazo, '') 
			when 'DEUDA'  then 'Pedido rechazado por deuda'
			when 'MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO'  then 'Pedido rechazado por monto m�ximo'
			when 'MONTO MINIMO STOCK'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO- DEUDA'  then 'Pedido rechazado por monto m�ximo y deuda'
			when 'MONTO MINIMO STOCK- DEUDA'  then 'Pedido rechazado por monto m�nimo y deuda'
			when 'DEUDA- MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo y deuda'
			else ''
			END)
			AS Asunto,
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
			LCDRW.FechaAtencion AS FechaHoraValidaci�n,
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
			LCDRWC.FechaCulminado AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'CDR-CULM' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			'CDR: EN EVALUACI�N' AS Asunto,
			CAST(0 AS BIT) AS FacturaHoy,
			LCDRWC.Visualizado,
			CAST(0 AS BIT) AS EsMontoMinino,
			1 AS FlagProcedencia,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	SELECT top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
		Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
	FROM @Temporal
	ORDER by FechaHoraValidaci�n desc;
END
GO


USE [BelcorpVenezuela]
GO
ALTER PROCEDURE [dbo].[GetNotificacionesConsultora]
	@ConsultoraId bigint,
	@ShowCDR bit = 0
AS
BEGIN
	declare @Temporal table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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

	declare @TemporalStock table
	(
		ProcesoId bigint,
		CampaniaId int,
		EstadoPROL varchar(2),
		FechaHoraValidaci�n datetime,
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
	)

	insert into @TemporalStock
	select MIN(vs.ValidacionStockPROLLogId) as ProcesoId,0 as CampaniaId, '' as EstadoPROL,
	v.FechaHoraInicio as FechaHoraValidaci�n, 0 as EnvioCorreo, 'VALSTOCK' as Proceso, 0 as Estado, cast(vs.ValidacionStockProlId as varchar) as Observaciones,
	'2000-01-01' as FechaFacturacion, 'Validaci�n de Stock' as Asunto , 0 as FacturaHoy, 0 as Visualizado, 0 as EsMontoMinino,0 as 'FlagProcedencia', 1
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.Consultora c with(nolock) on vs.Codigo = c.Codigo
	inner join ValidacionStockPROL v with(nolock) on vs.ValidacionStockProlId = v.ValidacionStockProlId
	where c.ConsultoraId = @ConsultoraId and vs.Enviocorreo = 1
	group by vs.ValidacionStockProlId,v.FechaHOraInicio;

	insert into @Temporal
	select ValAutomaticaPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	ISNULL(EnvioCorreo,0) as EnvioCorreo, 'VALAUTO' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId
	
	UNION ALL
	
	select ValidacionMovilPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,
	0 as EnvioCorreo, 'VALMOVIL' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con �xito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto m�nimo','Pedido no reservado por monto m�ximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia',
	1
	from ValidacionMovilPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL
	
	select st.ProcesoId,
		st.CampaniaId,
		st.EstadoPROL,
		st.FechaHoraValidaci�n,
		st.EnvioCorreo,
		st.Proceso,
		st.Estado,
		st.Observaciones,
		st.FechaFacturacion,
		st.Asunto,
		st.FacturaHoy,
		ISNULL(i.Visualizado,0),
		st.EsMontoMinino,
		0 as 'FlagProcedencia',
		1
	from @TemporalStock st
	left join ValidacionStockPROLInfo i with(nolock) on st.ProcesoId = i.ValidacionStockPROLLogId

	UNION ALL
	--
	select
		SolicitudClienteID as ProcesoId,
		Campania as CampaniaId,
		'' as EstadoPROL,
		FechaSolicitud as FechaHoraValidaci�n,
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

	select 
		S.SolicitudClienteCatalogoID as ProcesoId,
		S.Campania as CampaniaId,
		'' as EstadoPROL,
		S.FechaRegistro as FechaHoraValidaci�n,
		cast(0 as bit) as EnvioCorreo,
		'CATALOGO' as Proceso,
		1 as Estado,
		'' as Observaciones,
		GETDATE()  as FechaFacturacion, 
		S.AsuntoNotificacion as Asunto,
		cast(0 as bit) as FacturaHoy,
		S.Visualizado AS Visualizado,
		cast(0 as bit) as EsMontoMinino,
		1 as FlagProcedencia,
		1
	from SolicitudClienteCatalogo S
	INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId  AND S.CodigoConsultora = C.Codigo	

	UNION ALL

	SELECT * 
	FROM
		(SELECT 	
			LGPRV.LogGPRValidacionId  AS ProcesoId, --ProcesoValidacionPedidoRechazadoId 
			ISNULL(LGPRV.Campania, '201601')   AS CampaniaId,
			'' AS EstadoPROL,
			LGPRV.FechaFinValidacion AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'PEDREC' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			--CONCAT('Pedido Rechazado: ', ISNULL(LGPRV.MotivoRechazo, '')) AS Asunto,
			(CASE ISNULL(LGPRV.MotivoRechazo, '') 
			when 'DEUDA'  then 'Pedido rechazado por deuda'
			when 'MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO'  then 'Pedido rechazado por monto m�ximo'
			when 'MONTO MINIMO STOCK'  then 'Pedido rechazado por monto m�nimo'
			when 'MONTO MAXIMO- DEUDA'  then 'Pedido rechazado por monto m�ximo y deuda'
			when 'MONTO MINIMO STOCK- DEUDA'  then 'Pedido rechazado por monto m�nimo y deuda'
			when 'DEUDA- MONTO M�NIMO'  then 'Pedido rechazado por monto m�nimo y deuda'
			else ''
			END)
			AS Asunto,
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
			LCDRW.FechaAtencion AS FechaHoraValidaci�n,
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
			LCDRWC.FechaCulminado AS FechaHoraValidaci�n,
			CAST(0 AS BIT) as EnvioCorreo,
			'CDR-CULM' AS Proceso,
			1 AS Estado,
			'' AS Observaciones,
			GETDATE()  AS FechaFacturacion, 
			'CDR: EN EVALUACI�N' AS Asunto,
			CAST(0 AS BIT) AS FacturaHoy,
			LCDRWC.Visualizado,
			CAST(0 AS BIT) AS EsMontoMinino,
			1 AS FlagProcedencia,
			1
		FROM dbo.LogCDRWebCulminado LCDRWC
		WHERE LCDRWC.ConsultoraId = @ConsultoraId;
	END

	SELECT top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidaci�n,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
		Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
	FROM @Temporal
	ORDER by FechaHoraValidaci�n desc;
END
GO