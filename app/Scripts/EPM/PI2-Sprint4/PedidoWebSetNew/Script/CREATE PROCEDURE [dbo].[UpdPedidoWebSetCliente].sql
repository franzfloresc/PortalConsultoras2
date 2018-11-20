CREATE PROCEDURE [dbo].[UpdPedidoWebSetCliente] @PedidoID INT
	,@ClienteID SMALLINT
	,@CodigoUsuarioModificacion VARCHAR(25) = NULL
	,@SetId INT
AS
BEGIN
	UPDATE pedidowebset
	SET clienteid = @ClienteID
		,codigousuariomodificacion = @CodigoUsuarioModificacion
		,fechamodificacion = GETDATE()
	WHERE setid = @SetId;

	UPDATE pedidowebdetalle
	SET pedidowebdetalle.clienteid = @ClienteID
		,codigousuariomodificacion = @CodigoUsuarioModificacion
		,fechamodificacion = GETDATE()
	FROM pedidowebdetalle
	INNER JOIN pedidowebsetdetalle ON pedidowebdetalle.pedidodetalleid = pedidowebsetdetalle.pedidodetalleid
		AND pedidowebdetalle.pedidoid = @PedidoID
		AND pedidowebsetdetalle.setid = @SetId;
END
