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