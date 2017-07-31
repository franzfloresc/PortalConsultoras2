use BelcorpPeru
go
if exists(select 1 from information_schema.columns where table_name = 'OfertaFinalParametria' and column_name = 'Algoritmo')
Alter table OfertaFinalParametria drop column Algoritmo
go
use BelcorpColombia
go
if exists(select 1 from information_schema.columns where table_name = 'OfertaFinalParametria' and column_name = 'Algoritmo')
Alter table OfertaFinalParametria drop column Algoritmo
go
use BelcorpMexico
go
if exists(select 1 from information_schema.columns where table_name = 'OfertaFinalParametria' and column_name = 'Algoritmo')
Alter table OfertaFinalParametria drop column Algoritmo
go
go
use BelcorpChile
go
if exists(select 1 from information_schema.columns where table_name = 'OfertaFinalParametria' and column_name = 'Algoritmo')
Alter table OfertaFinalParametria drop column Algoritmo
go
