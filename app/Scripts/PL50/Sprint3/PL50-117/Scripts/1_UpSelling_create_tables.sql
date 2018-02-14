IF EXISTS (select * from sys.objects where type = 'U' and name = 'UpSellingDetalle')
BEGIN
	DROP TABLE [dbo].[UpSellingDetalle]
END
GO

IF EXISTS (select * from sys.objects where type = 'U' and name = 'UpSelling')
BEGIN
	DROP TABLE [dbo].[UpSelling]
END
GO

CREATE TABLE UpSelling(
	UpSellingId int not null identity primary key,
	CodigoCampana int not null,
	MontoMeta decimal(21,4) not null,
	TextoMeta1 varchar(250) not null,
	TextoMeta2 varchar(250) null,
	TextoGanaste1 varchar(250) null,
	TextoGanaste2 varchar(250) null,
	UsuarioCreacion varchar(150) not null,
	FechaCreacion DateTime not null,
	UsuarioModicacion varchar(150) null,
	FechaModificacion DateTime null
)

CREATE TABLE UpSellingDetalle(
	UpSellingDetalleID int not null identity primary key,
	CUV varchar(50) not null, --6?
	Nombre varchar(250) not null,
	Descripcion Varchar(500) null,
	Imagen Varchar(400) null,
	Stock int not null,
	Orden int not null,
	Activo bit not null,
	UpSellingId int not null,
	UsuarioCreacion varchar(150) not null,
	FechaCreacion DateTime not null,
	UsuarioModicacion varchar(150) null,
	FechaModificacion DateTime null
)

ALTER TABLE UpSellingDetalle ADD CONSTRAINT FK_UpSellingDetalle
FOREIGN KEY (UpSellingId) REFERENCES UpSelling(UpSellingId);