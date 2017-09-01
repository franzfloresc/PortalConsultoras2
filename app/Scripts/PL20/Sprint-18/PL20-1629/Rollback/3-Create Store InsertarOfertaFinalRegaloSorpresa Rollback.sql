GO
use BelcorpChile
go
if exists(select 1 from sysobjects where name = 'InsertarOfertaFinalRegaloSorpresa' and xtype = 'p')
drop procedure InsertarOfertaFinalRegaloSorpresa
go
