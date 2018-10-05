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
	set Estado = 0
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

	-- Region 01
	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, CodigoZona
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, '01'
		, '0101'
		, 1
		, 1
	)

	
	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, CodigoZona
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, '01'
		, '0102'
		, 1
		, 1
	)
	
	
	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, CodigoZona
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, '01'
		, '0103'
		, 1
		, 1
	)
	
	
	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, CodigoZona
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, '01'
		, '0104'
		, 1
		, 1
	)

	
	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, CodigoZona
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, '01'
		, '0108'
		, 1
		, 1
	)

	
	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, CodigoZona
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, '01'
		, '0123'
		, 1
		, 1
	)
	
	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, CodigoZona
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, '01'
		, '0125'
		, 1
		, 1
	)

	-- Region 26

	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, CodigoZona
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, '26'
		, '2604'
		, 1
		, 1
	)

	
	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, CodigoZona
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, '26'
		, '2606'
		, 1
		, 1
	)
	
	
	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, CodigoZona
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, '26'
		, '2610'
		, 1
		, 1
	)

	
	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, CodigoZona
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, '26'
		, '2612'
		, 1
		, 1
	)
	
	
	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, CodigoZona
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, '26'
		, '2613'
		, 1
		, 1
	)

	
	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, CodigoZona
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, '26'
		, '2614'
		, 1
		, 1
	)

	
	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, CodigoZona
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, '26'
		, '2623'
		, 1
		, 1
	)
	
	
	insert into ConfiguracionPaisDetalle(
	  ConfiguracionPaisID
	, CodigoRegion
	, CodigoZona
	, Estado
	, BloqueoRevistaImpresa
	)
	values(
		@ConfPaisId
		, '26'
		, '2625'
		, 1
		, 1
	)

	update ConfiguracionPais
	set Estado = 0
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

