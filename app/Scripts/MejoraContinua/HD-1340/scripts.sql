USE BelcorpPeru
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[OfertaShowRoomDetalleLog]') AND (type = 'U') )
 DROP TABLE ShowRoom.OfertaShowRoomDetalleLog
GO

create table ShowRoom.OfertaShowRoomDetalleLog
(
OfertaShowRoomDetalleLog int identity(1,1) primary key,
CampaniaID int,
CUV varchar(20),
NombreProducto varchar(100),
Descripcion1 varchar(150),
Descripcion2 varchar(150),
Descripcion3 varchar(150),
Imagen varchar(150),
Posicion int,
MarcaProducto varchar(100),
NombreArchivoCargado varchar(150),
NombreArchivoGuardado varchar(150),
FechaEliminacion datetime,
UsuarioEncargado varchar(100),
NumeroLote int
)

go

alter procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50),
@NombreArchivoCargado varchar(150),
@NombreArchivoGuardado varchar(150)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from ShowRoom.OfertaShowRoomDetalleLog
set @NumeroLote = @NumeroLote + 1 

insert into ShowRoom.OfertaShowRoomDetalleLog
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,Imagen,Posicion,MarcaProducto,
NombreArchivoCargado,NombreArchivoGuardado,FechaEliminacion,UsuarioEncargado,NumeroLote)
select o.CampaniaID,o.CUV,o.NombreProducto,o.Descripcion1,o.Descripcion2,o.Descripcion3,o.Imagen,o.Posicion,o.MarcaProducto,
@NombreArchivoCargado,@NombreArchivoGuardado,@FechaGeneral,@UsuarioCreacion,@NumeroLote
from ShowRoom.OfertaShowRoomDetalle o
left join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
where 
	o.CampaniaID = @CampaniaID 
	and t.CUV is null

delete from ShowRoom.OfertaShowRoomDetalle
where OfertaShowRoomDetalleID in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
		left join @OfertaShowRoomDetalle t on
		o.CUV = t.CUV
		and o.Posicion = t.Posicion
		where o.CampaniaID = @CampaniaID and t.CUV is null)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion	
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,t.CUV,t.NombreProducto,t.Descripcion1,t.Descripcion2,t.Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,t.Posicion,t.MarcaProducto
from @OfertaShowRoomDetalle t
left join ShowRoom.OfertaShowRoomDetalle o on
	t.CUV = o.CUV
	and t.Posicion = o.Posicion
	and o.CampaniaID = @CampaniaID
where 	
	o.CUV is null

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

GO

USE BelcorpMexico
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[OfertaShowRoomDetalleLog]') AND (type = 'U') )
 DROP TABLE ShowRoom.OfertaShowRoomDetalleLog
GO

create table ShowRoom.OfertaShowRoomDetalleLog
(
OfertaShowRoomDetalleLog int identity(1,1) primary key,
CampaniaID int,
CUV varchar(20),
NombreProducto varchar(100),
Descripcion1 varchar(150),
Descripcion2 varchar(150),
Descripcion3 varchar(150),
Imagen varchar(150),
Posicion int,
MarcaProducto varchar(100),
NombreArchivoCargado varchar(150),
NombreArchivoGuardado varchar(150),
FechaEliminacion datetime,
UsuarioEncargado varchar(100),
NumeroLote int
)

go

alter procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50),
@NombreArchivoCargado varchar(150),
@NombreArchivoGuardado varchar(150)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from ShowRoom.OfertaShowRoomDetalleLog
set @NumeroLote = @NumeroLote + 1 

insert into ShowRoom.OfertaShowRoomDetalleLog
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,Imagen,Posicion,MarcaProducto,
NombreArchivoCargado,NombreArchivoGuardado,FechaEliminacion,UsuarioEncargado,NumeroLote)
select o.CampaniaID,o.CUV,o.NombreProducto,o.Descripcion1,o.Descripcion2,o.Descripcion3,o.Imagen,o.Posicion,o.MarcaProducto,
@NombreArchivoCargado,@NombreArchivoGuardado,@FechaGeneral,@UsuarioCreacion,@NumeroLote
from ShowRoom.OfertaShowRoomDetalle o
left join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
where 
	o.CampaniaID = @CampaniaID 
	and t.CUV is null

delete from ShowRoom.OfertaShowRoomDetalle
where OfertaShowRoomDetalleID in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
		left join @OfertaShowRoomDetalle t on
		o.CUV = t.CUV
		and o.Posicion = t.Posicion
		where o.CampaniaID = @CampaniaID and t.CUV is null)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion	
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,t.CUV,t.NombreProducto,t.Descripcion1,t.Descripcion2,t.Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,t.Posicion,t.MarcaProducto
from @OfertaShowRoomDetalle t
left join ShowRoom.OfertaShowRoomDetalle o on
	t.CUV = o.CUV
	and t.Posicion = o.Posicion
	and o.CampaniaID = @CampaniaID
where 	
	o.CUV is null

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

GO

USE BelcorpColombia
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[OfertaShowRoomDetalleLog]') AND (type = 'U') )
 DROP TABLE ShowRoom.OfertaShowRoomDetalleLog
GO

create table ShowRoom.OfertaShowRoomDetalleLog
(
OfertaShowRoomDetalleLog int identity(1,1) primary key,
CampaniaID int,
CUV varchar(20),
NombreProducto varchar(100),
Descripcion1 varchar(150),
Descripcion2 varchar(150),
Descripcion3 varchar(150),
Imagen varchar(150),
Posicion int,
MarcaProducto varchar(100),
NombreArchivoCargado varchar(150),
NombreArchivoGuardado varchar(150),
FechaEliminacion datetime,
UsuarioEncargado varchar(100),
NumeroLote int
)

go

alter procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50),
@NombreArchivoCargado varchar(150),
@NombreArchivoGuardado varchar(150)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from ShowRoom.OfertaShowRoomDetalleLog
set @NumeroLote = @NumeroLote + 1 

insert into ShowRoom.OfertaShowRoomDetalleLog
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,Imagen,Posicion,MarcaProducto,
NombreArchivoCargado,NombreArchivoGuardado,FechaEliminacion,UsuarioEncargado,NumeroLote)
select o.CampaniaID,o.CUV,o.NombreProducto,o.Descripcion1,o.Descripcion2,o.Descripcion3,o.Imagen,o.Posicion,o.MarcaProducto,
@NombreArchivoCargado,@NombreArchivoGuardado,@FechaGeneral,@UsuarioCreacion,@NumeroLote
from ShowRoom.OfertaShowRoomDetalle o
left join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
where 
	o.CampaniaID = @CampaniaID 
	and t.CUV is null

delete from ShowRoom.OfertaShowRoomDetalle
where OfertaShowRoomDetalleID in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
		left join @OfertaShowRoomDetalle t on
		o.CUV = t.CUV
		and o.Posicion = t.Posicion
		where o.CampaniaID = @CampaniaID and t.CUV is null)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion	
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,t.CUV,t.NombreProducto,t.Descripcion1,t.Descripcion2,t.Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,t.Posicion,t.MarcaProducto
from @OfertaShowRoomDetalle t
left join ShowRoom.OfertaShowRoomDetalle o on
	t.CUV = o.CUV
	and t.Posicion = o.Posicion
	and o.CampaniaID = @CampaniaID
where 	
	o.CUV is null

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

GO

USE BelcorpVenezuela
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[OfertaShowRoomDetalleLog]') AND (type = 'U') )
 DROP TABLE ShowRoom.OfertaShowRoomDetalleLog
GO

create table ShowRoom.OfertaShowRoomDetalleLog
(
OfertaShowRoomDetalleLog int identity(1,1) primary key,
CampaniaID int,
CUV varchar(20),
NombreProducto varchar(100),
Descripcion1 varchar(150),
Descripcion2 varchar(150),
Descripcion3 varchar(150),
Imagen varchar(150),
Posicion int,
MarcaProducto varchar(100),
NombreArchivoCargado varchar(150),
NombreArchivoGuardado varchar(150),
FechaEliminacion datetime,
UsuarioEncargado varchar(100),
NumeroLote int
)

go

alter procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50),
@NombreArchivoCargado varchar(150),
@NombreArchivoGuardado varchar(150)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from ShowRoom.OfertaShowRoomDetalleLog
set @NumeroLote = @NumeroLote + 1 

insert into ShowRoom.OfertaShowRoomDetalleLog
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,Imagen,Posicion,MarcaProducto,
NombreArchivoCargado,NombreArchivoGuardado,FechaEliminacion,UsuarioEncargado,NumeroLote)
select o.CampaniaID,o.CUV,o.NombreProducto,o.Descripcion1,o.Descripcion2,o.Descripcion3,o.Imagen,o.Posicion,o.MarcaProducto,
@NombreArchivoCargado,@NombreArchivoGuardado,@FechaGeneral,@UsuarioCreacion,@NumeroLote
from ShowRoom.OfertaShowRoomDetalle o
left join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
where 
	o.CampaniaID = @CampaniaID 
	and t.CUV is null

delete from ShowRoom.OfertaShowRoomDetalle
where OfertaShowRoomDetalleID in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
		left join @OfertaShowRoomDetalle t on
		o.CUV = t.CUV
		and o.Posicion = t.Posicion
		where o.CampaniaID = @CampaniaID and t.CUV is null)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion	
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,t.CUV,t.NombreProducto,t.Descripcion1,t.Descripcion2,t.Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,t.Posicion,t.MarcaProducto
from @OfertaShowRoomDetalle t
left join ShowRoom.OfertaShowRoomDetalle o on
	t.CUV = o.CUV
	and t.Posicion = o.Posicion
	and o.CampaniaID = @CampaniaID
where 	
	o.CUV is null

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

GO

USE BelcorpSalvador
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[OfertaShowRoomDetalleLog]') AND (type = 'U') )
 DROP TABLE ShowRoom.OfertaShowRoomDetalleLog
GO

create table ShowRoom.OfertaShowRoomDetalleLog
(
OfertaShowRoomDetalleLog int identity(1,1) primary key,
CampaniaID int,
CUV varchar(20),
NombreProducto varchar(100),
Descripcion1 varchar(150),
Descripcion2 varchar(150),
Descripcion3 varchar(150),
Imagen varchar(150),
Posicion int,
MarcaProducto varchar(100),
NombreArchivoCargado varchar(150),
NombreArchivoGuardado varchar(150),
FechaEliminacion datetime,
UsuarioEncargado varchar(100),
NumeroLote int
)

go

alter procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50),
@NombreArchivoCargado varchar(150),
@NombreArchivoGuardado varchar(150)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from ShowRoom.OfertaShowRoomDetalleLog
set @NumeroLote = @NumeroLote + 1 

insert into ShowRoom.OfertaShowRoomDetalleLog
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,Imagen,Posicion,MarcaProducto,
NombreArchivoCargado,NombreArchivoGuardado,FechaEliminacion,UsuarioEncargado,NumeroLote)
select o.CampaniaID,o.CUV,o.NombreProducto,o.Descripcion1,o.Descripcion2,o.Descripcion3,o.Imagen,o.Posicion,o.MarcaProducto,
@NombreArchivoCargado,@NombreArchivoGuardado,@FechaGeneral,@UsuarioCreacion,@NumeroLote
from ShowRoom.OfertaShowRoomDetalle o
left join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
where 
	o.CampaniaID = @CampaniaID 
	and t.CUV is null

delete from ShowRoom.OfertaShowRoomDetalle
where OfertaShowRoomDetalleID in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
		left join @OfertaShowRoomDetalle t on
		o.CUV = t.CUV
		and o.Posicion = t.Posicion
		where o.CampaniaID = @CampaniaID and t.CUV is null)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion	
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,t.CUV,t.NombreProducto,t.Descripcion1,t.Descripcion2,t.Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,t.Posicion,t.MarcaProducto
from @OfertaShowRoomDetalle t
left join ShowRoom.OfertaShowRoomDetalle o on
	t.CUV = o.CUV
	and t.Posicion = o.Posicion
	and o.CampaniaID = @CampaniaID
where 	
	o.CUV is null

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

GO

USE BelcorpPuertoRico
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[OfertaShowRoomDetalleLog]') AND (type = 'U') )
 DROP TABLE ShowRoom.OfertaShowRoomDetalleLog
GO

create table ShowRoom.OfertaShowRoomDetalleLog
(
OfertaShowRoomDetalleLog int identity(1,1) primary key,
CampaniaID int,
CUV varchar(20),
NombreProducto varchar(100),
Descripcion1 varchar(150),
Descripcion2 varchar(150),
Descripcion3 varchar(150),
Imagen varchar(150),
Posicion int,
MarcaProducto varchar(100),
NombreArchivoCargado varchar(150),
NombreArchivoGuardado varchar(150),
FechaEliminacion datetime,
UsuarioEncargado varchar(100),
NumeroLote int
)

go

alter procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50),
@NombreArchivoCargado varchar(150),
@NombreArchivoGuardado varchar(150)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from ShowRoom.OfertaShowRoomDetalleLog
set @NumeroLote = @NumeroLote + 1 

insert into ShowRoom.OfertaShowRoomDetalleLog
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,Imagen,Posicion,MarcaProducto,
NombreArchivoCargado,NombreArchivoGuardado,FechaEliminacion,UsuarioEncargado,NumeroLote)
select o.CampaniaID,o.CUV,o.NombreProducto,o.Descripcion1,o.Descripcion2,o.Descripcion3,o.Imagen,o.Posicion,o.MarcaProducto,
@NombreArchivoCargado,@NombreArchivoGuardado,@FechaGeneral,@UsuarioCreacion,@NumeroLote
from ShowRoom.OfertaShowRoomDetalle o
left join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
where 
	o.CampaniaID = @CampaniaID 
	and t.CUV is null

delete from ShowRoom.OfertaShowRoomDetalle
where OfertaShowRoomDetalleID in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
		left join @OfertaShowRoomDetalle t on
		o.CUV = t.CUV
		and o.Posicion = t.Posicion
		where o.CampaniaID = @CampaniaID and t.CUV is null)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion	
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,t.CUV,t.NombreProducto,t.Descripcion1,t.Descripcion2,t.Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,t.Posicion,t.MarcaProducto
from @OfertaShowRoomDetalle t
left join ShowRoom.OfertaShowRoomDetalle o on
	t.CUV = o.CUV
	and t.Posicion = o.Posicion
	and o.CampaniaID = @CampaniaID
where 	
	o.CUV is null

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

GO

USE BelcorpPanama
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[OfertaShowRoomDetalleLog]') AND (type = 'U') )
 DROP TABLE ShowRoom.OfertaShowRoomDetalleLog
GO

create table ShowRoom.OfertaShowRoomDetalleLog
(
OfertaShowRoomDetalleLog int identity(1,1) primary key,
CampaniaID int,
CUV varchar(20),
NombreProducto varchar(100),
Descripcion1 varchar(150),
Descripcion2 varchar(150),
Descripcion3 varchar(150),
Imagen varchar(150),
Posicion int,
MarcaProducto varchar(100),
NombreArchivoCargado varchar(150),
NombreArchivoGuardado varchar(150),
FechaEliminacion datetime,
UsuarioEncargado varchar(100),
NumeroLote int
)

go

alter procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50),
@NombreArchivoCargado varchar(150),
@NombreArchivoGuardado varchar(150)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from ShowRoom.OfertaShowRoomDetalleLog
set @NumeroLote = @NumeroLote + 1 

insert into ShowRoom.OfertaShowRoomDetalleLog
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,Imagen,Posicion,MarcaProducto,
NombreArchivoCargado,NombreArchivoGuardado,FechaEliminacion,UsuarioEncargado,NumeroLote)
select o.CampaniaID,o.CUV,o.NombreProducto,o.Descripcion1,o.Descripcion2,o.Descripcion3,o.Imagen,o.Posicion,o.MarcaProducto,
@NombreArchivoCargado,@NombreArchivoGuardado,@FechaGeneral,@UsuarioCreacion,@NumeroLote
from ShowRoom.OfertaShowRoomDetalle o
left join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
where 
	o.CampaniaID = @CampaniaID 
	and t.CUV is null

delete from ShowRoom.OfertaShowRoomDetalle
where OfertaShowRoomDetalleID in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
		left join @OfertaShowRoomDetalle t on
		o.CUV = t.CUV
		and o.Posicion = t.Posicion
		where o.CampaniaID = @CampaniaID and t.CUV is null)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion	
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,t.CUV,t.NombreProducto,t.Descripcion1,t.Descripcion2,t.Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,t.Posicion,t.MarcaProducto
from @OfertaShowRoomDetalle t
left join ShowRoom.OfertaShowRoomDetalle o on
	t.CUV = o.CUV
	and t.Posicion = o.Posicion
	and o.CampaniaID = @CampaniaID
where 	
	o.CUV is null

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

GO

USE BelcorpGuatemala
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[OfertaShowRoomDetalleLog]') AND (type = 'U') )
 DROP TABLE ShowRoom.OfertaShowRoomDetalleLog
GO

create table ShowRoom.OfertaShowRoomDetalleLog
(
OfertaShowRoomDetalleLog int identity(1,1) primary key,
CampaniaID int,
CUV varchar(20),
NombreProducto varchar(100),
Descripcion1 varchar(150),
Descripcion2 varchar(150),
Descripcion3 varchar(150),
Imagen varchar(150),
Posicion int,
MarcaProducto varchar(100),
NombreArchivoCargado varchar(150),
NombreArchivoGuardado varchar(150),
FechaEliminacion datetime,
UsuarioEncargado varchar(100),
NumeroLote int
)

go

alter procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50),
@NombreArchivoCargado varchar(150),
@NombreArchivoGuardado varchar(150)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from ShowRoom.OfertaShowRoomDetalleLog
set @NumeroLote = @NumeroLote + 1 

insert into ShowRoom.OfertaShowRoomDetalleLog
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,Imagen,Posicion,MarcaProducto,
NombreArchivoCargado,NombreArchivoGuardado,FechaEliminacion,UsuarioEncargado,NumeroLote)
select o.CampaniaID,o.CUV,o.NombreProducto,o.Descripcion1,o.Descripcion2,o.Descripcion3,o.Imagen,o.Posicion,o.MarcaProducto,
@NombreArchivoCargado,@NombreArchivoGuardado,@FechaGeneral,@UsuarioCreacion,@NumeroLote
from ShowRoom.OfertaShowRoomDetalle o
left join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
where 
	o.CampaniaID = @CampaniaID 
	and t.CUV is null

delete from ShowRoom.OfertaShowRoomDetalle
where OfertaShowRoomDetalleID in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
		left join @OfertaShowRoomDetalle t on
		o.CUV = t.CUV
		and o.Posicion = t.Posicion
		where o.CampaniaID = @CampaniaID and t.CUV is null)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion	
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,t.CUV,t.NombreProducto,t.Descripcion1,t.Descripcion2,t.Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,t.Posicion,t.MarcaProducto
from @OfertaShowRoomDetalle t
left join ShowRoom.OfertaShowRoomDetalle o on
	t.CUV = o.CUV
	and t.Posicion = o.Posicion
	and o.CampaniaID = @CampaniaID
where 	
	o.CUV is null

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

GO

USE BelcorpEcuador
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[OfertaShowRoomDetalleLog]') AND (type = 'U') )
 DROP TABLE ShowRoom.OfertaShowRoomDetalleLog
GO

create table ShowRoom.OfertaShowRoomDetalleLog
(
OfertaShowRoomDetalleLog int identity(1,1) primary key,
CampaniaID int,
CUV varchar(20),
NombreProducto varchar(100),
Descripcion1 varchar(150),
Descripcion2 varchar(150),
Descripcion3 varchar(150),
Imagen varchar(150),
Posicion int,
MarcaProducto varchar(100),
NombreArchivoCargado varchar(150),
NombreArchivoGuardado varchar(150),
FechaEliminacion datetime,
UsuarioEncargado varchar(100),
NumeroLote int
)

go

alter procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50),
@NombreArchivoCargado varchar(150),
@NombreArchivoGuardado varchar(150)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from ShowRoom.OfertaShowRoomDetalleLog
set @NumeroLote = @NumeroLote + 1 

insert into ShowRoom.OfertaShowRoomDetalleLog
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,Imagen,Posicion,MarcaProducto,
NombreArchivoCargado,NombreArchivoGuardado,FechaEliminacion,UsuarioEncargado,NumeroLote)
select o.CampaniaID,o.CUV,o.NombreProducto,o.Descripcion1,o.Descripcion2,o.Descripcion3,o.Imagen,o.Posicion,o.MarcaProducto,
@NombreArchivoCargado,@NombreArchivoGuardado,@FechaGeneral,@UsuarioCreacion,@NumeroLote
from ShowRoom.OfertaShowRoomDetalle o
left join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
where 
	o.CampaniaID = @CampaniaID 
	and t.CUV is null

delete from ShowRoom.OfertaShowRoomDetalle
where OfertaShowRoomDetalleID in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
		left join @OfertaShowRoomDetalle t on
		o.CUV = t.CUV
		and o.Posicion = t.Posicion
		where o.CampaniaID = @CampaniaID and t.CUV is null)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion	
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,t.CUV,t.NombreProducto,t.Descripcion1,t.Descripcion2,t.Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,t.Posicion,t.MarcaProducto
from @OfertaShowRoomDetalle t
left join ShowRoom.OfertaShowRoomDetalle o on
	t.CUV = o.CUV
	and t.Posicion = o.Posicion
	and o.CampaniaID = @CampaniaID
where 	
	o.CUV is null

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

GO

USE BelcorpDominicana
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[OfertaShowRoomDetalleLog]') AND (type = 'U') )
 DROP TABLE ShowRoom.OfertaShowRoomDetalleLog
GO

create table ShowRoom.OfertaShowRoomDetalleLog
(
OfertaShowRoomDetalleLog int identity(1,1) primary key,
CampaniaID int,
CUV varchar(20),
NombreProducto varchar(100),
Descripcion1 varchar(150),
Descripcion2 varchar(150),
Descripcion3 varchar(150),
Imagen varchar(150),
Posicion int,
MarcaProducto varchar(100),
NombreArchivoCargado varchar(150),
NombreArchivoGuardado varchar(150),
FechaEliminacion datetime,
UsuarioEncargado varchar(100),
NumeroLote int
)

go

alter procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50),
@NombreArchivoCargado varchar(150),
@NombreArchivoGuardado varchar(150)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from ShowRoom.OfertaShowRoomDetalleLog
set @NumeroLote = @NumeroLote + 1 

insert into ShowRoom.OfertaShowRoomDetalleLog
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,Imagen,Posicion,MarcaProducto,
NombreArchivoCargado,NombreArchivoGuardado,FechaEliminacion,UsuarioEncargado,NumeroLote)
select o.CampaniaID,o.CUV,o.NombreProducto,o.Descripcion1,o.Descripcion2,o.Descripcion3,o.Imagen,o.Posicion,o.MarcaProducto,
@NombreArchivoCargado,@NombreArchivoGuardado,@FechaGeneral,@UsuarioCreacion,@NumeroLote
from ShowRoom.OfertaShowRoomDetalle o
left join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
where 
	o.CampaniaID = @CampaniaID 
	and t.CUV is null

delete from ShowRoom.OfertaShowRoomDetalle
where OfertaShowRoomDetalleID in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
		left join @OfertaShowRoomDetalle t on
		o.CUV = t.CUV
		and o.Posicion = t.Posicion
		where o.CampaniaID = @CampaniaID and t.CUV is null)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion	
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,t.CUV,t.NombreProducto,t.Descripcion1,t.Descripcion2,t.Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,t.Posicion,t.MarcaProducto
from @OfertaShowRoomDetalle t
left join ShowRoom.OfertaShowRoomDetalle o on
	t.CUV = o.CUV
	and t.Posicion = o.Posicion
	and o.CampaniaID = @CampaniaID
where 	
	o.CUV is null

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

GO

USE BelcorpCostaRica
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[OfertaShowRoomDetalleLog]') AND (type = 'U') )
 DROP TABLE ShowRoom.OfertaShowRoomDetalleLog
GO

create table ShowRoom.OfertaShowRoomDetalleLog
(
OfertaShowRoomDetalleLog int identity(1,1) primary key,
CampaniaID int,
CUV varchar(20),
NombreProducto varchar(100),
Descripcion1 varchar(150),
Descripcion2 varchar(150),
Descripcion3 varchar(150),
Imagen varchar(150),
Posicion int,
MarcaProducto varchar(100),
NombreArchivoCargado varchar(150),
NombreArchivoGuardado varchar(150),
FechaEliminacion datetime,
UsuarioEncargado varchar(100),
NumeroLote int
)

go

alter procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50),
@NombreArchivoCargado varchar(150),
@NombreArchivoGuardado varchar(150)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from ShowRoom.OfertaShowRoomDetalleLog
set @NumeroLote = @NumeroLote + 1 

insert into ShowRoom.OfertaShowRoomDetalleLog
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,Imagen,Posicion,MarcaProducto,
NombreArchivoCargado,NombreArchivoGuardado,FechaEliminacion,UsuarioEncargado,NumeroLote)
select o.CampaniaID,o.CUV,o.NombreProducto,o.Descripcion1,o.Descripcion2,o.Descripcion3,o.Imagen,o.Posicion,o.MarcaProducto,
@NombreArchivoCargado,@NombreArchivoGuardado,@FechaGeneral,@UsuarioCreacion,@NumeroLote
from ShowRoom.OfertaShowRoomDetalle o
left join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
where 
	o.CampaniaID = @CampaniaID 
	and t.CUV is null

delete from ShowRoom.OfertaShowRoomDetalle
where OfertaShowRoomDetalleID in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
		left join @OfertaShowRoomDetalle t on
		o.CUV = t.CUV
		and o.Posicion = t.Posicion
		where o.CampaniaID = @CampaniaID and t.CUV is null)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion	
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,t.CUV,t.NombreProducto,t.Descripcion1,t.Descripcion2,t.Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,t.Posicion,t.MarcaProducto
from @OfertaShowRoomDetalle t
left join ShowRoom.OfertaShowRoomDetalle o on
	t.CUV = o.CUV
	and t.Posicion = o.Posicion
	and o.CampaniaID = @CampaniaID
where 	
	o.CUV is null

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

GO

USE BelcorpChile
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[OfertaShowRoomDetalleLog]') AND (type = 'U') )
 DROP TABLE ShowRoom.OfertaShowRoomDetalleLog
GO

create table ShowRoom.OfertaShowRoomDetalleLog
(
OfertaShowRoomDetalleLog int identity(1,1) primary key,
CampaniaID int,
CUV varchar(20),
NombreProducto varchar(100),
Descripcion1 varchar(150),
Descripcion2 varchar(150),
Descripcion3 varchar(150),
Imagen varchar(150),
Posicion int,
MarcaProducto varchar(100),
NombreArchivoCargado varchar(150),
NombreArchivoGuardado varchar(150),
FechaEliminacion datetime,
UsuarioEncargado varchar(100),
NumeroLote int
)

go

alter procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50),
@NombreArchivoCargado varchar(150),
@NombreArchivoGuardado varchar(150)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from ShowRoom.OfertaShowRoomDetalleLog
set @NumeroLote = @NumeroLote + 1 

insert into ShowRoom.OfertaShowRoomDetalleLog
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,Imagen,Posicion,MarcaProducto,
NombreArchivoCargado,NombreArchivoGuardado,FechaEliminacion,UsuarioEncargado,NumeroLote)
select o.CampaniaID,o.CUV,o.NombreProducto,o.Descripcion1,o.Descripcion2,o.Descripcion3,o.Imagen,o.Posicion,o.MarcaProducto,
@NombreArchivoCargado,@NombreArchivoGuardado,@FechaGeneral,@UsuarioCreacion,@NumeroLote
from ShowRoom.OfertaShowRoomDetalle o
left join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
where 
	o.CampaniaID = @CampaniaID 
	and t.CUV is null

delete from ShowRoom.OfertaShowRoomDetalle
where OfertaShowRoomDetalleID in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
		left join @OfertaShowRoomDetalle t on
		o.CUV = t.CUV
		and o.Posicion = t.Posicion
		where o.CampaniaID = @CampaniaID and t.CUV is null)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion	
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,t.CUV,t.NombreProducto,t.Descripcion1,t.Descripcion2,t.Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,t.Posicion,t.MarcaProducto
from @OfertaShowRoomDetalle t
left join ShowRoom.OfertaShowRoomDetalle o on
	t.CUV = o.CUV
	and t.Posicion = o.Posicion
	and o.CampaniaID = @CampaniaID
where 	
	o.CUV is null

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

GO

USE BelcorpBolivia
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ShowRoom].[OfertaShowRoomDetalleLog]') AND (type = 'U') )
 DROP TABLE ShowRoom.OfertaShowRoomDetalleLog
GO

create table ShowRoom.OfertaShowRoomDetalleLog
(
OfertaShowRoomDetalleLog int identity(1,1) primary key,
CampaniaID int,
CUV varchar(20),
NombreProducto varchar(100),
Descripcion1 varchar(150),
Descripcion2 varchar(150),
Descripcion3 varchar(150),
Imagen varchar(150),
Posicion int,
MarcaProducto varchar(100),
NombreArchivoCargado varchar(150),
NombreArchivoGuardado varchar(150),
FechaEliminacion datetime,
UsuarioEncargado varchar(100),
NumeroLote int
)

go

alter procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50),
@NombreArchivoCargado varchar(150),
@NombreArchivoGuardado varchar(150)
as
begin

begin tran

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from ShowRoom.OfertaShowRoomDetalleLog
set @NumeroLote = @NumeroLote + 1 

insert into ShowRoom.OfertaShowRoomDetalleLog
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,Imagen,Posicion,MarcaProducto,
NombreArchivoCargado,NombreArchivoGuardado,FechaEliminacion,UsuarioEncargado,NumeroLote)
select o.CampaniaID,o.CUV,o.NombreProducto,o.Descripcion1,o.Descripcion2,o.Descripcion3,o.Imagen,o.Posicion,o.MarcaProducto,
@NombreArchivoCargado,@NombreArchivoGuardado,@FechaGeneral,@UsuarioCreacion,@NumeroLote
from ShowRoom.OfertaShowRoomDetalle o
left join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
where 
	o.CampaniaID = @CampaniaID 
	and t.CUV is null

delete from ShowRoom.OfertaShowRoomDetalle
where OfertaShowRoomDetalleID in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
		left join @OfertaShowRoomDetalle t on
		o.CUV = t.CUV
		and o.Posicion = t.Posicion
		where o.CampaniaID = @CampaniaID and t.CUV is null)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion,
	MarcaProducto = t.MarcaProducto
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion	
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,
FechaModificacion,UsuarioModificacion,Posicion,MarcaProducto)
select @CampaniaID,t.CUV,t.NombreProducto,t.Descripcion1,t.Descripcion2,t.Descripcion3,getdate(),@UsuarioCreacion,
getdate(),@UsuarioCreacion,t.Posicion,t.MarcaProducto
from @OfertaShowRoomDetalle t
left join ShowRoom.OfertaShowRoomDetalle o on
	t.CUV = o.CUV
	and t.Posicion = o.Posicion
	and o.CampaniaID = @CampaniaID
where 	
	o.CUV is null

end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

GO