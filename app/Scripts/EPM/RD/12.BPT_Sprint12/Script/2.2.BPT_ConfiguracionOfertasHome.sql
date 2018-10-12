USE BelcorpPeru
GO

GO

declare @idConfiPaisDetalle int = 0

select @idConfiPaisDetalle = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'GND'

delete from ConfiguracionOfertasHome
where ConfiguracionPaisID = @idConfiPaisDetalle

declare @ordenCode int = 0
select @ordenCode = h.ConfiguracionOfertasHomeID 
from ConfiguracionOfertasHome h
inner join ConfiguracionPais p on p.ConfiguracionPaisID = h.ConfiguracionPaisID
where p.Codigo = 'DES-NAV'

insert into ConfiguracionOfertasHome 
(
	ConfiguracionPaisID, CampaniaID,
	DesktopOrden, MobileOrden,
	DesktopOrdenBpt, MobileOrdenBpt,
	DesktopImagenFondo, MobileImagenFondo,
	DesktopTitulo, MobileTitulo,
	DesktopSubTitulo, MobileSubTitulo,
	DesktopTipoPresentacion, MobileTipoPresentacion,
	DesktopTipoEstrategia, MobileTipoEstrategia,
	DesktopCantidadProductos, MobileCantidadProductos,
	DesktopActivo, MobileActivo,
	UrlSeccion
)
values (
	@idConfiPaisDetalle, 201717,
	(select top 1 DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode),
	'GuiaDeNegocio_Desktop.jpg', 'GuiaDeNegocio_Mobile.jpg',
	'GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
	null, null,
	4, 4,
	null, null,
	0, 0,
	1, 1,
	''
)

update ConfiguracionOfertasHome set DesktopOrden = DesktopOrden + 1
where DesktopOrden >= (select DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrden = MobileOrden + 1
where MobileOrden >= (select MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set DesktopOrdenBpt = DesktopOrdenBpt + 1
where DesktopOrdenBpt >= (select DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrdenBpt = MobileOrdenBpt + 1
where MobileOrdenBpt >= (select MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

GO

USE BelcorpMexico
GO

GO

declare @idConfiPaisDetalle int = 0

select @idConfiPaisDetalle = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'GND'

delete from ConfiguracionOfertasHome
where ConfiguracionPaisID = @idConfiPaisDetalle

declare @ordenCode int = 0
select @ordenCode = h.ConfiguracionOfertasHomeID 
from ConfiguracionOfertasHome h
inner join ConfiguracionPais p on p.ConfiguracionPaisID = h.ConfiguracionPaisID
where p.Codigo = 'DES-NAV'

insert into ConfiguracionOfertasHome 
(
	ConfiguracionPaisID, CampaniaID,
	DesktopOrden, MobileOrden,
	DesktopOrdenBpt, MobileOrdenBpt,
	DesktopImagenFondo, MobileImagenFondo,
	DesktopTitulo, MobileTitulo,
	DesktopSubTitulo, MobileSubTitulo,
	DesktopTipoPresentacion, MobileTipoPresentacion,
	DesktopTipoEstrategia, MobileTipoEstrategia,
	DesktopCantidadProductos, MobileCantidadProductos,
	DesktopActivo, MobileActivo,
	UrlSeccion
)
values (
	@idConfiPaisDetalle, 201717,
	(select top 1 DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode),
	'GuiaDeNegocio_Desktop.jpg', 'GuiaDeNegocio_Mobile.jpg',
	'GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
	null, null,
	4, 4,
	null, null,
	0, 0,
	0, 0,
	''
)

update ConfiguracionOfertasHome set DesktopOrden = DesktopOrden + 1
where DesktopOrden >= (select DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrden = MobileOrden + 1
where MobileOrden >= (select MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set DesktopOrdenBpt = DesktopOrdenBpt + 1
where DesktopOrdenBpt >= (select DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrdenBpt = MobileOrdenBpt + 1
where MobileOrdenBpt >= (select MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

GO

USE BelcorpColombia
GO

GO

declare @idConfiPaisDetalle int = 0

select @idConfiPaisDetalle = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'GND'

delete from ConfiguracionOfertasHome
where ConfiguracionPaisID = @idConfiPaisDetalle

declare @ordenCode int = 0
select @ordenCode = h.ConfiguracionOfertasHomeID 
from ConfiguracionOfertasHome h
inner join ConfiguracionPais p on p.ConfiguracionPaisID = h.ConfiguracionPaisID
where p.Codigo = 'DES-NAV'

insert into ConfiguracionOfertasHome 
(
	ConfiguracionPaisID, CampaniaID,
	DesktopOrden, MobileOrden,
	DesktopOrdenBpt, MobileOrdenBpt,
	DesktopImagenFondo, MobileImagenFondo,
	DesktopTitulo, MobileTitulo,
	DesktopSubTitulo, MobileSubTitulo,
	DesktopTipoPresentacion, MobileTipoPresentacion,
	DesktopTipoEstrategia, MobileTipoEstrategia,
	DesktopCantidadProductos, MobileCantidadProductos,
	DesktopActivo, MobileActivo,
	UrlSeccion
)
values (
	@idConfiPaisDetalle, 201717,
	(select top 1 DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode),
	'GuiaDeNegocio_Desktop.jpg', 'GuiaDeNegocio_Mobile.jpg',
	'GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
	null, null,
	4, 4,
	null, null,
	0, 0,
	0, 0,
	''
)

update ConfiguracionOfertasHome set DesktopOrden = DesktopOrden + 1
where DesktopOrden >= (select DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrden = MobileOrden + 1
where MobileOrden >= (select MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set DesktopOrdenBpt = DesktopOrdenBpt + 1
where DesktopOrdenBpt >= (select DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrdenBpt = MobileOrdenBpt + 1
where MobileOrdenBpt >= (select MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

GO

USE BelcorpVenezuela
GO

GO

declare @idConfiPaisDetalle int = 0

select @idConfiPaisDetalle = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'GND'

delete from ConfiguracionOfertasHome
where ConfiguracionPaisID = @idConfiPaisDetalle

declare @ordenCode int = 0
select @ordenCode = h.ConfiguracionOfertasHomeID 
from ConfiguracionOfertasHome h
inner join ConfiguracionPais p on p.ConfiguracionPaisID = h.ConfiguracionPaisID
where p.Codigo = 'DES-NAV'

insert into ConfiguracionOfertasHome 
(
	ConfiguracionPaisID, CampaniaID,
	DesktopOrden, MobileOrden,
	DesktopOrdenBpt, MobileOrdenBpt,
	DesktopImagenFondo, MobileImagenFondo,
	DesktopTitulo, MobileTitulo,
	DesktopSubTitulo, MobileSubTitulo,
	DesktopTipoPresentacion, MobileTipoPresentacion,
	DesktopTipoEstrategia, MobileTipoEstrategia,
	DesktopCantidadProductos, MobileCantidadProductos,
	DesktopActivo, MobileActivo,
	UrlSeccion
)
values (
	@idConfiPaisDetalle, 201717,
	(select top 1 DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode),
	'GuiaDeNegocio_Desktop.jpg', 'GuiaDeNegocio_Mobile.jpg',
	'GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
	null, null,
	4, 4,
	null, null,
	0, 0,
	0, 0,
	''
)

update ConfiguracionOfertasHome set DesktopOrden = DesktopOrden + 1
where DesktopOrden >= (select DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrden = MobileOrden + 1
where MobileOrden >= (select MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set DesktopOrdenBpt = DesktopOrdenBpt + 1
where DesktopOrdenBpt >= (select DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrdenBpt = MobileOrdenBpt + 1
where MobileOrdenBpt >= (select MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

GO

USE BelcorpSalvador
GO

GO

declare @idConfiPaisDetalle int = 0

select @idConfiPaisDetalle = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'GND'

delete from ConfiguracionOfertasHome
where ConfiguracionPaisID = @idConfiPaisDetalle

declare @ordenCode int = 0
select @ordenCode = h.ConfiguracionOfertasHomeID 
from ConfiguracionOfertasHome h
inner join ConfiguracionPais p on p.ConfiguracionPaisID = h.ConfiguracionPaisID
where p.Codigo = 'DES-NAV'

insert into ConfiguracionOfertasHome 
(
	ConfiguracionPaisID, CampaniaID,
	DesktopOrden, MobileOrden,
	DesktopOrdenBpt, MobileOrdenBpt,
	DesktopImagenFondo, MobileImagenFondo,
	DesktopTitulo, MobileTitulo,
	DesktopSubTitulo, MobileSubTitulo,
	DesktopTipoPresentacion, MobileTipoPresentacion,
	DesktopTipoEstrategia, MobileTipoEstrategia,
	DesktopCantidadProductos, MobileCantidadProductos,
	DesktopActivo, MobileActivo,
	UrlSeccion
)
values (
	@idConfiPaisDetalle, 201717,
	(select top 1 DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode),
	'GuiaDeNegocio_Desktop.jpg', 'GuiaDeNegocio_Mobile.jpg',
	'GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
	null, null,
	4, 4,
	null, null,
	0, 0,
	0, 0,
	''
)

update ConfiguracionOfertasHome set DesktopOrden = DesktopOrden + 1
where DesktopOrden >= (select DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrden = MobileOrden + 1
where MobileOrden >= (select MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set DesktopOrdenBpt = DesktopOrdenBpt + 1
where DesktopOrdenBpt >= (select DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrdenBpt = MobileOrdenBpt + 1
where MobileOrdenBpt >= (select MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

GO

USE BelcorpPuertoRico
GO

GO

declare @idConfiPaisDetalle int = 0

select @idConfiPaisDetalle = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'GND'

delete from ConfiguracionOfertasHome
where ConfiguracionPaisID = @idConfiPaisDetalle

declare @ordenCode int = 0
select @ordenCode = h.ConfiguracionOfertasHomeID 
from ConfiguracionOfertasHome h
inner join ConfiguracionPais p on p.ConfiguracionPaisID = h.ConfiguracionPaisID
where p.Codigo = 'DES-NAV'

insert into ConfiguracionOfertasHome 
(
	ConfiguracionPaisID, CampaniaID,
	DesktopOrden, MobileOrden,
	DesktopOrdenBpt, MobileOrdenBpt,
	DesktopImagenFondo, MobileImagenFondo,
	DesktopTitulo, MobileTitulo,
	DesktopSubTitulo, MobileSubTitulo,
	DesktopTipoPresentacion, MobileTipoPresentacion,
	DesktopTipoEstrategia, MobileTipoEstrategia,
	DesktopCantidadProductos, MobileCantidadProductos,
	DesktopActivo, MobileActivo,
	UrlSeccion
)
values (
	@idConfiPaisDetalle, 201717,
	(select top 1 DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode),
	'GuiaDeNegocio_Desktop.jpg', 'GuiaDeNegocio_Mobile.jpg',
	'GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
	null, null,
	4, 4,
	null, null,
	0, 0,
	0, 0,
	''
)

update ConfiguracionOfertasHome set DesktopOrden = DesktopOrden + 1
where DesktopOrden >= (select DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrden = MobileOrden + 1
where MobileOrden >= (select MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set DesktopOrdenBpt = DesktopOrdenBpt + 1
where DesktopOrdenBpt >= (select DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrdenBpt = MobileOrdenBpt + 1
where MobileOrdenBpt >= (select MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

GO

USE BelcorpPanama
GO

GO

declare @idConfiPaisDetalle int = 0

select @idConfiPaisDetalle = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'GND'

delete from ConfiguracionOfertasHome
where ConfiguracionPaisID = @idConfiPaisDetalle

declare @ordenCode int = 0
select @ordenCode = h.ConfiguracionOfertasHomeID 
from ConfiguracionOfertasHome h
inner join ConfiguracionPais p on p.ConfiguracionPaisID = h.ConfiguracionPaisID
where p.Codigo = 'DES-NAV'

insert into ConfiguracionOfertasHome 
(
	ConfiguracionPaisID, CampaniaID,
	DesktopOrden, MobileOrden,
	DesktopOrdenBpt, MobileOrdenBpt,
	DesktopImagenFondo, MobileImagenFondo,
	DesktopTitulo, MobileTitulo,
	DesktopSubTitulo, MobileSubTitulo,
	DesktopTipoPresentacion, MobileTipoPresentacion,
	DesktopTipoEstrategia, MobileTipoEstrategia,
	DesktopCantidadProductos, MobileCantidadProductos,
	DesktopActivo, MobileActivo,
	UrlSeccion
)
values (
	@idConfiPaisDetalle, 201717,
	(select top 1 DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode),
	'GuiaDeNegocio_Desktop.jpg', 'GuiaDeNegocio_Mobile.jpg',
	'GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
	null, null,
	4, 4,
	null, null,
	0, 0,
	0, 0,
	''
)

update ConfiguracionOfertasHome set DesktopOrden = DesktopOrden + 1
where DesktopOrden >= (select DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrden = MobileOrden + 1
where MobileOrden >= (select MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set DesktopOrdenBpt = DesktopOrdenBpt + 1
where DesktopOrdenBpt >= (select DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrdenBpt = MobileOrdenBpt + 1
where MobileOrdenBpt >= (select MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

GO

USE BelcorpGuatemala
GO

GO

declare @idConfiPaisDetalle int = 0

select @idConfiPaisDetalle = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'GND'

delete from ConfiguracionOfertasHome
where ConfiguracionPaisID = @idConfiPaisDetalle

declare @ordenCode int = 0
select @ordenCode = h.ConfiguracionOfertasHomeID 
from ConfiguracionOfertasHome h
inner join ConfiguracionPais p on p.ConfiguracionPaisID = h.ConfiguracionPaisID
where p.Codigo = 'DES-NAV'

insert into ConfiguracionOfertasHome 
(
	ConfiguracionPaisID, CampaniaID,
	DesktopOrden, MobileOrden,
	DesktopOrdenBpt, MobileOrdenBpt,
	DesktopImagenFondo, MobileImagenFondo,
	DesktopTitulo, MobileTitulo,
	DesktopSubTitulo, MobileSubTitulo,
	DesktopTipoPresentacion, MobileTipoPresentacion,
	DesktopTipoEstrategia, MobileTipoEstrategia,
	DesktopCantidadProductos, MobileCantidadProductos,
	DesktopActivo, MobileActivo,
	UrlSeccion
)
values (
	@idConfiPaisDetalle, 201717,
	(select top 1 DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode),
	'GuiaDeNegocio_Desktop.jpg', 'GuiaDeNegocio_Mobile.jpg',
	'GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
	null, null,
	4, 4,
	null, null,
	0, 0,
	0, 0,
	''
)

update ConfiguracionOfertasHome set DesktopOrden = DesktopOrden + 1
where DesktopOrden >= (select DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrden = MobileOrden + 1
where MobileOrden >= (select MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set DesktopOrdenBpt = DesktopOrdenBpt + 1
where DesktopOrdenBpt >= (select DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrdenBpt = MobileOrdenBpt + 1
where MobileOrdenBpt >= (select MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

GO

USE BelcorpEcuador
GO

GO

declare @idConfiPaisDetalle int = 0

select @idConfiPaisDetalle = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'GND'

delete from ConfiguracionOfertasHome
where ConfiguracionPaisID = @idConfiPaisDetalle

declare @ordenCode int = 0
select @ordenCode = h.ConfiguracionOfertasHomeID 
from ConfiguracionOfertasHome h
inner join ConfiguracionPais p on p.ConfiguracionPaisID = h.ConfiguracionPaisID
where p.Codigo = 'DES-NAV'

insert into ConfiguracionOfertasHome 
(
	ConfiguracionPaisID, CampaniaID,
	DesktopOrden, MobileOrden,
	DesktopOrdenBpt, MobileOrdenBpt,
	DesktopImagenFondo, MobileImagenFondo,
	DesktopTitulo, MobileTitulo,
	DesktopSubTitulo, MobileSubTitulo,
	DesktopTipoPresentacion, MobileTipoPresentacion,
	DesktopTipoEstrategia, MobileTipoEstrategia,
	DesktopCantidadProductos, MobileCantidadProductos,
	DesktopActivo, MobileActivo,
	UrlSeccion
)
values (
	@idConfiPaisDetalle, 201717,
	(select top 1 DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode),
	'GuiaDeNegocio_Desktop.jpg', 'GuiaDeNegocio_Mobile.jpg',
	'GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
	null, null,
	4, 4,
	null, null,
	0, 0,
	0, 0,
	''
)

update ConfiguracionOfertasHome set DesktopOrden = DesktopOrden + 1
where DesktopOrden >= (select DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrden = MobileOrden + 1
where MobileOrden >= (select MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set DesktopOrdenBpt = DesktopOrdenBpt + 1
where DesktopOrdenBpt >= (select DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrdenBpt = MobileOrdenBpt + 1
where MobileOrdenBpt >= (select MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

GO

USE BelcorpDominicana
GO

GO

declare @idConfiPaisDetalle int = 0

select @idConfiPaisDetalle = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'GND'

delete from ConfiguracionOfertasHome
where ConfiguracionPaisID = @idConfiPaisDetalle

declare @ordenCode int = 0
select @ordenCode = h.ConfiguracionOfertasHomeID 
from ConfiguracionOfertasHome h
inner join ConfiguracionPais p on p.ConfiguracionPaisID = h.ConfiguracionPaisID
where p.Codigo = 'DES-NAV'

insert into ConfiguracionOfertasHome 
(
	ConfiguracionPaisID, CampaniaID,
	DesktopOrden, MobileOrden,
	DesktopOrdenBpt, MobileOrdenBpt,
	DesktopImagenFondo, MobileImagenFondo,
	DesktopTitulo, MobileTitulo,
	DesktopSubTitulo, MobileSubTitulo,
	DesktopTipoPresentacion, MobileTipoPresentacion,
	DesktopTipoEstrategia, MobileTipoEstrategia,
	DesktopCantidadProductos, MobileCantidadProductos,
	DesktopActivo, MobileActivo,
	UrlSeccion
)
values (
	@idConfiPaisDetalle, 201717,
	(select top 1 DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode),
	'GuiaDeNegocio_Desktop.jpg', 'GuiaDeNegocio_Mobile.jpg',
	'GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
	null, null,
	4, 4,
	null, null,
	0, 0,
	0, 0,
	''
)

update ConfiguracionOfertasHome set DesktopOrden = DesktopOrden + 1
where DesktopOrden >= (select DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrden = MobileOrden + 1
where MobileOrden >= (select MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set DesktopOrdenBpt = DesktopOrdenBpt + 1
where DesktopOrdenBpt >= (select DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrdenBpt = MobileOrdenBpt + 1
where MobileOrdenBpt >= (select MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

GO

USE BelcorpCostaRica
GO

GO

declare @idConfiPaisDetalle int = 0

select @idConfiPaisDetalle = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'GND'

delete from ConfiguracionOfertasHome
where ConfiguracionPaisID = @idConfiPaisDetalle

declare @ordenCode int = 0
select @ordenCode = h.ConfiguracionOfertasHomeID 
from ConfiguracionOfertasHome h
inner join ConfiguracionPais p on p.ConfiguracionPaisID = h.ConfiguracionPaisID
where p.Codigo = 'DES-NAV'

insert into ConfiguracionOfertasHome 
(
	ConfiguracionPaisID, CampaniaID,
	DesktopOrden, MobileOrden,
	DesktopOrdenBpt, MobileOrdenBpt,
	DesktopImagenFondo, MobileImagenFondo,
	DesktopTitulo, MobileTitulo,
	DesktopSubTitulo, MobileSubTitulo,
	DesktopTipoPresentacion, MobileTipoPresentacion,
	DesktopTipoEstrategia, MobileTipoEstrategia,
	DesktopCantidadProductos, MobileCantidadProductos,
	DesktopActivo, MobileActivo,
	UrlSeccion
)
values (
	@idConfiPaisDetalle, 201717,
	(select top 1 DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode),
	'GuiaDeNegocio_Desktop.jpg', 'GuiaDeNegocio_Mobile.jpg',
	'GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
	null, null,
	4, 4,
	null, null,
	0, 0,
	0, 0,
	''
)

update ConfiguracionOfertasHome set DesktopOrden = DesktopOrden + 1
where DesktopOrden >= (select DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrden = MobileOrden + 1
where MobileOrden >= (select MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set DesktopOrdenBpt = DesktopOrdenBpt + 1
where DesktopOrdenBpt >= (select DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrdenBpt = MobileOrdenBpt + 1
where MobileOrdenBpt >= (select MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

GO

USE BelcorpChile
GO

GO

declare @idConfiPaisDetalle int = 0

select @idConfiPaisDetalle = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'GND'

delete from ConfiguracionOfertasHome
where ConfiguracionPaisID = @idConfiPaisDetalle

declare @ordenCode int = 0
select @ordenCode = h.ConfiguracionOfertasHomeID 
from ConfiguracionOfertasHome h
inner join ConfiguracionPais p on p.ConfiguracionPaisID = h.ConfiguracionPaisID
where p.Codigo = 'DES-NAV'

insert into ConfiguracionOfertasHome 
(
	ConfiguracionPaisID, CampaniaID,
	DesktopOrden, MobileOrden,
	DesktopOrdenBpt, MobileOrdenBpt,
	DesktopImagenFondo, MobileImagenFondo,
	DesktopTitulo, MobileTitulo,
	DesktopSubTitulo, MobileSubTitulo,
	DesktopTipoPresentacion, MobileTipoPresentacion,
	DesktopTipoEstrategia, MobileTipoEstrategia,
	DesktopCantidadProductos, MobileCantidadProductos,
	DesktopActivo, MobileActivo,
	UrlSeccion
)
values (
	@idConfiPaisDetalle, 201717,
	(select top 1 DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode),
	'GuiaDeNegocio_Desktop.jpg', 'GuiaDeNegocio_Mobile.jpg',
	'GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
	null, null,
	4, 4,
	null, null,
	0, 0,
	0, 0,
	''
)

update ConfiguracionOfertasHome set DesktopOrden = DesktopOrden + 1
where DesktopOrden >= (select DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrden = MobileOrden + 1
where MobileOrden >= (select MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set DesktopOrdenBpt = DesktopOrdenBpt + 1
where DesktopOrdenBpt >= (select DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrdenBpt = MobileOrdenBpt + 1
where MobileOrdenBpt >= (select MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

GO

USE BelcorpBolivia
GO

GO

declare @idConfiPaisDetalle int = 0

select @idConfiPaisDetalle = ConfiguracionPaisID from ConfiguracionPais where Codigo = 'GND'

delete from ConfiguracionOfertasHome
where ConfiguracionPaisID = @idConfiPaisDetalle

declare @ordenCode int = 0
select @ordenCode = h.ConfiguracionOfertasHomeID 
from ConfiguracionOfertasHome h
inner join ConfiguracionPais p on p.ConfiguracionPaisID = h.ConfiguracionPaisID
where p.Codigo = 'DES-NAV'

insert into ConfiguracionOfertasHome 
(
	ConfiguracionPaisID, CampaniaID,
	DesktopOrden, MobileOrden,
	DesktopOrdenBpt, MobileOrdenBpt,
	DesktopImagenFondo, MobileImagenFondo,
	DesktopTitulo, MobileTitulo,
	DesktopSubTitulo, MobileSubTitulo,
	DesktopTipoPresentacion, MobileTipoPresentacion,
	DesktopTipoEstrategia, MobileTipoEstrategia,
	DesktopCantidadProductos, MobileCantidadProductos,
	DesktopActivo, MobileActivo,
	UrlSeccion
)
values (
	@idConfiPaisDetalle, 201717,
	(select top 1 DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode), 
	(select top 1 MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode),
	'GuiaDeNegocio_Desktop.jpg', 'GuiaDeNegocio_Mobile.jpg',
	'GUÍA DE NEGOCIO', 'GUÍA DE NEGOCIO',
	null, null,
	4, 4,
	null, null,
	0, 0,
	0, 0,
	''
)

update ConfiguracionOfertasHome set DesktopOrden = DesktopOrden + 1
where DesktopOrden >= (select DesktopOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrden = MobileOrden + 1
where MobileOrden >= (select MobileOrden from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set DesktopOrdenBpt = DesktopOrdenBpt + 1
where DesktopOrdenBpt >= (select DesktopOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

update ConfiguracionOfertasHome set MobileOrdenBpt = MobileOrdenBpt + 1
where MobileOrdenBpt >= (select MobileOrdenBpt from ConfiguracionOfertasHome where ConfiguracionOfertasHomeID = @ordenCode) and ConfiguracionOfertasHomeID <> @ordenCode

GO

