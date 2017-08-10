GO
use BelcorpChile
go
if Exists(Select 1 From sysobjects Where name = 'GetOfertasShowRoomOF' and xtype = 'p')
	drop procedure ShowRoom.GetOfertasShowRoomOF
go
