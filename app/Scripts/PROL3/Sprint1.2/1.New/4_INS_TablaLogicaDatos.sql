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
			('MontoMaximo', 'Lo sentimos, has superado el l�mite de tu l�nea de cr�dito de {simb} {maxMon}. Por favor, modifica tu pedido para que sea guardado con �xito.'),
			('MontoMinVenta', 'Tu pedido debe cumplir con el Pedido M�nimo de {simb} {minMon}, a�ade otros productos a tu pedido para completarlo.'),
			('MontoMinFact', 'Tu pedido debe cumplir con el Pedido M�nimo de {simb} {minMon}, a�ade otros productos a tu pedido para ser reservado y facturado.'),
			('MontoMinVentaDesc', 'Tu pedido no cumple con el monto m�nimo de {simb} {minMon} ya que se realiz� un descuento de {simb} {descMon} para las ofertas con m�s de un precio que escogiste. Agrega otros productos a tu pedido para completarlo.'),
			('MontoMinFactDesc', 'Tu pedido no cumple con el monto m�nimo de {simb} {minMon} ya que se realiz� un descuento de {simb} {descMon} para las ofertas con m�s de un precio que escogiste. Agrega otros productos a tu pedido para reservado y facturado.'),
			('LimiteVenta0', 'Lo sentimos, el producto {detCuv} est� agotado.'),
			('LimiteVenta', 'S�lo puedes pedir un m�ximo de {limVen} unidades del producto {detCuv} en esta campa�a. Modifica las unidades ingresadas.'),
			('Promocion2003', 'Recuerda que debes cumplir con la condici�n que aparece en el cat�logo para pedir el producto {detCuv}.'),
			('Promocion', 'Este producto ({detCuv}) NO se facturar� debido a que no cumples con la condici�n para adquirirlo. Por favor revisa las condiciones requeridas.'),
			('Reemplazo', 'Lo sentimos, el producto {detCuv} est� agotado. Lo hemos reemplazado por el producto {remCuv} - {remDes} que es igual o similar.'),
			('SinStock0', 'Lo sentimos, el producto {detCuv} est� agotado.'),
			('SinStock', 'Por el momento s�lo contamos con {stock} unidades del producto {detCuv}. Modifica las unidades ingresadas.'),
			('AutoLimiteVenta0', 'Se elimin� el producto {detCuv} - por estar agotado.'),
			('AutoLimiteVenta', 'Se elimin�  el producto {detCuv} porque s�lo puedes pedir un m�ximo de {limVen} unidades en la campa�a actual. Ingresa nuevamente el c�digo con las unidades correctas.'),
			('AutoPromocion2003', 'Se elimin� el producto {detCuv} - por no cumplir la condici�n que aparece en el cat�logo.'),			
			('AutoPromocion', 'Se elimin� el producto {detCuv} - por no cumplir la condici�n que aparece en el cat�logo.'),
			('AutoReemplazo', 'El producto {detCuv} est� agotado - se reemplaz� por el producto {remCuv} - {remDes} que es igual o similar.'),			
			('AutoSinStock0', 'Se elimin� el producto {detCuv} - por estar agotado.'),
			('AutoSinStock', 'Se elimin� porque solo contamos con {stock} unidades del producto {detCuv}.')	,
			('AutoBackOrder', 'Se recuperar� la siguiente campa�a.')	
		) Obs1(Codigo,Descripcion)
	)Obs2;
END
GO