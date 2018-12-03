USE [BelcorpPeru]
GO

ALTER PROCEDURE DelListPedidoWebDetalleValAuto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
	
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado)
	select PedidoID,0,ConsultoraID,CampaniaID,CUV,401,@FechaGeneral,Cantidad,PrecioUnidad,FechaCreacion,0
	from @PedidoWebDetalleValAuto;

GO

USE [BelcorpMexico]
GO

ALTER PROCEDURE DelListPedidoWebDetalleValAuto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
	
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado)
	select PedidoID,0,ConsultoraID,CampaniaID,CUV,401,@FechaGeneral,Cantidad,PrecioUnidad,FechaCreacion,0
	from @PedidoWebDetalleValAuto;

GO

USE [BelcorpColombia]
GO

ALTER PROCEDURE DelListPedidoWebDetalleValAuto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
	
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado)
	select PedidoID,0,ConsultoraID,CampaniaID,CUV,401,@FechaGeneral,Cantidad,PrecioUnidad,FechaCreacion,0
	from @PedidoWebDetalleValAuto;

GO

USE [BelcorpSalvador]
GO

ALTER PROCEDURE DelListPedidoWebDetalleValAuto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
	
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado)
	select PedidoID,0,ConsultoraID,CampaniaID,CUV,401,@FechaGeneral,Cantidad,PrecioUnidad,FechaCreacion,0
	from @PedidoWebDetalleValAuto;

GO

USE [BelcorpPuertoRico]
GO

ALTER PROCEDURE DelListPedidoWebDetalleValAuto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
	
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado)
	select PedidoID,0,ConsultoraID,CampaniaID,CUV,401,@FechaGeneral,Cantidad,PrecioUnidad,FechaCreacion,0
	from @PedidoWebDetalleValAuto;

GO

USE [BelcorpPanama]
GO

ALTER PROCEDURE DelListPedidoWebDetalleValAuto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
	
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado)
	select PedidoID,0,ConsultoraID,CampaniaID,CUV,401,@FechaGeneral,Cantidad,PrecioUnidad,FechaCreacion,0
	from @PedidoWebDetalleValAuto;

GO

USE [BelcorpGuatemala]
GO

ALTER PROCEDURE DelListPedidoWebDetalleValAuto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
	
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado)
	select PedidoID,0,ConsultoraID,CampaniaID,CUV,401,@FechaGeneral,Cantidad,PrecioUnidad,FechaCreacion,0
	from @PedidoWebDetalleValAuto;

GO

USE [BelcorpEcuador]
GO

ALTER PROCEDURE DelListPedidoWebDetalleValAuto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
	
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado)
	select PedidoID,0,ConsultoraID,CampaniaID,CUV,401,@FechaGeneral,Cantidad,PrecioUnidad,FechaCreacion,0
	from @PedidoWebDetalleValAuto;

GO

USE [BelcorpDominicana]
GO

ALTER PROCEDURE DelListPedidoWebDetalleValAuto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
	
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado)
	select PedidoID,0,ConsultoraID,CampaniaID,CUV,401,@FechaGeneral,Cantidad,PrecioUnidad,FechaCreacion,0
	from @PedidoWebDetalleValAuto;

GO

USE [BelcorpCostaRica]
GO

ALTER PROCEDURE DelListPedidoWebDetalleValAuto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
	
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado)
	select PedidoID,0,ConsultoraID,CampaniaID,CUV,401,@FechaGeneral,Cantidad,PrecioUnidad,FechaCreacion,0
	from @PedidoWebDetalleValAuto;

GO

USE [BelcorpChile]
GO

ALTER PROCEDURE DelListPedidoWebDetalleValAuto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
	
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado)
	select PedidoID,0,ConsultoraID,CampaniaID,CUV,401,@FechaGeneral,Cantidad,PrecioUnidad,FechaCreacion,0
	from @PedidoWebDetalleValAuto;

GO

USE [BelcorpBolivia]
GO

ALTER PROCEDURE DelListPedidoWebDetalleValAuto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
	
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado)
	select PedidoID,0,ConsultoraID,CampaniaID,CUV,401,@FechaGeneral,Cantidad,PrecioUnidad,FechaCreacion,0
	from @PedidoWebDetalleValAuto;

GO