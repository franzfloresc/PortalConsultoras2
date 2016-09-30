USE BelcorpPeru
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedidoDetalle_SB2]  
	@SolicitudClienteID bigint    
AS    
BEGIN   
	select 
	SolicitudClienteID,
	SolicitudClienteDetalleID, 
	CUV, 
	Producto, 
	Cantidad, 
	Precio, 
	FechaCreacion, 
	Tono, 
	scd.MarcaID, 
	Url,
	m.Descripcion as Marca,
	'' as MContacto,
	isnull(TipoAtencion,0) as TipoAtencion,
	isnull(PedidoWebID,0) as PedidoWebID,
	isnull(PedidoWebDetalleID,0) as PedidoWebDetalleID
	from dbo.SolicitudClienteDetalle scd left join Marca m on scd.MarcaID = m.MarcaID
	where scd.SolicitudClienteID = @SolicitudClienteID
END

/*end*/

USE BelcorpColombia
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedidoDetalle_SB2]  
	@SolicitudClienteID bigint    
AS    
BEGIN   
	select 
	SolicitudClienteID,
	SolicitudClienteDetalleID, 
	CUV, 
	Producto, 
	Cantidad, 
	Precio, 
	FechaCreacion, 
	Tono, 
	scd.MarcaID, 
	Url,
	m.Descripcion as Marca,
	'' as MContacto,
	isnull(TipoAtencion,0) as TipoAtencion,
	isnull(PedidoWebID,0) as PedidoWebID,
	isnull(PedidoWebDetalleID,0) as PedidoWebDetalleID
	from dbo.SolicitudClienteDetalle scd left join Marca m on scd.MarcaID = m.MarcaID
	where scd.SolicitudClienteID = @SolicitudClienteID
END

/*end*/

USE BelcorpChile
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedidoDetalle_SB2]  
	@SolicitudClienteID bigint    
AS    
BEGIN   
	select 
	SolicitudClienteID,
	SolicitudClienteDetalleID, 
	CUV, 
	Producto, 
	Cantidad, 
	Precio, 
	FechaCreacion, 
	Tono, 
	scd.MarcaID, 
	Url,
	m.Descripcion as Marca,
	'' as MContacto,
	isnull(TipoAtencion,0) as TipoAtencion,
	isnull(PedidoWebID,0) as PedidoWebID,
	isnull(PedidoWebDetalleID,0) as PedidoWebDetalleID
	from dbo.SolicitudClienteDetalle scd left join Marca m on scd.MarcaID = m.MarcaID
	where scd.SolicitudClienteID = @SolicitudClienteID
END

/*end*/

USE BelcorpMexico
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedidoDetalle_SB2]  
	@SolicitudClienteID bigint    
AS    
BEGIN   
	select 
	SolicitudClienteID,
	SolicitudClienteDetalleID, 
	CUV, 
	Producto, 
	Cantidad, 
	Precio, 
	FechaCreacion, 
	Tono, 
	scd.MarcaID, 
	Url,
	m.Descripcion as Marca,
	'' as MContacto,
	isnull(TipoAtencion,0) as TipoAtencion,
	isnull(PedidoWebID,0) as PedidoWebID,
	isnull(PedidoWebDetalleID,0) as PedidoWebDetalleID
	from dbo.SolicitudClienteDetalle scd left join Marca m on scd.MarcaID = m.MarcaID
	where scd.SolicitudClienteID = @SolicitudClienteID
END

/*end*/

USE BelcorpEcuador
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedidoDetalle_SB2]  
	@SolicitudClienteID bigint    
AS    
BEGIN   
	select 
	SolicitudClienteID,
	SolicitudClienteDetalleID, 
	CUV, 
	Producto, 
	Cantidad, 
	Precio, 
	FechaCreacion, 
	Tono, 
	scd.MarcaID, 
	Url,
	m.Descripcion as Marca,
	'' as MContacto,
	isnull(TipoAtencion,0) as TipoAtencion,
	isnull(PedidoWebID,0) as PedidoWebID,
	isnull(PedidoWebDetalleID,0) as PedidoWebDetalleID
	from dbo.SolicitudClienteDetalle scd left join Marca m on scd.MarcaID = m.MarcaID
	where scd.SolicitudClienteID = @SolicitudClienteID
END

/*end*/

USE BelcorpCostaRica
GO

CREATE PROCEDURE [dbo].[GetSolicitudesPedidoDetalle_SB2]  
	@SolicitudClienteID bigint    
AS    
BEGIN   
	select 
	SolicitudClienteID,
	SolicitudClienteDetalleID, 
	CUV, 
	Producto, 
	Cantidad, 
	Precio, 
	FechaCreacion, 
	Tono, 
	scd.MarcaID, 
	Url,
	m.Descripcion as Marca,
	'' as MContacto,
	isnull(TipoAtencion,0) as TipoAtencion,
	isnull(PedidoWebID,0) as PedidoWebID,
	isnull(PedidoWebDetalleID,0) as PedidoWebDetalleID
	from dbo.SolicitudClienteDetalle scd left join Marca m on scd.MarcaID = m.MarcaID
	where scd.SolicitudClienteID = @SolicitudClienteID
END