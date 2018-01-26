
USE BelcorpPeru_PL50
GO

alter table EstrategiaProducto
add UsuarioCreacion varchar(30) null

alter table EstrategiaProducto
add FechaCreacion datetime null

alter table EstrategiaProducto
add UsuarioModificacion varchar(30) null

alter table EstrategiaProducto
add FechaModificacion datetime null