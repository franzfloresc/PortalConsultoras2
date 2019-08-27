USE BelcorpBolivia
GO
ALTER PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
	@listPedidoRechazadoGestionable dbo.PedidoRechazadoGestionableType readonly
AS
BEGIN	
	declare @FechaAyer datetime = dbo.fnObtenerFechaHoraPais() -1;
	declare @FechaHoy datetime = dbo.fnObtenerFechaHoraPais();
	
	update PW
	set	PW.GPRSB = 0
	from dbo.PedidoWeb AS PW WITH(NOLOCK)
	where
		PW.IndicadorEnviado = 1 and PW.FechaProceso between @FechaAyer and @FechaHoy and
		not exists (
			select 1
			from @listPedidoRechazadoGestionable LPRG
			where LPRG.CampaniaId = PW.CampaniaId and LPRG.PedidoId = PW.PedidoId
		);
END
GO

USE BelcorpChile
GO
ALTER PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
	@listPedidoRechazadoGestionable dbo.PedidoRechazadoGestionableType readonly
AS
BEGIN	
	declare @FechaAyer datetime = dbo.fnObtenerFechaHoraPais() -1;
	declare @FechaHoy datetime = dbo.fnObtenerFechaHoraPais();
	
	update PW
	set	PW.GPRSB = 0
	from dbo.PedidoWeb AS PW WITH(NOLOCK)
	where
		PW.IndicadorEnviado = 1 and PW.FechaProceso between @FechaAyer and @FechaHoy and
		not exists (
			select 1
			from @listPedidoRechazadoGestionable LPRG
			where LPRG.CampaniaId = PW.CampaniaId and LPRG.PedidoId = PW.PedidoId
		);
END
GO

USE BelcorpColombia
GO
ALTER PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
	@listPedidoRechazadoGestionable dbo.PedidoRechazadoGestionableType readonly
AS
BEGIN	
	declare @FechaAyer datetime = dbo.fnObtenerFechaHoraPais() -1;
	declare @FechaHoy datetime = dbo.fnObtenerFechaHoraPais();
	
	update PW
	set	PW.GPRSB = 0
	from dbo.PedidoWeb AS PW WITH(NOLOCK)
	where
		PW.IndicadorEnviado = 1 and PW.FechaProceso between @FechaAyer and @FechaHoy and
		not exists (
			select 1
			from @listPedidoRechazadoGestionable LPRG
			where LPRG.CampaniaId = PW.CampaniaId and LPRG.PedidoId = PW.PedidoId
		);
END
GO

USE BelcorpCostaRica
GO
ALTER PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
	@listPedidoRechazadoGestionable dbo.PedidoRechazadoGestionableType readonly
AS
BEGIN	
	declare @FechaAyer datetime = dbo.fnObtenerFechaHoraPais() -1;
	declare @FechaHoy datetime = dbo.fnObtenerFechaHoraPais();
	
	update PW
	set	PW.GPRSB = 0
	from dbo.PedidoWeb AS PW WITH(NOLOCK)
	where
		PW.IndicadorEnviado = 1 and PW.FechaProceso between @FechaAyer and @FechaHoy and
		not exists (
			select 1
			from @listPedidoRechazadoGestionable LPRG
			where LPRG.CampaniaId = PW.CampaniaId and LPRG.PedidoId = PW.PedidoId
		);
END
GO

USE BelcorpDominicana
GO
ALTER PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
	@listPedidoRechazadoGestionable dbo.PedidoRechazadoGestionableType readonly
AS
BEGIN	
	declare @FechaAyer datetime = dbo.fnObtenerFechaHoraPais() -1;
	declare @FechaHoy datetime = dbo.fnObtenerFechaHoraPais();
	
	update PW
	set	PW.GPRSB = 0
	from dbo.PedidoWeb AS PW WITH(NOLOCK)
	where
		PW.IndicadorEnviado = 1 and PW.FechaProceso between @FechaAyer and @FechaHoy and
		not exists (
			select 1
			from @listPedidoRechazadoGestionable LPRG
			where LPRG.CampaniaId = PW.CampaniaId and LPRG.PedidoId = PW.PedidoId
		);
END
GO

USE BelcorpEcuador
GO
ALTER PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
	@listPedidoRechazadoGestionable dbo.PedidoRechazadoGestionableType readonly
AS
BEGIN	
	declare @FechaAyer datetime = dbo.fnObtenerFechaHoraPais() -1;
	declare @FechaHoy datetime = dbo.fnObtenerFechaHoraPais();
	
	update PW
	set	PW.GPRSB = 0
	from dbo.PedidoWeb AS PW WITH(NOLOCK)
	where
		PW.IndicadorEnviado = 1 and PW.FechaProceso between @FechaAyer and @FechaHoy and
		not exists (
			select 1
			from @listPedidoRechazadoGestionable LPRG
			where LPRG.CampaniaId = PW.CampaniaId and LPRG.PedidoId = PW.PedidoId
		);
END
GO

USE BelcorpGuatemala
GO
ALTER PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
	@listPedidoRechazadoGestionable dbo.PedidoRechazadoGestionableType readonly
AS
BEGIN	
	declare @FechaAyer datetime = dbo.fnObtenerFechaHoraPais() -1;
	declare @FechaHoy datetime = dbo.fnObtenerFechaHoraPais();
	
	update PW
	set	PW.GPRSB = 0
	from dbo.PedidoWeb AS PW WITH(NOLOCK)
	where
		PW.IndicadorEnviado = 1 and PW.FechaProceso between @FechaAyer and @FechaHoy and
		not exists (
			select 1
			from @listPedidoRechazadoGestionable LPRG
			where LPRG.CampaniaId = PW.CampaniaId and LPRG.PedidoId = PW.PedidoId
		);
END
GO

USE BelcorpMexico
GO
ALTER PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
	@listPedidoRechazadoGestionable dbo.PedidoRechazadoGestionableType readonly
AS
BEGIN	
	declare @FechaAyer datetime = dbo.fnObtenerFechaHoraPais() -1;
	declare @FechaHoy datetime = dbo.fnObtenerFechaHoraPais();
	
	update PW
	set	PW.GPRSB = 0
	from dbo.PedidoWeb AS PW WITH(NOLOCK)
	where
		PW.IndicadorEnviado = 1 and PW.FechaProceso between @FechaAyer and @FechaHoy and
		not exists (
			select 1
			from @listPedidoRechazadoGestionable LPRG
			where LPRG.CampaniaId = PW.CampaniaId and LPRG.PedidoId = PW.PedidoId
		);
END
GO

USE BelcorpPanama
GO
ALTER PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
	@listPedidoRechazadoGestionable dbo.PedidoRechazadoGestionableType readonly
AS
BEGIN	
	declare @FechaAyer datetime = dbo.fnObtenerFechaHoraPais() -1;
	declare @FechaHoy datetime = dbo.fnObtenerFechaHoraPais();
	
	update PW
	set	PW.GPRSB = 0
	from dbo.PedidoWeb AS PW WITH(NOLOCK)
	where
		PW.IndicadorEnviado = 1 and PW.FechaProceso between @FechaAyer and @FechaHoy and
		not exists (
			select 1
			from @listPedidoRechazadoGestionable LPRG
			where LPRG.CampaniaId = PW.CampaniaId and LPRG.PedidoId = PW.PedidoId
		);
END
GO

USE BelcorpPeru
GO
ALTER PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
	@listPedidoRechazadoGestionable dbo.PedidoRechazadoGestionableType readonly
AS
BEGIN	
	declare @FechaAyer datetime = dbo.fnObtenerFechaHoraPais() -1;
	declare @FechaHoy datetime = dbo.fnObtenerFechaHoraPais();
	
	update PW
	set	PW.GPRSB = 0
	from dbo.PedidoWeb AS PW WITH(NOLOCK)
	where
		PW.IndicadorEnviado = 1 and PW.FechaProceso between @FechaAyer and @FechaHoy and
		not exists (
			select 1
			from @listPedidoRechazadoGestionable LPRG
			where LPRG.CampaniaId = PW.CampaniaId and LPRG.PedidoId = PW.PedidoId
		);
END
GO

USE BelcorpPuertoRico
GO
ALTER PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
	@listPedidoRechazadoGestionable dbo.PedidoRechazadoGestionableType readonly
AS
BEGIN	
	declare @FechaAyer datetime = dbo.fnObtenerFechaHoraPais() -1;
	declare @FechaHoy datetime = dbo.fnObtenerFechaHoraPais();
	
	update PW
	set	PW.GPRSB = 0
	from dbo.PedidoWeb AS PW WITH(NOLOCK)
	where
		PW.IndicadorEnviado = 1 and PW.FechaProceso between @FechaAyer and @FechaHoy and
		not exists (
			select 1
			from @listPedidoRechazadoGestionable LPRG
			where LPRG.CampaniaId = PW.CampaniaId and LPRG.PedidoId = PW.PedidoId
		);
END
GO

USE BelcorpSalvador
GO
ALTER PROCEDURE [GPR].[ActualizarIndicadorGPRPedidosFacturados]
	@listPedidoRechazadoGestionable dbo.PedidoRechazadoGestionableType readonly
AS
BEGIN	
	declare @FechaAyer datetime = dbo.fnObtenerFechaHoraPais() -1;
	declare @FechaHoy datetime = dbo.fnObtenerFechaHoraPais();
	
	update PW
	set	PW.GPRSB = 0
	from dbo.PedidoWeb AS PW WITH(NOLOCK)
	where
		PW.IndicadorEnviado = 1 and PW.FechaProceso between @FechaAyer and @FechaHoy and
		not exists (
			select 1
			from @listPedidoRechazadoGestionable LPRG
			where LPRG.CampaniaId = PW.CampaniaId and LPRG.PedidoId = PW.PedidoId
		);
END
GO