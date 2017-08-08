GO
use BelcorpChile_Plan20
go
if Exists(Select 1 From sysobjects Where name = 'GetObtenerOfertaFinalRegaloSorpresa' and xtype = 'p')
drop procedure GetObtenerOfertaFinalRegaloSorpresa
