
use BelcorpPeru_BPT
go

alter table EstrategiaProducto
add NombreProducto varchar(150)

alter table EstrategiaProducto
add Descripcion1 varchar(255)

alter table EstrategiaProducto
add ImagenProducto varchar(150)

alter table EstrategiaProducto
add MarcaId tinyint