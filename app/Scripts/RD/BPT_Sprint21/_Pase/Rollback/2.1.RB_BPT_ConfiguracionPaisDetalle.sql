USE BelcorpPeru
GO

go
declare @ConfPaisId int = 0

select @ConfPaisId = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

if @ConfPaisId > 0
begin
	
	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @ConfPaisId
	
	delete from ConfiguracionPaisDetalle 
	where ConfiguracionPaisID = @ConfPaisId

end
go

USE BelcorpMexico
GO

go
declare @ConfPaisId int = 0

select @ConfPaisId = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

if @ConfPaisId > 0
begin
	
	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @ConfPaisId
	
	delete from ConfiguracionPaisDetalle 
	where ConfiguracionPaisID = @ConfPaisId

end
go

USE BelcorpColombia
GO

go
declare @ConfPaisId int = 0

select @ConfPaisId = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

if @ConfPaisId > 0
begin
	
	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @ConfPaisId
	
	delete from ConfiguracionPaisDetalle 
	where ConfiguracionPaisID = @ConfPaisId

end
go

USE BelcorpSalvador
GO

go
declare @ConfPaisId int = 0

select @ConfPaisId = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

if @ConfPaisId > 0
begin
	
	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @ConfPaisId
	
	delete from ConfiguracionPaisDetalle 
	where ConfiguracionPaisID = @ConfPaisId

end
go

USE BelcorpPuertoRico
GO

go
declare @ConfPaisId int = 0

select @ConfPaisId = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

if @ConfPaisId > 0
begin
	
	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @ConfPaisId
	
	delete from ConfiguracionPaisDetalle 
	where ConfiguracionPaisID = @ConfPaisId

end
go

USE BelcorpPanama
GO

go
declare @ConfPaisId int = 0

select @ConfPaisId = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

if @ConfPaisId > 0
begin
	
	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @ConfPaisId
	
	delete from ConfiguracionPaisDetalle 
	where ConfiguracionPaisID = @ConfPaisId

end
go

USE BelcorpGuatemala
GO

go
declare @ConfPaisId int = 0

select @ConfPaisId = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

if @ConfPaisId > 0
begin
	
	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @ConfPaisId
	
	delete from ConfiguracionPaisDetalle 
	where ConfiguracionPaisID = @ConfPaisId

end
go

USE BelcorpEcuador
GO

go
declare @ConfPaisId int = 0

select @ConfPaisId = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

if @ConfPaisId > 0
begin
	
	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @ConfPaisId
	
	delete from ConfiguracionPaisDetalle 
	where ConfiguracionPaisID = @ConfPaisId

end
go

USE BelcorpDominicana
GO

go
declare @ConfPaisId int = 0

select @ConfPaisId = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

if @ConfPaisId > 0
begin
	
	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @ConfPaisId
	
	delete from ConfiguracionPaisDetalle 
	where ConfiguracionPaisID = @ConfPaisId

end
go

USE BelcorpCostaRica
GO

go
declare @ConfPaisId int = 0

select @ConfPaisId = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

if @ConfPaisId > 0
begin
	
	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @ConfPaisId
	
	delete from ConfiguracionPaisDetalle 
	where ConfiguracionPaisID = @ConfPaisId

end
go

USE BelcorpChile
GO

go
declare @ConfPaisId int = 0

select @ConfPaisId = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

if @ConfPaisId > 0
begin
	
	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @ConfPaisId
	
	delete from ConfiguracionPaisDetalle 
	where ConfiguracionPaisID = @ConfPaisId

end
go

USE BelcorpBolivia
GO

go
declare @ConfPaisId int = 0

select @ConfPaisId = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

if @ConfPaisId > 0
begin
	
	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @ConfPaisId
	
	delete from ConfiguracionPaisDetalle 
	where ConfiguracionPaisID = @ConfPaisId

end
go

