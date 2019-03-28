GO
USE BelcorpPeru
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
USE BelcorpMexico
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
USE BelcorpColombia
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
USE BelcorpSalvador
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
USE BelcorpPuertoRico
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
USE BelcorpPanama
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
USE BelcorpGuatemala
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
USE BelcorpEcuador
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
USE BelcorpDominicana
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
USE BelcorpCostaRica
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
USE BelcorpChile
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
USE BelcorpBolivia
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
