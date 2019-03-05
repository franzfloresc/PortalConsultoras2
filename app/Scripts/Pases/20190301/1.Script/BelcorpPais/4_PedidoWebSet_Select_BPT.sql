GO
USE BelcorpPeru
GO

ALTER PROCEDURE [dbo].[PedidoWebSet_Select]
@SetId INT
AS
BEGIN
	SELECT
		 PWS.SetID
		,PWS.PedidoID
		,PWS.CuvSet
		,PWS.EstrategiaId
		,PWS.Cantidad
		,PWS.PrecioUnidad
		,PWS.ImporteTotal
		,PWS.Campania
		,PWS.ConsultoraID
		,PWS.OrdenPedido
		,PWS.CodigoUsuarioCreacion
		,PWS.CodigoUsuarioModificacion
		,PWS.FechaCreacion
		,PWS.FechaModificacion
		,PWS.ClienteID
		,ClienteNombre = C.NOMBRE
	FROM PedidoWebSet PWS
		LEFT JOIN CLIENTE C ON PWS.ConsultoraID = C.ConsultoraID
			AND PWS.ClienteID = C.ClienteID
	WHERE SetId = @SetId
END


GO
USE BelcorpMexico
GO

ALTER PROCEDURE [dbo].[PedidoWebSet_Select]
@SetId INT
AS
BEGIN
	SELECT
		 PWS.SetID
		,PWS.PedidoID
		,PWS.CuvSet
		,PWS.EstrategiaId
		,PWS.Cantidad
		,PWS.PrecioUnidad
		,PWS.ImporteTotal
		,PWS.Campania
		,PWS.ConsultoraID
		,PWS.OrdenPedido
		,PWS.CodigoUsuarioCreacion
		,PWS.CodigoUsuarioModificacion
		,PWS.FechaCreacion
		,PWS.FechaModificacion
		,PWS.ClienteID
		,ClienteNombre = C.NOMBRE
	FROM PedidoWebSet PWS
		LEFT JOIN CLIENTE C ON PWS.ConsultoraID = C.ConsultoraID
			AND PWS.ClienteID = C.ClienteID
	WHERE SetId = @SetId
END


GO
USE BelcorpColombia
GO

ALTER PROCEDURE [dbo].[PedidoWebSet_Select]
@SetId INT
AS
BEGIN
	SELECT
		 PWS.SetID
		,PWS.PedidoID
		,PWS.CuvSet
		,PWS.EstrategiaId
		,PWS.Cantidad
		,PWS.PrecioUnidad
		,PWS.ImporteTotal
		,PWS.Campania
		,PWS.ConsultoraID
		,PWS.OrdenPedido
		,PWS.CodigoUsuarioCreacion
		,PWS.CodigoUsuarioModificacion
		,PWS.FechaCreacion
		,PWS.FechaModificacion
		,PWS.ClienteID
		,ClienteNombre = C.NOMBRE
	FROM PedidoWebSet PWS
		LEFT JOIN CLIENTE C ON PWS.ConsultoraID = C.ConsultoraID
			AND PWS.ClienteID = C.ClienteID
	WHERE SetId = @SetId
END


GO
USE BelcorpSalvador
GO

ALTER PROCEDURE [dbo].[PedidoWebSet_Select]
@SetId INT
AS
BEGIN
	SELECT
		 PWS.SetID
		,PWS.PedidoID
		,PWS.CuvSet
		,PWS.EstrategiaId
		,PWS.Cantidad
		,PWS.PrecioUnidad
		,PWS.ImporteTotal
		,PWS.Campania
		,PWS.ConsultoraID
		,PWS.OrdenPedido
		,PWS.CodigoUsuarioCreacion
		,PWS.CodigoUsuarioModificacion
		,PWS.FechaCreacion
		,PWS.FechaModificacion
		,PWS.ClienteID
		,ClienteNombre = C.NOMBRE
	FROM PedidoWebSet PWS
		LEFT JOIN CLIENTE C ON PWS.ConsultoraID = C.ConsultoraID
			AND PWS.ClienteID = C.ClienteID
	WHERE SetId = @SetId
END


GO
USE BelcorpPuertoRico
GO

ALTER PROCEDURE [dbo].[PedidoWebSet_Select]
@SetId INT
AS
BEGIN
	SELECT
		 PWS.SetID
		,PWS.PedidoID
		,PWS.CuvSet
		,PWS.EstrategiaId
		,PWS.Cantidad
		,PWS.PrecioUnidad
		,PWS.ImporteTotal
		,PWS.Campania
		,PWS.ConsultoraID
		,PWS.OrdenPedido
		,PWS.CodigoUsuarioCreacion
		,PWS.CodigoUsuarioModificacion
		,PWS.FechaCreacion
		,PWS.FechaModificacion
		,PWS.ClienteID
		,ClienteNombre = C.NOMBRE
	FROM PedidoWebSet PWS
		LEFT JOIN CLIENTE C ON PWS.ConsultoraID = C.ConsultoraID
			AND PWS.ClienteID = C.ClienteID
	WHERE SetId = @SetId
END


GO
USE BelcorpPanama
GO

ALTER PROCEDURE [dbo].[PedidoWebSet_Select]
@SetId INT
AS
BEGIN
	SELECT
		 PWS.SetID
		,PWS.PedidoID
		,PWS.CuvSet
		,PWS.EstrategiaId
		,PWS.Cantidad
		,PWS.PrecioUnidad
		,PWS.ImporteTotal
		,PWS.Campania
		,PWS.ConsultoraID
		,PWS.OrdenPedido
		,PWS.CodigoUsuarioCreacion
		,PWS.CodigoUsuarioModificacion
		,PWS.FechaCreacion
		,PWS.FechaModificacion
		,PWS.ClienteID
		,ClienteNombre = C.NOMBRE
	FROM PedidoWebSet PWS
		LEFT JOIN CLIENTE C ON PWS.ConsultoraID = C.ConsultoraID
			AND PWS.ClienteID = C.ClienteID
	WHERE SetId = @SetId
END


GO
USE BelcorpGuatemala
GO

ALTER PROCEDURE [dbo].[PedidoWebSet_Select]
@SetId INT
AS
BEGIN
	SELECT
		 PWS.SetID
		,PWS.PedidoID
		,PWS.CuvSet
		,PWS.EstrategiaId
		,PWS.Cantidad
		,PWS.PrecioUnidad
		,PWS.ImporteTotal
		,PWS.Campania
		,PWS.ConsultoraID
		,PWS.OrdenPedido
		,PWS.CodigoUsuarioCreacion
		,PWS.CodigoUsuarioModificacion
		,PWS.FechaCreacion
		,PWS.FechaModificacion
		,PWS.ClienteID
		,ClienteNombre = C.NOMBRE
	FROM PedidoWebSet PWS
		LEFT JOIN CLIENTE C ON PWS.ConsultoraID = C.ConsultoraID
			AND PWS.ClienteID = C.ClienteID
	WHERE SetId = @SetId
END


GO
USE BelcorpEcuador
GO

ALTER PROCEDURE [dbo].[PedidoWebSet_Select]
@SetId INT
AS
BEGIN
	SELECT
		 PWS.SetID
		,PWS.PedidoID
		,PWS.CuvSet
		,PWS.EstrategiaId
		,PWS.Cantidad
		,PWS.PrecioUnidad
		,PWS.ImporteTotal
		,PWS.Campania
		,PWS.ConsultoraID
		,PWS.OrdenPedido
		,PWS.CodigoUsuarioCreacion
		,PWS.CodigoUsuarioModificacion
		,PWS.FechaCreacion
		,PWS.FechaModificacion
		,PWS.ClienteID
		,ClienteNombre = C.NOMBRE
	FROM PedidoWebSet PWS
		LEFT JOIN CLIENTE C ON PWS.ConsultoraID = C.ConsultoraID
			AND PWS.ClienteID = C.ClienteID
	WHERE SetId = @SetId
END


GO
USE BelcorpDominicana
GO

ALTER PROCEDURE [dbo].[PedidoWebSet_Select]
@SetId INT
AS
BEGIN
	SELECT
		 PWS.SetID
		,PWS.PedidoID
		,PWS.CuvSet
		,PWS.EstrategiaId
		,PWS.Cantidad
		,PWS.PrecioUnidad
		,PWS.ImporteTotal
		,PWS.Campania
		,PWS.ConsultoraID
		,PWS.OrdenPedido
		,PWS.CodigoUsuarioCreacion
		,PWS.CodigoUsuarioModificacion
		,PWS.FechaCreacion
		,PWS.FechaModificacion
		,PWS.ClienteID
		,ClienteNombre = C.NOMBRE
	FROM PedidoWebSet PWS
		LEFT JOIN CLIENTE C ON PWS.ConsultoraID = C.ConsultoraID
			AND PWS.ClienteID = C.ClienteID
	WHERE SetId = @SetId
END


GO
USE BelcorpCostaRica
GO

ALTER PROCEDURE [dbo].[PedidoWebSet_Select]
@SetId INT
AS
BEGIN
	SELECT
		 PWS.SetID
		,PWS.PedidoID
		,PWS.CuvSet
		,PWS.EstrategiaId
		,PWS.Cantidad
		,PWS.PrecioUnidad
		,PWS.ImporteTotal
		,PWS.Campania
		,PWS.ConsultoraID
		,PWS.OrdenPedido
		,PWS.CodigoUsuarioCreacion
		,PWS.CodigoUsuarioModificacion
		,PWS.FechaCreacion
		,PWS.FechaModificacion
		,PWS.ClienteID
		,ClienteNombre = C.NOMBRE
	FROM PedidoWebSet PWS
		LEFT JOIN CLIENTE C ON PWS.ConsultoraID = C.ConsultoraID
			AND PWS.ClienteID = C.ClienteID
	WHERE SetId = @SetId
END


GO
USE BelcorpChile
GO

ALTER PROCEDURE [dbo].[PedidoWebSet_Select]
@SetId INT
AS
BEGIN
	SELECT
		 PWS.SetID
		,PWS.PedidoID
		,PWS.CuvSet
		,PWS.EstrategiaId
		,PWS.Cantidad
		,PWS.PrecioUnidad
		,PWS.ImporteTotal
		,PWS.Campania
		,PWS.ConsultoraID
		,PWS.OrdenPedido
		,PWS.CodigoUsuarioCreacion
		,PWS.CodigoUsuarioModificacion
		,PWS.FechaCreacion
		,PWS.FechaModificacion
		,PWS.ClienteID
		,ClienteNombre = C.NOMBRE
	FROM PedidoWebSet PWS
		LEFT JOIN CLIENTE C ON PWS.ConsultoraID = C.ConsultoraID
			AND PWS.ClienteID = C.ClienteID
	WHERE SetId = @SetId
END


GO
USE BelcorpBolivia
GO

ALTER PROCEDURE [dbo].[PedidoWebSet_Select]
@SetId INT
AS
BEGIN
	SELECT
		 PWS.SetID
		,PWS.PedidoID
		,PWS.CuvSet
		,PWS.EstrategiaId
		,PWS.Cantidad
		,PWS.PrecioUnidad
		,PWS.ImporteTotal
		,PWS.Campania
		,PWS.ConsultoraID
		,PWS.OrdenPedido
		,PWS.CodigoUsuarioCreacion
		,PWS.CodigoUsuarioModificacion
		,PWS.FechaCreacion
		,PWS.FechaModificacion
		,PWS.ClienteID
		,ClienteNombre = C.NOMBRE
	FROM PedidoWebSet PWS
		LEFT JOIN CLIENTE C ON PWS.ConsultoraID = C.ConsultoraID
			AND PWS.ClienteID = C.ClienteID
	WHERE SetId = @SetId
END


GO
