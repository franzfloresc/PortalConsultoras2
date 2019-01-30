USE [BelcorpPeru_BPT]
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[UpdPedidoWebSetCliente]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[UpdPedidoWebSetCliente]
GO


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
GO

USE [BelcorpChile_BPT]
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[UpdPedidoWebSetCliente]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[UpdPedidoWebSetCliente]
GO

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
GO

USE [BelcorpCostaRica_BPT]
GO

IF EXISTS (
	SELECT * FROM sys.objects 
	WHERE object_id = 
	OBJECT_ID(N'[dbo].[UpdPedidoWebSetCliente]') 
	AND type in (N'P', N'PC')
) 
	DROP PROCEDURE [dbo].[UpdPedidoWebSetCliente]
GO

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
GO
