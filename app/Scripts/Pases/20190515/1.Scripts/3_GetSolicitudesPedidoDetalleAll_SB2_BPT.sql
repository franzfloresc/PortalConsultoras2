USE BelcorpBolivia
GO

IF OBJECT_ID(N'dbo.GetSolicitudesPedidoDetalleAll_SB2', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.GetSolicitudesPedidoDetalleAll_SB2
END
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedidoDetalleAll_SB2]
	@CampaniaId INT
	,@ConsultoraId BIGINT
AS
BEGIN
	SELECT d.SolicitudClienteID
		,d.SolicitudClienteDetalleID
		,d.CUV
		,d.Producto
		,d.Cantidad
		,d.Precio
		,d.FechaCreacion
		,d.Tono
		,d.MarcaID
		,d.Url
		,m.Descripcion AS Marca
		--,'' AS MContacto
		,tld.Descripcion AS MContacto
		,ISNULL(d.TipoAtencion, 0) AS TipoAtencion
		,ISNULL(d.PedidoWebID, 0) AS PedidoWebID
		,ISNULL(d.PedidoWebDetalleID, 0) AS PedidoWebDetalleID
		,ISNULL(d.Estado, 1) AS Estado
		,pc.CodigoProducto AS CodigoSap
	FROM dbo.SolicitudCliente c
	INNER JOIN dbo.SolicitudClienteDetalle d ON c.SolicitudClienteID = d.SolicitudClienteID
	LEFT JOIN ods.ProductoComercial pc ON c.Campania = pc.AnoCampania
		AND d.CUV = pc.CUV
	LEFT JOIN dbo.Marca m ON d.MarcaID = m.MarcaID
	LEFT JOIN dbo.TablaLogicaDatos tld ON tld.TablaLogicaID = 85
		AND tld.Codigo = c.FlagMedio
	WHERE c.Campania = @CampaniaId
		AND c.ConsultoraID = @ConsultoraId
		AND ISNULL(d.Estado, 1) = 1
		AND ISNULL(d.TipoAtencion, 0) = 0
		--AND d.Estado = 1
END
GO

USE BelcorpChile
GO


IF OBJECT_ID(N'dbo.GetSolicitudesPedidoDetalleAll_SB2', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.GetSolicitudesPedidoDetalleAll_SB2
END
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedidoDetalleAll_SB2]
	@CampaniaId INT
	,@ConsultoraId BIGINT
AS
BEGIN
	SELECT d.SolicitudClienteID
		,d.SolicitudClienteDetalleID
		,d.CUV
		,d.Producto
		,d.Cantidad
		,d.Precio
		,d.FechaCreacion
		,d.Tono
		,d.MarcaID
		,d.Url
		,m.Descripcion AS Marca
		--,'' AS MContacto
		,tld.Descripcion AS MContacto
		,ISNULL(d.TipoAtencion, 0) AS TipoAtencion
		,ISNULL(d.PedidoWebID, 0) AS PedidoWebID
		,ISNULL(d.PedidoWebDetalleID, 0) AS PedidoWebDetalleID
		,ISNULL(d.Estado, 1) AS Estado
		,pc.CodigoProducto AS CodigoSap
	FROM dbo.SolicitudCliente c
	INNER JOIN dbo.SolicitudClienteDetalle d ON c.SolicitudClienteID = d.SolicitudClienteID
	LEFT JOIN ods.ProductoComercial pc ON c.Campania = pc.AnoCampania
		AND d.CUV = pc.CUV
	LEFT JOIN dbo.Marca m ON d.MarcaID = m.MarcaID
	LEFT JOIN dbo.TablaLogicaDatos tld ON tld.TablaLogicaID = 85
		AND tld.Codigo = c.FlagMedio
	WHERE c.Campania = @CampaniaId
		AND c.ConsultoraID = @ConsultoraId
		AND ISNULL(d.Estado, 1) = 1
		AND ISNULL(d.TipoAtencion, 0) = 0
		--AND d.Estado = 1
END
GO

USE BelcorpColombia
GO


IF OBJECT_ID(N'dbo.GetSolicitudesPedidoDetalleAll_SB2', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.GetSolicitudesPedidoDetalleAll_SB2
END
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedidoDetalleAll_SB2]
	@CampaniaId INT
	,@ConsultoraId BIGINT
AS
BEGIN
	SELECT d.SolicitudClienteID
		,d.SolicitudClienteDetalleID
		,d.CUV
		,d.Producto
		,d.Cantidad
		,d.Precio
		,d.FechaCreacion
		,d.Tono
		,d.MarcaID
		,d.Url
		,m.Descripcion AS Marca
		--,'' AS MContacto
		,tld.Descripcion AS MContacto
		,ISNULL(d.TipoAtencion, 0) AS TipoAtencion
		,ISNULL(d.PedidoWebID, 0) AS PedidoWebID
		,ISNULL(d.PedidoWebDetalleID, 0) AS PedidoWebDetalleID
		,ISNULL(d.Estado, 1) AS Estado
		,pc.CodigoProducto AS CodigoSap
	FROM dbo.SolicitudCliente c
	INNER JOIN dbo.SolicitudClienteDetalle d ON c.SolicitudClienteID = d.SolicitudClienteID
	LEFT JOIN ods.ProductoComercial pc ON c.Campania = pc.AnoCampania
		AND d.CUV = pc.CUV
	LEFT JOIN dbo.Marca m ON d.MarcaID = m.MarcaID
	LEFT JOIN dbo.TablaLogicaDatos tld ON tld.TablaLogicaID = 85
		AND tld.Codigo = c.FlagMedio
	WHERE c.Campania = @CampaniaId
		AND c.ConsultoraID = @ConsultoraId
		AND ISNULL(d.Estado, 1) = 1
		AND ISNULL(d.TipoAtencion, 0) = 0
		--AND d.Estado = 1
END
GO

USE BelcorpCostaRica
GO


IF OBJECT_ID(N'dbo.GetSolicitudesPedidoDetalleAll_SB2', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.GetSolicitudesPedidoDetalleAll_SB2
END
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedidoDetalleAll_SB2]
	@CampaniaId INT
	,@ConsultoraId BIGINT
AS
BEGIN
	SELECT d.SolicitudClienteID
		,d.SolicitudClienteDetalleID
		,d.CUV
		,d.Producto
		,d.Cantidad
		,d.Precio
		,d.FechaCreacion
		,d.Tono
		,d.MarcaID
		,d.Url
		,m.Descripcion AS Marca
		--,'' AS MContacto
		,tld.Descripcion AS MContacto
		,ISNULL(d.TipoAtencion, 0) AS TipoAtencion
		,ISNULL(d.PedidoWebID, 0) AS PedidoWebID
		,ISNULL(d.PedidoWebDetalleID, 0) AS PedidoWebDetalleID
		,ISNULL(d.Estado, 1) AS Estado
		,pc.CodigoProducto AS CodigoSap
	FROM dbo.SolicitudCliente c
	INNER JOIN dbo.SolicitudClienteDetalle d ON c.SolicitudClienteID = d.SolicitudClienteID
	LEFT JOIN ods.ProductoComercial pc ON c.Campania = pc.AnoCampania
		AND d.CUV = pc.CUV
	LEFT JOIN dbo.Marca m ON d.MarcaID = m.MarcaID
	LEFT JOIN dbo.TablaLogicaDatos tld ON tld.TablaLogicaID = 85
		AND tld.Codigo = c.FlagMedio
	WHERE c.Campania = @CampaniaId
		AND c.ConsultoraID = @ConsultoraId
		AND ISNULL(d.Estado, 1) = 1
		AND ISNULL(d.TipoAtencion, 0) = 0
		--AND d.Estado = 1
END
GO

USE BelcorpDominicana
GO


IF OBJECT_ID(N'dbo.GetSolicitudesPedidoDetalleAll_SB2', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.GetSolicitudesPedidoDetalleAll_SB2
END
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedidoDetalleAll_SB2]
	@CampaniaId INT
	,@ConsultoraId BIGINT
AS
BEGIN
	SELECT d.SolicitudClienteID
		,d.SolicitudClienteDetalleID
		,d.CUV
		,d.Producto
		,d.Cantidad
		,d.Precio
		,d.FechaCreacion
		,d.Tono
		,d.MarcaID
		,d.Url
		,m.Descripcion AS Marca
		--,'' AS MContacto
		,tld.Descripcion AS MContacto
		,ISNULL(d.TipoAtencion, 0) AS TipoAtencion
		,ISNULL(d.PedidoWebID, 0) AS PedidoWebID
		,ISNULL(d.PedidoWebDetalleID, 0) AS PedidoWebDetalleID
		,ISNULL(d.Estado, 1) AS Estado
		,pc.CodigoProducto AS CodigoSap
	FROM dbo.SolicitudCliente c
	INNER JOIN dbo.SolicitudClienteDetalle d ON c.SolicitudClienteID = d.SolicitudClienteID
	LEFT JOIN ods.ProductoComercial pc ON c.Campania = pc.AnoCampania
		AND d.CUV = pc.CUV
	LEFT JOIN dbo.Marca m ON d.MarcaID = m.MarcaID
	LEFT JOIN dbo.TablaLogicaDatos tld ON tld.TablaLogicaID = 85
		AND tld.Codigo = c.FlagMedio
	WHERE c.Campania = @CampaniaId
		AND c.ConsultoraID = @ConsultoraId
		AND ISNULL(d.Estado, 1) = 1
		AND ISNULL(d.TipoAtencion, 0) = 0
		--AND d.Estado = 1
END
GO

USE BelcorpEcuador
GO


IF OBJECT_ID(N'dbo.GetSolicitudesPedidoDetalleAll_SB2', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.GetSolicitudesPedidoDetalleAll_SB2
END
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedidoDetalleAll_SB2]
	@CampaniaId INT
	,@ConsultoraId BIGINT
AS
BEGIN
	SELECT d.SolicitudClienteID
		,d.SolicitudClienteDetalleID
		,d.CUV
		,d.Producto
		,d.Cantidad
		,d.Precio
		,d.FechaCreacion
		,d.Tono
		,d.MarcaID
		,d.Url
		,m.Descripcion AS Marca
		--,'' AS MContacto
		,tld.Descripcion AS MContacto
		,ISNULL(d.TipoAtencion, 0) AS TipoAtencion
		,ISNULL(d.PedidoWebID, 0) AS PedidoWebID
		,ISNULL(d.PedidoWebDetalleID, 0) AS PedidoWebDetalleID
		,ISNULL(d.Estado, 1) AS Estado
		,pc.CodigoProducto AS CodigoSap
	FROM dbo.SolicitudCliente c
	INNER JOIN dbo.SolicitudClienteDetalle d ON c.SolicitudClienteID = d.SolicitudClienteID
	LEFT JOIN ods.ProductoComercial pc ON c.Campania = pc.AnoCampania
		AND d.CUV = pc.CUV
	LEFT JOIN dbo.Marca m ON d.MarcaID = m.MarcaID
	LEFT JOIN dbo.TablaLogicaDatos tld ON tld.TablaLogicaID = 85
		AND tld.Codigo = c.FlagMedio
	WHERE c.Campania = @CampaniaId
		AND c.ConsultoraID = @ConsultoraId
		AND ISNULL(d.Estado, 1) = 1
		AND ISNULL(d.TipoAtencion, 0) = 0
		--AND d.Estado = 1
END
GO

USE BelcorpGuatemala
GO


IF OBJECT_ID(N'dbo.GetSolicitudesPedidoDetalleAll_SB2', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.GetSolicitudesPedidoDetalleAll_SB2
END
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedidoDetalleAll_SB2]
	@CampaniaId INT
	,@ConsultoraId BIGINT
AS
BEGIN
	SELECT d.SolicitudClienteID
		,d.SolicitudClienteDetalleID
		,d.CUV
		,d.Producto
		,d.Cantidad
		,d.Precio
		,d.FechaCreacion
		,d.Tono
		,d.MarcaID
		,d.Url
		,m.Descripcion AS Marca
		--,'' AS MContacto
		,tld.Descripcion AS MContacto
		,ISNULL(d.TipoAtencion, 0) AS TipoAtencion
		,ISNULL(d.PedidoWebID, 0) AS PedidoWebID
		,ISNULL(d.PedidoWebDetalleID, 0) AS PedidoWebDetalleID
		,ISNULL(d.Estado, 1) AS Estado
		,pc.CodigoProducto AS CodigoSap
	FROM dbo.SolicitudCliente c
	INNER JOIN dbo.SolicitudClienteDetalle d ON c.SolicitudClienteID = d.SolicitudClienteID
	LEFT JOIN ods.ProductoComercial pc ON c.Campania = pc.AnoCampania
		AND d.CUV = pc.CUV
	LEFT JOIN dbo.Marca m ON d.MarcaID = m.MarcaID
	LEFT JOIN dbo.TablaLogicaDatos tld ON tld.TablaLogicaID = 85
		AND tld.Codigo = c.FlagMedio
	WHERE c.Campania = @CampaniaId
		AND c.ConsultoraID = @ConsultoraId
		AND ISNULL(d.Estado, 1) = 1
		AND ISNULL(d.TipoAtencion, 0) = 0
		--AND d.Estado = 1
END
GO

USE BelcorpMexico
GO


IF OBJECT_ID(N'dbo.GetSolicitudesPedidoDetalleAll_SB2', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.GetSolicitudesPedidoDetalleAll_SB2
END
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedidoDetalleAll_SB2]
	@CampaniaId INT
	,@ConsultoraId BIGINT
AS
BEGIN
	SELECT d.SolicitudClienteID
		,d.SolicitudClienteDetalleID
		,d.CUV
		,d.Producto
		,d.Cantidad
		,d.Precio
		,d.FechaCreacion
		,d.Tono
		,d.MarcaID
		,d.Url
		,m.Descripcion AS Marca
		--,'' AS MContacto
		,tld.Descripcion AS MContacto
		,ISNULL(d.TipoAtencion, 0) AS TipoAtencion
		,ISNULL(d.PedidoWebID, 0) AS PedidoWebID
		,ISNULL(d.PedidoWebDetalleID, 0) AS PedidoWebDetalleID
		,ISNULL(d.Estado, 1) AS Estado
		,pc.CodigoProducto AS CodigoSap
	FROM dbo.SolicitudCliente c
	INNER JOIN dbo.SolicitudClienteDetalle d ON c.SolicitudClienteID = d.SolicitudClienteID
	LEFT JOIN ods.ProductoComercial pc ON c.Campania = pc.AnoCampania
		AND d.CUV = pc.CUV
	LEFT JOIN dbo.Marca m ON d.MarcaID = m.MarcaID
	LEFT JOIN dbo.TablaLogicaDatos tld ON tld.TablaLogicaID = 85
		AND tld.Codigo = c.FlagMedio
	WHERE c.Campania = @CampaniaId
		AND c.ConsultoraID = @ConsultoraId
		AND ISNULL(d.Estado, 1) = 1
		AND ISNULL(d.TipoAtencion, 0) = 0
		--AND d.Estado = 1
END
GO

USE BelcorpPanama
GO


IF OBJECT_ID(N'dbo.GetSolicitudesPedidoDetalleAll_SB2', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.GetSolicitudesPedidoDetalleAll_SB2
END
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedidoDetalleAll_SB2]
	@CampaniaId INT
	,@ConsultoraId BIGINT
AS
BEGIN
	SELECT d.SolicitudClienteID
		,d.SolicitudClienteDetalleID
		,d.CUV
		,d.Producto
		,d.Cantidad
		,d.Precio
		,d.FechaCreacion
		,d.Tono
		,d.MarcaID
		,d.Url
		,m.Descripcion AS Marca
		--,'' AS MContacto
		,tld.Descripcion AS MContacto
		,ISNULL(d.TipoAtencion, 0) AS TipoAtencion
		,ISNULL(d.PedidoWebID, 0) AS PedidoWebID
		,ISNULL(d.PedidoWebDetalleID, 0) AS PedidoWebDetalleID
		,ISNULL(d.Estado, 1) AS Estado
		,pc.CodigoProducto AS CodigoSap
	FROM dbo.SolicitudCliente c
	INNER JOIN dbo.SolicitudClienteDetalle d ON c.SolicitudClienteID = d.SolicitudClienteID
	LEFT JOIN ods.ProductoComercial pc ON c.Campania = pc.AnoCampania
		AND d.CUV = pc.CUV
	LEFT JOIN dbo.Marca m ON d.MarcaID = m.MarcaID
	LEFT JOIN dbo.TablaLogicaDatos tld ON tld.TablaLogicaID = 85
		AND tld.Codigo = c.FlagMedio
	WHERE c.Campania = @CampaniaId
		AND c.ConsultoraID = @ConsultoraId
		AND ISNULL(d.Estado, 1) = 1
		AND ISNULL(d.TipoAtencion, 0) = 0
		--AND d.Estado = 1
END
GO

USE BelcorpPeru
GO


IF OBJECT_ID(N'dbo.GetSolicitudesPedidoDetalleAll_SB2', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.GetSolicitudesPedidoDetalleAll_SB2
END
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedidoDetalleAll_SB2]
	@CampaniaId INT
	,@ConsultoraId BIGINT
AS
BEGIN
	SELECT d.SolicitudClienteID
		,d.SolicitudClienteDetalleID
		,d.CUV
		,d.Producto
		,d.Cantidad
		,d.Precio
		,d.FechaCreacion
		,d.Tono
		,d.MarcaID
		,d.Url
		,m.Descripcion AS Marca
		--,'' AS MContacto
		,tld.Descripcion AS MContacto
		,ISNULL(d.TipoAtencion, 0) AS TipoAtencion
		,ISNULL(d.PedidoWebID, 0) AS PedidoWebID
		,ISNULL(d.PedidoWebDetalleID, 0) AS PedidoWebDetalleID
		,ISNULL(d.Estado, 1) AS Estado
		,pc.CodigoProducto AS CodigoSap
	FROM dbo.SolicitudCliente c
	INNER JOIN dbo.SolicitudClienteDetalle d ON c.SolicitudClienteID = d.SolicitudClienteID
	LEFT JOIN ods.ProductoComercial pc ON c.Campania = pc.AnoCampania
		AND d.CUV = pc.CUV
	LEFT JOIN dbo.Marca m ON d.MarcaID = m.MarcaID
	LEFT JOIN dbo.TablaLogicaDatos tld ON tld.TablaLogicaID = 85
		AND tld.Codigo = c.FlagMedio
	WHERE c.Campania = @CampaniaId
		AND c.ConsultoraID = @ConsultoraId
		AND ISNULL(d.Estado, 1) = 1
		AND ISNULL(d.TipoAtencion, 0) = 0
		--AND d.Estado = 1
END
GO

USE BelcorpPuertoRico
GO


IF OBJECT_ID(N'dbo.GetSolicitudesPedidoDetalleAll_SB2', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.GetSolicitudesPedidoDetalleAll_SB2
END
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedidoDetalleAll_SB2]
	@CampaniaId INT
	,@ConsultoraId BIGINT
AS
BEGIN
	SELECT d.SolicitudClienteID
		,d.SolicitudClienteDetalleID
		,d.CUV
		,d.Producto
		,d.Cantidad
		,d.Precio
		,d.FechaCreacion
		,d.Tono
		,d.MarcaID
		,d.Url
		,m.Descripcion AS Marca
		--,'' AS MContacto
		,tld.Descripcion AS MContacto
		,ISNULL(d.TipoAtencion, 0) AS TipoAtencion
		,ISNULL(d.PedidoWebID, 0) AS PedidoWebID
		,ISNULL(d.PedidoWebDetalleID, 0) AS PedidoWebDetalleID
		,ISNULL(d.Estado, 1) AS Estado
		,pc.CodigoProducto AS CodigoSap
	FROM dbo.SolicitudCliente c
	INNER JOIN dbo.SolicitudClienteDetalle d ON c.SolicitudClienteID = d.SolicitudClienteID
	LEFT JOIN ods.ProductoComercial pc ON c.Campania = pc.AnoCampania
		AND d.CUV = pc.CUV
	LEFT JOIN dbo.Marca m ON d.MarcaID = m.MarcaID
	LEFT JOIN dbo.TablaLogicaDatos tld ON tld.TablaLogicaID = 85
		AND tld.Codigo = c.FlagMedio
	WHERE c.Campania = @CampaniaId
		AND c.ConsultoraID = @ConsultoraId
		AND ISNULL(d.Estado, 1) = 1
		AND ISNULL(d.TipoAtencion, 0) = 0
		--AND d.Estado = 1
END
GO

USE BelcorpSalvador
GO


IF OBJECT_ID(N'dbo.GetSolicitudesPedidoDetalleAll_SB2', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.GetSolicitudesPedidoDetalleAll_SB2
END
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedidoDetalleAll_SB2]
	@CampaniaId INT
	,@ConsultoraId BIGINT
AS
BEGIN
	SELECT d.SolicitudClienteID
		,d.SolicitudClienteDetalleID
		,d.CUV
		,d.Producto
		,d.Cantidad
		,d.Precio
		,d.FechaCreacion
		,d.Tono
		,d.MarcaID
		,d.Url
		,m.Descripcion AS Marca
		--,'' AS MContacto
		,tld.Descripcion AS MContacto
		,ISNULL(d.TipoAtencion, 0) AS TipoAtencion
		,ISNULL(d.PedidoWebID, 0) AS PedidoWebID
		,ISNULL(d.PedidoWebDetalleID, 0) AS PedidoWebDetalleID
		,ISNULL(d.Estado, 1) AS Estado
		,pc.CodigoProducto AS CodigoSap
	FROM dbo.SolicitudCliente c
	INNER JOIN dbo.SolicitudClienteDetalle d ON c.SolicitudClienteID = d.SolicitudClienteID
	LEFT JOIN ods.ProductoComercial pc ON c.Campania = pc.AnoCampania
		AND d.CUV = pc.CUV
	LEFT JOIN dbo.Marca m ON d.MarcaID = m.MarcaID
	LEFT JOIN dbo.TablaLogicaDatos tld ON tld.TablaLogicaID = 85
		AND tld.Codigo = c.FlagMedio
	WHERE c.Campania = @CampaniaId
		AND c.ConsultoraID = @ConsultoraId
		AND ISNULL(d.Estado, 1) = 1
		AND ISNULL(d.TipoAtencion, 0) = 0
		--AND d.Estado = 1
END
GO
