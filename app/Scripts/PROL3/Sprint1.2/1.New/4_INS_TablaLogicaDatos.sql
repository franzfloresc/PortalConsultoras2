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
			('MontoMinVenta', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para completarlo.'),
			('MontoMinFact', 'Tu pedido debe cumplir con el Pedido Mínimo de {simb} {minMon}, añade otros productos a tu pedido para ser reservado y facturado.'),
			('MontoMinVentaDesc', 'Tu pedido no cumple con el monto mínimo de {simb} {minMon} ya que se realizó un descuento de {simb} {descMon} para las ofertas con más de un precio que escogiste. Agrega otros productos a tu pedido para completarlo.'),
			('MontoMinFactDesc', 'Tu pedido no cumple con el monto mínimo de {simb} {minMon} ya que se realizó un descuento de {simb} {descMon} para las ofertas con más de un precio que escogiste. Agrega otros productos a tu pedido para reservado y facturado.'),
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