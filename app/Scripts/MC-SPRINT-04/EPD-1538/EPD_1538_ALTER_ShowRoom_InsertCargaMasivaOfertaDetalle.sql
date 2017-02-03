

USE BelcorpBolivia
GO

DROP PROCEDURE ShowRoom.InsertCargaMasivaOfertaDetalle
DROP TYPE ShowRoom.OfertaShowRoomDetalleType

IF NOT EXISTS (
		SELECT *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE COLUMN_NAME = 'Posicion' AND TABLE_SCHEMA = 'ShowRoom' AND TABLE_NAME = 'OfertaShowRoomDetalle'
		)
		BEGIN
		  ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD Posicion INT NULL
		END

/****** Object:  UserDefinedTableType [ShowRoom].[OfertaShowRoomDetalleType]    Script Date: 25/01/2017 06:27:28 p.m. ******/
CREATE TYPE [ShowRoom].[OfertaShowRoomDetalleType] AS TABLE(
	CUV varchar(20) NULL,
	NombreSet varchar(250) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL
)
GO

ALTER procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as
begin
begin tran
declare @tablaSets table (CUV varchar(20), NombreSet varchar(250))

insert into @tablaSets
select distinct CUV, NombreSet from @OfertaShowRoomDetalle

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

	delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion)
select 
	@CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion, Posicion
	from @OfertaShowRoomDetalle
	where NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)

update ShowRoom.OfertaShowRoom
set Descripcion = t.NombreSet
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
c.CampaniaID = o.CampaniaID
inner join @tablaSets t on
	o.CUV = t.CUV
where c.Codigo = @CampaniaID
end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END
GO

/*end*/

USE BelcorpChile
GO

DROP PROCEDURE ShowRoom.InsertCargaMasivaOfertaDetalle
DROP TYPE ShowRoom.OfertaShowRoomDetalleType

IF NOT EXISTS (
		SELECT *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE COLUMN_NAME = 'Posicion' AND TABLE_SCHEMA = 'ShowRoom' AND TABLE_NAME = 'OfertaShowRoomDetalle'
		)
		BEGIN
		  ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD Posicion INT NULL
		END

/****** Object:  UserDefinedTableType [ShowRoom].[OfertaShowRoomDetalleType]    Script Date: 25/01/2017 06:27:28 p.m. ******/
CREATE TYPE [ShowRoom].[OfertaShowRoomDetalleType] AS TABLE(
	CUV varchar(20) NULL,
	NombreSet varchar(250) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL
)
GO

ALTER procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as
begin

begin tran

declare @tablaSets table (CUV varchar(20), NombreSet varchar(250))

insert into @tablaSets
select distinct CUV, NombreSet from @OfertaShowRoomDetalle

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()
	
	delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion)
select 
	@CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion,Posicion
from @OfertaShowRoomDetalle
where NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)

update
 ShowRoom.OfertaShowRoom
set Descripcion = t.NombreSet
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	c.CampaniaID = o.CampaniaID
inner join @tablaSets t on
	o.CUV = t.CUV
where 
	c.Codigo = @CampaniaID
end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

GO

/*end*/

USE BelcorpColombia
GO

DROP PROCEDURE ShowRoom.InsertCargaMasivaOfertaDetalle
DROP TYPE ShowRoom.OfertaShowRoomDetalleType

IF NOT EXISTS (
		SELECT *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE COLUMN_NAME = 'Posicion' AND TABLE_SCHEMA = 'ShowRoom' AND TABLE_NAME = 'OfertaShowRoomDetalle'
		)
		BEGIN
		  ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD Posicion INT NULL
		END

/****** Object:  UserDefinedTableType [ShowRoom].[OfertaShowRoomDetalleType]    Script Date: 25/01/2017 06:27:28 p.m. ******/
CREATE TYPE [ShowRoom].[OfertaShowRoomDetalleType] AS TABLE(
	CUV varchar(20) NULL,
	NombreSet varchar(250) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL
)
GO

ALTER procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as
begin

begin tran

declare @tablaSets table (CUV varchar(20), NombreSet varchar(
250))

insert into @tablaSets
select distinct CUV, NombreSet from @OfertaShowRoomDetalle

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion,Posicion
from @OfertaShowRoomDetalle
where 
	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)

update ShowRoom.OfertaShowRoom
set Descripcion = t.NombreSet
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	c.CampaniaID = o.CampaniaID
inner join @tablaSets t on
	o.CUV = t.CUV
where 
	c.Codigo = @CampaniaID
end

commit tran

IF (@@ERROR <> 0) BEGIN
PRINT 'Error Inesperado!'
    ROLLBACK TRAN
END

GO

/*end*/

USE BelcorpCostaRica
GO

DROP PROCEDURE ShowRoom.InsertCargaMasivaOfertaDetalle
DROP TYPE ShowRoom.OfertaShowRoomDetalleType

IF NOT EXISTS (
		SELECT *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE COLUMN_NAME = 'Posicion' AND TABLE_SCHEMA = 'ShowRoom' AND TABLE_NAME = 'OfertaShowRoomDetalle'
		)
		BEGIN
		  ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD Posicion INT NULL
		END

/****** Object:  UserDefinedTableType [ShowRoom].[OfertaShowRoomDetalleType]    Script Date: 25/01/2017 06:27:28 p.m. ******/
CREATE TYPE [ShowRoom].[OfertaShowRoomDetalleType] AS TABLE(
	CUV varchar(20) NULL,
	NombreSet varchar(250) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL
)
GO

ALTER procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as

begin

begin tran
declare @tablaSets table (CUV varchar(20), NombreSet varchar(250))

insert into @tablaSets
select distinct CUV, NombreSet from @OfertaShowRoomDetalle

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,

	Descripcion1 = t.Descripcion1,

	Descripcion2 = t.Descripcion2,

	Descripcion3 = t.Descripcion3,

	UsuarioModificacion = @UsuarioCreacion

from ShowRoom.OfertaShowRoomDetalle o

inner join @OfertaShowRoomDetalle t on	

	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto

where

	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle

(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion)

select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion,Posicion
from @OfertaShowRoomDetalle
where NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID

		and o.CUV = CUV)

update ShowRoom.OfertaShowRoom
set Descripcion = t.NombreSet
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	c.CampaniaID = o.CampaniaID
inner join @tablaSets t on
	o.CUV = t.CUV
where 
	c.Codigo = @CampaniaID
end

commit tran

IF (@@ERROR <> 0) BEGIN

PRINT 'Error Inesperado!'

    ROLLBACK TRAN

END

GO

/*end*/

USE BelcorpDominicana
GO

DROP PROCEDURE ShowRoom.InsertCargaMasivaOfertaDetalle
DROP TYPE ShowRoom.OfertaShowRoomDetalleType

IF NOT EXISTS (
		SELECT *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE COLUMN_NAME = 'Posicion' AND TABLE_SCHEMA = 'ShowRoom' AND TABLE_NAME = 'OfertaShowRoomDetalle'
		)
		BEGIN
		  ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD Posicion INT NULL
		END

/****** Object:  UserDefinedTableType [ShowRoom].[OfertaShowRoomDetalleType]    Script Date: 25/01/2017 06:27:28 p.m. ******/
CREATE TYPE [ShowRoom].[OfertaShowRoomDetalleType] AS TABLE(
	CUV varchar(20) NULL,
	NombreSet varchar(250) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL
)
GO

ALTER procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as

begin



begin tran


declare @tablaSets table (CUV varchar(20), NombreSet varchar(250))

insert into @tablaSets
select distinct CUV, NombreSet from @OfertaShowRoomDetalle


DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	



insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion,Posicion
from @OfertaShowRoomDetalle
where NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)



update ShowRoom.OfertaShowRoom

set Descripcion = t.NombreSet

from ShowRoom.OfertaShowRoom o

inner join ods.Campania c on

	c.CampaniaID = o.CampaniaID

inner join @tablaSets t on

	o.CUV = t.CUV

where 

	c.Codigo = @CampaniaID

end



commit tran



IF (@@ERROR <> 0) BEGIN

PRINT 'Error Inesperado!'

    ROLLBACK TRAN

END

GO

/*end*/

USE BelcorpEcuador
GO

DROP PROCEDURE ShowRoom.InsertCargaMasivaOfertaDetalle
DROP TYPE ShowRoom.OfertaShowRoomDetalleType

IF NOT EXISTS (
		SELECT *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE COLUMN_NAME = 'Posicion' AND TABLE_SCHEMA = 'ShowRoom' AND TABLE_NAME = 'OfertaShowRoomDetalle'
		)
		BEGIN
		  ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD Posicion INT NULL
		END

/****** Object:  UserDefinedTableType [ShowRoom].[OfertaShowRoomDetalleType]    Script Date: 25/01/2017 06:27:28 p.m. ******/
CREATE TYPE [ShowRoom].[OfertaShowRoomDetalleType] AS TABLE(
	CUV varchar(20) NULL,
	NombreSet varchar(250) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL
)
GO

ALTER procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as

begin



begin tran

declare @tablaSets table (CUV varchar(20), NombreSet varchar(250))
insert into @tablaSets
select distinct CUV, NombreSet from @OfertaShowRoomDetalle

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle

set NombreProducto = t.NombreProducto,

	Descripcion1 = t.Descripcion1,

	Descripcion2 = t.Descripcion2,

	Descripcion3 = t.Descripcion3,

	UsuarioModificacion = @UsuarioCreacion

from ShowRoom.OfertaShowRoomDetalle o

inner join @OfertaShowRoomDetalle t on	

	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto

where

	o.CampaniaID = @CampaniaID	



insert into ShowRoom.OfertaShowRoomDetalle

(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion)

select 

@CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion,Posicion

from @OfertaShowRoomDetalle

where 

	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID

		and o.CUV = CUV)



update ShowRoom.OfertaShowRoom

set Descripcion = t.NombreSet

from ShowRoom.OfertaShowRoom o

inner join ods.Campania c on

	c.CampaniaID = o.CampaniaID

inner join @tablaSets t on

	o.CUV = t.CUV

where 

	c.Codigo = @CampaniaID

end



commit tran



IF (@@ERROR <> 0) BEGIN

PRINT 'Error Inesperado!'

    ROLLBACK TRAN

END

GO
/*end*/

USE BelcorpGuatemala
GO

DROP PROCEDURE ShowRoom.InsertCargaMasivaOfertaDetalle
DROP TYPE ShowRoom.OfertaShowRoomDetalleType

IF NOT EXISTS (
		SELECT *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE COLUMN_NAME = 'Posicion' AND TABLE_SCHEMA = 'ShowRoom' AND TABLE_NAME = 'OfertaShowRoomDetalle'
		)
		BEGIN
		  ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD Posicion INT NULL
		END

/****** Object:  UserDefinedTableType [ShowRoom].[OfertaShowRoomDetalleType]    Script Date: 25/01/2017 06:27:28 p.m. ******/
CREATE TYPE [ShowRoom].[OfertaShowRoomDetalleType] AS TABLE(
	CUV varchar(20) NULL,
	NombreSet varchar(250) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL
)
GO

ALTER procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as

begin
begin tran

declare @tablaSets table (CUV varchar(20), NombreSet varchar(250))

insert into @tablaSets

select distinct CUV, NombreSet from @OfertaShowRoomDetalle

DECLARE @FechaGeneral DATETIME    

    

SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle

set NombreProducto = t.NombreProducto,

	Descripcion1 = t.Descripcion1,

	Descripcion2 = t.Descripcion2,

	Descripcion3 = t.Descripcion3,

	UsuarioModificacion = @UsuarioCreacion

from ShowRoom.OfertaShowRoomDetalle o

inner join @OfertaShowRoomDetalle t on	

	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto

where

	o.CampaniaID = @CampaniaID	



insert into ShowRoom.OfertaShowRoomDetalle

(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion)

select 

@CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion,Posicion

from @OfertaShowRoomDetalle

where 

	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID

		and o.CUV = CUV)



update ShowRoom.OfertaShowRoom

set Descripcion = t.NombreSet

from ShowRoom.OfertaShowRoom o

inner join ods.Campania c on

	c.CampaniaID = o.CampaniaID

inner join @tablaSets t on

	o.CUV = t.CUV

where 

	c.Codigo = @CampaniaID

end



commit tran



IF (@@ERROR <> 0) BEGIN

PRINT 'Error Inesperado!'

    ROLLBACK TRAN

END

GO

/*end*/

USE BelcorpMexico
GO

DROP PROCEDURE ShowRoom.InsertCargaMasivaOfertaDetalle
DROP TYPE ShowRoom.OfertaShowRoomDetalleType

IF NOT EXISTS (
		SELECT *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE COLUMN_NAME = 'Posicion' AND TABLE_SCHEMA = 'ShowRoom' AND TABLE_NAME = 'OfertaShowRoomDetalle'
		)
		BEGIN
		  ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD Posicion INT NULL
		END

/****** Object:  UserDefinedTableType [ShowRoom].[OfertaShowRoomDetalleType]    Script Date: 25/01/2017 06:27:28 p.m. ******/
CREATE TYPE [ShowRoom].[OfertaShowRoomDetalleType] AS TABLE(
	CUV varchar(20) NULL,
	NombreSet varchar(250) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL
)
GO

ALTER procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as

begin

begin tran

declare @tablaSets table (CUV varchar(20), NombreSet varchar(250))

insert into @tablaSets
select distinct CUV, NombreSet from @OfertaShowRoomDetalle

DECLARE @FechaGeneral DATETIME        

SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,

	Descripcion2 = t.Descripcion2,

	Descripcion3 = t.Descripcion3,

	UsuarioModificacion = @UsuarioCreacion

from ShowRoom.OfertaShowRoomDetalle o

inner join @OfertaShowRoomDetalle t on	

	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto

where

	o.CampaniaID = @CampaniaID	



insert into ShowRoom.OfertaShowRoomDetalle

(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion)

select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion,Posicion
from @OfertaShowRoomDetalle
where 
	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID

		and o.CUV = CUV)

update ShowRoom.OfertaShowRoom

set Descripcion = t.NombreSet

from ShowRoom.OfertaShowRoom o

inner join ods.Campania c on

	c.CampaniaID = o.CampaniaID

inner join @tablaSets t on

	o.CUV = t.CUV

where 

	c.Codigo = @CampaniaID

end

commit tran

IF (@@ERROR <> 0) BEGIN

PRINT 'Error Inesperado!'

    ROLLBACK TRAN

END

GO

/*end*/

USE BelcorpPanama
GO

DROP PROCEDURE ShowRoom.InsertCargaMasivaOfertaDetalle
DROP TYPE ShowRoom.OfertaShowRoomDetalleType

IF NOT EXISTS (
		SELECT *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE COLUMN_NAME = 'Posicion' AND TABLE_SCHEMA = 'ShowRoom' AND TABLE_NAME = 'OfertaShowRoomDetalle'
		)
		BEGIN
		  ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD Posicion INT NULL
		END

/****** Object:  UserDefinedTableType [ShowRoom].[OfertaShowRoomDetalleType]    Script Date: 25/01/2017 06:27:28 p.m. ******/
CREATE TYPE [ShowRoom].[OfertaShowRoomDetalleType] AS TABLE(
	CUV varchar(20) NULL,
	NombreSet varchar(250) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL
)
GO

ALTER procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as

begin

begin tran

declare @tablaSets table (CUV varchar(20), NombreSet varchar(250))

insert into @tablaSets

select distinct CUV, NombreSet from @OfertaShowRoomDetalle



DECLARE @FechaGeneral DATETIME        

SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle

set NombreProducto = t.NombreProducto,

	Descripcion1 = t.Descripcion1,

	Descripcion2 = t.Descripcion2,

	Descripcion3 = t.Descripcion3,

	UsuarioModificacion = @UsuarioCreacion

from ShowRoom.OfertaShowRoomDetalle o

inner join @OfertaShowRoomDetalle t on	

	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto

where

	o.CampaniaID = @CampaniaID	



insert into ShowRoom.OfertaShowRoomDetalle

(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion)

select 

@CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion,Posicion

from @OfertaShowRoomDetalle

where 

	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID

		and o.CUV = CUV)



update ShowRoom.OfertaShowRoom

set Descripcion = t.NombreSet

from ShowRoom.OfertaShowRoom o

inner join ods.Campania c on

	c.CampaniaID = o.CampaniaID

inner join @tablaSets t on

	o.CUV = t.CUV

where 

	c.Codigo = @CampaniaID

end

commit tran

IF (@@ERROR <> 0) BEGIN

PRINT 'Error Inesperado!'

    ROLLBACK TRAN

END

GO

/*end*/

USE BelcorpPeru
GO

DROP PROCEDURE ShowRoom.InsertCargaMasivaOfertaDetalle
DROP TYPE ShowRoom.OfertaShowRoomDetalleType

IF NOT EXISTS (
		SELECT *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE COLUMN_NAME = 'Posicion' AND TABLE_SCHEMA = 'ShowRoom' AND TABLE_NAME = 'OfertaShowRoomDetalle'
		)
		BEGIN
		  ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD Posicion INT NULL
		END

/****** Object:  UserDefinedTableType [ShowRoom].[OfertaShowRoomDetalleType]    Script Date: 25/01/2017 06:27:28 p.m. ******/
CREATE TYPE [ShowRoom].[OfertaShowRoomDetalleType] AS TABLE(
	CUV varchar(20) NULL,
	NombreSet varchar(250) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL
)
GO

ALTER procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as

begin

begin tran

declare @tablaSets table (CUV varchar(20), NombreSet varchar(250))

insert into @tablaSets

select distinct CUV, NombreSet from @OfertaShowRoomDetalle



DECLARE @FechaGeneral DATETIME        

SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle

set NombreProducto = t.NombreProducto,

	Descripcion1 = t.Descripcion1,

	Descripcion2 = t.Descripcion2,

	Descripcion3 = t.Descripcion3,

	UsuarioModificacion = @UsuarioCreacion

from ShowRoom.OfertaShowRoomDetalle o

inner join @OfertaShowRoomDetalle t on	

	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto

where

	o.CampaniaID = @CampaniaID	



insert into ShowRoom.OfertaShowRoomDetalle

(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion)

select 

@CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion,Posicion

from @OfertaShowRoomDetalle

where 

	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID

		and o.CUV = CUV)



update ShowRoom.OfertaShowRoom

set Descripcion = t.NombreSet

from ShowRoom.OfertaShowRoom o

inner join ods.Campania c on

	c.CampaniaID = o.CampaniaID

inner join @tablaSets t on

	o.CUV = t.CUV

where 

	c.Codigo = @CampaniaID

end



commit tran



IF (@@ERROR <> 0) BEGIN

PRINT 'Error Inesperado!'

    ROLLBACK TRAN

END

GO

/*end*/

USE BelcorpPuertoRico
GO

DROP PROCEDURE ShowRoom.InsertCargaMasivaOfertaDetalle
DROP TYPE ShowRoom.OfertaShowRoomDetalleType

IF NOT EXISTS (
		SELECT *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE COLUMN_NAME = 'Posicion' AND TABLE_SCHEMA = 'ShowRoom' AND TABLE_NAME = 'OfertaShowRoomDetalle'
		)
		BEGIN
		  ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD Posicion INT NULL
		END

/****** Object:  UserDefinedTableType [ShowRoom].[OfertaShowRoomDetalleType]    Script Date: 25/01/2017 06:27:28 p.m. ******/
CREATE TYPE [ShowRoom].[OfertaShowRoomDetalleType] AS TABLE(
	CUV varchar(20) NULL,
	NombreSet varchar(250) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL
)
GO

ALTER procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as

begin

begin tran
declare @tablaSets table (CUV varchar(20), NombreSet varchar(250))

insert into @tablaSets
select distinct CUV, NombreSet from @OfertaShowRoomDetalle

DECLARE @FechaGeneral DATETIME        

SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,

	Descripcion2 = t.Descripcion2,

	Descripcion3 = t.Descripcion3,

	UsuarioModificacion = @UsuarioCreacion

from ShowRoom.OfertaShowRoomDetalle o

inner join @OfertaShowRoomDetalle t on	

	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto

where

	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion,Posicion
from @OfertaShowRoomDetalle
where 
	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID
		and o.CUV = CUV)

update ShowRoom.OfertaShowRoom
set Descripcion = t.NombreSet
from ShowRoom.OfertaShowRoom o
inner join ods.Campania c on
	c.CampaniaID = o.CampaniaID
inner join @tablaSets t on
	o.CUV = t.CUV
where 
	c.Codigo = @CampaniaID
end

commit tran

IF (@@ERROR <> 0) BEGIN

PRINT 'Error Inesperado!'

    ROLLBACK TRAN

END

GO

/*end*/

USE BelcorpSalvador
GO

DROP PROCEDURE ShowRoom.InsertCargaMasivaOfertaDetalle
DROP TYPE ShowRoom.OfertaShowRoomDetalleType

IF NOT EXISTS (
		SELECT *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE COLUMN_NAME = 'Posicion' AND TABLE_SCHEMA = 'ShowRoom' AND TABLE_NAME = 'OfertaShowRoomDetalle'
		)
		BEGIN
		  ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD Posicion INT NULL
		END

/****** Object:  UserDefinedTableType [ShowRoom].[OfertaShowRoomDetalleType]    Script Date: 25/01/2017 06:27:28 p.m. ******/
CREATE TYPE [ShowRoom].[OfertaShowRoomDetalleType] AS TABLE(
	CUV varchar(20) NULL,
	NombreSet varchar(250) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL
)
GO

ALTER procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as

begin

begin tran
declare @tablaSets table (CUV varchar(20), NombreSet varchar(250))

insert into @tablaSets

select distinct CUV, NombreSet from @OfertaShowRoomDetalle
DECLARE @FechaGeneral DATETIME        

SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,

	Descripcion2 = t.Descripcion2,

	Descripcion3 = t.Descripcion3,

	UsuarioModificacion = @UsuarioCreacion

from ShowRoom.OfertaShowRoomDetalle o

inner join @OfertaShowRoomDetalle t on	

	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto

where

	o.CampaniaID = @CampaniaID	



insert into ShowRoom.OfertaShowRoomDetalle

(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion)

select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion,Posicion

from @OfertaShowRoomDetalle

where 
	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID

		and o.CUV = CUV)



update ShowRoom.OfertaShowRoom

set Descripcion = t.NombreSet

from ShowRoom.OfertaShowRoom o

inner join ods.Campania c on

	c.CampaniaID = o.CampaniaID

inner join @tablaSets t on

	o.CUV = t.CUV

where 

	c.Codigo = @CampaniaID

end



commit tran



IF (@@ERROR <> 0) BEGIN

PRINT 'Error Inesperado!'

    ROLLBACK TRAN

END

GO

/*end*/

USE BelcorpVenezuela
GO

DROP PROCEDURE ShowRoom.InsertCargaMasivaOfertaDetalle
DROP TYPE ShowRoom.OfertaShowRoomDetalleType

IF NOT EXISTS (
		SELECT *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE COLUMN_NAME = 'Posicion' AND TABLE_SCHEMA = 'ShowRoom' AND TABLE_NAME = 'OfertaShowRoomDetalle'
		)
		BEGIN
		  ALTER TABLE ShowRoom.OfertaShowRoomDetalle ADD Posicion INT NULL
		END

/****** Object:  UserDefinedTableType [ShowRoom].[OfertaShowRoomDetalleType]    Script Date: 25/01/2017 06:27:28 p.m. ******/
CREATE TYPE [ShowRoom].[OfertaShowRoomDetalleType] AS TABLE(
	CUV varchar(20) NULL,
	NombreSet varchar(250) NULL,
	NombreProducto varchar(150) NULL,
	Descripcion1 varchar(150) NULL,
	Descripcion2 varchar(150) NULL,
	Descripcion3 varchar(150) NULL,
	Posicion int NULL
)
GO

ALTER procedure ShowRoom.InsertCargaMasivaOfertaDetalle
@OfertaShowRoomDetalle ShowRoom.OfertaShowRoomDetalleType readonly,
@CampaniaID int,
@UsuarioCreacion varchar(50)
as

begin

begin tran
declare @tablaSets table (CUV varchar(20), NombreSet varchar(250))
insert into @tablaSets

select distinct CUV, NombreSet from @OfertaShowRoomDetalle


DECLARE @FechaGeneral DATETIME        

SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

delete from ShowRoom.OfertaShowRoomDetalle
	where OfertaShowRoomDetalleID not in (select o.OfertaShowRoomDetalleID from ShowRoom.OfertaShowRoomDetalle o
	inner join @OfertaShowRoomDetalle t on
	o.CUV = t.CUV
	and o.Posicion = t.Posicion)

update ShowRoom.OfertaShowRoomDetalle
set NombreProducto = t.NombreProducto,
	Descripcion1 = t.Descripcion1,

	Descripcion2 = t.Descripcion2,

	Descripcion3 = t.Descripcion3,

	UsuarioModificacion = @UsuarioCreacion

from ShowRoom.OfertaShowRoomDetalle o

inner join @OfertaShowRoomDetalle t on	

	o.CUV = t.CUV
	and o.Posicion = t.Posicion
	--and o.NombreProducto = t.NombreProducto

where

	o.CampaniaID = @CampaniaID	



insert into ShowRoom.OfertaShowRoomDetalle

(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion,Posicion)

select 

@CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion,Posicion

from @OfertaShowRoomDetalle

where 

	NombreProducto not in (select NombreProducto from ShowRoom.OfertaShowRoomDetalle o where o.CampaniaID = @CampaniaID

		and o.CUV = CUV)



update ShowRoom.OfertaShowRoom

set Descripcion = t.NombreSet

from ShowRoom.OfertaShowRoom o

inner join ods.Campania c on

	c.CampaniaID = o.CampaniaID

inner join @tablaSets t on

	o.CUV = t.CUV

where 

	c.Codigo = @CampaniaID

end



commit tran



IF (@@ERROR <> 0) BEGIN

PRINT 'Error Inesperado!'

    ROLLBACK TRAN

END

GO






