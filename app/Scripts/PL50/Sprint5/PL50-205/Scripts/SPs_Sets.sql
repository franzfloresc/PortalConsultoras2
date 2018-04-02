IF OBJECT_ID('dbo.PedidoWebSet_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Select
GO
CREATE PROCEDURE PedidoWebSet_Select @SetId INT
AS
BEGIN
	SELECT SetID
		,PedidoID
		,CuvSet
		,EstrategiaId
		,NombreSet
		,Cantidad
		,PrecioUnidad
		,ImporteTotal
		,TipoEstrategiaId
		,Campania
		,ConsultoraID
		,OrdenPedido
		,CodigoUsuarioCreacion
		,CodigoUsuarioModificacion
		,FechaCreacion
		,FechaModificacion
	FROM PedidoWebSet
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSetDetalle_Select', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSetDetalle_Select
GO
CREATE PROCEDURE PedidoWebSetDetalle_Select @SetId INT
AS
BEGIN
	SELECT SetDetalleID
		,SetID
		,CuvProducto
		,NombreProducto
		,Cantidad
		,CantidadOriginal
		,FactorRepeticion
		,PedidoDetalleID
		,PrecioUnidad
		,TipoOfertaSisID
	FROM PedidoWebSetDetalle
	WHERE SetId = @SetId
END
GO

IF OBJECT_ID('dbo.PedidoWebSet_Eliminar', 'P') IS NOT NULL
	DROP PROC dbo.PedidoWebSet_Eliminar
GO
CREATE PROCEDURE PedidoWebSet_Eliminar @SetId INT
AS
BEGIN
	BEGIN TRAN

	BEGIN TRY
		DELETE
		FROM PedidoWebSetDetalle
		WHERE SetId = @SetId

		DELETE
		FROM PedidoWebSet
		WHERE SetId = @setID

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
	END CATCH
END
