use BelcorpPeru
go
if exists(select 1 from information_schema.columns where table_name = 'Pais' and column_name = 'OfertaFinal')
Alter table Pais drop column OfertaFinal

if exists(select 1 from information_schema.columns where table_name = 'Pais' and column_name = 'OFGanaMas'  )
Alter table Pais drop column OFGanaMas 
