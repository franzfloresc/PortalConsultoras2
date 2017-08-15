USE BelcorpBolivia
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
@TipoEstrategia int

as

DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0


if @TipoEstrategia = 4
begin
	select @TipoEstrategiaID = TipoEstrategiaID 

	from TipoEstrategia 

	where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
end

if @TipoEstrategia = 7
begin
select  @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
end


declare @EtiquetaID2 int = 0

if @TipoEstrategia = 4
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'
end

if @TipoEstrategia = 7
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
end


insert into Estrategia

(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,

FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,

Cantidad,FlagCantidad,

Zona,

Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,

FechaModificacion,ColorFondo,FlagEstrella)

select 

	@TipoEstrategiaID,CampaniaId,0,0,0,'',LimiteVenta,Descripcion,

	1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,

	0,0,

	'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpChile
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
@TipoEstrategia int

as

DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0


if @TipoEstrategia = 4
begin
	select @TipoEstrategiaID = TipoEstrategiaID 

	from TipoEstrategia 

	where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
end

if @TipoEstrategia = 7
begin
select  @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
end


declare @EtiquetaID2 int = 0

if @TipoEstrategia = 4
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'
end

if @TipoEstrategia = 7
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
end


insert into Estrategia

(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,

FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,

Cantidad,FlagCantidad,

Zona,

Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,

FechaModificacion,ColorFondo,FlagEstrella)

select 

	@TipoEstrategiaID,CampaniaId,0,0,0,'',LimiteVenta,Descripcion,

	1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,

	0,0,

	'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpColombia
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
@TipoEstrategia int

as


DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0


if @TipoEstrategia = 4
begin
	select @TipoEstrategiaID = TipoEstrategiaID 

	from TipoEstrategia 

	where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
end

if @TipoEstrategia = 7
begin
select  @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
end


declare @EtiquetaID2 int = 0

if @TipoEstrategia = 4
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'
end

if @TipoEstrategia = 7
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
end


insert into Estrategia

(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,

FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,

Cantidad,FlagCantidad,

Zona,

Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,

FechaModificacion,ColorFondo,FlagEstrella)

select 

	@TipoEstrategiaID,CampaniaId,0,0,0,'',LimiteVenta,Descripcion,

	1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,

	0,0,

	'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpCostaRica
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
@TipoEstrategia int

as

DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0


if @TipoEstrategia = 4
begin
	select @TipoEstrategiaID = TipoEstrategiaID 

	from TipoEstrategia 

	where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
end

if @TipoEstrategia = 7
begin
select  @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
end


declare @EtiquetaID2 int = 0

if @TipoEstrategia = 4
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'
end

if @TipoEstrategia = 7
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
end


insert into Estrategia

(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,

FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,

Cantidad,FlagCantidad,

Zona,

Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,

FechaModificacion,ColorFondo,FlagEstrella)

select 

	@TipoEstrategiaID,CampaniaId,0,0,0,'',LimiteVenta,Descripcion,

	1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,

	0,0,

	'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpDominicana
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
@TipoEstrategia int

as


DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0


if @TipoEstrategia = 4
begin
	select @TipoEstrategiaID = TipoEstrategiaID 

	from TipoEstrategia 

	where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
end

if @TipoEstrategia = 7
begin
select  @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
end


declare @EtiquetaID2 int = 0

if @TipoEstrategia = 4
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'
end

if @TipoEstrategia = 7
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
end


insert into Estrategia

(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,

FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,

Cantidad,FlagCantidad,

Zona,

Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,

FechaModificacion,ColorFondo,FlagEstrella)

select 

	@TipoEstrategiaID,CampaniaId,0,0,0,'',LimiteVenta,Descripcion,

	1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,

	0,0,

	'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpEcuador
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
@TipoEstrategia int

as


DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0


if @TipoEstrategia = 4
begin
	select @TipoEstrategiaID = TipoEstrategiaID 

	from TipoEstrategia 

	where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
end

if @TipoEstrategia = 7
begin
select  @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
end


declare @EtiquetaID2 int = 0

if @TipoEstrategia = 4
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'
end

if @TipoEstrategia = 7
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
end


insert into Estrategia

(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,

FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,

Cantidad,FlagCantidad,

Zona,

Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,

FechaModificacion,ColorFondo,FlagEstrella)

select 

	@TipoEstrategiaID,CampaniaId,0,0,0,'',LimiteVenta,Descripcion,

	1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,

	0,0,

	'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpGuatemala
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
@TipoEstrategia int

as


DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0


if @TipoEstrategia = 4
begin
	select @TipoEstrategiaID = TipoEstrategiaID 

	from TipoEstrategia 

	where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
end

if @TipoEstrategia = 7
begin
select  @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
end


declare @EtiquetaID2 int = 0

if @TipoEstrategia = 4
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'
end

if @TipoEstrategia = 7
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
end


insert into Estrategia

(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,

FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,

Cantidad,FlagCantidad,

Zona,

Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,

FechaModificacion,ColorFondo,FlagEstrella)

select 

	@TipoEstrategiaID,CampaniaId,0,0,0,'',LimiteVenta,Descripcion,

	1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,

	0,0,

	'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpMexico
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
@TipoEstrategia int

as


DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0


if @TipoEstrategia = 4
begin
	select @TipoEstrategiaID = TipoEstrategiaID 

	from TipoEstrategia 

	where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
end

if @TipoEstrategia = 7
begin
select  @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
end


declare @EtiquetaID2 int = 0

if @TipoEstrategia = 4
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'
end

if @TipoEstrategia = 7
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
end


insert into Estrategia

(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,

FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,

Cantidad,FlagCantidad,

Zona,

Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,

FechaModificacion,ColorFondo,FlagEstrella)

select 

	@TipoEstrategiaID,CampaniaId,0,0,0,'',LimiteVenta,Descripcion,

	1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,

	0,0,

	'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpPanama
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
@TipoEstrategia int

as


DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0


if @TipoEstrategia = 4
begin
	select @TipoEstrategiaID = TipoEstrategiaID 

	from TipoEstrategia 

	where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
end

if @TipoEstrategia = 7
begin
select  @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
end


declare @EtiquetaID2 int = 0

if @TipoEstrategia = 4
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'
end

if @TipoEstrategia = 7
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
end


insert into Estrategia

(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,

FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,

Cantidad,FlagCantidad,

Zona,

Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,

FechaModificacion,ColorFondo,FlagEstrella)

select 

	@TipoEstrategiaID,CampaniaId,0,0,0,'',LimiteVenta,Descripcion,

	1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,

	0,0,

	'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpPeru
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
@TipoEstrategia int

as


DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0


if @TipoEstrategia = 4
begin
	select @TipoEstrategiaID = TipoEstrategiaID 

	from TipoEstrategia 

	where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
end

if @TipoEstrategia = 7
begin
select  @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
end


declare @EtiquetaID2 int = 0

if @TipoEstrategia = 4
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'
end

if @TipoEstrategia = 7
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
end


insert into Estrategia

(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,

FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,

Cantidad,FlagCantidad,

Zona,

Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,

FechaModificacion,ColorFondo,FlagEstrella)

select 

	@TipoEstrategiaID,CampaniaId,0,0,0,'',LimiteVenta,Descripcion,

	1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,

	0,0,

	'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpPuertoRico
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
@TipoEstrategia int

as


DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0


if @TipoEstrategia = 4
begin
	select @TipoEstrategiaID = TipoEstrategiaID 

	from TipoEstrategia 

	where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
end

if @TipoEstrategia = 7
begin
select  @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
end


declare @EtiquetaID2 int = 0

if @TipoEstrategia = 4
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'
end

if @TipoEstrategia = 7
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
end


insert into Estrategia

(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,

FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,

Cantidad,FlagCantidad,

Zona,

Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,

FechaModificacion,ColorFondo,FlagEstrella)

select 

	@TipoEstrategiaID,CampaniaId,0,0,0,'',LimiteVenta,Descripcion,

	1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,

	0,0,

	'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpSalvador
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
@TipoEstrategia int

as

DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0


if @TipoEstrategia = 4
begin
	select @TipoEstrategiaID = TipoEstrategiaID 

	from TipoEstrategia 

	where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
end

if @TipoEstrategia = 7
begin
select  @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
end


declare @EtiquetaID2 int = 0

if @TipoEstrategia = 4
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'
end

if @TipoEstrategia = 7
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
end


insert into Estrategia

(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,

FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,

Cantidad,FlagCantidad,

Zona,

Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,

FechaModificacion,ColorFondo,FlagEstrella)

select 

	@TipoEstrategiaID,CampaniaId,0,0,0,'',LimiteVenta,Descripcion,

	1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,

	0,0,

	'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpVenezuela
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly,
@TipoEstrategia int

as


DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0


if @TipoEstrategia = 4
begin
	select @TipoEstrategiaID = TipoEstrategiaID 

	from TipoEstrategia 

	where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'
end

if @TipoEstrategia = 7
begin
select  @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA DEL DÍA')+'%'
end


declare @EtiquetaID2 int = 0

if @TipoEstrategia = 4
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'
end

if @TipoEstrategia = 7
begin
select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('OFERTA DEL DÍA') + '%'
end


insert into Estrategia

(TipoEstrategiaID,CampaniaID,CampaniaIDFin,NumeroPedido,Activo,ImagenURL,LimiteVenta,DescripcionCUV2,

FlagDescripcion,CUV,EtiquetaID,Precio,FlagCEP,CUV2,EtiquetaID2,Precio2,FlagCEP2,TextoLibre,FlagTextoLibre,

Cantidad,FlagCantidad,

Zona,

Limite,Orden,UsuarioCreacion,FechaCreacion,UsuarioModificacion,

FechaModificacion,ColorFondo,FlagEstrella)

select 

	@TipoEstrategiaID,CampaniaId,0,0,0,'',LimiteVenta,Descripcion,

	1,'',0,PrecioTachado,0,CUV,@EtiquetaID2,PrecioOferta,1,'',0,

	0,0,

	'2053,2121,2101,2102,2103,2105,20003,20004,20005,20006,20007,20008,20009,20010,20055,20058,2106,2107,2109,2110,20011,20012,20013,20014,20016,20017,20054,20059,20060,2111,2112,2114,2115,20028,20029,20030,20031,20032,20033,20034,20035,20056,20061',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

GO
