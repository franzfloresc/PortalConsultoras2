Use BelcorpPeru

go
declare @ConfPaisId int = 0

select @ConfPaisId = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

if @ConfPaisId > 0
begin
	
	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @ConfPaisId

	delete from ConfiguracionPaisDetalle 
	where ConfiguracionPaisID = @ConfPaisId

	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, '50'
		, 1
		, 1
	)

	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, '80'
		, 1
		, 1
	)

	update ConfiguracionPais
	set Estado = 1
	, Excluyente = 0
	, DesdeCampania = 201807
	where ConfiguracionPaisID = @ConfPaisId 

end
go


Use BelcorpColombia

go
declare @ConfPaisId int = 0

select @ConfPaisId = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'RDR'

if @ConfPaisId > 0
begin
	
	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @ConfPaisId

	delete from ConfiguracionPaisDetalle 
	where ConfiguracionPaisID = @ConfPaisId

	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, '01'
		, 1
		, 1
	)

	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, '26'
		, 1
		, 1
	)

	update ConfiguracionPais
	set Estado = 1
	, Excluyente = 0
	, DesdeCampania = 201807
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

