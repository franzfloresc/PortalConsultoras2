USE BelcorpBolivia
GO
IF OBJECT_ID('dbo.ClearPedidoWebPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.ClearPedidoWebPedidoSapId
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
alter procedure UpdateMontosPedidoWeb_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MontoAhorroCatalogo money,
	@MontoAhorroRevista money,
	@MontoDescuento money,
	@MontoEscala money
as
begin
	update PedidoWeb 
	set
		MontoAhorroCatalogo = @MontoAhorroCatalogo,
		MontoAhorroRevista = @MontoAhorroRevista,
		DescuentoProl = @MontoDescuento,
		MontoEscala = @MontoEscala
	where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;
end
GO
/*end*/

USE BelcorpChile
GO
IF OBJECT_ID('dbo.ClearPedidoWebPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.ClearPedidoWebPedidoSapId
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
alter procedure UpdateMontosPedidoWeb_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MontoAhorroCatalogo money,
	@MontoAhorroRevista money,
	@MontoDescuento money,
	@MontoEscala money
as
begin
	update PedidoWeb 
	set
		MontoAhorroCatalogo = @MontoAhorroCatalogo,
		MontoAhorroRevista = @MontoAhorroRevista,
		DescuentoProl = @MontoDescuento,
		MontoEscala = @MontoEscala
	where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;
end
GO
/*end*/

USE BelcorpColombia
GO
IF OBJECT_ID('dbo.ClearPedidoWebPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.ClearPedidoWebPedidoSapId
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
alter procedure UpdateMontosPedidoWeb_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MontoAhorroCatalogo money,
	@MontoAhorroRevista money,
	@MontoDescuento money,
	@MontoEscala money
as
begin
	update PedidoWeb 
	set
		MontoAhorroCatalogo = @MontoAhorroCatalogo,
		MontoAhorroRevista = @MontoAhorroRevista,
		DescuentoProl = @MontoDescuento,
		MontoEscala = @MontoEscala
	where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;
end
GO
/*end*/

USE BelcorpCostaRica
GO
IF OBJECT_ID('dbo.ClearPedidoWebPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.ClearPedidoWebPedidoSapId
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
alter procedure UpdateMontosPedidoWeb_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MontoAhorroCatalogo money,
	@MontoAhorroRevista money,
	@MontoDescuento money,
	@MontoEscala money
as
begin
	update PedidoWeb 
	set
		MontoAhorroCatalogo = @MontoAhorroCatalogo,
		MontoAhorroRevista = @MontoAhorroRevista,
		DescuentoProl = @MontoDescuento,
		MontoEscala = @MontoEscala
	where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;
end
GO
/*end*/

USE BelcorpDominicana
GO
IF OBJECT_ID('dbo.ClearPedidoWebPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.ClearPedidoWebPedidoSapId
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
alter procedure UpdateMontosPedidoWeb_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MontoAhorroCatalogo money,
	@MontoAhorroRevista money,
	@MontoDescuento money,
	@MontoEscala money
as
begin
	update PedidoWeb 
	set
		MontoAhorroCatalogo = @MontoAhorroCatalogo,
		MontoAhorroRevista = @MontoAhorroRevista,
		DescuentoProl = @MontoDescuento,
		MontoEscala = @MontoEscala
	where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;
end
GO
/*end*/

USE BelcorpEcuador
GO
IF OBJECT_ID('dbo.ClearPedidoWebPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.ClearPedidoWebPedidoSapId
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
alter procedure UpdateMontosPedidoWeb_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MontoAhorroCatalogo money,
	@MontoAhorroRevista money,
	@MontoDescuento money,
	@MontoEscala money
as
begin
	update PedidoWeb 
	set
		MontoAhorroCatalogo = @MontoAhorroCatalogo,
		MontoAhorroRevista = @MontoAhorroRevista,
		DescuentoProl = @MontoDescuento,
		MontoEscala = @MontoEscala
	where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;
end
GO
/*end*/

USE BelcorpGuatemala
GO
IF OBJECT_ID('dbo.ClearPedidoWebPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.ClearPedidoWebPedidoSapId
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
alter procedure UpdateMontosPedidoWeb_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MontoAhorroCatalogo money,
	@MontoAhorroRevista money,
	@MontoDescuento money,
	@MontoEscala money
as
begin
	update PedidoWeb 
	set
		MontoAhorroCatalogo = @MontoAhorroCatalogo,
		MontoAhorroRevista = @MontoAhorroRevista,
		DescuentoProl = @MontoDescuento,
		MontoEscala = @MontoEscala
	where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;
end
GO
/*end*/

USE BelcorpMexico
GO
IF OBJECT_ID('dbo.ClearPedidoWebPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.ClearPedidoWebPedidoSapId
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
alter procedure UpdateMontosPedidoWeb_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MontoAhorroCatalogo money,
	@MontoAhorroRevista money,
	@MontoDescuento money,
	@MontoEscala money
as
begin
	update PedidoWeb 
	set
		MontoAhorroCatalogo = @MontoAhorroCatalogo,
		MontoAhorroRevista = @MontoAhorroRevista,
		DescuentoProl = @MontoDescuento,
		MontoEscala = @MontoEscala
	where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;
end
GO
/*end*/

USE BelcorpPanama
GO
IF OBJECT_ID('dbo.ClearPedidoWebPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.ClearPedidoWebPedidoSapId
END
GO
ALTER PROCEDURE [dbo].[GetPedidoWebByFechaFacturacion_SB2] --'2014-06-05',1,1
	@FechaFacturacion date,
	@TipoCronograma int,
	@NroLote int
as
BEGIN
	set nocount on;

	declare @Tipo smallint
	if @TipoCronograma = 1
		set @Tipo = (select isnull(ProcesoRegular,0) from [dbo].[ConfiguracionValidacion])
	else if @TipoCronograma = 2
		set @Tipo = (select isnull(ProcesoDA,0) from [dbo].[ConfiguracionValidacion])
	else
		set @Tipo = (select isnull(ProcesoDAPRD,0) from [dbo].[ConfiguracionValidacion])

	if @TipoCronograma = 1
	begin

		declare @ConfValZonaTemp table
		(
			Campaniaid int,
			Regionid int,
			Zonaid int,
			FechaInicioFacturacion smalldatetime,
			FechaFinFacturacion smalldatetime
		)

		insert into @ConfValZonaTemp
		select	cr.campaniaid, cr.regionid, cr.zonaid, cr.FechaInicioFacturacion,
				cr.FechaInicioFacturacion + isnull(cz.DiasDuracionCronograma,1) - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(cr.ZonaID, cz.DiasDuracionCronograma, cr.FechaInicioFacturacion),0)
		from	ods.Cronograma cr with(nolock)
		left join ConfiguracionValidacionZona cz with(nolock) on cr.zonaid = cz.zonaid
		where	cr.FechaInicioFacturacion <= @FechaFacturacion and
				cr.FechaInicioFacturacion + 10 >= @FechaFacturacion
		insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
		select @NroLote, p.CampaniaID, p.PedidoID
		from dbo.PedidoWeb p with(nolock)
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
		join @ConfValZonaTemp cr on ca.CampaniaID = cr.CampaniaID
				and c.RegionID = cr.RegionID
				and c.ZonaID = cr.ZonaID
		join (
			select CampaniaID, PedidoID
			from dbo.PedidoWebDetalle with(nolock)
			where isnull(EsKitNueva, '0') != 1
			group by CampaniaID, PedidoID
		) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
		where cr.FechaInicioFacturacion <= @FechaFacturacion
			and cr.FechaFinFacturacion >= @FechaFacturacion
			and p.IndicadorEnviado = 0
			and p.Bloqueado = 0
			--and exists(select * from dbo.PedidoWebDetalle where CampaniaID = p.CampaniaID
			--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
			and c.zonaid not in (select Zonaid
								 from cronograma
								 where CampaniaID = ca.CampaniaID)
			and (@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,202,201));
	end
	else
		insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
		select @NroLote, p.CampaniaID, p.PedidoID
		from dbo.PedidoWeb p with(nolock)
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
		join dbo.Cronograma cr with(nolock) on ca.CampaniaID = cr.CampaniaID
				and c.RegionID = cr.RegionID
				and c.ZonaID = cr.ZonaID
		join (
			select CampaniaID, PedidoID
			from dbo.PedidoWebDetalle with(nolock)
			where isnull(EsKitNueva, '0') != 1
			group by CampaniaID, PedidoID
		) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
		where cr.FechaInicioWeb <= @FechaFacturacion
			and cr.FechaFinWeb >= @FechaFacturacion
			and p.IndicadorEnviado = 0
			and p.Bloqueado = 0
			--and exists(select * from dbo.PedidoWebDetalle where CampaniaID = p.CampaniaID
			--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)

			and (@Tipo = 0 OR @Tipo = IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,202,201));
			
       --**********************************Cupon***********************************
	   declare @tiene_cupon_pais bit 
	   set @tiene_cupon_pais = (select tieneCupon From Pais With (nolock) Where EstadoActivo = 1)
	   
       create table #pedido_cupon(CampaniaID int,pedidoId int,CuponID int,CodigoConsultora varchar(25),TipoCupon char(2),ValorCupon Char(12))    
       create index #pedido_cupon_idx_2 on #pedido_cupon(CampaniaID,PedidoID)   
          
        if @tiene_cupon_pais = 1 
        begin  
			 select 
                    p.PedidoID,
                    p.CampaniaID,
                    c.Codigo as CodigoConsultora
             into #temp
			 from dbo.PedidoWeb p with(nolock)
			 inner join dbo.TempPedidoWebID  pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
             inner join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID and isnull(pd.EsKitNueva, '0') != 1
             inner join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
             inner join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
			 inner join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
             where pk.NroLote = @NroLote
             group by p.CampaniaID, p.PedidoID, c.Codigo
             having sum(pd.Cantidad) > 0;
 
          insert into #pedido_cupon(CampaniaID,pedidoId,CuponID,CodigoConsultora,TipoCupon,ValorCupon)   
          select Distinct   
              pedido.CampaniaID,   
              pedido.PedidoID,   
              Cupon.CuponID,   
              CodigoConsultora = CuponConsultora.CodigoConsultora,   
            TipoCupon = right('00' + RTrim(Ltrim(Convert(varchar,Cupon.Tipo))),2), 
            ValorCupon = right('000000000000' + replace(RTrim(Ltrim(Convert(varchar,CuponConsultora.ValorAsociado))),'.',''),12) 
         From #temp pedido 
          Inner join Cupon with (nolock) On  
                    pedido.CampaniaId = Cupon.CampaniaId And  
                    Cupon.Estado = 1   
          Inner join CuponConsultora with (nolock) On       
                    Cupon.CuponID = CuponConsultora.CuponID And  
                    Cupon.CampaniaId = CuponConsultora.CampaniaId And  
                    pedido.CodigoConsultora = CuponConsultora.CodigoConsultora And  
                    CuponConsultora.EstadoCupon = 2
            
            drop table #temp
       End  
       --**********************************Cupon ***********************************			
			
	-- Cabecera de pedidos para descarga
	select
		p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
		p.Clientes, r.Codigo as CodigoRegion,
		z.Codigo as CodigoZona,
		IIF(p.EstadoPedido = 202 AND p.ValidacionAbierta = 0,1,0) as Validado,
		p.IPUsuario,
		TipoCupon = isnull(pc.TipoCupon,'00') ,
		ValorCupon = isnull(pc.ValorCupon,'000000000000')			
	from dbo.PedidoWeb p with(nolock)
		join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join ods.Region r with(nolock) on c.RegionID = r.RegionID
		join ods.Zona z with(nolock) on c.RegionID = z.RegionID and c.ZonaID = z.ZonaID
		left join #pedido_cupon pc on pc.CampaniaID = p.CampaniaID and pc.PedidoID = p.PedidoID --Cupon
	where pk.NroLote = @NroLote
	order by p.CampaniaID, p.PedidoID;

	-- Detalle de pedidos para descarga
	select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
		pd.CUV as CodigoVenta, pr.CodigoProducto,
		/*case when p.EstadoPedido = 202 and pr.IndicadorDigitable = 1
			then pr.FactorRepeticion * sum(pd.Cantidad)
			else sum(pd.Cantidad) end as Cantidad*/
			sum(pd.Cantidad) as Cantidad,
			pd.OrigenPedidoWeb
	from dbo.PedidoWeb p with(nolock)
		join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
		join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID
		and isnull(pd.EsKitNueva, '0') != 1
		join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
		join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
	where pk.NroLote = @NroLote and pd.PedidoDetalleIDPadre is null
	group by p.CampaniaID, p.PedidoID, c.Codigo, pd.CUV, pr.CodigoProducto, pd.OrigenPedidoWeb
	having sum(pd.Cantidad) > 0
	order by CampaniaID, PedidoID, CodigoVenta;
	
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
alter procedure UpdateMontosPedidoWeb_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MontoAhorroCatalogo money,
	@MontoAhorroRevista money,
	@MontoDescuento money,
	@MontoEscala money
as
begin
	update PedidoWeb 
	set
		MontoAhorroCatalogo = @MontoAhorroCatalogo,
		MontoAhorroRevista = @MontoAhorroRevista,
		DescuentoProl = @MontoDescuento,
		MontoEscala = @MontoEscala
	where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;
end
GO
/*end*/

USE BelcorpPeru
GO
IF OBJECT_ID('dbo.ClearPedidoWebPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.ClearPedidoWebPedidoSapId
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
alter procedure UpdateMontosPedidoWeb_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MontoAhorroCatalogo money,
	@MontoAhorroRevista money,
	@MontoDescuento money,
	@MontoEscala money
as
begin
	update PedidoWeb 
	set
		MontoAhorroCatalogo = @MontoAhorroCatalogo,
		MontoAhorroRevista = @MontoAhorroRevista,
		DescuentoProl = @MontoDescuento,
		MontoEscala = @MontoEscala
	where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;
end
GO
/*end*/

USE BelcorpPuertoRico
GO
IF OBJECT_ID('dbo.ClearPedidoWebPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.ClearPedidoWebPedidoSapId
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
alter procedure UpdateMontosPedidoWeb_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MontoAhorroCatalogo money,
	@MontoAhorroRevista money,
	@MontoDescuento money,
	@MontoEscala money
as
begin
	update PedidoWeb 
	set
		MontoAhorroCatalogo = @MontoAhorroCatalogo,
		MontoAhorroRevista = @MontoAhorroRevista,
		DescuentoProl = @MontoDescuento,
		MontoEscala = @MontoEscala
	where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;
end
GO
/*end*/

USE BelcorpSalvador
GO
IF OBJECT_ID('dbo.ClearPedidoWebPedidoSapId') IS NOT NULL
BEGIN
	drop procedure dbo.ClearPedidoWebPedidoSapId
END
GO
declare @TablaLogicaID smallint = 5;
declare @TablaLogicaDescripcion varchar(30) = 'Codigo Observacion Prol';

IF NOT EXISTS(SELECT 1 FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID)
BEGIN
	INSERT TablaLogica(TablaLogicaID,Descripcion)
	VALUES (@TablaLogicaID,@TablaLogicaDescripcion);
END

IF (@TablaLogicaDescripcion = (SELECT Descripcion FROM TablaLogica WHERE TablaLogicaID = @TablaLogicaID))
BEGIN
	delete from TablaLogicaDatos
	where TablaLogicaID = @TablaLogicaID;

	insert TablaLogicaDatos(TablaLogicaDatosID,TablaLogicaID,Codigo,Descripcion)
	select
		TablaLogicaID * 100 + 10 + row_number() over(order by TablaLogicaID),
		TablaLogicaID,
		Codigo,
		Descripcion
	from(
		select
			@TablaLogicaID as TablaLogicaID,
			Codigo,
			Descripcion
		from(values
			('Deuda', 'Lo sentimos, tienes una deuda de {simb} {deuMon}. Te invitamos a cancelar el saldo pendiente y reservar tu pedido para que sea facturado exitosamente.'),
			('MontoMaximo', 'Lo sentimos, has superado el límite de tu línea de crédito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con éxito.'),
			('MontoMinimoVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinimoFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('LimiteVenta', 'Sólo puedes pedir un máximo de {limVen} unidades del producto {detCuv} en esta campaña. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condición que aparece en el catálogo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturará debido a que no cumples con la condición para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} está agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} está agotado.'),
			('SinStock', 'Por el momento sólo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se eliminó  el producto {detCuv} porque sólo puedes pedir un máximo de {limVen} unidades en la campaña actual. Ingresa nuevamente el código con las unidades correctas.'),
			('AutoPromocion2003', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),			
			('AutoPromocion', 'Se eliminó el producto {detCuv} - por no cumplir la condición que aparece en el catálogo.'),
			('AutoReemplazo', 'El producto {detCuv} está agotado - se reemplazó por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se eliminó el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se eliminó porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperará la siguiente campaña.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO
IF OBJECT_ID('dbo.UpdPedidoWebReserva') IS NOT NULL
BEGIN
	drop procedure dbo.UpdPedidoWebReserva
END
GO
create proc dbo.UpdPedidoWebReserva
	@CampaniaID int,
	@PedidoID int,
	@CodigoUsuarioModificacion varchar(25),
	@MontoTotalProl money,
	--@MontoDescuento money,
	--@MontoAhorroCatalogo money,
	--@MontoAhorroRevista money,
	--@MontoEscala money,
	@EstimadoGanancia money,
	@EstadoPedido smallint,
	@PedidoSapId bigint,
	@VersionProl tinyint
as
begin
	declare @FechaGeneral datetime = dbo.fnObtenerFechaHoraPais();
	declare @ModificaPedidoReservadoDetalle bit = iif(@EstadoPedido = 201, 0, 1);

	update PedidoWebDetalle
	set ModificaPedidoReservado = @ModificaPedidoReservadoDetalle
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID

	update PedidoWeb 
	set
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = @FechaGeneral,
		MontoTotalProl = @MontoTotalProl,
		--DescuentoProl = @MontoDescuento,
		--MontoAhorroCatalogo = @MontoAhorroCatalogo,
		--MontoAhorroRevista = @MontoAhorroRevista,
		--MontoEscala = @MontoEscala,
		EstimadoGanancia = @EstimadoGanancia,
		FechaReserva = @FechaGeneral,
		EstadoPedido = @EstadoPedido,
		ValidacionAbierta = 0,
		ModificaPedidoReservado = 0,
		PedidoSapId = iif(@PedidoSapId = 0, PedidoSapId, @PedidoSapId),
		VersionProl = @VersionProl
	where CampaniaID = @CampaniaID AND PedidoID = @PedidoID;
end
GO
alter procedure UpdateMontosPedidoWeb_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MontoAhorroCatalogo money,
	@MontoAhorroRevista money,
	@MontoDescuento money,
	@MontoEscala money
as
begin
	update PedidoWeb 
	set
		MontoAhorroCatalogo = @MontoAhorroCatalogo,
		MontoAhorroRevista = @MontoAhorroRevista,
		DescuentoProl = @MontoDescuento,
		MontoEscala = @MontoEscala
	where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID;
end
GO