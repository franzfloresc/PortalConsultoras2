use BelcorpPeru
go
if not exists(select 1 from information_schema.columns where table_name = 'OfertaFinalParametria' and column_name = 'Algoritmo')
Alter table OfertaFinalParametria add Algoritmo varchar(10)
go
use BelcorpColombia
go
if not exists(select 1 from information_schema.columns where table_name = 'OfertaFinalParametria' and column_name = 'Algoritmo')
Alter table OfertaFinalParametria add Algoritmo varchar(10)
go