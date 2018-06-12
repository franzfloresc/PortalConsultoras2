ALTER PROCEDURE DelListPedidoWebDetalleValAuto
	@PedidoWebDetalleValAuto dbo.PedidoWebDetalleValAutoType readonly
AS
BEGIN
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
END