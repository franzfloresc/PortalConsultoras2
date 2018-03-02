USE BelcorpPeru
GO

IF (OBJECT_ID('ShowRoom.GetShowRoomOfertaById', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetShowRoomOfertaById AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END


GO

USE BelcorpMexico
GO

IF (OBJECT_ID('ShowRoom.GetShowRoomOfertaById', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetShowRoomOfertaById AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END


GO

USE BelcorpColombia
GO

IF (OBJECT_ID('ShowRoom.GetShowRoomOfertaById', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetShowRoomOfertaById AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END


GO

USE BelcorpVenezuela
GO

IF (OBJECT_ID('ShowRoom.GetShowRoomOfertaById', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetShowRoomOfertaById AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END


GO

USE BelcorpSalvador
GO

IF (OBJECT_ID('ShowRoom.GetShowRoomOfertaById', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetShowRoomOfertaById AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END


GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID('ShowRoom.GetShowRoomOfertaById', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetShowRoomOfertaById AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END


GO

USE BelcorpPanama
GO

IF (OBJECT_ID('ShowRoom.GetShowRoomOfertaById', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetShowRoomOfertaById AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END


GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID('ShowRoom.GetShowRoomOfertaById', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetShowRoomOfertaById AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END


GO

USE BelcorpEcuador
GO

IF (OBJECT_ID('ShowRoom.GetShowRoomOfertaById', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetShowRoomOfertaById AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END


GO

USE BelcorpDominicana
GO

IF (OBJECT_ID('ShowRoom.GetShowRoomOfertaById', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetShowRoomOfertaById AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END


GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID('ShowRoom.GetShowRoomOfertaById', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetShowRoomOfertaById AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END


GO

USE BelcorpChile
GO

IF (OBJECT_ID('ShowRoom.GetShowRoomOfertaById', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetShowRoomOfertaById AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END


GO

USE BelcorpBolivia
GO

IF (OBJECT_ID('ShowRoom.GetShowRoomOfertaById', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetShowRoomOfertaById AS SET NOCOUNT ON;')
GO

--
ALTER PROCEDURE ShowRoom.GetShowRoomOfertaById
 @OfertaShowRoomID int
AS
/*
ShowRoom.GetShowRoomOfertaById 113
*/
BEGIN
 
 SET NOCOUNT ON;
  
	select 
		OfertaShowRoomID,CampaniaID,CUV,TipoOfertaSisID,ConfiguracionOfertaID,Descripcion,PrecioValorizado,Stock,
		StockInicial,ImagenProducto,UnidadesPermitidas,FlagHabilitarProducto,DescripcionLegal,UsuarioRegistro,FechaRegistro,
		UsuarioModificacion,FechaModificacion,ImagenMini,Orden,CodigoCategoria,TipNegocio,PrecioOferta
	from showroom.ofertashowroom
	where OfertaShowRoomID = @OfertaShowRoomID
 
END


GO

