USE BelcorpPeru
GO

IF (OBJECT_ID('ShowRoom.GetProductosShowRoomDetalle', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetProductosShowRoomDetalle AS SET NOCOUNT ON;')
GO

ALTER  procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end


GO

USE BelcorpMexico
GO

IF (OBJECT_ID('ShowRoom.GetProductosShowRoomDetalle', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetProductosShowRoomDetalle AS SET NOCOUNT ON;')
GO

ALTER  procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end


GO

USE BelcorpColombia
GO

IF (OBJECT_ID('ShowRoom.GetProductosShowRoomDetalle', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetProductosShowRoomDetalle AS SET NOCOUNT ON;')
GO

ALTER  procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end


GO

USE BelcorpVenezuela
GO

IF (OBJECT_ID('ShowRoom.GetProductosShowRoomDetalle', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetProductosShowRoomDetalle AS SET NOCOUNT ON;')
GO

ALTER  procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end


GO

USE BelcorpSalvador
GO

IF (OBJECT_ID('ShowRoom.GetProductosShowRoomDetalle', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetProductosShowRoomDetalle AS SET NOCOUNT ON;')
GO

ALTER  procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end


GO

USE BelcorpPuertoRico
GO

IF (OBJECT_ID('ShowRoom.GetProductosShowRoomDetalle', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetProductosShowRoomDetalle AS SET NOCOUNT ON;')
GO

ALTER  procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end


GO

USE BelcorpPanama
GO

IF (OBJECT_ID('ShowRoom.GetProductosShowRoomDetalle', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetProductosShowRoomDetalle AS SET NOCOUNT ON;')
GO

ALTER  procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end


GO

USE BelcorpGuatemala
GO

IF (OBJECT_ID('ShowRoom.GetProductosShowRoomDetalle', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetProductosShowRoomDetalle AS SET NOCOUNT ON;')
GO

ALTER  procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end


GO

USE BelcorpEcuador
GO

IF (OBJECT_ID('ShowRoom.GetProductosShowRoomDetalle', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetProductosShowRoomDetalle AS SET NOCOUNT ON;')
GO

ALTER  procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end


GO

USE BelcorpDominicana
GO

IF (OBJECT_ID('ShowRoom.GetProductosShowRoomDetalle', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetProductosShowRoomDetalle AS SET NOCOUNT ON;')
GO

ALTER  procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end


GO

USE BelcorpCostaRica
GO

IF (OBJECT_ID('ShowRoom.GetProductosShowRoomDetalle', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetProductosShowRoomDetalle AS SET NOCOUNT ON;')
GO

ALTER  procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end


GO

USE BelcorpChile
GO

IF (OBJECT_ID('ShowRoom.GetProductosShowRoomDetalle', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetProductosShowRoomDetalle AS SET NOCOUNT ON;')
GO

ALTER  procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end


GO

USE BelcorpBolivia
GO

IF (OBJECT_ID('ShowRoom.GetProductosShowRoomDetalle', 'P') IS NULL)
	EXEC ('CREATE PROCEDURE ShowRoom.GetProductosShowRoomDetalle AS SET NOCOUNT ON;')
GO

ALTER  procedure ShowRoom.GetProductosShowRoomDetalle
@CampaniaID int,
@CUV varchar(5)
as
/*
ShowRoom.GetProductosShowRoomDetalle 201705,'96248'
ShowRoom.GetProductosShowRoomDetalle 201705,'99008'
*/
begin

select
	OfertaShowRoomDetalleID,
	CampaniaID,
	CUV,
	isnull(NombreProducto,'') as NombreProducto,
	isnull(Descripcion1,'') as Descripcion1,
	isnull(Descripcion2,'') as Descripcion2,
	isnull(Descripcion3,'') as Descripcion3,
	isnull(Imagen,'') as Imagen,
	FechaCreacion,
	UsuarioCreacion,
	FechaModificacion,
	UsuarioModificacion,
	Posicion,
	MarcaProducto
from ShowRoom.OfertaShowRoomDetalle
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV

end


GO

