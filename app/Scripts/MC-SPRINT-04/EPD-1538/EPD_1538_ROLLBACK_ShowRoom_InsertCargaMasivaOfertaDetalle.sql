

USE BelcorpBolivia
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

update ShowRoom.OfertaShowRoomDetalle
set 
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
select 
	@CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion
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

update ShowRoom.OfertaShowRoomDetalle
set 
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
select 
	@CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion
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

update ShowRoom.OfertaShowRoomDetalle
set 
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion
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

update ShowRoom.OfertaShowRoomDetalle
set 

	Descripcion1 = t.Descripcion1,

	Descripcion2 = t.Descripcion2,

	Descripcion3 = t.Descripcion3,

	UsuarioModificacion = @UsuarioCreacion

from ShowRoom.OfertaShowRoomDetalle o

inner join @OfertaShowRoomDetalle t on	

	o.CUV = t.CUV

	and o.NombreProducto = t.NombreProducto

where

	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle

(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)

select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion
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

update ShowRoom.OfertaShowRoomDetalle
set 
	Descripcion1 = t.Descripcion1,
	Descripcion2 = t.Descripcion2,
	Descripcion3 = t.Descripcion3,
	UsuarioModificacion = @UsuarioCreacion
from ShowRoom.OfertaShowRoomDetalle o
inner join @OfertaShowRoomDetalle t on	
	o.CUV = t.CUV
	and o.NombreProducto = t.NombreProducto
where
	o.CampaniaID = @CampaniaID	



insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion
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

update ShowRoom.OfertaShowRoomDetalle

set 

	Descripcion1 = t.Descripcion1,

	Descripcion2 = t.Descripcion2,

	Descripcion3 = t.Descripcion3,

	UsuarioModificacion = @UsuarioCreacion

from ShowRoom.OfertaShowRoomDetalle o

inner join @OfertaShowRoomDetalle t on	

	o.CUV = t.CUV

	and o.NombreProducto = t.NombreProducto

where

	o.CampaniaID = @CampaniaID	



insert into ShowRoom.OfertaShowRoomDetalle

(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)

select 

@CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion

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



update ShowRoom.OfertaShowRoomDetalle

set 

	Descripcion1 = t.Descripcion1,

	Descripcion2 = t.Descripcion2,

	Descripcion3 = t.Descripcion3,

	UsuarioModificacion = @UsuarioCreacion

from ShowRoom.OfertaShowRoomDetalle o

inner join @OfertaShowRoomDetalle t on	

	o.CUV = t.CUV

	and o.NombreProducto = t.NombreProducto

where

	o.CampaniaID = @CampaniaID	



insert into ShowRoom.OfertaShowRoomDetalle

(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)

select 

@CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion

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

update ShowRoom.OfertaShowRoomDetalle
set 
	Descripcion1 = t.Descripcion1,

	Descripcion2 = t.Descripcion2,

	Descripcion3 = t.Descripcion3,

	UsuarioModificacion = @UsuarioCreacion

from ShowRoom.OfertaShowRoomDetalle o

inner join @OfertaShowRoomDetalle t on	

	o.CUV = t.CUV

	and o.NombreProducto = t.NombreProducto

where

	o.CampaniaID = @CampaniaID	



insert into ShowRoom.OfertaShowRoomDetalle

(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)

select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion
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



update ShowRoom.OfertaShowRoomDetalle

set 

	Descripcion1 = t.Descripcion1,

	Descripcion2 = t.Descripcion2,

	Descripcion3 = t.Descripcion3,

	UsuarioModificacion = @UsuarioCreacion

from ShowRoom.OfertaShowRoomDetalle o

inner join @OfertaShowRoomDetalle t on	

	o.CUV = t.CUV

	and o.NombreProducto = t.NombreProducto

where

	o.CampaniaID = @CampaniaID	



insert into ShowRoom.OfertaShowRoomDetalle

(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)

select 

@CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion

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



update ShowRoom.OfertaShowRoomDetalle

set 

	Descripcion1 = t.Descripcion1,

	Descripcion2 = t.Descripcion2,

	Descripcion3 = t.Descripcion3,

	UsuarioModificacion = @UsuarioCreacion

from ShowRoom.OfertaShowRoomDetalle o

inner join @OfertaShowRoomDetalle t on	

	o.CUV = t.CUV

	and o.NombreProducto = t.NombreProducto

where

	o.CampaniaID = @CampaniaID	



insert into ShowRoom.OfertaShowRoomDetalle

(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)

select 

@CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion

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

update ShowRoom.OfertaShowRoomDetalle
set 
	Descripcion1 = t.Descripcion1,

	Descripcion2 = t.Descripcion2,

	Descripcion3 = t.Descripcion3,

	UsuarioModificacion = @UsuarioCreacion

from ShowRoom.OfertaShowRoomDetalle o

inner join @OfertaShowRoomDetalle t on	

	o.CUV = t.CUV

	and o.NombreProducto = t.NombreProducto

where

	o.CampaniaID = @CampaniaID	

insert into ShowRoom.OfertaShowRoomDetalle
(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)
select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion
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

update ShowRoom.OfertaShowRoomDetalle
set 
	Descripcion1 = t.Descripcion1,

	Descripcion2 = t.Descripcion2,

	Descripcion3 = t.Descripcion3,

	UsuarioModificacion = @UsuarioCreacion

from ShowRoom.OfertaShowRoomDetalle o

inner join @OfertaShowRoomDetalle t on	

	o.CUV = t.CUV

	and o.NombreProducto = t.NombreProducto

where

	o.CampaniaID = @CampaniaID	



insert into ShowRoom.OfertaShowRoomDetalle

(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)

select @CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion

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



update ShowRoom.OfertaShowRoomDetalle
set 
	Descripcion1 = t.Descripcion1,

	Descripcion2 = t.Descripcion2,

	Descripcion3 = t.Descripcion3,

	UsuarioModificacion = @UsuarioCreacion

from ShowRoom.OfertaShowRoomDetalle o

inner join @OfertaShowRoomDetalle t on	

	o.CUV = t.CUV

	and o.NombreProducto = t.NombreProducto

where

	o.CampaniaID = @CampaniaID	



insert into ShowRoom.OfertaShowRoomDetalle

(CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,FechaCreacion,UsuarioCreacion,FechaModificacion,UsuarioModificacion)

select 

@CampaniaID,CUV,NombreProducto,Descripcion1,Descripcion2,Descripcion3,getdate(),@UsuarioCreacion,getdate(),@UsuarioCreacion

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






