USE BelcorpPeru
GO

GO

	declare @RevistaDigitalId int = 0
	declare @RevistaDigitalCodigo varchar(30) = 'RD'

	declare @datoCodigo varchar(100) = 'ActivoMDO'

	select @RevistaDigitalId = cp.ConfiguracionPaisID
	from ConfiguracionPais cp
	where cp.Codigo = @RevistaDigitalCodigo

	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @RevistaDigitalId
	and codigo = @datoCodigo

	insert into ConfiguracionPaisDatos(
		ConfiguracionPaisID
		,Codigo
		,CampaniaID
		,Valor1
		,Descripcion
		,Estado
	)
	values(
		@RevistaDigitalId
		,@datoCodigo
		,0
		,'1'
		,'Activar MDO => 1 activo'
		,0
	)

GO

USE BelcorpMexico
GO

GO

	declare @RevistaDigitalId int = 0
	declare @RevistaDigitalCodigo varchar(30) = 'RD'

	declare @datoCodigo varchar(100) = 'ActivoMDO'

	select @RevistaDigitalId = cp.ConfiguracionPaisID
	from ConfiguracionPais cp
	where cp.Codigo = @RevistaDigitalCodigo

	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @RevistaDigitalId
	and codigo = @datoCodigo

	insert into ConfiguracionPaisDatos(
		ConfiguracionPaisID
		,Codigo
		,CampaniaID
		,Valor1
		,Descripcion
		,Estado
	)
	values(
		@RevistaDigitalId
		,@datoCodigo
		,0
		,'1'
		,'Activar MDO => 1 activo'
		,0
	)

GO

USE BelcorpColombia
GO

GO

	declare @RevistaDigitalId int = 0
	declare @RevistaDigitalCodigo varchar(30) = 'RD'

	declare @datoCodigo varchar(100) = 'ActivoMDO'

	select @RevistaDigitalId = cp.ConfiguracionPaisID
	from ConfiguracionPais cp
	where cp.Codigo = @RevistaDigitalCodigo

	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @RevistaDigitalId
	and codigo = @datoCodigo

	insert into ConfiguracionPaisDatos(
		ConfiguracionPaisID
		,Codigo
		,CampaniaID
		,Valor1
		,Descripcion
		,Estado
	)
	values(
		@RevistaDigitalId
		,@datoCodigo
		,0
		,'1'
		,'Activar MDO => 1 activo'
		,0
	)

GO

USE BelcorpSalvador
GO

GO

	declare @RevistaDigitalId int = 0
	declare @RevistaDigitalCodigo varchar(30) = 'RD'

	declare @datoCodigo varchar(100) = 'ActivoMDO'

	select @RevistaDigitalId = cp.ConfiguracionPaisID
	from ConfiguracionPais cp
	where cp.Codigo = @RevistaDigitalCodigo

	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @RevistaDigitalId
	and codigo = @datoCodigo

	insert into ConfiguracionPaisDatos(
		ConfiguracionPaisID
		,Codigo
		,CampaniaID
		,Valor1
		,Descripcion
		,Estado
	)
	values(
		@RevistaDigitalId
		,@datoCodigo
		,0
		,'1'
		,'Activar MDO => 1 activo'
		,0
	)

GO

USE BelcorpPuertoRico
GO

GO

	declare @RevistaDigitalId int = 0
	declare @RevistaDigitalCodigo varchar(30) = 'RD'

	declare @datoCodigo varchar(100) = 'ActivoMDO'

	select @RevistaDigitalId = cp.ConfiguracionPaisID
	from ConfiguracionPais cp
	where cp.Codigo = @RevistaDigitalCodigo

	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @RevistaDigitalId
	and codigo = @datoCodigo

	insert into ConfiguracionPaisDatos(
		ConfiguracionPaisID
		,Codigo
		,CampaniaID
		,Valor1
		,Descripcion
		,Estado
	)
	values(
		@RevistaDigitalId
		,@datoCodigo
		,0
		,'1'
		,'Activar MDO => 1 activo'
		,0
	)

GO

USE BelcorpPanama
GO

GO

	declare @RevistaDigitalId int = 0
	declare @RevistaDigitalCodigo varchar(30) = 'RD'

	declare @datoCodigo varchar(100) = 'ActivoMDO'

	select @RevistaDigitalId = cp.ConfiguracionPaisID
	from ConfiguracionPais cp
	where cp.Codigo = @RevistaDigitalCodigo

	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @RevistaDigitalId
	and codigo = @datoCodigo

	insert into ConfiguracionPaisDatos(
		ConfiguracionPaisID
		,Codigo
		,CampaniaID
		,Valor1
		,Descripcion
		,Estado
	)
	values(
		@RevistaDigitalId
		,@datoCodigo
		,0
		,'1'
		,'Activar MDO => 1 activo'
		,0
	)

GO

USE BelcorpGuatemala
GO

GO

	declare @RevistaDigitalId int = 0
	declare @RevistaDigitalCodigo varchar(30) = 'RD'

	declare @datoCodigo varchar(100) = 'ActivoMDO'

	select @RevistaDigitalId = cp.ConfiguracionPaisID
	from ConfiguracionPais cp
	where cp.Codigo = @RevistaDigitalCodigo

	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @RevistaDigitalId
	and codigo = @datoCodigo

	insert into ConfiguracionPaisDatos(
		ConfiguracionPaisID
		,Codigo
		,CampaniaID
		,Valor1
		,Descripcion
		,Estado
	)
	values(
		@RevistaDigitalId
		,@datoCodigo
		,0
		,'1'
		,'Activar MDO => 1 activo'
		,0
	)

GO

USE BelcorpEcuador
GO

GO

	declare @RevistaDigitalId int = 0
	declare @RevistaDigitalCodigo varchar(30) = 'RD'

	declare @datoCodigo varchar(100) = 'ActivoMDO'

	select @RevistaDigitalId = cp.ConfiguracionPaisID
	from ConfiguracionPais cp
	where cp.Codigo = @RevistaDigitalCodigo

	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @RevistaDigitalId
	and codigo = @datoCodigo

	insert into ConfiguracionPaisDatos(
		ConfiguracionPaisID
		,Codigo
		,CampaniaID
		,Valor1
		,Descripcion
		,Estado
	)
	values(
		@RevistaDigitalId
		,@datoCodigo
		,0
		,'1'
		,'Activar MDO => 1 activo'
		,0
	)

GO

USE BelcorpDominicana
GO

GO

	declare @RevistaDigitalId int = 0
	declare @RevistaDigitalCodigo varchar(30) = 'RD'

	declare @datoCodigo varchar(100) = 'ActivoMDO'

	select @RevistaDigitalId = cp.ConfiguracionPaisID
	from ConfiguracionPais cp
	where cp.Codigo = @RevistaDigitalCodigo

	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @RevistaDigitalId
	and codigo = @datoCodigo

	insert into ConfiguracionPaisDatos(
		ConfiguracionPaisID
		,Codigo
		,CampaniaID
		,Valor1
		,Descripcion
		,Estado
	)
	values(
		@RevistaDigitalId
		,@datoCodigo
		,0
		,'1'
		,'Activar MDO => 1 activo'
		,0
	)

GO

USE BelcorpCostaRica
GO

GO

	declare @RevistaDigitalId int = 0
	declare @RevistaDigitalCodigo varchar(30) = 'RD'

	declare @datoCodigo varchar(100) = 'ActivoMDO'

	select @RevistaDigitalId = cp.ConfiguracionPaisID
	from ConfiguracionPais cp
	where cp.Codigo = @RevistaDigitalCodigo

	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @RevistaDigitalId
	and codigo = @datoCodigo

	insert into ConfiguracionPaisDatos(
		ConfiguracionPaisID
		,Codigo
		,CampaniaID
		,Valor1
		,Descripcion
		,Estado
	)
	values(
		@RevistaDigitalId
		,@datoCodigo
		,0
		,'1'
		,'Activar MDO => 1 activo'
		,0
	)

GO

USE BelcorpChile
GO

GO

	declare @RevistaDigitalId int = 0
	declare @RevistaDigitalCodigo varchar(30) = 'RD'

	declare @datoCodigo varchar(100) = 'ActivoMDO'

	select @RevistaDigitalId = cp.ConfiguracionPaisID
	from ConfiguracionPais cp
	where cp.Codigo = @RevistaDigitalCodigo

	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @RevistaDigitalId
	and codigo = @datoCodigo

	insert into ConfiguracionPaisDatos(
		ConfiguracionPaisID
		,Codigo
		,CampaniaID
		,Valor1
		,Descripcion
		,Estado
	)
	values(
		@RevistaDigitalId
		,@datoCodigo
		,0
		,'1'
		,'Activar MDO => 1 activo'
		,0
	)

GO

USE BelcorpBolivia
GO

GO

	declare @RevistaDigitalId int = 0
	declare @RevistaDigitalCodigo varchar(30) = 'RD'

	declare @datoCodigo varchar(100) = 'ActivoMDO'

	select @RevistaDigitalId = cp.ConfiguracionPaisID
	from ConfiguracionPais cp
	where cp.Codigo = @RevistaDigitalCodigo

	delete from ConfiguracionPaisDatos
	where ConfiguracionPaisID = @RevistaDigitalId
	and codigo = @datoCodigo

	insert into ConfiguracionPaisDatos(
		ConfiguracionPaisID
		,Codigo
		,CampaniaID
		,Valor1
		,Descripcion
		,Estado
	)
	values(
		@RevistaDigitalId
		,@datoCodigo
		,0
		,'1'
		,'Activar MDO => 1 activo'
		,0
	)

GO

