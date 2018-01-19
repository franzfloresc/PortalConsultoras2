

USE BelcorpChile

go

declare @origen varchar(10) = 'RD'

delete from AsesoraOnline where Origen = @origen

go