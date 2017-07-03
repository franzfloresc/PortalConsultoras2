USE BelcorpBolivia
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly

as


DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0



select @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'



declare @EtiquetaID2 int = 0

select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'



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

	'57,81,134,13,14,15,16,29,30,31,56,58,72,73,91,95,115,130,11,12,26,33,53,54,76,87,93,94,7,8,22,25,45,88,89,109,110,112,122,124,9,43,44,50,83,85,111,123,125,10,38,39,51,70,86,103,119,71,84,106,107,121,23,24,27,28,41,42,46,52,90,105,113,114,120,129,18,32,4
7,61,74,75,131,2,17,59,60,62,67,77,78,92,96,101,102,116,118,132,34,49,64,97,3,20,21,36,37,48,63,66,69,79,82,117,5,6,65,80,68,100',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpChile
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly

as


DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0



select @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'



declare @EtiquetaID2 int = 0

select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'



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

	'57,81,134,13,14,15,16,29,30,31,56,58,72,73,91,95,115,130,11,12,26,33,53,54,76,87,93,94,7,8,22,25,45,88,89,109,110,112,122,124,9,43,44,50,83,85,111,123,125,10,38,39,51,70,86,103,119,71,84,106,107,121,23,24,27,28,41,42,46,52,90,105,113,114,120,129,18,32,4
7,61,74,75,131,2,17,59,60,62,67,77,78,92,96,101,102,116,118,132,34,49,64,97,3,20,21,36,37,48,63,66,69,79,82,117,5,6,65,80,68,100',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpColombia
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly

as




DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0



select @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'



declare @EtiquetaID2 int = 0

select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'



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

	'57,81,134,13,14,15,16,29,30,31,56,58,72,73,91,95,115,130,11,12,26,33,53,54,76,87,93,94,7,8,22,25,45,88,89,109,110,112,122,124,9,43,44,50,83,85,111,123,125,10,38,39,51,70,86,103,119,71,84,106,107,121,23,24,27,28,41,42,46,52,90,105,113,114,120,129,18,32,4
7,61,74,75,131,2,17,59,60,62,67,77,78,92,96,101,102,116,118,132,34,49,64,97,3,20,21,36,37,48,63,66,69,79,82,117,5,6,65,80,68,100',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpCostaRica
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly

as


DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0



select @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'



declare @EtiquetaID2 int = 0

select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'



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

	'57,81,134,13,14,15,16,29,30,31,56,58,72,73,91,95,115,130,11,12,26,33,53,54,76,87,93,94,7,8,22,25,45,88,89,109,110,112,122,124,9,43,44,50,83,85,111,123,125,10,38,39,51,70,86,103,119,71,84,106,107,121,23,24,27,28,41,42,46,52,90,105,113,114,120,129,18,32,4
7,61,74,75,131,2,17,59,60,62,67,77,78,92,96,101,102,116,118,132,34,49,64,97,3,20,21,36,37,48,63,66,69,79,82,117,5,6,65,80,68,100',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpDominicana
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly

as

DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0



select @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'



declare @EtiquetaID2 int = 0

select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'



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

	'57,81,134,13,14,15,16,29,30,31,56,58,72,73,91,95,115,130,11,12,26,33,53,54,76,87,93,94,7,8,22,25,45,88,89,109,110,112,122,124,9,43,44,50,83,85,111,123,125,10,38,39,51,70,86,103,119,71,84,106,107,121,23,24,27,28,41,42,46,52,90,105,113,114,120,129,18,32,4
7,61,74,75,131,2,17,59,60,62,67,77,78,92,96,101,102,116,118,132,34,49,64,97,3,20,21,36,37,48,63,66,69,79,82,117,5,6,65,80,68,100',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpEcuador
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly

as

DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0



select @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'



declare @EtiquetaID2 int = 0

select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'



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

	'57,81,134,13,14,15,16,29,30,31,56,58,72,73,91,95,115,130,11,12,26,33,53,54,76,87,93,94,7,8,22,25,45,88,89,109,110,112,122,124,9,43,44,50,83,85,111,123,125,10,38,39,51,70,86,103,119,71,84,106,107,121,23,24,27,28,41,42,46,52,90,105,113,114,120,129,18,32,4
7,61,74,75,131,2,17,59,60,62,67,77,78,92,96,101,102,116,118,132,34,49,64,97,3,20,21,36,37,48,63,66,69,79,82,117,5,6,65,80,68,100',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpGuatemala
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly

as


DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0



select @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'



declare @EtiquetaID2 int = 0

select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'



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

	'57,81,134,13,14,15,16,29,30,31,56,58,72,73,91,95,115,130,11,12,26,33,53,54,76,87,93,94,7,8,22,25,45,88,89,109,110,112,122,124,9,43,44,50,83,85,111,123,125,10,38,39,51,70,86,103,119,71,84,106,107,121,23,24,27,28,41,42,46,52,90,105,113,114,120,129,18,32,4
7,61,74,75,131,2,17,59,60,62,67,77,78,92,96,101,102,116,118,132,34,49,64,97,3,20,21,36,37,48,63,66,69,79,82,117,5,6,65,80,68,100',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpMexico
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly

as



DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0



select @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'



declare @EtiquetaID2 int = 0

select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'



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

	'57,81,134,13,14,15,16,29,30,31,56,58,72,73,91,95,115,130,11,12,26,33,53,54,76,87,93,94,7,8,22,25,45,88,89,109,110,112,122,124,9,43,44,50,83,85,111,123,125,10,38,39,51,70,86,103,119,71,84,106,107,121,23,24,27,28,41,42,46,52,90,105,113,114,120,129,18,32,4
7,61,74,75,131,2,17,59,60,62,67,77,78,92,96,101,102,116,118,132,34,49,64,97,3,20,21,36,37,48,63,66,69,79,82,117,5,6,65,80,68,100',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpPanama
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly

as



DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0



select @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'



declare @EtiquetaID2 int = 0

select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'



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

	'57,81,134,13,14,15,16,29,30,31,56,58,72,73,91,95,115,130,11,12,26,33,53,54,76,87,93,94,7,8,22,25,45,88,89,109,110,112,122,124,9,43,44,50,83,85,111,123,125,10,38,39,51,70,86,103,119,71,84,106,107,121,23,24,27,28,41,42,46,52,90,105,113,114,120,129,18,32,4
7,61,74,75,131,2,17,59,60,62,67,77,78,92,96,101,102,116,118,132,34,49,64,97,3,20,21,36,37,48,63,66,69,79,82,117,5,6,65,80,68,100',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpPeru
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly

as



DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0



select @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'



declare @EtiquetaID2 int = 0

select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'



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

	'57,81,134,13,14,15,16,29,30,31,56,58,72,73,91,95,115,130,11,12,26,33,53,54,76,87,93,94,7,8,22,25,45,88,89,109,110,112,122,124,9,43,44,50,83,85,111,123,125,10,38,39,51,70,86,103,119,71,84,106,107,121,23,24,27,28,41,42,46,52,90,105,113,114,120,129,18,32,4
7,61,74,75,131,2,17,59,60,62,67,77,78,92,96,101,102,116,118,132,34,49,64,97,3,20,21,36,37,48,63,66,69,79,82,117,5,6,65,80,68,100',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpPuertoRico
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly

as



DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0



select @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'



declare @EtiquetaID2 int = 0

select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'



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

	'57,81,134,13,14,15,16,29,30,31,56,58,72,73,91,95,115,130,11,12,26,33,53,54,76,87,93,94,7,8,22,25,45,88,89,109,110,112,122,124,9,43,44,50,83,85,111,123,125,10,38,39,51,70,86,103,119,71,84,106,107,121,23,24,27,28,41,42,46,52,90,105,113,114,120,129,18,32,4
7,61,74,75,131,2,17,59,60,62,67,77,78,92,96,101,102,116,118,132,34,49,64,97,3,20,21,36,37,48,63,66,69,79,82,117,5,6,65,80,68,100',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpSalvador
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly

as


DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0



select @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'



declare @EtiquetaID2 int = 0

select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'



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

	'57,81,134,13,14,15,16,29,30,31,56,58,72,73,91,95,115,130,11,12,26,33,53,54,76,87,93,94,7,8,22,25,45,88,89,109,110,112,122,124,9,43,44,50,83,85,111,123,125,10,38,39,51,70,86,103,119,71,84,106,107,121,23,24,27,28,41,42,46,52,90,105,113,114,120,129,18,32,4
7,61,74,75,131,2,17,59,60,62,67,77,78,92,96,101,102,116,118,132,34,49,64,97,3,20,21,36,37,48,63,66,69,79,82,117,5,6,65,80,68,100',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

USE BelcorpVenezuela
go

alter procedure dbo.InsertEstrategiaOfertaParaTi

@EstrategiaTemporal dbo.EstrategiaTemporalType readonly

as



DECLARE @FechaGeneral DATETIME

	SET @FechaGeneral = dbo.fnObtenerFechaHoraPais()



declare @TipoEstrategiaID int = 0



select @TipoEstrategiaID = TipoEstrategiaID 

from TipoEstrategia 

where DescripcionEstrategia like '%'+ UPPER('OFERTA PARA TI')+'%'



declare @EtiquetaID2 int = 0

select @EtiquetaID2 = EtiquetaID from Etiqueta 

where Descripcion like '%' + UPPER('Precio para T') + '%'



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

	'57,81,134,13,14,15,16,29,30,31,56,58,72,73,91,95,115,130,11,12,26,33,53,54,76,87,93,94,7,8,22,25,45,88,89,109,110,112,122,124,9,43,44,50,83,85,111,123,125,10,38,39,51,70,86,103,119,71,84,106,107,121,23,24,27,28,41,42,46,52,90,105,113,114,120,129,18,32,4
7,61,74,75,131,2,17,59,60,62,67,77,78,92,96,101,102,116,118,132,34,49,64,97,3,20,21,36,37,48,63,66,69,79,82,117,5,6,65,80,68,100',

	NULL,0,UsuarioCreacion,@FechaGeneral,UsuarioCreacion,

	@FechaGeneral,'',OfertaUltimoMinuto

from @EstrategiaTemporal

go

