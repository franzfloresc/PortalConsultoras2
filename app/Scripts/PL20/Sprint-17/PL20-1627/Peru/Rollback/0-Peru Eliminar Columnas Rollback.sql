use BelcorpPeru
go
if not exists(select 1 from information_schema.columns where table_name = 'Pais' and column_name = 'OfertaFinal')
Alter table Pais add OfertaFinal int

if not exists(select 1 from information_schema.columns where table_name = 'Pais' and column_name = 'OFGanaMas'  )
Alter table Pais add OFGanaMas tinyint 

Update Pais set OfertaFinal = 1 Where EstadoActivo = 1
Update Pais set OFGanaMas = 1 Where EstadoActivo = 1
