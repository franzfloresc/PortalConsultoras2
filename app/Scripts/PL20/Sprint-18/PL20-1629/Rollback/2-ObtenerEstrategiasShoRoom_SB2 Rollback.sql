GO
use BelcorpChile_Plan20
go
if exists(select 1 from sysobjects where name = 'ObtenerEstrategiasShoRoom_SB2' and xtype = 'p')
drop procedure ObtenerEstrategiasShoRoom_SB2
go

GO
