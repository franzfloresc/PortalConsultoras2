GO
USE BelcorpPeru
GO
go
print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if not exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	declare @DesdeCampania int = 201907
	declare @Orden int = 1
	declare @ConfiguracionPaisID int

	select
		@ConfiguracionPaisID = cp.ConfiguracionPaisID
	from [dbo].[ConfiguracionPais] cp
	where cp.Codigo = @Codigo

	print 'Empieza insert into [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	begin try

	begin transaction InsertCOHCodigoATP;

	insert into [dbo].[ConfiguracionOfertasHome](
		ConfiguracionPaisID, CampaniaID, UrlSeccion,
		DesktopOrden, MobileOrden, DesktopOrdenBpt, MobileOrdenBpt,
		DesktopUsarImagenFondo, MobileUsarImagenFondo,
		DesktopImagenFondo, MobileImagenFondo,
		DesktopTitulo, MobileTitulo, DesktopSubTitulo, MobileSubTitulo,
		DesktopTipoPresentacion, MobileTipoPresentacion, DesktopTipoEstrategia, MobileTipoEstrategia,
		DesktopCantidadProductos, MobileCantidadProductos,
		DesktopActivo, MobileActivo,
		DesktopColorFondo, MobileColorFondo,
		DesktopColorTexto, MobileColorTexto,
		BotonTexto1,BotonTexto2,
		BotonColor,	BotonColorTexto
	)
	values
	(
		@ConfiguracionPaisID, @DesdeCampania, '',
		@Orden, @Orden, @Orden, @Orden,
		0,0,
		'ContenedorHome_Banner_Atp.png','ContenedorHome_Banner_Atp.png',
		'ARMA TU PACK','ARMA TU PACK','Elige tus productos favoritos y llévatelos a #PrecioTotal','Elige tus productos favoritos y llévatelos a #PrecioTotal',
		10,10,'004','004',
		0,0,
		1,1,
		'#fa1702','#fa1702',
		'#ffffff','#ffffff',
		'Comenzar','Modificar',
		'#000000','#ffffff'
	)

	IF (@@TRANCOUNT > 0)  commit transaction InsertCOHCodigoATP;

	print 'Registro insertado correctamente en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	end try
	begin catch
	    SELECT
        ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;

		IF (@@TRANCOUNT > 0) rollback transaction InsertCOHCodigoATP;

		print 'Error al insertar registro en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
	end catch
end
else
begin
	print 'El registro en Configuracion Ofertas Home con Codigo ATP YA EXISTE'
end

print 'Finaliza insert into  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
go




GO
USE BelcorpMexico
GO
go
print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if not exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	declare @DesdeCampania int = 201907
	declare @Orden int = 1
	declare @ConfiguracionPaisID int

	select
		@ConfiguracionPaisID = cp.ConfiguracionPaisID
	from [dbo].[ConfiguracionPais] cp
	where cp.Codigo = @Codigo

	print 'Empieza insert into [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	begin try

	begin transaction InsertCOHCodigoATP;

	insert into [dbo].[ConfiguracionOfertasHome](
		ConfiguracionPaisID, CampaniaID, UrlSeccion,
		DesktopOrden, MobileOrden, DesktopOrdenBpt, MobileOrdenBpt,
		DesktopUsarImagenFondo, MobileUsarImagenFondo,
		DesktopImagenFondo, MobileImagenFondo,
		DesktopTitulo, MobileTitulo, DesktopSubTitulo, MobileSubTitulo,
		DesktopTipoPresentacion, MobileTipoPresentacion, DesktopTipoEstrategia, MobileTipoEstrategia,
		DesktopCantidadProductos, MobileCantidadProductos,
		DesktopActivo, MobileActivo,
		DesktopColorFondo, MobileColorFondo,
		DesktopColorTexto, MobileColorTexto,
		BotonTexto1,BotonTexto2,
		BotonColor,	BotonColorTexto
	)
	values
	(
		@ConfiguracionPaisID, @DesdeCampania, '',
		@Orden, @Orden, @Orden, @Orden,
		0,0,
		'ContenedorHome_Banner_Atp.png','ContenedorHome_Banner_Atp.png',
		'ARMA TU PACK','ARMA TU PACK','Elige tus productos favoritos y llévatelos a #PrecioTotal','Elige tus productos favoritos y llévatelos a #PrecioTotal',
		10,10,'004','004',
		0,0,
		0,0,
		'#fa1702','#fa1702',
		'#ffffff','#ffffff',
		'Comenzar','Modificar',
		'#000000','#ffffff'
	)

	IF (@@TRANCOUNT > 0)  commit transaction InsertCOHCodigoATP;

	print 'Registro insertado correctamente en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	end try
	begin catch
	    SELECT
        ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;

		IF (@@TRANCOUNT > 0) rollback transaction InsertCOHCodigoATP;

		print 'Error al insertar registro en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
	end catch
end
else
begin
	print 'El registro en Configuracion Ofertas Home con Codigo ATP YA EXISTE'
end

print 'Finaliza insert into  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
go




GO
USE BelcorpColombia
GO
go
print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if not exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	declare @DesdeCampania int = 201907
	declare @Orden int = 1
	declare @ConfiguracionPaisID int

	select
		@ConfiguracionPaisID = cp.ConfiguracionPaisID
	from [dbo].[ConfiguracionPais] cp
	where cp.Codigo = @Codigo

	print 'Empieza insert into [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	begin try

	begin transaction InsertCOHCodigoATP;

	insert into [dbo].[ConfiguracionOfertasHome](
		ConfiguracionPaisID, CampaniaID, UrlSeccion,
		DesktopOrden, MobileOrden, DesktopOrdenBpt, MobileOrdenBpt,
		DesktopUsarImagenFondo, MobileUsarImagenFondo,
		DesktopImagenFondo, MobileImagenFondo,
		DesktopTitulo, MobileTitulo, DesktopSubTitulo, MobileSubTitulo,
		DesktopTipoPresentacion, MobileTipoPresentacion, DesktopTipoEstrategia, MobileTipoEstrategia,
		DesktopCantidadProductos, MobileCantidadProductos,
		DesktopActivo, MobileActivo,
		DesktopColorFondo, MobileColorFondo,
		DesktopColorTexto, MobileColorTexto,
		BotonTexto1,BotonTexto2,
		BotonColor,	BotonColorTexto
	)
	values
	(
		@ConfiguracionPaisID, @DesdeCampania, '',
		@Orden, @Orden, @Orden, @Orden,
		0,0,
		'ContenedorHome_Banner_Atp.png','ContenedorHome_Banner_Atp.png',
		'ARMA TU PACK','ARMA TU PACK','Elige tus productos favoritos y llévatelos a #PrecioTotal','Elige tus productos favoritos y llévatelos a #PrecioTotal',
		10,10,'004','004',
		0,0,
		1,1,
		'#fa1702','#fa1702',
		'#ffffff','#ffffff',
		'Comenzar','Modificar',
		'#000000','#ffffff'
	)

	IF (@@TRANCOUNT > 0)  commit transaction InsertCOHCodigoATP;

	print 'Registro insertado correctamente en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	end try
	begin catch
	    SELECT
        ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;

		IF (@@TRANCOUNT > 0) rollback transaction InsertCOHCodigoATP;

		print 'Error al insertar registro en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
	end catch
end
else
begin
	print 'El registro en Configuracion Ofertas Home con Codigo ATP YA EXISTE'
end

print 'Finaliza insert into  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
go




GO
USE BelcorpSalvador
GO
go
print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if not exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	declare @DesdeCampania int = 201907
	declare @Orden int = 1
	declare @ConfiguracionPaisID int

	select
		@ConfiguracionPaisID = cp.ConfiguracionPaisID
	from [dbo].[ConfiguracionPais] cp
	where cp.Codigo = @Codigo

	print 'Empieza insert into [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	begin try

	begin transaction InsertCOHCodigoATP;

	insert into [dbo].[ConfiguracionOfertasHome](
		ConfiguracionPaisID, CampaniaID, UrlSeccion,
		DesktopOrden, MobileOrden, DesktopOrdenBpt, MobileOrdenBpt,
		DesktopUsarImagenFondo, MobileUsarImagenFondo,
		DesktopImagenFondo, MobileImagenFondo,
		DesktopTitulo, MobileTitulo, DesktopSubTitulo, MobileSubTitulo,
		DesktopTipoPresentacion, MobileTipoPresentacion, DesktopTipoEstrategia, MobileTipoEstrategia,
		DesktopCantidadProductos, MobileCantidadProductos,
		DesktopActivo, MobileActivo,
		DesktopColorFondo, MobileColorFondo,
		DesktopColorTexto, MobileColorTexto,
		BotonTexto1,BotonTexto2,
		BotonColor,	BotonColorTexto
	)
	values
	(
		@ConfiguracionPaisID, @DesdeCampania, '',
		@Orden, @Orden, @Orden, @Orden,
		0,0,
		'ContenedorHome_Banner_Atp.png','ContenedorHome_Banner_Atp.png',
		'ARMA TU PACK','ARMA TU PACK','Elige tus productos favoritos y llévatelos a #PrecioTotal','Elige tus productos favoritos y llévatelos a #PrecioTotal',
		10,10,'004','004',
		0,0,
		0,0,
		'#fa1702','#fa1702',
		'#ffffff','#ffffff',
		'Comenzar','Modificar',
		'#000000','#ffffff'
	)

	IF (@@TRANCOUNT > 0)  commit transaction InsertCOHCodigoATP;

	print 'Registro insertado correctamente en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	end try
	begin catch
	    SELECT
        ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;

		IF (@@TRANCOUNT > 0) rollback transaction InsertCOHCodigoATP;

		print 'Error al insertar registro en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
	end catch
end
else
begin
	print 'El registro en Configuracion Ofertas Home con Codigo ATP YA EXISTE'
end

print 'Finaliza insert into  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
go




GO
USE BelcorpPuertoRico
GO
go
print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if not exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	declare @DesdeCampania int = 201907
	declare @Orden int = 1
	declare @ConfiguracionPaisID int

	select
		@ConfiguracionPaisID = cp.ConfiguracionPaisID
	from [dbo].[ConfiguracionPais] cp
	where cp.Codigo = @Codigo

	print 'Empieza insert into [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	begin try

	begin transaction InsertCOHCodigoATP;

	insert into [dbo].[ConfiguracionOfertasHome](
		ConfiguracionPaisID, CampaniaID, UrlSeccion,
		DesktopOrden, MobileOrden, DesktopOrdenBpt, MobileOrdenBpt,
		DesktopUsarImagenFondo, MobileUsarImagenFondo,
		DesktopImagenFondo, MobileImagenFondo,
		DesktopTitulo, MobileTitulo, DesktopSubTitulo, MobileSubTitulo,
		DesktopTipoPresentacion, MobileTipoPresentacion, DesktopTipoEstrategia, MobileTipoEstrategia,
		DesktopCantidadProductos, MobileCantidadProductos,
		DesktopActivo, MobileActivo,
		DesktopColorFondo, MobileColorFondo,
		DesktopColorTexto, MobileColorTexto,
		BotonTexto1,BotonTexto2,
		BotonColor,	BotonColorTexto
	)
	values
	(
		@ConfiguracionPaisID, @DesdeCampania, '',
		@Orden, @Orden, @Orden, @Orden,
		0,0,
		'ContenedorHome_Banner_Atp.png','ContenedorHome_Banner_Atp.png',
		'ARMA TU PACK','ARMA TU PACK','Elige tus productos favoritos y llévatelos a #PrecioTotal','Elige tus productos favoritos y llévatelos a #PrecioTotal',
		10,10,'004','004',
		0,0,
		0,0,
		'#fa1702','#fa1702',
		'#ffffff','#ffffff',
		'Comenzar','Modificar',
		'#000000','#ffffff'
	)

	IF (@@TRANCOUNT > 0)  commit transaction InsertCOHCodigoATP;

	print 'Registro insertado correctamente en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	end try
	begin catch
	    SELECT
        ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;

		IF (@@TRANCOUNT > 0) rollback transaction InsertCOHCodigoATP;

		print 'Error al insertar registro en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
	end catch
end
else
begin
	print 'El registro en Configuracion Ofertas Home con Codigo ATP YA EXISTE'
end

print 'Finaliza insert into  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
go




GO
USE BelcorpPanama
GO
go
print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if not exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	declare @DesdeCampania int = 201907
	declare @Orden int = 1
	declare @ConfiguracionPaisID int

	select
		@ConfiguracionPaisID = cp.ConfiguracionPaisID
	from [dbo].[ConfiguracionPais] cp
	where cp.Codigo = @Codigo

	print 'Empieza insert into [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	begin try

	begin transaction InsertCOHCodigoATP;

	insert into [dbo].[ConfiguracionOfertasHome](
		ConfiguracionPaisID, CampaniaID, UrlSeccion,
		DesktopOrden, MobileOrden, DesktopOrdenBpt, MobileOrdenBpt,
		DesktopUsarImagenFondo, MobileUsarImagenFondo,
		DesktopImagenFondo, MobileImagenFondo,
		DesktopTitulo, MobileTitulo, DesktopSubTitulo, MobileSubTitulo,
		DesktopTipoPresentacion, MobileTipoPresentacion, DesktopTipoEstrategia, MobileTipoEstrategia,
		DesktopCantidadProductos, MobileCantidadProductos,
		DesktopActivo, MobileActivo,
		DesktopColorFondo, MobileColorFondo,
		DesktopColorTexto, MobileColorTexto,
		BotonTexto1,BotonTexto2,
		BotonColor,	BotonColorTexto
	)
	values
	(
		@ConfiguracionPaisID, @DesdeCampania, '',
		@Orden, @Orden, @Orden, @Orden,
		0,0,
		'ContenedorHome_Banner_Atp.png','ContenedorHome_Banner_Atp.png',
		'ARMA TU PACK','ARMA TU PACK','Elige tus productos favoritos y llévatelos a #PrecioTotal','Elige tus productos favoritos y llévatelos a #PrecioTotal',
		10,10,'004','004',
		0,0,
		0,0,
		'#fa1702','#fa1702',
		'#ffffff','#ffffff',
		'Comenzar','Modificar',
		'#000000','#ffffff'
	)

	IF (@@TRANCOUNT > 0)  commit transaction InsertCOHCodigoATP;

	print 'Registro insertado correctamente en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	end try
	begin catch
	    SELECT
        ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;

		IF (@@TRANCOUNT > 0) rollback transaction InsertCOHCodigoATP;

		print 'Error al insertar registro en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
	end catch
end
else
begin
	print 'El registro en Configuracion Ofertas Home con Codigo ATP YA EXISTE'
end

print 'Finaliza insert into  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
go




GO
USE BelcorpGuatemala
GO
go
print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if not exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	declare @DesdeCampania int = 201907
	declare @Orden int = 1
	declare @ConfiguracionPaisID int

	select
		@ConfiguracionPaisID = cp.ConfiguracionPaisID
	from [dbo].[ConfiguracionPais] cp
	where cp.Codigo = @Codigo

	print 'Empieza insert into [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	begin try

	begin transaction InsertCOHCodigoATP;

	insert into [dbo].[ConfiguracionOfertasHome](
		ConfiguracionPaisID, CampaniaID, UrlSeccion,
		DesktopOrden, MobileOrden, DesktopOrdenBpt, MobileOrdenBpt,
		DesktopUsarImagenFondo, MobileUsarImagenFondo,
		DesktopImagenFondo, MobileImagenFondo,
		DesktopTitulo, MobileTitulo, DesktopSubTitulo, MobileSubTitulo,
		DesktopTipoPresentacion, MobileTipoPresentacion, DesktopTipoEstrategia, MobileTipoEstrategia,
		DesktopCantidadProductos, MobileCantidadProductos,
		DesktopActivo, MobileActivo,
		DesktopColorFondo, MobileColorFondo,
		DesktopColorTexto, MobileColorTexto,
		BotonTexto1,BotonTexto2,
		BotonColor,	BotonColorTexto
	)
	values
	(
		@ConfiguracionPaisID, @DesdeCampania, '',
		@Orden, @Orden, @Orden, @Orden,
		0,0,
		'ContenedorHome_Banner_Atp.png','ContenedorHome_Banner_Atp.png',
		'ARMA TU PACK','ARMA TU PACK','Elige tus productos favoritos y llévatelos a #PrecioTotal','Elige tus productos favoritos y llévatelos a #PrecioTotal',
		10,10,'004','004',
		0,0,
		0,0,
		'#fa1702','#fa1702',
		'#ffffff','#ffffff',
		'Comenzar','Modificar',
		'#000000','#ffffff'
	)

	IF (@@TRANCOUNT > 0)  commit transaction InsertCOHCodigoATP;

	print 'Registro insertado correctamente en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	end try
	begin catch
	    SELECT
        ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;

		IF (@@TRANCOUNT > 0) rollback transaction InsertCOHCodigoATP;

		print 'Error al insertar registro en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
	end catch
end
else
begin
	print 'El registro en Configuracion Ofertas Home con Codigo ATP YA EXISTE'
end

print 'Finaliza insert into  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
go




GO
USE BelcorpEcuador
GO
go
print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if not exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	declare @DesdeCampania int = 201907
	declare @Orden int = 1
	declare @ConfiguracionPaisID int

	select
		@ConfiguracionPaisID = cp.ConfiguracionPaisID
	from [dbo].[ConfiguracionPais] cp
	where cp.Codigo = @Codigo

	print 'Empieza insert into [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	begin try

	begin transaction InsertCOHCodigoATP;

	insert into [dbo].[ConfiguracionOfertasHome](
		ConfiguracionPaisID, CampaniaID, UrlSeccion,
		DesktopOrden, MobileOrden, DesktopOrdenBpt, MobileOrdenBpt,
		DesktopUsarImagenFondo, MobileUsarImagenFondo,
		DesktopImagenFondo, MobileImagenFondo,
		DesktopTitulo, MobileTitulo, DesktopSubTitulo, MobileSubTitulo,
		DesktopTipoPresentacion, MobileTipoPresentacion, DesktopTipoEstrategia, MobileTipoEstrategia,
		DesktopCantidadProductos, MobileCantidadProductos,
		DesktopActivo, MobileActivo,
		DesktopColorFondo, MobileColorFondo,
		DesktopColorTexto, MobileColorTexto,
		BotonTexto1,BotonTexto2,
		BotonColor,	BotonColorTexto
	)
	values
	(
		@ConfiguracionPaisID, @DesdeCampania, '',
		@Orden, @Orden, @Orden, @Orden,
		0,0,
		'ContenedorHome_Banner_Atp.png','ContenedorHome_Banner_Atp.png',
		'ARMA TU PACK','ARMA TU PACK','Elige tus productos favoritos y llévatelos a #PrecioTotal','Elige tus productos favoritos y llévatelos a #PrecioTotal',
		10,10,'004','004',
		0,0,
		0,0,
		'#fa1702','#fa1702',
		'#ffffff','#ffffff',
		'Comenzar','Modificar',
		'#000000','#ffffff'
	)

	IF (@@TRANCOUNT > 0)  commit transaction InsertCOHCodigoATP;

	print 'Registro insertado correctamente en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	end try
	begin catch
	    SELECT
        ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;

		IF (@@TRANCOUNT > 0) rollback transaction InsertCOHCodigoATP;

		print 'Error al insertar registro en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
	end catch
end
else
begin
	print 'El registro en Configuracion Ofertas Home con Codigo ATP YA EXISTE'
end

print 'Finaliza insert into  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
go




GO
USE BelcorpDominicana
GO
go
print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if not exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	declare @DesdeCampania int = 201907
	declare @Orden int = 1
	declare @ConfiguracionPaisID int

	select
		@ConfiguracionPaisID = cp.ConfiguracionPaisID
	from [dbo].[ConfiguracionPais] cp
	where cp.Codigo = @Codigo

	print 'Empieza insert into [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	begin try

	begin transaction InsertCOHCodigoATP;

	insert into [dbo].[ConfiguracionOfertasHome](
		ConfiguracionPaisID, CampaniaID, UrlSeccion,
		DesktopOrden, MobileOrden, DesktopOrdenBpt, MobileOrdenBpt,
		DesktopUsarImagenFondo, MobileUsarImagenFondo,
		DesktopImagenFondo, MobileImagenFondo,
		DesktopTitulo, MobileTitulo, DesktopSubTitulo, MobileSubTitulo,
		DesktopTipoPresentacion, MobileTipoPresentacion, DesktopTipoEstrategia, MobileTipoEstrategia,
		DesktopCantidadProductos, MobileCantidadProductos,
		DesktopActivo, MobileActivo,
		DesktopColorFondo, MobileColorFondo,
		DesktopColorTexto, MobileColorTexto,
		BotonTexto1,BotonTexto2,
		BotonColor,	BotonColorTexto
	)
	values
	(
		@ConfiguracionPaisID, @DesdeCampania, '',
		@Orden, @Orden, @Orden, @Orden,
		0,0,
		'ContenedorHome_Banner_Atp.png','ContenedorHome_Banner_Atp.png',
		'ARMA TU PACK','ARMA TU PACK','Elige tus productos favoritos y llévatelos a #PrecioTotal','Elige tus productos favoritos y llévatelos a #PrecioTotal',
		10,10,'004','004',
		0,0,
		0,0,
		'#fa1702','#fa1702',
		'#ffffff','#ffffff',
		'Comenzar','Modificar',
		'#000000','#ffffff'
	)

	IF (@@TRANCOUNT > 0)  commit transaction InsertCOHCodigoATP;

	print 'Registro insertado correctamente en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	end try
	begin catch
	    SELECT
        ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;

		IF (@@TRANCOUNT > 0) rollback transaction InsertCOHCodigoATP;

		print 'Error al insertar registro en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
	end catch
end
else
begin
	print 'El registro en Configuracion Ofertas Home con Codigo ATP YA EXISTE'
end

print 'Finaliza insert into  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
go




GO
USE BelcorpCostaRica
GO
go
print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if not exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	declare @DesdeCampania int = 201907
	declare @Orden int = 1
	declare @ConfiguracionPaisID int

	select
		@ConfiguracionPaisID = cp.ConfiguracionPaisID
	from [dbo].[ConfiguracionPais] cp
	where cp.Codigo = @Codigo

	print 'Empieza insert into [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	begin try

	begin transaction InsertCOHCodigoATP;

	insert into [dbo].[ConfiguracionOfertasHome](
		ConfiguracionPaisID, CampaniaID, UrlSeccion,
		DesktopOrden, MobileOrden, DesktopOrdenBpt, MobileOrdenBpt,
		DesktopUsarImagenFondo, MobileUsarImagenFondo,
		DesktopImagenFondo, MobileImagenFondo,
		DesktopTitulo, MobileTitulo, DesktopSubTitulo, MobileSubTitulo,
		DesktopTipoPresentacion, MobileTipoPresentacion, DesktopTipoEstrategia, MobileTipoEstrategia,
		DesktopCantidadProductos, MobileCantidadProductos,
		DesktopActivo, MobileActivo,
		DesktopColorFondo, MobileColorFondo,
		DesktopColorTexto, MobileColorTexto,
		BotonTexto1,BotonTexto2,
		BotonColor,	BotonColorTexto
	)
	values
	(
		@ConfiguracionPaisID, @DesdeCampania, '',
		@Orden, @Orden, @Orden, @Orden,
		0,0,
		'ContenedorHome_Banner_Atp.png','ContenedorHome_Banner_Atp.png',
		'ARMA TU PACK','ARMA TU PACK','Elige tus productos favoritos y llévatelos a #PrecioTotal','Elige tus productos favoritos y llévatelos a #PrecioTotal',
		10,10,'004','004',
		0,0,
		1,1,
		'#fa1702','#fa1702',
		'#ffffff','#ffffff',
		'Comenzar','Modificar',
		'#000000','#ffffff'
	)

	IF (@@TRANCOUNT > 0)  commit transaction InsertCOHCodigoATP;

	print 'Registro insertado correctamente en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	end try
	begin catch
	    SELECT
        ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;

		IF (@@TRANCOUNT > 0) rollback transaction InsertCOHCodigoATP;

		print 'Error al insertar registro en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
	end catch
end
else
begin
	print 'El registro en Configuracion Ofertas Home con Codigo ATP YA EXISTE'
end

print 'Finaliza insert into  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
go




GO
USE BelcorpChile
GO
go
print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if not exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	declare @DesdeCampania int = 201907
	declare @Orden int = 1
	declare @ConfiguracionPaisID int

	select
		@ConfiguracionPaisID = cp.ConfiguracionPaisID
	from [dbo].[ConfiguracionPais] cp
	where cp.Codigo = @Codigo

	print 'Empieza insert into [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	begin try

	begin transaction InsertCOHCodigoATP;

	insert into [dbo].[ConfiguracionOfertasHome](
		ConfiguracionPaisID, CampaniaID, UrlSeccion,
		DesktopOrden, MobileOrden, DesktopOrdenBpt, MobileOrdenBpt,
		DesktopUsarImagenFondo, MobileUsarImagenFondo,
		DesktopImagenFondo, MobileImagenFondo,
		DesktopTitulo, MobileTitulo, DesktopSubTitulo, MobileSubTitulo,
		DesktopTipoPresentacion, MobileTipoPresentacion, DesktopTipoEstrategia, MobileTipoEstrategia,
		DesktopCantidadProductos, MobileCantidadProductos,
		DesktopActivo, MobileActivo,
		DesktopColorFondo, MobileColorFondo,
		DesktopColorTexto, MobileColorTexto,
		BotonTexto1,BotonTexto2,
		BotonColor,	BotonColorTexto
	)
	values
	(
		@ConfiguracionPaisID, @DesdeCampania, '',
		@Orden, @Orden, @Orden, @Orden,
		0,0,
		'ContenedorHome_Banner_Atp.png','ContenedorHome_Banner_Atp.png',
		'ARMA TU PACK','ARMA TU PACK','Elige tus productos favoritos y llévatelos a #PrecioTotal','Elige tus productos favoritos y llévatelos a #PrecioTotal',
		10,10,'004','004',
		0,0,
		1,1,
		'#fa1702','#fa1702',
		'#ffffff','#ffffff',
		'Comenzar','Modificar',
		'#000000','#ffffff'
	)

	IF (@@TRANCOUNT > 0)  commit transaction InsertCOHCodigoATP;

	print 'Registro insertado correctamente en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	end try
	begin catch
	    SELECT
        ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;

		IF (@@TRANCOUNT > 0) rollback transaction InsertCOHCodigoATP;

		print 'Error al insertar registro en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
	end catch
end
else
begin
	print 'El registro en Configuracion Ofertas Home con Codigo ATP YA EXISTE'
end

print 'Finaliza insert into  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
go




GO
USE BelcorpBolivia
GO
go
print db_name()

declare @Codigo varchar(100) = 'ATP'

-- Verificar si existe la configuracion con Codigo ATP
if not exists (select 1
				from [dbo].[ConfiguracionPais] cp,  [dbo].[ConfiguracionOfertasHome] coh
				where cp.ConfiguracionPaisID = coh.ConfiguracionPaisID
				and cp.Codigo = @Codigo)
begin

	declare @DesdeCampania int = 201907
	declare @Orden int = 1
	declare @ConfiguracionPaisID int

	select
		@ConfiguracionPaisID = cp.ConfiguracionPaisID
	from [dbo].[ConfiguracionPais] cp
	where cp.Codigo = @Codigo

	print 'Empieza insert into [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	begin try

	begin transaction InsertCOHCodigoATP;

	insert into [dbo].[ConfiguracionOfertasHome](
		ConfiguracionPaisID, CampaniaID, UrlSeccion,
		DesktopOrden, MobileOrden, DesktopOrdenBpt, MobileOrdenBpt,
		DesktopUsarImagenFondo, MobileUsarImagenFondo,
		DesktopImagenFondo, MobileImagenFondo,
		DesktopTitulo, MobileTitulo, DesktopSubTitulo, MobileSubTitulo,
		DesktopTipoPresentacion, MobileTipoPresentacion, DesktopTipoEstrategia, MobileTipoEstrategia,
		DesktopCantidadProductos, MobileCantidadProductos,
		DesktopActivo, MobileActivo,
		DesktopColorFondo, MobileColorFondo,
		DesktopColorTexto, MobileColorTexto,
		BotonTexto1,BotonTexto2,
		BotonColor,	BotonColorTexto
	)
	values
	(
		@ConfiguracionPaisID, @DesdeCampania, '',
		@Orden, @Orden, @Orden, @Orden,
		0,0,
		'ContenedorHome_Banner_Atp.png','ContenedorHome_Banner_Atp.png',
		'ARMA TU PACK','ARMA TU PACK','Elige tus productos favoritos y llévatelos a #PrecioTotal','Elige tus productos favoritos y llévatelos a #PrecioTotal',
		10,10,'004','004',
		0,0,
		0,0,
		'#fa1702','#fa1702',
		'#ffffff','#ffffff',
		'Comenzar','Modificar',
		'#000000','#ffffff'
	)

	IF (@@TRANCOUNT > 0)  commit transaction InsertCOHCodigoATP;

	print 'Registro insertado correctamente en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'

	end try
	begin catch
	    SELECT
        ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;

		IF (@@TRANCOUNT > 0) rollback transaction InsertCOHCodigoATP;

		print 'Error al insertar registro en [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
	end catch
end
else
begin
	print 'El registro en Configuracion Ofertas Home con Codigo ATP YA EXISTE'
end

print 'Finaliza insert into  [dbo].[ConfiguracionOfertasHome]: Codigo ATP'
go




GO
