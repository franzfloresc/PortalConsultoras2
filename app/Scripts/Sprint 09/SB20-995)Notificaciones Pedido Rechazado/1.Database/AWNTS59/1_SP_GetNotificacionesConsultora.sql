USE BelcorpColombia
GO
ALTER PROCEDURE dbo.GetNotificacionesConsultora
	@ConsultoraId bigint
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
		FlagProcedencia bit
	)

	declare @TemporalStock table
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
		FlagProcedencia bit
	)

	insert into @TemporalStock
	select MIN(vs.ValidacionStockPROLLogId) as ProcesoId,0 as CampaniaId, '' as EstadoPROL,
	v.FechaHoraInicio as FechaHoraValidación, 0 as EnvioCorreo, 'VALSTOCK' as Proceso, 0 as Estado, cast(vs.ValidacionStockProlId as varchar) as Observaciones,
	'2000-01-01' as FechaFacturacion, 'Validación de Stock' as Asunto , 0 as FacturaHoy, 0 as Visualizado, 0 as EsMontoMinino,0 as 'FlagProcedencia' 
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.Consultora c with(nolock) on vs.Codigo = c.Codigo
	inner join ValidacionStockPROL v with(nolock) on vs.ValidacionStockProlId = v.ValidacionStockProlId
	where c.ConsultoraId = @ConsultoraId and vs.Enviocorreo = 1
	group by vs.ValidacionStockProlId,v.FechaHOraInicio;

	insert into @Temporal
	select ValAutomaticaPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,
	ISNULL(EnvioCorreo,0) as EnvioCorreo, 'VALAUTO' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con éxito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto mínimo','Pedido no reservado por monto máximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia'
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId
	
	UNION ALL
	
	select ValidacionMovilPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,
	0 as EnvioCorreo, 'VALMOVIL' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con éxito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto mínimo','Pedido no reservado por monto máximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia'
	from ValidacionMovilPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL
	
	select st.ProcesoId,
		st.CampaniaId,
		st.EstadoPROL,
		st.FechaHoraValidación,
		st.EnvioCorreo,
		st.Proceso,
		st.Estado,
		st.Observaciones,
		st.FechaFacturacion,
		st.Asunto,
		st.FacturaHoy,
		ISNULL(i.Visualizado,0),
		st.EsMontoMinino,
		0 as 'FlagProcedencia'
	from @TemporalStock st
	left join ValidacionStockPROLInfo i with(nolock) on st.ProcesoId = i.ValidacionStockPROLLogId

	UNION ALL
	
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
		1 as 'FlagProcedencia'
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))

	UNION ALL
	
	select 
		S.SolicitudClienteCatalogoID as ProcesoId,
		S.Campania as CampaniaId,
		'' as EstadoPROL,
		S.FechaRegistro as FechaHoraValidación,
		cast(0 as bit) as EnvioCorreo,
		'CATALOGO' as Proceso,
		1  as Estado,
		'' as Observaciones,
		GETDATE()  as FechaFacturacion, 
		S.AsuntoNotificacion as Asunto,
		cast(0 as bit) as FacturaHoy,
		S.Visualizado AS Visualizado,
		cast(0 as bit) as EsMontoMinino,
		1 as FlagProcedencia
	from SolicitudClienteCatalogo S
	INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId  AND S.CodigoConsultora = C.Codigo
	
	UNION ALL
	
	SELECT
		LGPRV.LogGPRValidacionId AS ProcesoId,
		PR.Campania AS CampaniaId,
		'' AS EstadoPROL,
		LGPRV.FechaFinValidacion AS FechaHoraValidación,
		CAST(0 AS BIT) as EnvioCorreo,
		'PEDREC' AS Proceso,
		1 AS Estado,
		'' AS Observaciones,
		GETDATE()  AS FechaFacturacion, 
		CONCAT('Pedido Rechazado: ', LGPRV.DescripcionRechazo) AS Asunto,
		CAST(0 AS BIT) AS FacturaHoy,
		LGPRV.Visualizado AS Visualizado,
		CAST(0 AS BIT) AS EsMontoMinino,
		1 AS FlagProcedencia
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId;

	select top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
	Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
	from @Temporal
	order by FechaHoraValidación desc;
END
GO
/*end*/

USE BelcorpMexico
GO
ALTER PROCEDURE dbo.GetNotificacionesConsultora
	@ConsultoraId bigint
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
		FlagProcedencia bit
	)

	declare @TemporalStock table
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
		FlagProcedencia bit
	)

	insert into @TemporalStock
	select MIN(vs.ValidacionStockPROLLogId) as ProcesoId,0 as CampaniaId, '' as EstadoPROL,
	v.FechaHoraInicio as FechaHoraValidación, 0 as EnvioCorreo, 'VALSTOCK' as Proceso, 0 as Estado, cast(vs.ValidacionStockProlId as varchar) as Observaciones,
	'2000-01-01' as FechaFacturacion, 'Validación de Stock' as Asunto , 0 as FacturaHoy, 0 as Visualizado, 0 as EsMontoMinino,0 as 'FlagProcedencia' 
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.Consultora c with(nolock) on vs.Codigo = c.Codigo
	inner join ValidacionStockPROL v with(nolock) on vs.ValidacionStockProlId = v.ValidacionStockProlId
	where c.ConsultoraId = @ConsultoraId and vs.Enviocorreo = 1
	group by vs.ValidacionStockProlId,v.FechaHOraInicio;

	insert into @Temporal
	select ValAutomaticaPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,
	ISNULL(EnvioCorreo,0) as EnvioCorreo, 'VALAUTO' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con éxito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto mínimo','Pedido no reservado por monto máximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia'
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId
	
	UNION ALL
	
	select ValidacionMovilPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,
	0 as EnvioCorreo, 'VALMOVIL' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con éxito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto mínimo','Pedido no reservado por monto máximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia'
	from ValidacionMovilPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL
	
	select st.ProcesoId,
		st.CampaniaId,
		st.EstadoPROL,
		st.FechaHoraValidación,
		st.EnvioCorreo,
		st.Proceso,
		st.Estado,
		st.Observaciones,
		st.FechaFacturacion,
		st.Asunto,
		st.FacturaHoy,
		ISNULL(i.Visualizado,0),
		st.EsMontoMinino,
		0 as 'FlagProcedencia'
	from @TemporalStock st
	left join ValidacionStockPROLInfo i with(nolock) on st.ProcesoId = i.ValidacionStockPROLLogId

	UNION ALL
	
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
		1 as 'FlagProcedencia'
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))

	UNION ALL
	
	select 
		S.SolicitudClienteCatalogoID as ProcesoId,
		S.Campania as CampaniaId,
		'' as EstadoPROL,
		S.FechaRegistro as FechaHoraValidación,
		cast(0 as bit) as EnvioCorreo,
		'CATALOGO' as Proceso,
		1  as Estado,
		'' as Observaciones,
		GETDATE()  as FechaFacturacion, 
		S.AsuntoNotificacion as Asunto,
		cast(0 as bit) as FacturaHoy,
		S.Visualizado AS Visualizado,
		cast(0 as bit) as EsMontoMinino,
		1 as FlagProcedencia
	from SolicitudClienteCatalogo S
	INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId  AND S.CodigoConsultora = C.Codigo
	
	UNION ALL
	
	SELECT
		LGPRV.LogGPRValidacionId AS ProcesoId,
		PR.Campania AS CampaniaId,
		'' AS EstadoPROL,
		LGPRV.FechaFinValidacion AS FechaHoraValidación,
		CAST(0 AS BIT) as EnvioCorreo,
		'PEDREC' AS Proceso,
		1 AS Estado,
		'' AS Observaciones,
		GETDATE()  AS FechaFacturacion, 
		CONCAT('Pedido Rechazado: ', LGPRV.DescripcionRechazo) AS Asunto,
		CAST(0 AS BIT) AS FacturaHoy,
		LGPRV.Visualizado AS Visualizado,
		CAST(0 AS BIT) AS EsMontoMinino,
		1 AS FlagProcedencia
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId;

	select top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
	Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
	from @Temporal
	order by FechaHoraValidación desc;
END
GO
/*end*/

USE BelcorpPeru
GO
ALTER PROCEDURE dbo.GetNotificacionesConsultora
	@ConsultoraId bigint
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
		FlagProcedencia bit
	)

	declare @TemporalStock table
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
		FlagProcedencia bit
	)

	insert into @TemporalStock
	select MIN(vs.ValidacionStockPROLLogId) as ProcesoId,0 as CampaniaId, '' as EstadoPROL,
	v.FechaHoraInicio as FechaHoraValidación, 0 as EnvioCorreo, 'VALSTOCK' as Proceso, 0 as Estado, cast(vs.ValidacionStockProlId as varchar) as Observaciones,
	'2000-01-01' as FechaFacturacion, 'Validación de Stock' as Asunto , 0 as FacturaHoy, 0 as Visualizado, 0 as EsMontoMinino,0 as 'FlagProcedencia' 
	from ValidacionStockPROLLog vs with(nolock)
	inner join ods.Consultora c with(nolock) on vs.Codigo = c.Codigo
	inner join ValidacionStockPROL v with(nolock) on vs.ValidacionStockProlId = v.ValidacionStockProlId
	where c.ConsultoraId = @ConsultoraId and vs.Enviocorreo = 1
	group by vs.ValidacionStockProlId,v.FechaHOraInicio;

	insert into @Temporal
	select ValAutomaticaPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,
	ISNULL(EnvioCorreo,0) as EnvioCorreo, 'VALAUTO' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con éxito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto mínimo','Pedido no reservado por monto máximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia'
	from ValidacionAutomaticaPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId
	
	UNION ALL
	
	select ValidacionMovilPROLLogId as ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,
	0 as EnvioCorreo, 'VALMOVIL' as Proceso, Estado, Observaciones, FechaFacturacion,
	(case when Estado = 4 then 'Pedido reservado con éxito' 
		 when Estado = 5 then 'Pedido reservado con observaciones'
		 when Estado = 2 then IIF(EsMontoMinino=1,'Pedido no reservado por monto mínimo','Pedido no reservado por monto máximo')
		 when Estado = 3 then 'Pedido no reservado por observaciones' end) as Asunto, 
	ISNULL(FacturaHoy,0) as FacturaHoy,
	ISNULL(Visualizado,0) as Visualizado, EsMontoMinino,0 as 'FlagProcedencia'
	from ValidacionMovilPROLLog with(nolock)
	where Estado in (2,3,4,5) and ConsultoraId = @ConsultoraId

	UNION ALL
	
	select st.ProcesoId,
		st.CampaniaId,
		st.EstadoPROL,
		st.FechaHoraValidación,
		st.EnvioCorreo,
		st.Proceso,
		st.Estado,
		st.Observaciones,
		st.FechaFacturacion,
		st.Asunto,
		st.FacturaHoy,
		ISNULL(i.Visualizado,0),
		st.EsMontoMinino,
		0 as 'FlagProcedencia'
	from @TemporalStock st
	left join ValidacionStockPROLInfo i with(nolock) on st.ProcesoId = i.ValidacionStockPROLLogId

	UNION ALL
	
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
		1 as 'FlagProcedencia'
	from SolicitudCliente 
	where ConsultoraID = @ConsultoraId and (Estado IS NULL or LTRIM(RTRIM(Estado)) IN ('A', 'C'))

	UNION ALL
	
	select 
		S.SolicitudClienteCatalogoID as ProcesoId,
		S.Campania as CampaniaId,
		'' as EstadoPROL,
		S.FechaRegistro as FechaHoraValidación,
		cast(0 as bit) as EnvioCorreo,
		'CATALOGO' as Proceso,
		1  as Estado,
		'' as Observaciones,
		GETDATE()  as FechaFacturacion, 
		S.AsuntoNotificacion as Asunto,
		cast(0 as bit) as FacturaHoy,
		S.Visualizado AS Visualizado,
		cast(0 as bit) as EsMontoMinino,
		1 as FlagProcedencia
	from SolicitudClienteCatalogo S
	INNER JOIN ods.Consultora C ON C.ConsultoraID = @ConsultoraId  AND S.CodigoConsultora = C.Codigo
	
	UNION ALL
	
	SELECT
		LGPRV.LogGPRValidacionId AS ProcesoId,
		PR.Campania AS CampaniaId,
		'' AS EstadoPROL,
		LGPRV.FechaFinValidacion AS FechaHoraValidación,
		CAST(0 AS BIT) as EnvioCorreo,
		'PEDREC' AS Proceso,
		1 AS Estado,
		'' AS Observaciones,
		GETDATE()  AS FechaFacturacion, 
		CONCAT('Pedido Rechazado: ', LGPRV.DescripcionRechazo) AS Asunto,
		CAST(0 AS BIT) AS FacturaHoy,
		LGPRV.Visualizado AS Visualizado,
		CAST(0 AS BIT) AS EsMontoMinino,
		1 AS FlagProcedencia
	FROM GPR.LogGPRValidacion LGPRV
	INNER JOIN GPR.PedidoRechazado PR ON LGPRV.IdPedidoRechazado = PR.IdPedidoRechazado
	WHERE LGPRV.Rechazado = 1 AND LGPRV.ConsultoraId = @ConsultoraId;

	select top 10 ProcesoId,CampaniaId,EstadoPROL,FechaHoraValidación,EnvioCorreo,Proceso,Estado,Observaciones,FechaFacturacion,
	Asunto,FacturaHoy,Visualizado,EsMontoMinino,FlagProcedencia
	from @Temporal
	order by FechaHoraValidación desc;
END
GO