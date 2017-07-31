use BelcorpPeru
go
if not exists(select 1 from configuracionPais where Codigo = 'OFT')
insert into configuracionPais(Codigo,Excluyente,Descripcion,Estado) 
select 
Codigo = 'OFT',
Excluyente = '1',
Descripcion = 'Oferta Final Tradicional',
Estado = 1

if not exists(select 1 from configuracionPais where Codigo = 'OFTGM')
insert into configuracionPais(Codigo,Excluyente,Descripcion,Estado) 
select 
Codigo = 'OFTGM',
Excluyente = '1',
Descripcion = 'Oferta Final Gana Mas',
Estado = 1

Update OfertaFinalParametria set Algoritmo = 'OFT'
go
use BelcorpColombia
go
if not exists(select 1 from configuracionPais where Codigo = 'OFT')
insert into configuracionPais(Codigo,Excluyente,Descripcion,Estado) 
select 
Codigo = 'OFT',
Excluyente = '1',
Descripcion = 'Oferta Final Tradicional',
Estado = 1

if not exists(select 1 from configuracionPais where Codigo = 'OFTGM')
insert into configuracionPais(Codigo,Excluyente,Descripcion,Estado) 
select 
Codigo = 'OFTGM',
Excluyente = '1',
Descripcion = 'Oferta Final Gana Mas',
Estado = 1

Update OfertaFinalParametria set Algoritmo = 'OFT'
go
use BelcorpMexico
go
if not exists(select 1 from configuracionPais where Codigo = 'OFT')
insert into configuracionPais(Codigo,Excluyente,Descripcion,Estado) 
select 
Codigo = 'OFT',
Excluyente = '1',
Descripcion = 'Oferta Final Tradicional',
Estado = 1

if not exists(select 1 from configuracionPais where Codigo = 'OFTGM')
insert into configuracionPais(Codigo,Excluyente,Descripcion,Estado) 
select 
Codigo = 'OFTGM',
Excluyente = '1',
Descripcion = 'Oferta Final Gana Mas',
Estado = 1

Update OfertaFinalParametria set Algoritmo = 'OFT'
go
use BelcorpChile
go
if not exists(select 1 from configuracionPais where Codigo = 'OFC')
insert into configuracionPais(Codigo,Excluyente,Descripcion,Estado) 
select 
Codigo = 'OFC',
Excluyente = '0',
Descripcion = 'Oferta Final Cross-Selling',
Estado = 1

if not exists(select 1 from configuracionPais where Codigo = 'OFCGM')
insert into configuracionPais(Codigo,Excluyente,Descripcion,Estado) 
select 
Codigo = 'OFCGM',
Excluyente = '1',
Descripcion = 'Oferta Final Cross-Selling Gana Mas',
Estado = 1

Update OfertaFinalParametria set Algoritmo = 'OFC'
