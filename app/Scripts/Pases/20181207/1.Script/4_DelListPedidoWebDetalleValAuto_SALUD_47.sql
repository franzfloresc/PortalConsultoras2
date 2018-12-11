
USE [BelcorpPeru]
GO
ALTER PROCEDURE [dbo].[DelListPedidoWebDetalleValAuto]
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @PedidoWebAccionesPROLID bigint;

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
		
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado, PedidoWebAccionesPROLID)
	select PWDV.PedidoID,0,PWDV.ConsultoraID,PWDV.CampaniaID,PWDV.CUV,401,@FechaGeneral,PWDV.Cantidad,PWDV.PrecioUnidad,PWDV.FechaCreacion,0,PWAP.PedidoWebAccionesPROLID
	from @PedidoWebDetalleValAuto PWDV
	inner join PedidoWebAccionesPROL PWAP on PWDV.PedidoID = PWAP.PedidoID and PWDV.PedidoDetalleID = PWAP.PedidoDetalleID 
						and PWDV.ValAutomaticaPROLLogId = PWAP.ValAutomaticaPROLLogId
GO


USE [BelcorpMexico]
GO
ALTER PROCEDURE [dbo].[DelListPedidoWebDetalleValAuto]
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @PedidoWebAccionesPROLID bigint;

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
		
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado, PedidoWebAccionesPROLID)
	select PWDV.PedidoID,0,PWDV.ConsultoraID,PWDV.CampaniaID,PWDV.CUV,401,@FechaGeneral,PWDV.Cantidad,PWDV.PrecioUnidad,PWDV.FechaCreacion,0,PWAP.PedidoWebAccionesPROLID
	from @PedidoWebDetalleValAuto PWDV
	inner join PedidoWebAccionesPROL PWAP on PWDV.PedidoID = PWAP.PedidoID and PWDV.PedidoDetalleID = PWAP.PedidoDetalleID 
						and PWDV.ValAutomaticaPROLLogId = PWAP.ValAutomaticaPROLLogId
GO


USE [BelcorpColombia]
GO
ALTER PROCEDURE [dbo].[DelListPedidoWebDetalleValAuto]
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @PedidoWebAccionesPROLID bigint;

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
		
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado, PedidoWebAccionesPROLID)
	select PWDV.PedidoID,0,PWDV.ConsultoraID,PWDV.CampaniaID,PWDV.CUV,401,@FechaGeneral,PWDV.Cantidad,PWDV.PrecioUnidad,PWDV.FechaCreacion,0,PWAP.PedidoWebAccionesPROLID
	from @PedidoWebDetalleValAuto PWDV
	inner join PedidoWebAccionesPROL PWAP on PWDV.PedidoID = PWAP.PedidoID and PWDV.PedidoDetalleID = PWAP.PedidoDetalleID 
						and PWDV.ValAutomaticaPROLLogId = PWAP.ValAutomaticaPROLLogId
GO


USE [BelcorpSalvador]
GO
ALTER PROCEDURE [dbo].[DelListPedidoWebDetalleValAuto]
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @PedidoWebAccionesPROLID bigint;

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
		
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado, PedidoWebAccionesPROLID)
	select PWDV.PedidoID,0,PWDV.ConsultoraID,PWDV.CampaniaID,PWDV.CUV,401,@FechaGeneral,PWDV.Cantidad,PWDV.PrecioUnidad,PWDV.FechaCreacion,0,PWAP.PedidoWebAccionesPROLID
	from @PedidoWebDetalleValAuto PWDV
	inner join PedidoWebAccionesPROL PWAP on PWDV.PedidoID = PWAP.PedidoID and PWDV.PedidoDetalleID = PWAP.PedidoDetalleID 
						and PWDV.ValAutomaticaPROLLogId = PWAP.ValAutomaticaPROLLogId
GO


USE [BelcorpPuertoRico]
GO
ALTER PROCEDURE [dbo].[DelListPedidoWebDetalleValAuto]
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @PedidoWebAccionesPROLID bigint;

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
		
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado, PedidoWebAccionesPROLID)
	select PWDV.PedidoID,0,PWDV.ConsultoraID,PWDV.CampaniaID,PWDV.CUV,401,@FechaGeneral,PWDV.Cantidad,PWDV.PrecioUnidad,PWDV.FechaCreacion,0,PWAP.PedidoWebAccionesPROLID
	from @PedidoWebDetalleValAuto PWDV
	inner join PedidoWebAccionesPROL PWAP on PWDV.PedidoID = PWAP.PedidoID and PWDV.PedidoDetalleID = PWAP.PedidoDetalleID 
						and PWDV.ValAutomaticaPROLLogId = PWAP.ValAutomaticaPROLLogId
GO


USE [BelcorpPanama]
GO
ALTER PROCEDURE [dbo].[DelListPedidoWebDetalleValAuto]
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @PedidoWebAccionesPROLID bigint;

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
		
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado, PedidoWebAccionesPROLID)
	select PWDV.PedidoID,0,PWDV.ConsultoraID,PWDV.CampaniaID,PWDV.CUV,401,@FechaGeneral,PWDV.Cantidad,PWDV.PrecioUnidad,PWDV.FechaCreacion,0,PWAP.PedidoWebAccionesPROLID
	from @PedidoWebDetalleValAuto PWDV
	inner join PedidoWebAccionesPROL PWAP on PWDV.PedidoID = PWAP.PedidoID and PWDV.PedidoDetalleID = PWAP.PedidoDetalleID 
						and PWDV.ValAutomaticaPROLLogId = PWAP.ValAutomaticaPROLLogId
GO


USE [BelcorpGuatemala]
GO
ALTER PROCEDURE [dbo].[DelListPedidoWebDetalleValAuto]
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @PedidoWebAccionesPROLID bigint;

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
		
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado, PedidoWebAccionesPROLID)
	select PWDV.PedidoID,0,PWDV.ConsultoraID,PWDV.CampaniaID,PWDV.CUV,401,@FechaGeneral,PWDV.Cantidad,PWDV.PrecioUnidad,PWDV.FechaCreacion,0,PWAP.PedidoWebAccionesPROLID
	from @PedidoWebDetalleValAuto PWDV
	inner join PedidoWebAccionesPROL PWAP on PWDV.PedidoID = PWAP.PedidoID and PWDV.PedidoDetalleID = PWAP.PedidoDetalleID 
						and PWDV.ValAutomaticaPROLLogId = PWAP.ValAutomaticaPROLLogId
GO


USE [BelcorpEcuador]
GO
ALTER PROCEDURE [dbo].[DelListPedidoWebDetalleValAuto]
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @PedidoWebAccionesPROLID bigint;

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
		
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado, PedidoWebAccionesPROLID)
	select PWDV.PedidoID,0,PWDV.ConsultoraID,PWDV.CampaniaID,PWDV.CUV,401,@FechaGeneral,PWDV.Cantidad,PWDV.PrecioUnidad,PWDV.FechaCreacion,0,PWAP.PedidoWebAccionesPROLID
	from @PedidoWebDetalleValAuto PWDV
	inner join PedidoWebAccionesPROL PWAP on PWDV.PedidoID = PWAP.PedidoID and PWDV.PedidoDetalleID = PWAP.PedidoDetalleID 
						and PWDV.ValAutomaticaPROLLogId = PWAP.ValAutomaticaPROLLogId
GO


USE [BelcorpDominicana]
GO
ALTER PROCEDURE [dbo].[DelListPedidoWebDetalleValAuto]
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @PedidoWebAccionesPROLID bigint;

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
		
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado, PedidoWebAccionesPROLID)
	select PWDV.PedidoID,0,PWDV.ConsultoraID,PWDV.CampaniaID,PWDV.CUV,401,@FechaGeneral,PWDV.Cantidad,PWDV.PrecioUnidad,PWDV.FechaCreacion,0,PWAP.PedidoWebAccionesPROLID
	from @PedidoWebDetalleValAuto PWDV
	inner join PedidoWebAccionesPROL PWAP on PWDV.PedidoID = PWAP.PedidoID and PWDV.PedidoDetalleID = PWAP.PedidoDetalleID 
						and PWDV.ValAutomaticaPROLLogId = PWAP.ValAutomaticaPROLLogId
GO


USE [BelcorpCostaRica]
GO
ALTER PROCEDURE [dbo].[DelListPedidoWebDetalleValAuto]
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @PedidoWebAccionesPROLID bigint;

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
		
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado, PedidoWebAccionesPROLID)
	select PWDV.PedidoID,0,PWDV.ConsultoraID,PWDV.CampaniaID,PWDV.CUV,401,@FechaGeneral,PWDV.Cantidad,PWDV.PrecioUnidad,PWDV.FechaCreacion,0,PWAP.PedidoWebAccionesPROLID
	from @PedidoWebDetalleValAuto PWDV
	inner join PedidoWebAccionesPROL PWAP on PWDV.PedidoID = PWAP.PedidoID and PWDV.PedidoDetalleID = PWAP.PedidoDetalleID 
						and PWDV.ValAutomaticaPROLLogId = PWAP.ValAutomaticaPROLLogId
GO


USE [BelcorpChile]
GO
ALTER PROCEDURE [dbo].[DelListPedidoWebDetalleValAuto]
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @PedidoWebAccionesPROLID bigint;

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
		
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado, PedidoWebAccionesPROLID)
	select PWDV.PedidoID,0,PWDV.ConsultoraID,PWDV.CampaniaID,PWDV.CUV,401,@FechaGeneral,PWDV.Cantidad,PWDV.PrecioUnidad,PWDV.FechaCreacion,0,PWAP.PedidoWebAccionesPROLID
	from @PedidoWebDetalleValAuto PWDV
	inner join PedidoWebAccionesPROL PWAP on PWDV.PedidoID = PWAP.PedidoID and PWDV.PedidoDetalleID = PWAP.PedidoDetalleID 
						and PWDV.ValAutomaticaPROLLogId = PWAP.ValAutomaticaPROLLogId
GO


USE [BelcorpBolivia]
GO
ALTER PROCEDURE [dbo].[DelListPedidoWebDetalleValAuto]
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS  
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @PedidoWebAccionesPROLID bigint;

	insert into PedidoWebAccionesPROL(CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,FechaAccion,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen)
	select CampaniaID,PedidoID,PedidoDetalleID,ConsultoraID,CUV,Cantidad,PrecioUnidad,Tipo,Accion,@FechaGeneral,MensajePROL,ValAutomaticaPROLLogId,CodigoObservacion,TipoOrigen
	from @PedidoWebDetalleValAuto;
		
	delete PWD
	from dbo.PedidoWebDetalle PWD
	inner join @PedidoWebDetalleValAuto PWDVA on
		PWD.CampaniaID = PWDVA.CampaniaID and 
		PWD.PedidoID = PWDVA.PedidoID and 
		PWD.PedidoDetalleID = PWDVA.PedidoDetalleID;
  
	insert into PedidoWebDetalleSeguimiento(PedidoID,MarcaID,ConsultoraID,CampaniaID,CUV,AccionId,FechaAccion,Cantidad,PrecioUnidad,FechaCreacion,ItemValidado, PedidoWebAccionesPROLID)
	select PWDV.PedidoID,0,PWDV.ConsultoraID,PWDV.CampaniaID,PWDV.CUV,401,@FechaGeneral,PWDV.Cantidad,PWDV.PrecioUnidad,PWDV.FechaCreacion,0,PWAP.PedidoWebAccionesPROLID
	from @PedidoWebDetalleValAuto PWDV
	inner join PedidoWebAccionesPROL PWAP on PWDV.PedidoID = PWAP.PedidoID and PWDV.PedidoDetalleID = PWAP.PedidoDetalleID 
						and PWDV.ValAutomaticaPROLLogId = PWAP.ValAutomaticaPROLLogId
GO


