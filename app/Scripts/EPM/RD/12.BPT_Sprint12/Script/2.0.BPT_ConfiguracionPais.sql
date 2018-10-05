USE BelcorpPeru
GO

GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'GND')
begin
	declare @ordenCode varchar(10) = 'DES-NAV'
	insert into ConfiguracionPais (
		Codigo, Excluyente, Descripcion, Estado, 
		TienePerfil, DesdeCampania, 
		Orden, MobileOrden, OrdenBpt, MobileOrdenBPT,
		DesktopTituloMenu, MobileTituloMenu,
		DesktopTituloBanner, MobileTituloBanner,
		DesktopSubTituloBanner, MobileSubTituloBanner,
		DesktopFondoBanner, MobileFondoBanner,
		DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, Logo)	
	values (
		'GND', 0, 'Guía de Negocio Digitalizada', 1,
		1, 201717,
		(select top 1 Orden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 OrdenBpt from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode), 
		'EXPLORA|GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
		'#Nombre, disfruta de tu guía de negocio online', '#Nombre, disfruta de tu guía de negocio online',
		'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.', 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.',
		'', '',
		'', '',
		'', null)
		
	set @ordenCode = 'GND'
	
	update ConfiguracionPais set Orden = Orden + 1
	where Orden >= (select Orden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set MobileOrden = MobileOrden + 1
	where MobileOrden >= (select MobileOrden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set OrdenBpt = OrdenBpt + 1
	where OrdenBpt >= (select OrdenBpt from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode
	
	update ConfiguracionPais set MobileOrdenBPT = MobileOrdenBPT + 1
	where MobileOrdenBPT >= (select MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

end
GO

USE BelcorpMexico
GO

GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'GND')
begin
	declare @ordenCode varchar(10) = 'DES-NAV'
	insert into ConfiguracionPais (
		Codigo, Excluyente, Descripcion, Estado, 
		TienePerfil, DesdeCampania, 
		Orden, MobileOrden, OrdenBpt, MobileOrdenBPT,
		DesktopTituloMenu, MobileTituloMenu,
		DesktopTituloBanner, MobileTituloBanner,
		DesktopSubTituloBanner, MobileSubTituloBanner,
		DesktopFondoBanner, MobileFondoBanner,
		DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, Logo)	
	values (
		'GND', 0, 'Guía de Negocio Digitalizada', 0,
		1, 201717,
		(select top 1 Orden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 OrdenBpt from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode), 
		'EXPLORA|GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
		'#Nombre, disfruta de tu guía de negocio online', '#Nombre, disfruta de tu guía de negocio online',
		'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.', 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.',
		'', '',
		'', '',
		'', null)
		
	set @ordenCode = 'GND'
	
	update ConfiguracionPais set Orden = Orden + 1
	where Orden >= (select Orden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set MobileOrden = MobileOrden + 1
	where MobileOrden >= (select MobileOrden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set OrdenBpt = OrdenBpt + 1
	where OrdenBpt >= (select OrdenBpt from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode
	
	update ConfiguracionPais set MobileOrdenBPT = MobileOrdenBPT + 1
	where MobileOrdenBPT >= (select MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

end
GO

USE BelcorpColombia
GO

GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'GND')
begin
	declare @ordenCode varchar(10) = 'DES-NAV'
	insert into ConfiguracionPais (
		Codigo, Excluyente, Descripcion, Estado, 
		TienePerfil, DesdeCampania, 
		Orden, MobileOrden, OrdenBpt, MobileOrdenBPT,
		DesktopTituloMenu, MobileTituloMenu,
		DesktopTituloBanner, MobileTituloBanner,
		DesktopSubTituloBanner, MobileSubTituloBanner,
		DesktopFondoBanner, MobileFondoBanner,
		DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, Logo)	
	values (
		'GND', 0, 'Guía de Negocio Digitalizada', 0,
		1, 201717,
		(select top 1 Orden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 OrdenBpt from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode), 
		'EXPLORA|GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
		'#Nombre, disfruta de tu guía de negocio online', '#Nombre, disfruta de tu guía de negocio online',
		'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.', 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.',
		'', '',
		'', '',
		'', null)
		
	set @ordenCode = 'GND'
	
	update ConfiguracionPais set Orden = Orden + 1
	where Orden >= (select Orden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set MobileOrden = MobileOrden + 1
	where MobileOrden >= (select MobileOrden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set OrdenBpt = OrdenBpt + 1
	where OrdenBpt >= (select OrdenBpt from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode
	
	update ConfiguracionPais set MobileOrdenBPT = MobileOrdenBPT + 1
	where MobileOrdenBPT >= (select MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

end
GO

USE BelcorpVenezuela
GO

GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'GND')
begin
	declare @ordenCode varchar(10) = 'DES-NAV'
	insert into ConfiguracionPais (
		Codigo, Excluyente, Descripcion, Estado, 
		TienePerfil, DesdeCampania, 
		Orden, MobileOrden, OrdenBpt, MobileOrdenBPT,
		DesktopTituloMenu, MobileTituloMenu,
		DesktopTituloBanner, MobileTituloBanner,
		DesktopSubTituloBanner, MobileSubTituloBanner,
		DesktopFondoBanner, MobileFondoBanner,
		DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, Logo)	
	values (
		'GND', 0, 'Guía de Negocio Digitalizada', 0,
		1, 201717,
		(select top 1 Orden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 OrdenBpt from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode), 
		'EXPLORA|GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
		'#Nombre, disfruta de tu guía de negocio online', '#Nombre, disfruta de tu guía de negocio online',
		'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.', 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.',
		'', '',
		'', '',
		'', null)
		
	set @ordenCode = 'GND'
	
	update ConfiguracionPais set Orden = Orden + 1
	where Orden >= (select Orden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set MobileOrden = MobileOrden + 1
	where MobileOrden >= (select MobileOrden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set OrdenBpt = OrdenBpt + 1
	where OrdenBpt >= (select OrdenBpt from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode
	
	update ConfiguracionPais set MobileOrdenBPT = MobileOrdenBPT + 1
	where MobileOrdenBPT >= (select MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

end
GO

USE BelcorpSalvador
GO

GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'GND')
begin
	declare @ordenCode varchar(10) = 'DES-NAV'
	insert into ConfiguracionPais (
		Codigo, Excluyente, Descripcion, Estado, 
		TienePerfil, DesdeCampania, 
		Orden, MobileOrden, OrdenBpt, MobileOrdenBPT,
		DesktopTituloMenu, MobileTituloMenu,
		DesktopTituloBanner, MobileTituloBanner,
		DesktopSubTituloBanner, MobileSubTituloBanner,
		DesktopFondoBanner, MobileFondoBanner,
		DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, Logo)	
	values (
		'GND', 0, 'Guía de Negocio Digitalizada', 0,
		1, 201717,
		(select top 1 Orden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 OrdenBpt from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode), 
		'EXPLORA|GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
		'#Nombre, disfruta de tu guía de negocio online', '#Nombre, disfruta de tu guía de negocio online',
		'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.', 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.',
		'', '',
		'', '',
		'', null)
		
	set @ordenCode = 'GND'
	
	update ConfiguracionPais set Orden = Orden + 1
	where Orden >= (select Orden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set MobileOrden = MobileOrden + 1
	where MobileOrden >= (select MobileOrden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set OrdenBpt = OrdenBpt + 1
	where OrdenBpt >= (select OrdenBpt from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode
	
	update ConfiguracionPais set MobileOrdenBPT = MobileOrdenBPT + 1
	where MobileOrdenBPT >= (select MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

end
GO

USE BelcorpPuertoRico
GO

GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'GND')
begin
	declare @ordenCode varchar(10) = 'DES-NAV'
	insert into ConfiguracionPais (
		Codigo, Excluyente, Descripcion, Estado, 
		TienePerfil, DesdeCampania, 
		Orden, MobileOrden, OrdenBpt, MobileOrdenBPT,
		DesktopTituloMenu, MobileTituloMenu,
		DesktopTituloBanner, MobileTituloBanner,
		DesktopSubTituloBanner, MobileSubTituloBanner,
		DesktopFondoBanner, MobileFondoBanner,
		DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, Logo)	
	values (
		'GND', 0, 'Guía de Negocio Digitalizada', 0,
		1, 201717,
		(select top 1 Orden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 OrdenBpt from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode), 
		'EXPLORA|GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
		'#Nombre, disfruta de tu guía de negocio online', '#Nombre, disfruta de tu guía de negocio online',
		'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.', 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.',
		'', '',
		'', '',
		'', null)
		
	set @ordenCode = 'GND'
	
	update ConfiguracionPais set Orden = Orden + 1
	where Orden >= (select Orden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set MobileOrden = MobileOrden + 1
	where MobileOrden >= (select MobileOrden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set OrdenBpt = OrdenBpt + 1
	where OrdenBpt >= (select OrdenBpt from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode
	
	update ConfiguracionPais set MobileOrdenBPT = MobileOrdenBPT + 1
	where MobileOrdenBPT >= (select MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

end
GO

USE BelcorpPanama
GO

GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'GND')
begin
	declare @ordenCode varchar(10) = 'DES-NAV'
	insert into ConfiguracionPais (
		Codigo, Excluyente, Descripcion, Estado, 
		TienePerfil, DesdeCampania, 
		Orden, MobileOrden, OrdenBpt, MobileOrdenBPT,
		DesktopTituloMenu, MobileTituloMenu,
		DesktopTituloBanner, MobileTituloBanner,
		DesktopSubTituloBanner, MobileSubTituloBanner,
		DesktopFondoBanner, MobileFondoBanner,
		DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, Logo)	
	values (
		'GND', 0, 'Guía de Negocio Digitalizada', 0,
		1, 201717,
		(select top 1 Orden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 OrdenBpt from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode), 
		'EXPLORA|GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
		'#Nombre, disfruta de tu guía de negocio online', '#Nombre, disfruta de tu guía de negocio online',
		'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.', 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.',
		'', '',
		'', '',
		'', null)
		
	set @ordenCode = 'GND'
	
	update ConfiguracionPais set Orden = Orden + 1
	where Orden >= (select Orden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set MobileOrden = MobileOrden + 1
	where MobileOrden >= (select MobileOrden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set OrdenBpt = OrdenBpt + 1
	where OrdenBpt >= (select OrdenBpt from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode
	
	update ConfiguracionPais set MobileOrdenBPT = MobileOrdenBPT + 1
	where MobileOrdenBPT >= (select MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

end
GO

USE BelcorpGuatemala
GO

GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'GND')
begin
	declare @ordenCode varchar(10) = 'DES-NAV'
	insert into ConfiguracionPais (
		Codigo, Excluyente, Descripcion, Estado, 
		TienePerfil, DesdeCampania, 
		Orden, MobileOrden, OrdenBpt, MobileOrdenBPT,
		DesktopTituloMenu, MobileTituloMenu,
		DesktopTituloBanner, MobileTituloBanner,
		DesktopSubTituloBanner, MobileSubTituloBanner,
		DesktopFondoBanner, MobileFondoBanner,
		DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, Logo)	
	values (
		'GND', 0, 'Guía de Negocio Digitalizada', 0,
		1, 201717,
		(select top 1 Orden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 OrdenBpt from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode), 
		'EXPLORA|GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
		'#Nombre, disfruta de tu guía de negocio online', '#Nombre, disfruta de tu guía de negocio online',
		'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.', 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.',
		'', '',
		'', '',
		'', null)
		
	set @ordenCode = 'GND'
	
	update ConfiguracionPais set Orden = Orden + 1
	where Orden >= (select Orden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set MobileOrden = MobileOrden + 1
	where MobileOrden >= (select MobileOrden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set OrdenBpt = OrdenBpt + 1
	where OrdenBpt >= (select OrdenBpt from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode
	
	update ConfiguracionPais set MobileOrdenBPT = MobileOrdenBPT + 1
	where MobileOrdenBPT >= (select MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

end
GO

USE BelcorpEcuador
GO

GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'GND')
begin
	declare @ordenCode varchar(10) = 'DES-NAV'
	insert into ConfiguracionPais (
		Codigo, Excluyente, Descripcion, Estado, 
		TienePerfil, DesdeCampania, 
		Orden, MobileOrden, OrdenBpt, MobileOrdenBPT,
		DesktopTituloMenu, MobileTituloMenu,
		DesktopTituloBanner, MobileTituloBanner,
		DesktopSubTituloBanner, MobileSubTituloBanner,
		DesktopFondoBanner, MobileFondoBanner,
		DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, Logo)	
	values (
		'GND', 0, 'Guía de Negocio Digitalizada', 0,
		1, 201717,
		(select top 1 Orden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 OrdenBpt from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode), 
		'EXPLORA|GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
		'#Nombre, disfruta de tu guía de negocio online', '#Nombre, disfruta de tu guía de negocio online',
		'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.', 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.',
		'', '',
		'', '',
		'', null)
		
	set @ordenCode = 'GND'
	
	update ConfiguracionPais set Orden = Orden + 1
	where Orden >= (select Orden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set MobileOrden = MobileOrden + 1
	where MobileOrden >= (select MobileOrden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set OrdenBpt = OrdenBpt + 1
	where OrdenBpt >= (select OrdenBpt from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode
	
	update ConfiguracionPais set MobileOrdenBPT = MobileOrdenBPT + 1
	where MobileOrdenBPT >= (select MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

end
GO

USE BelcorpDominicana
GO

GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'GND')
begin
	declare @ordenCode varchar(10) = 'DES-NAV'
	insert into ConfiguracionPais (
		Codigo, Excluyente, Descripcion, Estado, 
		TienePerfil, DesdeCampania, 
		Orden, MobileOrden, OrdenBpt, MobileOrdenBPT,
		DesktopTituloMenu, MobileTituloMenu,
		DesktopTituloBanner, MobileTituloBanner,
		DesktopSubTituloBanner, MobileSubTituloBanner,
		DesktopFondoBanner, MobileFondoBanner,
		DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, Logo)	
	values (
		'GND', 0, 'Guía de Negocio Digitalizada', 0,
		1, 201717,
		(select top 1 Orden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 OrdenBpt from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode), 
		'EXPLORA|GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
		'#Nombre, disfruta de tu guía de negocio online', '#Nombre, disfruta de tu guía de negocio online',
		'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.', 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.',
		'', '',
		'', '',
		'', null)
		
	set @ordenCode = 'GND'
	
	update ConfiguracionPais set Orden = Orden + 1
	where Orden >= (select Orden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set MobileOrden = MobileOrden + 1
	where MobileOrden >= (select MobileOrden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set OrdenBpt = OrdenBpt + 1
	where OrdenBpt >= (select OrdenBpt from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode
	
	update ConfiguracionPais set MobileOrdenBPT = MobileOrdenBPT + 1
	where MobileOrdenBPT >= (select MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

end
GO

USE BelcorpCostaRica
GO

GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'GND')
begin
	declare @ordenCode varchar(10) = 'DES-NAV'
	insert into ConfiguracionPais (
		Codigo, Excluyente, Descripcion, Estado, 
		TienePerfil, DesdeCampania, 
		Orden, MobileOrden, OrdenBpt, MobileOrdenBPT,
		DesktopTituloMenu, MobileTituloMenu,
		DesktopTituloBanner, MobileTituloBanner,
		DesktopSubTituloBanner, MobileSubTituloBanner,
		DesktopFondoBanner, MobileFondoBanner,
		DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, Logo)	
	values (
		'GND', 0, 'Guía de Negocio Digitalizada', 0,
		1, 201717,
		(select top 1 Orden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 OrdenBpt from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode), 
		'EXPLORA|GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
		'#Nombre, disfruta de tu guía de negocio online', '#Nombre, disfruta de tu guía de negocio online',
		'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.', 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.',
		'', '',
		'', '',
		'', null)
		
	set @ordenCode = 'GND'
	
	update ConfiguracionPais set Orden = Orden + 1
	where Orden >= (select Orden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set MobileOrden = MobileOrden + 1
	where MobileOrden >= (select MobileOrden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set OrdenBpt = OrdenBpt + 1
	where OrdenBpt >= (select OrdenBpt from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode
	
	update ConfiguracionPais set MobileOrdenBPT = MobileOrdenBPT + 1
	where MobileOrdenBPT >= (select MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

end
GO

USE BelcorpChile
GO

GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'GND')
begin
	declare @ordenCode varchar(10) = 'DES-NAV'
	insert into ConfiguracionPais (
		Codigo, Excluyente, Descripcion, Estado, 
		TienePerfil, DesdeCampania, 
		Orden, MobileOrden, OrdenBpt, MobileOrdenBPT,
		DesktopTituloMenu, MobileTituloMenu,
		DesktopTituloBanner, MobileTituloBanner,
		DesktopSubTituloBanner, MobileSubTituloBanner,
		DesktopFondoBanner, MobileFondoBanner,
		DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, Logo)	
	values (
		'GND', 0, 'Guía de Negocio Digitalizada', 0,
		1, 201717,
		(select top 1 Orden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 OrdenBpt from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode), 
		'EXPLORA|GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
		'#Nombre, disfruta de tu guía de negocio online', '#Nombre, disfruta de tu guía de negocio online',
		'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.', 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.',
		'', '',
		'', '',
		'', null)
		
	set @ordenCode = 'GND'
	
	update ConfiguracionPais set Orden = Orden + 1
	where Orden >= (select Orden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set MobileOrden = MobileOrden + 1
	where MobileOrden >= (select MobileOrden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set OrdenBpt = OrdenBpt + 1
	where OrdenBpt >= (select OrdenBpt from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode
	
	update ConfiguracionPais set MobileOrdenBPT = MobileOrdenBPT + 1
	where MobileOrdenBPT >= (select MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

end
GO

USE BelcorpBolivia
GO

GO

if not exists (select 1 from ConfiguracionPais where Codigo = 'GND')
begin
	declare @ordenCode varchar(10) = 'DES-NAV'
	insert into ConfiguracionPais (
		Codigo, Excluyente, Descripcion, Estado, 
		TienePerfil, DesdeCampania, 
		Orden, MobileOrden, OrdenBpt, MobileOrdenBPT,
		DesktopTituloMenu, MobileTituloMenu,
		DesktopTituloBanner, MobileTituloBanner,
		DesktopSubTituloBanner, MobileSubTituloBanner,
		DesktopFondoBanner, MobileFondoBanner,
		DesktopLogoBanner, MobileLogoBanner,
		UrlMenu, Logo)	
	values (
		'GND', 0, 'Guía de Negocio Digitalizada', 0,
		1, 201717,
		(select top 1 Orden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrden from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 OrdenBpt from ConfiguracionPais where Codigo = @ordenCode), 
		(select top 1 MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode), 
		'EXPLORA|GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
		'#Nombre, disfruta de tu guía de negocio online', '#Nombre, disfruta de tu guía de negocio online',
		'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.', 'Encuentra aquí todas las ofertas de tu revista física y no te pierdas ninguna oferta.',
		'', '',
		'', '',
		'', null)
		
	set @ordenCode = 'GND'
	
	update ConfiguracionPais set Orden = Orden + 1
	where Orden >= (select Orden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set MobileOrden = MobileOrden + 1
	where MobileOrden >= (select MobileOrden from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

	update ConfiguracionPais set OrdenBpt = OrdenBpt + 1
	where OrdenBpt >= (select OrdenBpt from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode
	
	update ConfiguracionPais set MobileOrdenBPT = MobileOrdenBPT + 1
	where MobileOrdenBPT >= (select MobileOrdenBPT from ConfiguracionPais where Codigo = @ordenCode) and Codigo <> @ordenCode

end
GO

