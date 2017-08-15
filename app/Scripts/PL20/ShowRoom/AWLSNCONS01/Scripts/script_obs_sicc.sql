USE BelcorpBolivia
go

update Permiso set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

update MenuMobile set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

alter procedure ShowRoom.GetProductosShowRoomDetalle
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

go

USE BelcorpChile
go

update Permiso set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

update MenuMobile set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

alter procedure ShowRoom.GetProductosShowRoomDetalle
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

go

USE BelcorpColombia
go

update Permiso set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

update MenuMobile set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

alter procedure ShowRoom.GetProductosShowRoomDetalle
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

go

USE BelcorpCostaRica
go

update Permiso set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

update MenuMobile set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

alter procedure ShowRoom.GetProductosShowRoomDetalle
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

go

USE BelcorpDominicana
go

update Permiso set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

update MenuMobile set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

alter procedure ShowRoom.GetProductosShowRoomDetalle
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

go

USE BelcorpEcuador
go

update Permiso set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

update MenuMobile set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

alter procedure ShowRoom.GetProductosShowRoomDetalle
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

go

USE BelcorpGuatemala
go

update Permiso set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

update MenuMobile set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

alter procedure ShowRoom.GetProductosShowRoomDetalle
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

go

USE BelcorpMexico
go

update Permiso set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

update MenuMobile set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

alter procedure ShowRoom.GetProductosShowRoomDetalle
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

go

USE BelcorpPanama
go

update Permiso set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

update MenuMobile set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

alter procedure ShowRoom.GetProductosShowRoomDetalle
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

go

USE BelcorpPeru
go

update Permiso set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

update MenuMobile set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

alter procedure ShowRoom.GetProductosShowRoomDetalle
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

go

USE BelcorpPuertoRico
go

update Permiso set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

update MenuMobile set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

alter procedure ShowRoom.GetProductosShowRoomDetalle
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

go

USE BelcorpSalvador
go

update Permiso set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

update MenuMobile set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

alter procedure ShowRoom.GetProductosShowRoomDetalle
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

go

USE BelcorpVenezuela
go

update Permiso set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

update MenuMobile set Descripcion = 'VENTA EXCLUSIVA WEB' where Descripcion = 'GRAN VENTA ONLINE'
go

alter procedure ShowRoom.GetProductosShowRoomDetalle
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

go