USE BelcorpBolivia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaTemporal')
	DROP PROCEDURE InsertEstrategiaTemporal;	
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end
go

USE BelcorpCostaRica
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaTemporal')
	DROP PROCEDURE InsertEstrategiaTemporal;	
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end
go
USE BelcorpChile
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaTemporal')
	DROP PROCEDURE InsertEstrategiaTemporal;	
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end
go
USE BelcorpColombia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaTemporal')
	DROP PROCEDURE InsertEstrategiaTemporal;	
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end
go

USE BelcorpDominicana
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaTemporal')
	DROP PROCEDURE InsertEstrategiaTemporal;	
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end
go

USE BelcorpEcuador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaTemporal')
	DROP PROCEDURE InsertEstrategiaTemporal;	
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end
go

USE BelcorpGuatemala
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaTemporal')
	DROP PROCEDURE InsertEstrategiaTemporal;	
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end
go

USE BelcorpMexico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaTemporal')
	DROP PROCEDURE InsertEstrategiaTemporal;	
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end
go

USE BelcorpPanama
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaTemporal')
	DROP PROCEDURE InsertEstrategiaTemporal;	
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end
go

USE BelcorpPeru
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaTemporal')
	DROP PROCEDURE InsertEstrategiaTemporal;	
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end
go

USE BelcorpPuertoRico
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaTemporal')
	DROP PROCEDURE InsertEstrategiaTemporal;	
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end
go

USE BelcorpSalvador
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaTemporal')
	DROP PROCEDURE InsertEstrategiaTemporal;	
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end
go

USE BelcorpVenezuela
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'InsertEstrategiaTemporal')
	DROP PROCEDURE InsertEstrategiaTemporal;	
GO

create procedure dbo.InsertEstrategiaTemporal
@EstrategiaTemporal dbo.EstrategiaTemporalType readonly
as
/*

*/
begin

DECLARE @FechaGeneral DATETIME
	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()

declare @NumeroLote int = 0
select @NumeroLote = isnull(max(NumeroLote),0) from EstrategiaTemporal

set @NumeroLote = @NumeroLote + 1

insert into EstrategiaTemporal 
(CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,NumeroLote,FechaCreacion,UsuarioCreacion)
select
CampaniaId,CUV,Descripcion,PrecioOferta,PrecioTachado,CodigoSap,OfertaUltimoMinuto,LimiteVenta,@NumeroLote,@FechaGeneral,UsuarioCreacion
from @EstrategiaTemporal

end
go













