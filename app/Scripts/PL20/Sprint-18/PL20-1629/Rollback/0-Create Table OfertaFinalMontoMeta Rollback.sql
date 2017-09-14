Use BelcorpChile
go
if exists(select 1 from sysobjects where name = 'OfertaFinalMontoMeta' and xtype = 'u')
begin
	drop table OfertaFinalMontoMeta
end
