GO
USE BelcorpPeru
GO
go
begin

	declare @ConfiguracionPaisID int

	select @ConfiguracionPaisID = ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in ('BannerCarruselTitulo', 'BannerCarruselTextoEnlace')

	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTitulo'
		, 0
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,null
		,'Texto para el banner del carrusel'
		,1
		,'BannerCarrusel'
		);


	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTextoEnlace'
		, 0
		,'VER MÁS'
		,'VER MÁS'
		,null
		,'Texto para el botón'
		,1
		,'BannerCarrusel'
		);
end;
go

GO
USE BelcorpMexico
GO
go
begin

	declare @ConfiguracionPaisID int

	select @ConfiguracionPaisID = ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in ('BannerCarruselTitulo', 'BannerCarruselTextoEnlace')

	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTitulo'
		, 0
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,null
		,'Texto para el banner del carrusel'
		,1
		,'BannerCarrusel'
		);


	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTextoEnlace'
		, 0
		,'VER MÁS'
		,'VER MÁS'
		,null
		,'Texto para el botón'
		,1
		,'BannerCarrusel'
		);
end;
go

GO
USE BelcorpColombia
GO
go
begin

	declare @ConfiguracionPaisID int

	select @ConfiguracionPaisID = ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in ('BannerCarruselTitulo', 'BannerCarruselTextoEnlace')

	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTitulo'
		, 0
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,null
		,'Texto para el banner del carrusel'
		,1
		,'BannerCarrusel'
		);


	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTextoEnlace'
		, 0
		,'VER MÁS'
		,'VER MÁS'
		,null
		,'Texto para el botón'
		,1
		,'BannerCarrusel'
		);
end;
go

GO
USE BelcorpSalvador
GO
go
begin

	declare @ConfiguracionPaisID int

	select @ConfiguracionPaisID = ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in ('BannerCarruselTitulo', 'BannerCarruselTextoEnlace')

	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTitulo'
		, 0
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,null
		,'Texto para el banner del carrusel'
		,1
		,'BannerCarrusel'
		);


	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTextoEnlace'
		, 0
		,'VER MÁS'
		,'VER MÁS'
		,null
		,'Texto para el botón'
		,1
		,'BannerCarrusel'
		);
end;
go

GO
USE BelcorpPuertoRico
GO
go
begin

	declare @ConfiguracionPaisID int

	select @ConfiguracionPaisID = ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in ('BannerCarruselTitulo', 'BannerCarruselTextoEnlace')

	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTitulo'
		, 0
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,null
		,'Texto para el banner del carrusel'
		,1
		,'BannerCarrusel'
		);


	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTextoEnlace'
		, 0
		,'VER MÁS'
		,'VER MÁS'
		,null
		,'Texto para el botón'
		,1
		,'BannerCarrusel'
		);
end;
go

GO
USE BelcorpPanama
GO
go
begin

	declare @ConfiguracionPaisID int

	select @ConfiguracionPaisID = ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in ('BannerCarruselTitulo', 'BannerCarruselTextoEnlace')

	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTitulo'
		, 0
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,null
		,'Texto para el banner del carrusel'
		,1
		,'BannerCarrusel'
		);


	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTextoEnlace'
		, 0
		,'VER MÁS'
		,'VER MÁS'
		,null
		,'Texto para el botón'
		,1
		,'BannerCarrusel'
		);
end;
go

GO
USE BelcorpGuatemala
GO
go
begin

	declare @ConfiguracionPaisID int

	select @ConfiguracionPaisID = ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in ('BannerCarruselTitulo', 'BannerCarruselTextoEnlace')

	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTitulo'
		, 0
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,null
		,'Texto para el banner del carrusel'
		,1
		,'BannerCarrusel'
		);


	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTextoEnlace'
		, 0
		,'VER MÁS'
		,'VER MÁS'
		,null
		,'Texto para el botón'
		,1
		,'BannerCarrusel'
		);
end;
go

GO
USE BelcorpEcuador
GO
go
begin

	declare @ConfiguracionPaisID int

	select @ConfiguracionPaisID = ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in ('BannerCarruselTitulo', 'BannerCarruselTextoEnlace')

	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTitulo'
		, 0
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,null
		,'Texto para el banner del carrusel'
		,1
		,'BannerCarrusel'
		);


	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTextoEnlace'
		, 0
		,'VER MÁS'
		,'VER MÁS'
		,null
		,'Texto para el botón'
		,1
		,'BannerCarrusel'
		);
end;
go

GO
USE BelcorpDominicana
GO
go
begin

	declare @ConfiguracionPaisID int

	select @ConfiguracionPaisID = ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in ('BannerCarruselTitulo', 'BannerCarruselTextoEnlace')

	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTitulo'
		, 0
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,null
		,'Texto para el banner del carrusel'
		,1
		,'BannerCarrusel'
		);


	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTextoEnlace'
		, 0
		,'VER MÁS'
		,'VER MÁS'
		,null
		,'Texto para el botón'
		,1
		,'BannerCarrusel'
		);
end;
go

GO
USE BelcorpCostaRica
GO
go
begin

	declare @ConfiguracionPaisID int

	select @ConfiguracionPaisID = ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in ('BannerCarruselTitulo', 'BannerCarruselTextoEnlace')

	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTitulo'
		, 0
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,null
		,'Texto para el banner del carrusel'
		,1
		,'BannerCarrusel'
		);


	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTextoEnlace'
		, 0
		,'VER MÁS'
		,'VER MÁS'
		,null
		,'Texto para el botón'
		,1
		,'BannerCarrusel'
		);
end;
go

GO
USE BelcorpChile
GO
go
begin

	declare @ConfiguracionPaisID int

	select @ConfiguracionPaisID = ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in ('BannerCarruselTitulo', 'BannerCarruselTextoEnlace')

	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTitulo'
		, 0
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,null
		,'Texto para el banner del carrusel'
		,1
		,'BannerCarrusel'
		);


	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTextoEnlace'
		, 0
		,'VER MÁS'
		,'VER MÁS'
		,null
		,'Texto para el botón'
		,1
		,'BannerCarrusel'
		);
end;
go

GO
USE BelcorpBolivia
GO
go
begin

	declare @ConfiguracionPaisID int

	select @ConfiguracionPaisID = ConfiguracionPaisID from dbo.configuracionpais where codigo = 'MG'

	delete from ConfiguracionPaisDatos where ConfiguracionPaisID = @ConfiguracionPaisID and Codigo in ('BannerCarruselTitulo', 'BannerCarruselTextoEnlace')

	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTitulo'
		, 0
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,'TENEMOS MÁS&nbsp;OPCIONES PARA TÍ'
		,null
		,'Texto para el banner del carrusel'
		,1
		,'BannerCarrusel'
		);


	insert into dbo.ConfiguracionPaisDatos(
		ConfiguracionPaisID
		, Codigo
		, CampaniaID
		, Valor1
		, Valor2
		, Valor3
		, Descripcion
		, Estado
		, Componente
		) values  (
		@ConfiguracionPaisID
		,'BannerCarruselTextoEnlace'
		, 0
		,'VER MÁS'
		,'VER MÁS'
		,null
		,'Texto para el botón'
		,1
		,'BannerCarrusel'
		);
end;
go

GO
