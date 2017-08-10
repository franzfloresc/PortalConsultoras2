GO
use BelcorpChile
go
if exists(select 1 from sysobjects where name = 'GetListaProductoOfertaFinalRegaloSorpresa' and xtype = 'p')
drop procedure GetListaProductoOfertaFinalRegaloSorpresa
go

GO
go