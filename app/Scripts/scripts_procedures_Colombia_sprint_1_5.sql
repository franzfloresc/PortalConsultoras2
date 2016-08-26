USE BelcorpColombia_SB2
go

/*TABLAS*/

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[ProductoSugerido]') AND (type = 'U') )
 DROP TABLE [dbo].[ProductoSugerido]
GO

create table [dbo].[ProductoSugerido]
(
	ProductoSugeridoID int identity(1,1) primary key
	, CampaniaID varchar(6) not null
	, CUV varchar(20) not null
	, CUVSugerido varchar(20) not null
	, Orden int not null
	, ImagenProducto varchar(150) null
	, Estado int not null
	, UsuarioRegistro varchar(50) not null
	, FechaRegistro datetime not null
	, UsuarioModificacion varchar(50) null
	, FechaModificacion datetime null
)

GO

IF NOT EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[GrupoBannerBase]') AND (type = 'U') )
BEGIN
	CREATE TABLE [dbo].[GrupoBannerBase](
	[GrupoBannerID] [int] NOT NULL,
	[Nombre] [varchar](200) NULL,
	[Dimension] [varchar](50) NULL,
	[Ancho] [smallint] NULL,
	[Alto] [smallint] NULL,
	[orden] [int] NULL,
	 CONSTRAINT [PK_GrupoBannerBase] PRIMARY KEY CLUSTERED 
	(
		[GrupoBannerID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
	) ON [PRIMARY]

END
GO

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[OfertaFinalRegionZona]') AND (type = 'U') )
	DROP TABLE [dbo].[OfertaFinalRegionZona]
GO

create table dbo.OfertaFinalRegionZona
(
	OfertaFinalRegionZonaID int primary key identity(1,1),
	CodigoRegion varchar(2),
	CodigoZona varchar(4),
	Estado bit
)

go

IF  EXISTS ( SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[OfertaFinalParametria]') AND (type = 'U') )
	DROP TABLE [dbo].[OfertaFinalParametria]
GO

create table dbo.OfertaFinalParametria
(
	OfertaFinalParametriaID int primary key identity(1,1),
	Tipo varchar(20),	
	GapMinimo decimal(18,2),
	GapMaximo decimal(18,2)
)

go

/*FIN TABLAS*/

/*NUEVOS CAMPOS*/
IF  EXISTS ( SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ods].[OfertasPersonalizadas]') AND (type = N'SN') )
	DROP SYNONYM [ods].[OfertasPersonalizadas]
GO

CREATE SYNONYM [ods].[OfertasPersonalizadas] FOR [ODS_CO_SB2].[dbo].[OfertasPersonalizadas]
GO

IF  EXISTS ( SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ods].[ConfiguracionProgramaNuevas]') AND (type = N'SN') )
	DROP SYNONYM [ods].[ConfiguracionProgramaNuevas]
GO

CREATE SYNONYM [ods].[ConfiguracionProgramaNuevas] FOR [ODS_CO_SB2].[dbo].[ConfiguracionProgramaNuevas]
GO

IF  EXISTS ( SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ods].[EscalaDescuento]') AND (type = N'SN') )
	DROP SYNONYM [ods].[EscalaDescuento]
GO

CREATE SYNONYM [ods].[EscalaDescuento] FOR [ODS_CO_SB2].[dbo].[EscalaDescuento]
GO

IF  EXISTS ( SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ods].[INT_SOA_COBRA_DEUDA_SECCI]') AND (type = N'SN') )
	DROP SYNONYM [ods].[INT_SOA_COBRA_DEUDA_SECCI]
GO

CREATE SYNONYM [ods].[INT_SOA_COBRA_DEUDA_SECCI] FOR [ODS_CO_SB2].[ffvv].[INT_SOA_COBRA_DEUDA_SECCI]

GO

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.PedidoWebDetalle') and SYSCOLUMNS.NAME = N'EsSugerido') = 0
	ALTER TABLE dbo.PedidoWebDetalle ADD EsSugerido bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.pedidowebdetalle') and SYSCOLUMNS.NAME = N'EsKitNueva') = 0
	ALTER TABLE dbo.PedidoWebDetalle ADD EsKitNueva bit
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'MontoAhorro') = 0
	ALTER TABLE dbo.PedidoWeb ADD MontoAhorro money
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'MontoEscala') = 0
	ALTER TABLE dbo.PedidoWeb ADD MontoEscala money
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'MontoAhorro') = 1
	ALTER TABLE dbo.PedidoWeb drop column MontoAhorro
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'MontoAhorroCatalogo') = 0
	ALTER TABLE dbo.PedidoWeb ADD MontoAhorroCatalogo money
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'MontoAhorroRevista') = 0
	ALTER TABLE dbo.PedidoWeb ADD MontoAhorroRevista money
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.pedidowebdetalle') and SYSCOLUMNS.NAME = N'OrdenPedidoWD') = 0
	ALTER TABLE dbo.PedidoWebDetalle ADD OrdenPedidoWD int
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.MensajeMetaConsultora')) = 0
 begin

	CREATE TABLE dbo.MensajeMetaConsultora(
		TipoMensaje varchar(50),
		Titulo varchar(1000),
		Mensaje varchar(1000)
	);
	
	insert into dbo.MensajeMetaConsultora(TipoMensaje, Titulo, Mensaje)
	values('MontoMinimo', '¡VAMOS, ADELANTE!', 'Te faltan #valor para pasar pedido')
					
	insert into dbo.MensajeMetaConsultora(TipoMensaje, Titulo, Mensaje)
	values('TippingPoint', '¡RECIBE TU BONIFICACIÓN DEL PROGRAMA DE NUEVAS!', 'Sólo te faltan #valor más.')
	
	insert into dbo.MensajeMetaConsultora(TipoMensaje, Titulo, Mensaje)
	values('MontoMaximo', '¡SÓLO PUEDES AGREGAR #valor MÁS!', 'Ya estas por llegar a tu tope de línea de crédito.')
	
	insert into dbo.MensajeMetaConsultora(TipoMensaje, Titulo, Mensaje)
	values('MontoMaximoSupero', 'YA ALCANZASTE EL LÍMITE DE TU LÍNEA DE CRÉDITO', 'Tu pedido ya alcanzó el monto máximo de tu línea de crédito.')
	
	insert into dbo.MensajeMetaConsultora(TipoMensaje, Titulo, Mensaje)
	values('EscalaDescuento', '¡YA LLEGAS AL #porcentaje% DSCTO!', 'Solo agrega #valor más.')
	
	insert into dbo.MensajeMetaConsultora(TipoMensaje, Titulo, Mensaje)
	values('EscalaDescuentoSupero', '¡BIEN!', 'Ya alcanzaste el #porcentaje de descuento.')

end
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
 where sysobjects.id = object_id('dbo.TipoEstrategia') and SYSCOLUMNS.NAME = N'FlagMostrarImg') = 0
	ALTER TABLE dbo.TipoEstrategia ADD FlagMostrarImg TINYINT NULL 
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Pais') and SYSCOLUMNS.NAME = N'OfertaFinal') = 0
	ALTER TABLE dbo.Pais ADD OfertaFinal int
go

if (select COUNT(*) from dbo.sysobjects inner join dbo.syscolumns on SYSOBJECTS.ID = SYSCOLUMNS.ID 
	where sysobjects.id = object_id('dbo.Permiso') and SYSCOLUMNS.NAME = N'EsPrincipal') = 0
	ALTER TABLE dbo.Permiso ADD EsPrincipal bit
go

/*FIN NUEVOS CAMPOS*/

/*INSERT*/
UPDATE dbo.Permiso set EsPrincipal = 0 WHERE PermisoID<1000

CREATE TABLE #tblTemporal (idPermisoTemp int)
INSERT INTO #tblTemporal(idPermisoTemp) 
SELECT PermisoID FROM RolPermiso WHERE RolID=1 and PermisoID>1000
DELETE FROM RolPermiso WHERE RolID=1 and PermisoID>1000
DELETE FROM Permiso WHERE PermisoID IN (SELECT idPermisoTemp FROM #tblTemporal)
DROP TABLE #tblTemporal


INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1002, N'SOCIA EMPRESARIA', 0, 1, N'Lider/Index', 0, N'Header', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1003, N'MI NEGOCIO', 0, 2, N'', 0, N'Header', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1004, N'MI ACADEMIA', 0, 3, N'MiAcademia/Index', 0, N'Header', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1005, N'MI COMUNIDAD', 0, 4, N'Comunidad/Index', 0, N'Header', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1006, N'MI ASESOR DE BELLEZA', 0, 5, N'', 0, N'Header', NULL, 0, 0, 0, 1)

--HIJOS MI NEGOCIO
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1013, N'Seguimiento a tu pedido', 1003, 2, N'Tracking/Index', 0, N'Header', NULL, NULL, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1015, N'Mis pedidos', 1003, 4, N'MisPedidos/Index', 0, N'Header', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1016, N'Mis pagos', 1003, 5, N'MisPagos/Index', 0, N'Header', NULL, NULL, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal])
VALUES (1017, N'Mis beneficios', 1003, 6, N'MisBeneficios/Index', 0, N'Header', NULL, 0, 0, 0, 1)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
--VALUES (1018, N'Mis incentivos', 1003, 7, N'', 0, N'Header', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1019, N'Consultora Online', 1003, 8, N'ConsultoraOnline/Index', 0, N'Header', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1020, N'Mis clientes', 1003, 9, N'Cliente/Index', 0, N'Header', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1021, N'Liquidación web', 1003, 10, N'OfertaLiquidacion/OfertasLiquidacion', 0, N'Header', NULL, 0, 0, 0, 1)
--FIN HIJOS MI NEGOCIO

--HIJOS MI ASESOR DE BELLEZA
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1023, N'ÉSIKA', 1006, 1, N'', 0, N'Header', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1024, N'LBEL', 1006, 2, N'', 0, N'Header', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1025, N'CYZONE', 1006, 3, N'', 0, N'Header', NULL, 0, 0, 0, 1)

--HIJOS ESIKA
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1026, N'Maquillador Virtual', 1023, 1, N'http://www.esika.com/coach-de-belleza/maquillador-virtual/', 1, N'Header', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1027, N'Manicure virtual', 1023, 2, N'http://www.esika.com/coach-de-belleza/manicure-virtual/', 1, N'Header', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1028, N'Esika blog', 1023, 3, N'http://www.esika.com/blog/', 1, N'Header', NULL, 0, 0, 0, 1)
--FIN HIJOS ESIKA

-- HIJOS LBEL
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1029, N'Diagnóstico de Piel', 1024, 1, N'http://www.lbel.com/diagnosticodepiel', 1, N'Header', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1030, N'Asesor de Bases y Polvos', 1024, 2, N'http://www.lbel.com/asesordemaquillaje/', 1, N'Header', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1031, N'Belleza a tu medida', 1024, 3, N'http://www.lbel.com/bellezaatumedida', 1, N'Header', NULL, 0, 0, 0, 1)
-- FIN HIJOS LBEL

-- HIJOS CYZONE
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1032, N'Maquillador virtual', 1025, 1, N'http://www.cyzone.com/pe/maquillador-virtual', 1, N'Header', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1033, N'Manicure virtual', 1025, 2, N'http://www.cyzone.com/pe/manicure-virtual', 1, N'Header', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1034, N'Look book', 1025, 3, N'http://www.cyzone.com/look-book/', 1, N'Header', NULL, 0, 0, 0, 1)
-- FIN HIJOS CYZONE

-- FOOTER
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1040, N'AYUDA', 0, 2, N'', 0, N'Footer', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1041, N'LEGAL', 0, 3, N'', 0, N'Footer', NULL, 0, 0, 0, 1)

INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1042, N'PREGUNTAS FRECUENTES', 1040, 1, N'https://www.somosbelcorp.com/Content/FAQ/Preguntas frecuentes Portal Consultora CO.pdf', 1, N'Footer', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1043, N'CONTÁCTANOS', 1040, 2, N'http://belcorprespondeqa.somosbelcorp.com/', 1, N'Footer', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1044, N'CONDICIONES DE USO WEB', 1041, 1, N'https://www.somosbelcorp.com/Content/FAQ/CONDICIONES_DE_USO_WEB_CO.pdf', 1, N'Footer', NULL, 0, 0, 0, 1)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios], [EsPrincipal]) 
VALUES (1045, N'POLÍTICAS DE PRIVACIDAD', 1041, 2, N'https://www.somosbelcorp.com/Content/FAQ/POLITICA_DE_PRIVACIDAD_CO.pdf', 1, N'Footer', NULL, 0, 0, 0, 1)
-- FIN FOOTER

INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1002, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1003, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1004, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1005, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1006, 1, 1)

INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1013, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1014, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1015, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1016, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1017, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1018, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1019, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1020, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1021, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1023, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1024, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1025, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1026, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1027, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1028, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1029, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1030, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1031, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1032, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1033, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1034, 1, 1)

INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1040, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1041, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1042, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1043, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1044, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 1045, 1, 1)



IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 87)
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion) VALUES (87, 'Carousel Liquidaciones Home')
END

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 8701)
BEGIN
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) VALUES (8701, 87, 1, 'Cantidad de productos a cargar')
END

GO

DELETE FROM MenuMobile WHERE Posicion='Menu'

INSERT INTO MenuMobile(MenuMobileID, Descripcion, MenuPadreID, OrdenItem, UrlItem, UrlImagen, PaginaNueva, Posicion, [Version])
VALUES
(1, 'Mi Negocio', 0, 1, '', '', 0, 'Menu', 'Mobile'),
(2, 'Catálogos y Revistas', 0, 2, 'Mobile/Catalogo', '', 0, 'Menu', 'Mobile'),
(3, 'Mi Asesor de Belleza', 0, 3, '', '', 0, 'Menu', 'Mobile'),
(4, 'Mi Academia', 0, 4, 'MiAcademia/Index', '', 1, 'Menu', 'Mobile'),
(5, 'Mi Comunidad', 0, 5, 'Comunidad/Index', '', 1, 'Menu', 'Mobile'),
(6, 'Mis Notificaciones', 0, 6, 'Mobile/Notificaciones', '', 0, 'Menu', 'Mobile'),

(9, 'Seguimiento a tu pedido', 1, 1, 'Mobile/SeguimientoPedido', '', 0, 'Menu', 'Mobile'),
--(11, 'Pedido FIC', 1, 2, '#', '', 0, 'Menu', 'Mobile'),
(12, 'Pedidos ingresados', 1, 3, 'Mobile/PedidosFacturados', '', 0, 'Menu', 'Mobile'),
(13, 'Pedidos facturados', 1, 4, 'Mobile/PedidosFacturados', '', 0, 'Menu', 'Mobile'),
(10, 'Estado de cuenta', 1, 5, 'Mobile/EstadoCuenta', '', 0, 'Menu', 'Mobile'),
--(16, 'Pago en Línea', 1, 6, 'Mobile/Paypal', '', 0, 'Menu', 'Mobile')
(7, 'Consultora Online', 1, 7, 'Mobile/ConsultoraOnline', '', 0, 'Menu', 'Mobile'),
(14, 'Mis clientes', 1, 8, 'Mobile/Cliente', '', 0, 'Menu', 'Mobile'),
(8, 'Liquidación web', 1, 9, 'Mobile/OfertaLiquidacion', '', 0, 'Menu', 'Mobile'),
(15, 'Productos Agotados', 1, 10, 'Mobile/ProductosAgotados', '', 0, 'Menu', 'Mobile')

ALTER TABLE MenuMobile
ALTER COLUMN Descripcion VARCHAR(70) NOT NULL

--SELECT * FROM MenuMobile
DELETE MenuMobile
WHERE Posicion = 'Footer'

--PADRES

INSERT INTO MenuMobile (MenuMobileID
						,Descripcion
						,MenuPadreId
						,OrdenItem
						,UrlItem
						,UrlImagen
						,PaginaNueva
						,Posicion
						,[Version])
				VALUES (100
						,'Ayuda'
						,0
						,3
						,''
						,''
						,0
						,'Footer'
						,'Completa')
INSERT INTO MenuMobile (MenuMobileID
						,Descripcion
						,MenuPadreId
						,OrdenItem
						,UrlItem
						,UrlImagen
						,PaginaNueva
						,Posicion
						,[Version])
				VALUES (101
						,'Legal'
						,0
						,4
						,''
						,''
						,0
						,'Footer'
						,'Completa')

--HIJOS

INSERT INTO MenuMobile (MenuMobileID
						,Descripcion
						,MenuPadreId
						,OrdenItem
						,UrlItem
						,UrlImagen
						,PaginaNueva
						,Posicion
						,[Version])
				VALUES (102
						,'Preguntas Frecuentes'
						,100
						,1
						,'http://comunidad.somosbelcorp.com/t5/Blog-editorial/RESUELVE-TUS-DUDAS-O-ADQUIERE-TUS-PRODUCTOS-FAVORITOS/ba-p/9082'
						,''
						,1
						,'Footer'
						,'Completa')
INSERT INTO MenuMobile (MenuMobileID
						,Descripcion
						,MenuPadreId
						,OrdenItem
						,UrlItem
						,UrlImagen
						,PaginaNueva
						,Posicion
						,[Version])
				VALUES (103
						,'Contáctanos'
						,100
						,2
						,'http://belcorprespondeqa.somosbelcorp.com/'
						,''
						,1
						,'Footer'
						,'Mobile')
INSERT INTO MenuMobile (MenuMobileID
						,Descripcion
						,MenuPadreId
						,OrdenItem
						,UrlItem
						,UrlImagen
						,PaginaNueva
						,Posicion
						,[Version])
				VALUES (104
						,'Tutorial'
						,100
						,3
						,''
						,''
						,1
						,'Footer'
						,'Completa')

INSERT INTO MenuMobile (MenuMobileID
						,Descripcion
						,MenuPadreId
						,OrdenItem
						,UrlItem
						,UrlImagen
						,PaginaNueva
						,Posicion
						,[Version])
				VALUES (105
						,'Términos y Condiciones'
						,101
						,1
						,'https://www.somosbelcorp.com/WebPages/TerminosyReferencias_CO.aspx'
						,''
						,1
						,'Footer'
						,'Completa')
INSERT INTO MenuMobile (MenuMobileID
						,Descripcion
						,MenuPadreId
						,OrdenItem
						,UrlItem
						,UrlImagen
						,PaginaNueva
						,Posicion
						,[Version])
				VALUES (106
						,'Protección de datos personales'
						,101
						,2
						,'https://www.somosbelcorp.com/Content/FAQ/Politica_DATOS_PERSONALES_CO.pdf'
						,''
						,1
						,'Footer'
						,'Completa')
GO

if not exists(select 1 from Permiso where Descripcion = 'Carga de Reemplazos Sugeridos')
begin

	-- MENNU Y PERMISO
	DECLARE @IDPadre INT = 111
	DECLARE @RolID INT = 4
	DECLARE @PermisoID INT
	DECLARE @OrdenItem INT

	
	-- select * from Permiso  WHERE IDPadre = 111
	SELECT @PermisoID=MAX(PermisoID), @OrdenItem=MAX(OrdenItem) FROM Permiso WHERE IDPadre = @IDPadre;
	--SELECT @PermisoID, @OrdenItem

	INSERT INTO Permiso
	(PermisoID, Descripcion, IdPadre, OrdenItem, UrlItem, PaginaNueva, Posicion, UrlImagen, EsSoloImagen, EsMenuEspecial, EsServicios)
	VALUES(@PermisoID+1, 'Carga de Reemplazos Sugeridos', @IDPadre, @OrdenItem + 1,'AdministrarProductoSugerido/Index',0,'Header','',0,0,0)
	INSERT INTO RolPermiso(RolID, PermisoID, Activo, Mostrar) VALUES(@RolID, @PermisoID + 1, 1, 1)

end

GO

IF not EXISTS (select * from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos' ) 
begin

	declare @id int
	select @id = max(TablaLogicaID) + 1 from dbo.tablalogica
	insert into dbo.tablalogica(TablaLogicaID, Descripcion) values( @id, 'Reemplazos Sugeridos')
	insert into dbo.tablalogicadatos(TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion
	) values( convert(varchar, @id) + '01', @id, '5', 'Productos con reemplazos configurados por campaña')
	insert into dbo.tablalogicadatos(TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion
	) values( convert(varchar, @id) + '02', @id, '5', 'Reemplazos configurados por producto por campaña')

end

go

if not exists(select 1 from GrupoBannerBase where GrupoBannerID = 150)
begin
	INSERT [dbo].[GrupoBannerBase] ([GrupoBannerID], [Nombre], [Dimension], [Ancho], [Alto], [orden]) VALUES (150, N'Grupo Banner Principal SB2.0', N'Dimensiones: 1920 x 323', 1920, 323, 2)
end

GO

if not exists(select 1 from GrupoBannerBase where GrupoBannerID = 151)
begin
	INSERT [dbo].[GrupoBannerBase] ([GrupoBannerID], [Nombre], [Dimension], [Ancho], [Alto], [orden]) VALUES (151, N'Grupo Banner: Seccion Baja 1 SB2.0', N'Dimensiones: 371 x 200', 371, 200, 23)
end

GO

if not exists(select 1 from GrupoBannerBase where GrupoBannerID = 152)
begin
	INSERT [dbo].[GrupoBannerBase] ([GrupoBannerID], [Nombre], [Dimension], [Ancho], [Alto], [orden]) VALUES (152, N'Grupo Banner: Seccion Baja 2 SB2.0', N'Dimensiones: 371 x 200', 371, 200, 24)
end

GO

if not exists(select 1 from GrupoBannerBase where GrupoBannerID = 153)
begin
	INSERT [dbo].[GrupoBannerBase] ([GrupoBannerID], [Nombre], [Dimension], [Ancho], [Alto], [orden]) VALUES (153, N'Grupo Banner: Seccion Baja 3 SB2.0', N'Dimensiones: 371 x 200', 371, 200, 25)
end

GO

UPDATE dbo.Marca SET Descripcion = 'L''Bel' WHERE Descripcion = 'LBel'
UPDATE dbo.Marca SET Descripcion = 'Ésika' WHERE Descripcion = 'Esika'
UPDATE ods.Marca SET Nombre = 'L''Bel' WHERE Nombre = 'LBel'
UPDATE ods.Marca SET Nombre = 'Ésika' WHERE Nombre = 'Esika'

GO

/*FIN INSERTS*/

/*FUNCIONES*/
IF exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FiltrarTallaColorLiquidacion_2_SB2]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
	drop function [dbo].FiltrarTallaColorLiquidacion_2_SB2
GO

CREATE FUNCTION FiltrarTallaColorLiquidacion_2_SB2
( @CUV VARCHAR(20), 
  @CampaniaID INT 
) 
	RETURNS VARCHAR(8000)
AS
BEGIN
	DECLARE @tblTallaColor TABLE(ID INT IDENTITY(1, 1), CUV VARCHAR(20), DESCRIPCIONCUV VARCHAR(200), DESCRIPCIONTALLACOLOR VARCHAR(200), PrecioUnitario numeric(15, 2))	

	INSERT INTO @tblTallaColor
	SELECT TCC.CUV, 
	CASE
		WHEN ISNULL(TCC.DescripcionCUV, '') = '' THEN PC.Descripcion
		ELSE TCC.DescripcionCUV 
	END,
	'Seleccione',	
	pc.PrecioUnitario
	FROM TallaColorLiquidacion TCC 
	INNER JOIN ods.ProductoComercial PC ON PC.CUV = TCC.CUV
	INNER JOIN ods.Campania	CA ON CA.CampaniaID = PC.CampaniaID  AND TCC.CampaniaID = CA.Codigo
	WHERE 
			 TCC.CampaniaID = @CampaniaID
		 AND TCC.CUV = @CUV

	INSERT INTO @tblTallaColor
	SELECT TCC.CUV, 
	CASE
		WHEN ISNULL(TCC.DescripcionCUV, '') = '' THEN PC.Descripcion
		ELSE TCC.DescripcionCUV 
	END, 
	TCC.Descripcion,	
	pc.PrecioUnitario
	FROM TallaColorLiquidacion TCC 
	INNER JOIN ods.ProductoComercial PC ON PC.CUV = TCC.CUV
	INNER JOIN ods.Campania	CA ON CA.CampaniaID = PC.CampaniaID  AND TCC.CampaniaID = CA.Codigo
	WHERE 
			TCC.CampaniaID = @CampaniaID
		 AND TCC.CUV = @CUV
		 AND ISNULL(TCC.Descripcion, '') <> ''

	INSERT INTO @tblTallaColor
	SELECT TCC.CUV, 
	CASE
		WHEN ISNULL(TCC.DescripcionCUV, '') = '' THEN PC.Descripcion
		ELSE TCC.DescripcionCUV 
	END, 
	TCC.DESCRIPCION, pc.PrecioUnitario 
	FROM TallaColorLiquidacion TCC 
	INNER JOIN ods.ProductoComercial PC ON PC.CUV = TCC.CUV
	INNER JOIN ods.Campania	CA ON CA.CampaniaID = PC.CampaniaID  AND TCC.CampaniaID = CA.Codigo
	INNER JOIN OfertaProducto OP ON OP.CUV = PC.CUV AND OP.CampaniaID = PC.CampaniaID
	WHERE 
			TCC.CampaniaID = @CampaniaID
		 AND CUVPadre = @CUV
		 AND TCC.CUV <> @CUV
		 AND OP.Stock > 0

	DECLARE @i INT, @total INT, @strTallaColor VARCHAR(MAX), @cuvv VARCHAR(20), @descripcionCUVv VARCHAR(200), @descripcionTallaColorv VARCHAR(200), @PrecioUnitario numeric(15, 2), @tipo VARCHAR(20)

	SET @strTallaColor = ''
	SET @tipo = (SELECT Tipo FROM TallaColorLiquidacion WHERE CUV = @CUV AND CampaniaID = @CampaniaID)

	SET @i = 1
	SET @total =(SELECT MAX(ID) FROM @tblTallaColor)

	IF @total > 1
	BEGIN
		SET @strTallaColor = @strTallaColor + @tipo + '^'
	END

	WHILE @i <= @total
	BEGIN
			SET @cuvv = (SELECT cuv FROM @tblTallaColor WHERE ID = @i)
			SET @descripcionCUVv = (SELECT DESCRIPCIONCUV FROM @tblTallaColor WHERE ID = @i)
			SET @descripcionTallaColorv = (SELECT DESCRIPCIONTALLACOLOR FROM @tblTallaColor WHERE ID = @i)
			SET @PrecioUnitario = (SELECT PrecioUnitario FROM @tblTallaColor WHERE ID = @i)
			SET @strTallaColor = @strTallaColor + @cuvv + '|' + @descripcionCUVv + '|' + @descripcionTallaColorv + '|' + CONVERT(VARCHAR(20), @PrecioUnitario) + '</>'
			
		SET @i = @i + 1
	END

	RETURN ISNULL(@strTallaColor, '')
END

go

IF exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[fn_ObtenerTallaColorCuv_SB2]') and OBJECTPROPERTY(id, N'IsScalarFunction') = 1)
	drop function [dbo].fn_ObtenerTallaColorCuv_SB2
GO

create function [dbo].fn_ObtenerTallaColorCuv_SB2
(
	@CUV varchar(5) = null,
	@CampaniaId varchar(6) = null
)
returns VARCHAR(4)
as
/*
select dbo.fn_ObtenerTallaColorCuv_SB2('95422','201411')
select dbo.fn_ObtenerTallaColorCuv_SB2('95422','201610')
*/
begin

set @CUV = isnull(@CUV,'')
set @CampaniaId = isnull(@CampaniaId,'')

declare @resultado varchar(4) = ''

select top 1
	@resultado = Tipo 
from TallaColorCUV
where 
	CUVPadre = @CUV
	and CampaniaId = @CampaniaId

return @resultado

end

go

/*FIN FUNCIONES*/

/*PROCEDIMIENTOS ALMACENADOS*/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductoSugeridoByCUV_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetProductoSugeridoByCUV_SB2
GO

create procedure dbo.GetProductoSugeridoByCUV_SB2
@CampaniaID int,
@ConsultoraID int,
@CUV varchar(100),
@RegionID int,
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
as
/*
dbo.GetProductoSugeridoByCUV_SB2 201609,2,'02767',2701,2161,'50','5052'
dbo.GetProductoSugeridoByCUV_SB2 201609,2,'00040',2701,2161,'50','5052'
*/
begin

declare @tablaSugerido table
(
	Orden int,
	ImagenProducto varchar(150),
	CUV varchar(20)
)

insert into @tablaSugerido
select Orden, ImagenProducto, CUVSugerido
from ProductoSugerido
where 
	CampaniaID = @CampaniaID
	and CUV = @CUV
	and Estado = '1'

declare @tablaCUV table(
	CUV varchar(20), Descripcion varchar(100), PrecioCatalogo decimal(18,2), 
	MarcaID int, EstaEnRevista int, TieneStock int, EsExpoOferta int,
	CUVRevista varchar(20), CUVComplemento varchar(20), PaisID int,
	CampaniaID varchar(6), CodigoCatalago varchar(6), CodigoProducto varchar(12),
	IndicadorMontoMinimo int, DescripcionMarca varchar(20), DescripcionCategoria varchar(20),
	DescripcionEstrategia varchar(200), ConfiguracionOfertaID int, TipoOfertaSisID int,
	FlagNueva int, TipoEstrategiaID int, IndicadorOferta bit, TieneSugerido int
) 

DECLARE cursorSugerido CURSOR
    FOR SELECT CUV FROM @tablaSugerido
OPEN cursorSugerido
FETCH NEXT FROM cursorSugerido into @CUV

WHILE @@FETCH_STATUS = 0   
BEGIN         

	   insert into @tablaCUV
	   exec dbo.GetProductoComercialByCampaniaBySearchRegionZona @CampaniaID,1,1,@CUV,@RegionID,@ZonaID,@CodigoRegion,@CodigoZona	   
	   
	   FETCH NEXT FROM cursorSugerido INTO @CUV 
END

declare @tablaPedidoDetalle table ( CUV varchar(20) )
insert into @tablaPedidoDetalle
select pd.CUV from PedidoWeb p
inner join PedidoWebDetalle pd on
	p.PedidoID = pd.PedidoID and p.CampaniaID = pd.CampaniaID
where p.ConsultoraID = @ConsultoraID and p.CampaniaID = @CampaniaID

--Verificar que tenga stock
select
	t.CUV, t.Descripcion, t.PrecioCatalogo, 
	t.MarcaID, t.EstaEnRevista, t.TieneStock, t.EsExpoOferta,
	t.CUVRevista, t.CUVComplemento, t.PaisID,
	t.CampaniaID, t.CodigoCatalago, t.CodigoProducto,
	t.IndicadorMontoMinimo, t.DescripcionMarca, t.DescripcionCategoria,
	t.DescripcionEstrategia, t.ConfiguracionOfertaID, t.TipoOfertaSisID,
	t.FlagNueva, t.TipoEstrategiaID, t.IndicadorOferta, ts.ImagenProducto as ImagenProductoSugerido
from @tablaCUV t
inner join @tablaSugerido ts on
	t.CUV = ts.CUV
where t.TieneStock = 1
	and t.CUV not in (select CUV from @tablaPedidoDetalle)
order by ts.Orden

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductoComercialByCampaniaBySearchRegionZona_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetProductoComercialByCampaniaBySearchRegionZona_SB2
GO

CREATE PROCEDURE dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2
	@CampaniaID int,
	@RowCount int,
	@Criterio int,
	@CodigoDescripcion varchar(100),
	@RegionID int,
	@ZonaID int,
	@CodigoRegion varchar(10),
	@CodigoZona varchar(10)
AS
/*
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201609,1,1,'00025',2701,2161,'50','5052'
dbo.GetProductoComercialByCampaniaBySearchRegionZona_SB2 201609,1,1,'02767',2701,2161,'50','5052'
*/
BEGIN

-- Depuramos las tallas y colores
EXEC DepurarTallaColorCUV @CampaniaID
EXEC DepurarTallaColorLiquidacion @CampaniaID

DECLARE @OfertaProductoTemp table
(
	CampaniaID int,
	CUV varchar(6),
	Descripcion varchar(250),
	ConfiguracionOfertaID int,
	TipoOfertaSisID int,
	PrecioOferta numeric(12,2)
)

insert into @OfertaProductoTemp
select 
	op.CampaniaID, op.CUV, op.Descripcion, op.ConfiguracionOfertaID, op.TipoOfertaSisID,null
FROM OfertaProducto op
inner join ods.Campania c on
	op.CampaniaID = c.CampaniaID
where
	c.codigo = @CampaniaID

DECLARE @ProductoFaltanteTemp table (CUV varchar(6))

INSERT INTO @ProductoFaltanteTemp
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante nolock
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa (nolock)
inner join ods.Campania c (nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

--Logica para Producto Sugerido
declare @TieneSugerido int = 0
if exists (	select 1 from dbo.ProductoSugerido 
			where CampaniaID = @CampaniaID and CUV = @CodigoDescripcion and Estado = 1)
begin
	set @TieneSugerido = 1
end
	
IF(@Criterio = 1)
BEGIN
	select 
		distinct top (@RowCount) p.CUV,
		coalesce(EST.DescripcionCUV2 + ' '+ tcc.Descripcion, 
		est.descripcioncuv2, 
		op.Descripcion, 
		mc.Descripcion, 
		pd.Descripcion, 
		p.Descripcion) AS Descripcion,
		coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
				(	SELECT E.TipoEstrategiaID FROM Estrategia E
					INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
					WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
		ISNULL(te.flagNueva, 0) FlagNueva,
		ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
		P.IndicadorOferta,
		@TieneSugerido as TieneSugerido
	from ods.ProductoComercial p
	left join dbo.ProductoDescripcion pd ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on 
		op.CampaniaID = P.CampaniaID 
		AND op.CUV = P.CUV
	left join MatrizComercial mc on 
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON 
		EST.CampaniaID = p.AnoCampania 
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = p.CUV)) 
		AND EST.Activo = 1 
	LEFT JOIN dbo.TallaColorCUV tcc 
		ON tcc.CUV = p.CUV 
		AND tcc.CampaniaID = p.AnoCampania
	LEFT JOIN TipoEstrategia TE ON 
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M ON 
		p.MarcaId = M.MarcaId
	where 
		p.AnoCampania = @CampaniaID 
		AND p.IndicadorDigitable = 1
		AND CHARINDEX(@CodigoDescripcion,p.CUV)>0
END
ELSE
BEGIN
	select 
		distinct top (@RowCount) p.CUV,
		coalesce(est.descripcioncuv2, op.Descripcion, mc.Descripcion, pd.Descripcion, p.Descripcion) AS Descripcion,
		coalesce(est.precio2, op.PrecioOferta, pd.PrecioProducto*pd.FactorRepeticion ,p.PrecioUnitario*p.FactorRepeticion) AS PrecioCatalogo,
		p.MarcaID,
		0 AS EstaEnRevista,
		(case when ISNULL(pf.CUV,0) = 0 then 1 when ISNULL(pf.CUV,0) > 0 then 0 end) AS TieneStock,
		ISNULL(pcc.EsExpoOferta,0) AS EsExpoOferta,
		ISNULL(pcc.CUVRevista,'') AS CUVRevista,
		'' AS CUVComplemento,
		p.PaisID,
		p.AnoCampania AS CampaniaID,
		p.CodigoCatalago,
		p.CodigoProducto,
		p.IndicadorMontoMinimo,
		M.Descripcion as DescripcionMarca,
		'NO DISPONIBLE' AS DescripcionCategoria,
		TE.DescripcionEstrategia AS DescripcionEstrategia,
		ISNULL(op.ConfiguracionOfertaID,0) ConfiguracionOfertaID,
		CASE
			WHEN EXISTS(SELECT 1 FROM TallaColorLiquidacion WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN 1702
			WHEN EXISTS(SELECT 1 FROM TallaColorCUV WHERE CampaniaID = @CampaniaID AND CUV = p.CUV) THEN
			(	SELECT E.TipoEstrategiaID FROM Estrategia E
				INNER JOIN TALLACOLORCUV TCC ON E.CAMPANIAID = TCC.CAMPANIAID AND E.CUV2 = TCC.CUVPADRE
				WHERE TCC.CUV = p.CUV AND E.CAMPANIAID=@CampaniaID)
			ELSE ISNULL(op.TipoOfertaSisID,0) END TipoOfertaSisID,
			ISNULL(te.flagNueva, 0) FlagNueva,
			ISNULL(te.TipoEstrategiaID, '') TipoEstrategiaID,
			P.IndicadorOferta,
			@TieneSugerido as TieneSugerido
	from ods.ProductoComercial p
	left join dbo.ProductoDescripcion pd ON 
		p.AnoCampania = pd.CampaniaID 
		AND p.CUV = pd.CUV
	left join @ProductoFaltanteTemp pf ON 
		p.CUV = pf.CUV
	left join ProductoComercialConfiguracion pcc ON 
		p.AnoCampania = pcc.CampaniaID 
		AND p.CUV = pcc.CUV
	left join @OfertaProductoTemp op on
		op.CampaniaID = P.CampaniaID
		AND op.CUV = P.CUV
	left join MatrizComercial mc on
		p.CodigoProducto = mc.CodigoSAP
	LEFT JOIN Estrategia EST ON
		EST.CampaniaID = p.AnoCampania
		AND (EST.CUV2 = p.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV	TCC WHERE TCC.CUV = p.CUV))
		AND EST.Activo = 1
	LEFT JOIN TipoEstrategia TE ON
		TE.TipoEstrategiaID = EST.TipoEstrategiaID
	LEFT JOIN Marca M ON
		p.MarcaId = M.MarcaId
	where
		p.AnoCampania = @CampaniaID
		AND p.IndicadorDigitable = 1
		AND CHARINDEX(@CodigoDescripcion,coalesce(op.Descripcion,pd.Descripcion, p.Descripcion))>0
END

END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOfertasPortal_2_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetOfertasPortal_2_SB2
GO

CREATE PROCEDURE GetOfertasPortal_2_SB2  
 @TipoOfertaSisID int,  
 @DuplaConsultora int,  
 @CodigoCampania int,  
 @Offset int,  
 @CantidadRegistros int  
AS  
/*  
 GetOfertasPortal 1702, 100, 201414  
*/  
BEGIN  
 SET NOCOUNT ON  
  -- Depuramos las tallas y colores  
  EXEC DepurarTallaColorLiquidacion @CodigoCampania  
  
  if @TipoOfertaSisID = 1701  
   BEGIN  
    if @DuplaConsultora = 1  
     BEGIN  
      select   
         OP.OfertaProductoID,  
         OP.CampaniaID,  
         ca.Codigo as CodigoCampania,  
         OP.CUV,  
         OP.Descripcion,  
         coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,  
         isnull(OP.Stock,0) Stock,  
         isnull(OP.ImagenProducto,'') ImagenProducto,  
         OP.Orden,  
         OP.UnidadesPermitidas,  
         isnull(OP.DescripcionLegal,'') DescripcionLegal,  
         OP.ConfiguracionOfertaID,  
         OP.TipoOfertaSisID,  
         PC.MarcaID,  
         M.Descripcion as DescripcionMarca, --R2469  
       'NO DISPONIBLE' AS DescripcionCategoria,  
       'NO DISPONIBLE' AS DescripcionEstrategia   
      from ofertaproducto op with(nolock)  
      inner join ods.campania ca with(nolock)  
         on op.campaniaid = ca.campaniaid  
      inner join ods.productocomercial pc with(nolock)  
        on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid  
      left join ProductoDescripcion pd with(nolock)   
       on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv  
       --R2469 - JICM Nuevos Campos marcación  
      --LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap  
      -- LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca  
      -- LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria  
      --LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2  
      -- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID  
      left join Marca M ON pc.MarcaId = M.MarcaId  
      where op.TipoOfertaSisID = @TipoOfertaSisID   
        and OP.FlagHabilitarProducto = 1  
        AND CA.Codigo = @CodigoCampania  
        AND OP.ConfiguracionOfertaID IN  
        (SELECT ConfiguracionOfertaID   
         FROM configuracionoferta with(nolock)  
        WHERE TipoOfertaSisID = @TipoOfertaSisID  
           and CodigoOferta = pc.CodigoTipoOferta )  
       ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC  
       OFFSET @Offset ROWS  
       FETCH NEXT @CantidadRegistros ROWS ONLY  
     END  
    ELSE  
     BEGIN  
      select   
         OP.OfertaProductoID,  
         OP.CampaniaID,  
         ca.Codigo as CodigoCampania,  
         OP.CUV,  
         OP.Descripcion,  
         coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,  
         isnull(OP.Stock,0) Stock,  
         isnull(OP.ImagenProducto,'') ImagenProducto,  
         OP.Orden,  
         OP.UnidadesPermitidas,  
         isnull(OP.DescripcionLegal,'') DescripcionLegal,  
         OP.ConfiguracionOfertaID,  
         OP.TipoOfertaSisID,  
         PC.MarcaID,  
          M.Descripcion as DescripcionMarca, --R2469  
       'NO DISPONIBLE' AS DescripcionCategoria,  
       'NO DISPONIBLE' AS DescripcionEstrategia   
      from ofertaproducto op with(nolock)  
      inner join ods.campania ca with(nolock)  
         on op.campaniaid = ca.campaniaid  
      inner join ods.productocomercial pc with(nolock)  
        on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid  
      left join ProductoDescripcion pd with(nolock)   
       on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv  
       --R2469  
        --LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap  
        --LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca  
        --LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria  
        --LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2  
        --LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID  
      left join Marca M ON pc.MarcaId = M.MarcaId  
      where op.TipoOfertaSisID = @TipoOfertaSisID   
        and OP.FlagHabilitarProducto = 1  
        AND CA.Codigo = @CodigoCampania  
        AND OP.ConfiguracionOfertaID IN  
        (SELECT ConfiguracionOfertaID   
         FROM configuracionoferta with(nolock)  
        WHERE TipoOfertaSisID = @TipoOfertaSisID  
            AND ConfiguracionOfertaID != 2  
            and CodigoOferta = pc.CodigoTipoOferta )  
  
       ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC  
       OFFSET @Offset ROWS  
       FETCH NEXT @CantidadRegistros ROWS ONLY  
  
     END  
   END  
  ELSE  
   BEGIN  
    select   
       OP.OfertaProductoID,  
       OP.CampaniaID,  
       ca.Codigo as CodigoCampania,  
       OP.CUV,  
       CASE  
       WHEN tcl.DescripcionCUV IS NOT NULL THEN tcl.DescripcionCUV  
       ELSE OP.Descripcion END Descripcion,  
       coalesce(pd.PrecioProducto * pd.FactorRepeticion, OP.PrecioOferta) PrecioOferta,  
       isnull(OP.Stock,0) Stock,  
       isnull(OP.ImagenProducto,'') ImagenProducto,  
       OP.Orden,  
       OP.UnidadesPermitidas,  
       isnull(OP.DescripcionLegal,'') DescripcionLegal,  
       OP.ConfiguracionOfertaID,  
       OP.TipoOfertaSisID,  
       PC.MarcaID,  
       dbo.FiltrarTallaColorLiquidacion_2_SB2(op.CUV, CA.Codigo) TallaColor,  
        M.Descripcion as DescripcionMarca, --R2469  
     'NO DISPONIBLE' AS DescripcionCategoria,  
     'NO DISPONIBLE' AS DescripcionEstrategia   
    from ofertaproducto op with(nolock)  
    inner join ods.campania ca with(nolock)  
     on op.campaniaid = ca.campaniaid  
    inner join ods.productocomercial pc with(nolock)  
     on pc.cuv = op.cuv and pc.campaniaid = op.campaniaid  
    left join ProductoDescripcion pd with(nolock)   
     on ca.Codigo = pd.campaniaid and op.cuv = pd.cuv  
    left join TallaColorLiquidacion tcl with(nolock)  
     on tcl.CUV = pc.CUV and tcl.CampaniaID = pc.AnoCampania  
    --LEFT JOIN ODS.SAP_PRODUCTO PRO ON PC.CodigoProducto=PRO.CodigoSap  
    --LEFT JOIN ODS.SAP_MARCA MAR ON MAR.Codigo = PRO.CodigoMarca  
    --LEFT JOIN ODS.SAP_CATEGORIA CAT ON CAT.CodigoCategoria=PRO.CodigoCategoria  
    --LEFT JOIN Estrategia ES ON ES.CampaniaID = pc.CampaniaID AND pc.CUV = ES.CUV2  
    -- LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = ES.TipoEstrategiaID  
     left join Marca M ON pc.MarcaId = M.MarcaId  
     where op.TipoOfertaSisID = @TipoOfertaSisID   
      and OP.FlagHabilitarProducto = 1  
      AND OP.Stock > 0  
      AND CA.Codigo = @CodigoCampania  
      AND OP.ConfiguracionOfertaID IN  
      (SELECT ConfiguracionOfertaID   
       FROM configuracionoferta with(nolock)  
      WHERE TipoOfertaSisID = @TipoOfertaSisID  
         and CodigoOferta = pc.CodigoTipoOferta )  
     ORDER BY OP.ConfiguracionOfertaID, OP.Orden ASC  
     OFFSET @Offset ROWS  
     FETCH NEXT @CantidadRegistros ROWS ONLY  
   END  
 SET NOCOUNT OFF  
END  

go  

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarEstrategiasPedido_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].ListarEstrategiasPedido_SB2
GO

CREATE PROCEDURE [dbo].[ListarEstrategiasPedido_SB2]  
@CampaniaID INT,  
@ConsultoraID VARCHAR(30),  
@CUV VARCHAR(20),  
@ZonaID VARCHAR(20)  
AS
/*
dbo.ListarEstrategiasPedido_SB2 201612,'2','','2161'
*/
BEGIN  
	SET NOCOUNT ON  
    
	DECLARE @tablaCuvPedido table (CUV varchar(6))
	insert into @tablaCuvPedido
	SELECT CUV   
	FROM PedidoWebDetalle with(nolock)   
	WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID	

	DECLARE @CuvReco VARCHAR(20)  
	SELECT 
		@CuvReco = CSA.CUV 
	FROM CrossSellingAsociacion CSA   
	INNER JOIN ods.Campania CA ON CSA.CampaniaID = CA.CampaniaID   
	WHERE
		CA.Codigo = @CampaniaID 
		AND (CUVAsociado = @CUV OR CUVAsociado2 = @CUV OR CUV = @CUV)
    
	/* RECOMENDACION POR CUV - INICIO */   
	SELECT  
		EstrategiaID,   
		CUV2,   
		DescripcionCUV2,   
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,   
		E.Precio,  
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,   
		Precio2,  
		TextoLibre,   
		FlagEstrella,   
		ColorFondo,  
		e.TipoEstrategiaID,  
		e.ImagenURL FotoProducto01,  
		te.ImagenEstrategia ImagenURL,  
		e.LimiteVenta,  
		pc.MarcaID,  
		te.Orden Orden1,  
		e.Orden Orden2,  
		pc.IndicadorMontoMinimo,  
		pc.CodigoProducto,   
		TE.FlagNueva,
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		1 as TipoEstrategiaImagenMostrar	--CrossSelling
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
	INTO #TEMPORAL  
	FROM Estrategia E  
	INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
	INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
	INNER JOIN CrossSellingAsociacion CSA ON CSA.CampaniaID = CA.CampaniaID AND (E.CUV2 = CSA.CUVAsociado OR E.CUV2 = CSA.CUVAsociado2 )  
	INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2  
	WHERE
		E.Activo = 1   
		AND TE.flagRecoProduc = 1  
		AND TE.FlagActivo = 1  
		AND CSA.CUV IS NOT NULL  
		AND CA.Codigo = @CampaniaID  
		AND CSA.CUV = @CuvReco  
		AND E.Zona LIKE '%' + @ZonaID + '%' 
	ORDER BY 
		te.Orden ASC, 
		e.Orden ASC  	
	/* RECOMENDACION POR CUV - FIN */      

	DECLARE @CodigoConsultora VARCHAR(25)    
	DECLARE @NumeroPedido INT  
    
	SELECT   
		@NumeroPedido = consecutivonueva + 1,  
		@CodigoConsultora = codigo    
	FROM ods.Consultora   
	WHERE   
		ConsultoraID=@ConsultoraID  
    
	-- Obtener estrategias de Pack Nuevas.   
	INSERT INTO #TEMPORAL  
	SELECT   
		EstrategiaID,   
		CUV2,   
		DescripcionCUV2,   
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,   
		Precio,  
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,   
		Precio2,  
		TextoLibre,   
		FlagEstrella,   
		ColorFondo,  
		e.TipoEstrategiaID,  
		e.ImagenURL FotoProducto01,  
		te.ImagenEstrategia ImagenURL,  
		e.LimiteVenta,  
		pc.MarcaID,  
		te.Orden Orden1,  
		e.Orden Orden2,  
		pc.IndicadorMontoMinimo,  
		pc.CodigoProducto,  
		1 AS FlagNueva, -- R2621   
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		2 as TipoEstrategiaImagenMostrar	-- Pack Nuevas
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
	FROM Estrategia E  
	INNER JOIN TipoEstrategia TE ON 
		E.TipoEstrategiaID = TE.TipoEstrategiaID  
	INNER JOIN ods.Campania CA ON 
		E.CampaniaID = CA.Codigo  
	INNER JOIN ods.ProductoComercial PC ON 
		PC.CampaniaID = CA.CampaniaID 
		AND PC.CUV = E.CUV2  
	INNER JOIN Ods.ConsultorasProgramaNuevas CPN ON 
		CPN.CodigoConsultora = @CodigoConsultora 
		AND CPN.CodigoPrograma = TE.CodigoPrograma   
	WHERE       
		(E.CampaniaID = @CampaniaID OR @CampaniaID between E.CampaniaID and E.CampaniaIDFin)  
		AND E.Activo = 1  
		AND CPN.Participa = 1    
		AND TE.FlagActivo = 1  
		AND TE.flagNueva = 1    
		AND E.NumeroPedido = @NumeroPedido   
		AND E.Zona LIKE '%' + @ZonaID + '%'  
		AND E.CUV2 not in(	SELECT CUV   
							FROM @tablaCuvPedido )        		
	ORDER BY te.Orden ASC, e.Orden ASC   
        
	-- Obtener estrategias de recomendadas para ti.  
	declare @CodigoRegion varchar(2) = null
	declare @CodigoZona varchar(4) = null
	select @CodigoRegion = r.Codigo, @CodigoZona = z.Codigo
	from ods.Zona z
	inner join ods.Region r on
		z.RegionId = r.RegionId
	where ZonaId = @ZonaID

	declare @tablaCuvFaltante table (CUV varchar(6))
	insert into @tablaCuvFaltante
	select 
		distinct ltrim(rtrim(CUV))
	from dbo.ProductoFaltante nolock
	where 
		CampaniaID = @CampaniaID and Zonaid = @ZonaID
	UNION ALL
	select 
		distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
	from ods.FaltanteAnunciado fa (nolock)
	inner join ods.Campania c (nolock) on 
		fa.CampaniaID = c.CampaniaID
	where 
		c.Codigo = @CampaniaID 
		and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL)
		and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

	INSERT INTO #TEMPORAL  
	SELECT top 5
		EstrategiaID,   
		CUV2,   
		DescripcionCUV2,   
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion, 
		e.Precio,  
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,   
		Precio2,  
		TextoLibre,  
		FlagEstrella,   
		ColorFondo,  
		e.TipoEstrategiaID,  
		e.ImagenURL FotoProducto01,  
		te.ImagenEstrategia ImagenURL,  
		e.LimiteVenta,    pc.MarcaID,  
		te.Orden Orden1,  
		op.Orden Orden2,  
		pc.IndicadorMontoMinimo,  
		pc.CodigoProducto,  
		0 AS FlagNueva, -- R2621  
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		3 as TipoEstrategiaImagenMostrar	--Oferta para Ti
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
	FROM Estrategia E  
	INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
	INNER JOIN ods.Campania ca ON CA.Codigo = e.campaniaid   
	INNER JOIN ods.OfertasPersonalizadas op ON E.CUV2 = op.CUV and op.AnioCampanaVenta = CA.Codigo and op.TipoPersonalizacion = 'OPT'
	INNER JOIN ods.Consultora c ON op.CodConsultora = c.Codigo  
	INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2  
	WHERE  
		E.Activo = 1
		AND ca.Codigo = @CampaniaID  
		AND c.ConsultoraID = @ConsultoraID
		AND E.Zona LIKE '%' + @ZonaID + '%'  
		AND TE.FlagActivo = 1
		AND TE.flagRecoPerfil = 1
		AND E.CUV2 not in (	SELECT CUV FROM @tablaCuvPedido )
		AND E.CUV2 not in ( SELECT CUV FROM @tablaCuvFaltante )
	ORDER BY te.Orden ASC, op.Orden  
    
	--  Oferta Web y Lanzamiento
	INSERT INTO #TEMPORAL  
	SELECT  
		EstrategiaID,   
		CUV2,   
		DescripcionCUV2,   
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID) EtiquetaDescripcion,   
		Precio,  
		dbo.ObtenerDescripcionEtiqueta(EtiquetaID2) EtiquetaDescripcion2,   
		Precio2,  
		TextoLibre,   
		FlagEstrella,   
		ColorFondo,  
		e.TipoEstrategiaID,  
		e.ImagenURL FotoProducto01,  
		te.ImagenEstrategia ImagenURL,  
		e.LimiteVenta,  
		pc.MarcaID,  
		te.Orden Orden1,  
		e.Orden Orden2,  
		pc.IndicadorMontoMinimo,  
		pc.CodigoProducto,  
		te.flagNueva,
		dbo.fn_ObtenerTallaColorCuv_SB2(E.CUV2,@CampaniaID) as TipoTallaColor,
		4 as TipoEstrategiaImagenMostrar	--Oferta Web
		, E.EtiquetaID		-- SB20-351
		, E.EtiquetaID2		-- SB20-351
	FROM Estrategia E  
	INNER JOIN TipoEstrategia TE ON E.TipoEstrategiaID = TE.TipoEstrategiaID  
	INNER JOIN ods.Campania CA ON E.CampaniaID = CA.Codigo  
	INNER JOIN ods.ProductoComercial PC ON PC.CampaniaID = CA.CampaniaID AND PC.CUV = E.CUV2  
	WHERE  
		E.Activo = 1   
		AND TE.FlagActivo = 1  
		AND E.CampaniaID = @CampaniaID  
		AND TE.flagRecoProduc = 0  
		AND TE.flagNueva = 0  
		AND TE.flagRecoPerfil = 0  
		AND E.Zona LIKE '%' + @ZonaID + '%'  
	ORDER BY 
		te.Orden ASC, 
		e.Orden ASC   
           
	SELECT   
		T.EstrategiaID,  
		T.CUV2,  
		T.DescripcionCUV2,  
		T.EtiquetaDescripcion,  
		T.Precio,  
		T.EtiquetaDescripcion2,  
		T.Precio2,  
		T.TextoLibre,  
		T.FlagEstrella,  
		T.ColorFondo,  
		T.TipoEstrategiaID,  
		T.FotoProducto01,  
		T.ImagenURL,  
		T.LimiteVenta,  
		T.MarcaID,  
		T.Orden1,  
		T.Orden2,  
		T.IndicadorMontoMinimo,  
		M.Descripcion as DescripcionMarca,  
		'NO DISPONIBLE' AS DescripcionCategoria,  
		TE.DescripcionEstrategia AS DescripcionEstrategia,  
		T.FlagNueva, -- R2621   
		T.TipoTallaColor,
		case 
			when UPPER(TE.DescripcionEstrategia) = 'LANZAMIENTO' then 5		--Lanzamiento
			else T.TipoEstrategiaImagenMostrar 
		end as TipoEstrategiaImagenMostrar,
		T.CodigoProducto as CodigoProducto
		, ISNULL(TE.FlagMostrarImg,0) AS FlagMostrarImg		/* SB20-353 */
		, T.EtiquetaID		-- SB20-351
		, T.EtiquetaID2		-- SB20-351
	FROM #TEMPORAL T  
	INNER JOIN TipoEstrategia TE ON TE.TipoEstrategiaID = T.TipoEstrategiaID  
	LEFT JOIN Marca M ON M.MarcaId = T.MarcaId  
	ORDER BY Orden1 ASC, Orden2 ASC, EstrategiaID ASC    
    
	DROP TABLE #TEMPORAL  
  
 SET NOCOUNT OFF  
END  

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConfiguracionProgramaNuevas_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetConfiguracionProgramaNuevas_SB2
GO

CREATE PROCEDURE [dbo].GetConfiguracionProgramaNuevas_SB2
(
	@Campania varchar(50)
)
AS
BEGIN
	
	select 
			 CodigoPrograma
			,CampaniaInicio
			,CampaniaFin
			,IndExigVent
			,IndProgObli
			,CuponKit
			,CUVKit
	from  ods.configuracionProgramaNuevas
	where CampaniaInicio <= @Campania and @Campania <= CampaniaFin

END

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebDetalleByCampania_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetPedidoWebDetalleByCampania_SB2
GO

CREATE PROCEDURE [dbo].GetPedidoWebDetalleByCampania_SB2
 @CampaniaID INT,    
 @ConsultoraID BIGINT    
AS    
/*    
 GetPedidoWebDetalleByCampania 201611, 49627031    
*/    
BEGIN    
 SET NOCOUNT ON    
  -- Depuramos las tallas y colores    
   EXEC DepurarTallaColorCUV @CampaniaID    
   EXEC DepurarTallaColorLiquidacion @CampaniaID    
 /*Para Nuevas obtener el numero de pedido de la consultora.*/  
 DECLARE @NumeroPedido  INT  
 SELECT @NumeroPedido = consecutivonueva + 1  
 FROM ods.Consultora   
 WHERE ConsultoraID=@ConsultoraID  
 /*Revisar si la consultora pertenece al programa Nuevas.*/    
 DECLARE @ProgramaNuevoActivado INT  
 DECLARE @CodigoPrograma  VARCHAR(3)  
   
 SELECT @ProgramaNuevoActivado = COUNT(C.ConsultoraID),   
   @CodigoPrograma = CP.CodigoPrograma  
 FROM ods.Consultora C INNER JOIN ods.ConsultorasProgramaNuevas CP ON C.Codigo = CP.CodigoConsultora  
 WHERE C.ConsultoraID = @ConsultoraID AND CP.Participa = 1  
 GROUP BY C.ConsultoraID, CP.CodigoPrograma  
   
  SELECT pwd.CampaniaID,    
      pwd.PedidoID,     
      pwd.PedidoDetalleID,     
      isnull(pwd.MarcaID,0) as MarcaID,     
      pwd.ConsultoraID,    
      pwd.ClienteID,
	  pwd.OrdenPedidoWD,     
      pwd.Cantidad,     
      pwd.PrecioUnidad,     
      pwd.ImporteTotal,     
      pwd.CUV,   
      pwd.EsKitNueva,   
      CASE    
		WHEN tcl.DescripcionCUV IS NOT NULL THEN TCL.DescripcionCUV     
		ELSE coalesce(EST.DescripcionCUV2 + ' ' + tcc.Descripcion,EST.DescripcionCUV2, mc.Descripcion, OP.Descripcion, pd.Descripcion, pc.Descripcion) END DescripcionProd,   
      c.Nombre,     
      pwd.OfertaWeb,    
      pc.IndicadorMontoMinimo,    
      ISNULL(pwd.ConfiguracionOfertaID,0) ConfiguracionOfertaID,    
      ISNULL(pwd.TipoOfertaSisID,0) TipoOfertaSisID,    
      ISNULL(pwd.TipoPedido, 'W') TipoPedido,    
      CASE    
		WHEN EXISTS(SELECT 1 FROM TALLACOLORCUV T WHERE T.CAMPANIAID = PWD.CAMPANIAID AND T.CUV = PWD.CUV) THEN    
		(    
			  SELECT TOP 1 '[ ' + TE.DescripcionEstrategia + ' ]' FROM OFERTA O     
			  INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID     
			  INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID    
			  INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1  
			  INNER JOIN TallaColorCUV T ON T.CUV = PWD.CUV AND T.CAMPANIAID = PWD.CAMPANIAID        
			  WHERE    
			  TE.FLAGACTIVO = 1     
			 AND O.CODIGOOFERTA = pc.codigotipooferta    
			 AND T.CUV = pwd.CUV    
		)    
		ELSE    
		(    
			 -- SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O     
			 -- INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID     
			 -- INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID    
			 -- INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.CAMPANIAID = PWD.CAMPANIAID  AND E.Activo=1      
			 -- WHERE    
			 -- TE.FLAGACTIVO = 1     
			 --AND O.CODIGOOFERTA = pc.codigotipooferta    
			 --AND E.CUV2 = pwd.CUV 
			 SELECT TOP 1 '[ ' + DescripcionEstrategia + ' ]' FROM OFERTA O     
			  INNER JOIN TIPOESTRATEGIAOFERTA TEO ON O.OfertaID = TEO.OfertaID     
			  INNER JOIN TIPOESTRATEGIA TE ON TE.TIPOESTRATEGIAID = TEO.TIPOESTRATEGIAID    
			  INNER JOIN ESTRATEGIA E ON E.TIPOESTRATEGIAID = TE.TIPOESTRATEGIAID AND E.Activo=1      
			  WHERE 
			  (E.CampaniaID = PWD.CAMPANIAID OR PWD.CAMPANIAID between E.CampaniaID and E.CampaniaIDFin)    			  
			  AND TE.FLAGACTIVO = 1     
			 AND O.CODIGOOFERTA = pc.codigotipooferta    
			 AND E.CUV2 = pwd.CUV   
		)    
		END DescripcionOferta,    
   M.Descripcion AS DescripcionLarga, --R2469  
   'NO DISPONIBLE' AS Categoria, --R2469  
   TE.DescripcionEstrategia as DescripcionEstrategia, --R2469  
	CASE WHEN TE.FlagNueva =1 THEN   
		CASE WHEN @ProgramaNuevoActivado > 0 THEN 1   
		END  
		ELSE 0 END  AS TipoEstrategiaID, -- R2621 -- R2621  
 PC.IndicadorOferta AS IndicadorOfertaCUV  /*R20150701LR*/   
 FROM dbo.PedidoWebDetalle pwd    
	 JOIN ods.ProductoComercial pc ON pwd.CampaniaID = pc.AnoCampania AND pwd.CUV = pc.CUV    
	 LEFT JOIN dbo.Cliente c ON pwd.ClienteID = c.ClienteID AND pwd.ConsultoraID = c.ConsultoraID    
	 LEFT JOIN dbo.ProductoDescripcion pd ON pwd.CampaniaID = pd.CampaniaID AND pwd.CUV = pd.CUV      
	 LEFT JOIN OfertaProducto OP ON OP.CampaniaID = PC.CampaniaID AND OP.CUV = PC.CUV    
	 LEFT JOIN MatrizComercial mc on pc.CodigoProducto = mc.CodigoSAP    
	 LEFT JOIN TallaColorLiquidacion tcl on tcl.CUV = pwd.CUV AND tcl.CampaniaID = pwd.CampaniaID    
	 LEFT JOIN Estrategia EST ON PWD.CampaniaID BETWEEN EST.CampaniaID AND EST.CampaniaIDFin  
			AND (EST.CUV2 = PWD.CUV OR EST.CUV2 = (SELECT CUVPadre FROM TallaColorCUV TCC WHERE TCC.CUV = PWD.CUV)) 
			AND EST.Activo=1 
			AND EST.Numeropedido = (CASE WHEN @ProgramaNuevoActivado = 0 THEN 0 ELSE @NumeroPedido END)   
	 LEFT JOIN dbo.TallaColorCUV tcc ON tcc.cuv = pwd.CUV AND tcc.CampaniaID = pwd.CampaniaID     
	 LEFT JOIN TipoEstrategia TE ON TE.TipoEstrategiaID= EST.TipoEstrategiaID  AND (TE.CodigoPrograma = @CodigoPrograma OR TE.CodigoPrograma IS NULL) 
	 LEFT JOIN Marca M ON pc.MarcaId = M.MarcaId  
 WHERE pwd.CampaniaID = @CampaniaID    
	AND pwd.ConsultoraID = @ConsultoraID AND pwd.CUVPadre IS NULL 
 ORDER BY pwd.OrdenPedidoWD DESC,pwd.PedidoDetalleID DESC    
 SET NOCOUNT OFF    
END   

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DelPedidoWebDetalleMasivo_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].DelPedidoWebDetalleMasivo_SB2
GO

CREATE PROCEDURE [dbo].DelPedidoWebDetalleMasivo_SB2
 @CampaniaID INT,  
 @PedidoID INT
AS  
BEGIN

DECLARE @FechaGeneral DATETIME        
SET @FechaGeneral = dbo.fnObtenerFechaHoraPais() 

declare @TempPedidoCampania table
(
	Id int identity(1,1),
	TipoOfertaSisID int,
	CUV varchar(20),
	Stock int
)

insert into @TempPedidoCampania
select TipoOfertaSisID, CUV, Cantidad
from PedidoWebDetalle
where CampaniaID = @CampaniaID and PedidoID = @PedidoID and TipoOfertaSisID = 1702  
	AND ISNULL(EsKitNueva, '0') != '1'

declare @Cont int
set @Cont = 1

declare @Total int
set @Total = (select count(*) from @TempPedidoCampania)

IF @Total != 0
BEGIN
	WHILE(@Cont <= @Total)
	BEGIN
		declare @T_TipoOfertaSisID int
		declare @T_CUV varchar(20)
		declare	@T_Stock int

		select	@T_TipoOfertaSisID = TipoOfertaSisID, 
				@T_CUV = CUV, 
				@T_Stock = Stock
		from @TempPedidoCampania
		where Id = @Cont

		EXEC UpdStockOfertaProductoDel @T_TipoOfertaSisID, @CampaniaID, @T_CUV, @T_Stock

		set @Cont = @Cont + 1
	END
END

insert into PedidoWebDetalleSeguimiento
(PedidoID, MarcaID, ConsultoraID, CampaniaID, CUV, AccionId, FechaAccion, Cantidad, PrecioUnidad, FechaCreacion,ItemValidado)
select PedidoID, MarcaID, ConsultoraID, CampaniaID, CUV, 401, @FechaGeneral, Cantidad, PrecioUnidad, FechaCreacion,ModificaPedidoReservado
from PedidoWebDetalle
where CampaniaID = @CampaniaID and PedidoID = @PedidoID AND ISNULL(EsKitNueva, '0') != '1'

delete from PedidoWebDetalle
where CampaniaID = @CampaniaID and PedidoID = @PedidoID AND ISNULL(EsKitNueva, '0') != '1'

END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebByFechaFacturacion_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetPedidoWebByFechaFacturacion_SB2
GO

CREATE PROCEDURE [dbo].GetPedidoWebByFechaFacturacion_SB2 --'2014-02-14',1,1
	@FechaFacturacion date,
	@TipoCronograma int,
	@NroLote int
as
BEGIN
set nocount on;

declare @Tipo smallint
if @TipoCronograma = 1
	set @Tipo = (select isnull(ProcesoRegular,0) from [dbo].[ConfiguracionValidacion])
else if @TipoCronograma = 2
	set @Tipo = (select isnull(ProcesoDA,0) from [dbo].[ConfiguracionValidacion])
else
	set @Tipo = (select isnull(ProcesoDAPRD,0) from [dbo].[ConfiguracionValidacion])

if @TipoCronograma = 1
begin

	--declare @ConfValZonaTemp table
	--(
	--	Campaniaid int,
	--	Regionid int,
	--	Zonaid int,
	--	FechaInicioFacturacion smalldatetime,
	--	FechaFinFacturacion smalldatetime
	--)

	--insert into @ConfValZonaTemp
	--select	cr.campaniaid, cr.regionid, cr.zonaid, cr.FechaInicioFacturacion, 
	--		cr.FechaInicioFacturacion + isnull(cz.DiasDuracionCronograma,1) - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(cr.ZonaID, cz.DiasDuracionCronograma, cr.FechaInicioFacturacion),0)
	--from	ods.Cronograma cr
	--left join ConfiguracionValidacionZona cz on cr.zonaid = cz.zonaid
	--where	cr.FechaInicioFacturacion <= @FechaFacturacion and 
	--		cr.FechaInicioFacturacion + 10 >= @FechaFacturacion

	insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
	select @NroLote, p.CampaniaID, p.PedidoID
	from dbo.PedidoWeb p with(nolock)
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	--join @ConfValZonaTemp cr on ca.CampaniaID = cr.CampaniaID
	join ods.Cronograma cr with(nolock) on ca.CampaniaID = cr.CampaniaID
			and c.RegionID = cr.RegionID
			and c.ZonaID = cr.ZonaID
	join (
		select CampaniaID, PedidoID
		from dbo.PedidoWebDetalle with(nolock)
		WHERE isnull(EsKitNueva, '0') != 1
		group by CampaniaID, PedidoID
	) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
	where cr.FechaInicioFacturacion <= @FechaFacturacion
		and cr.FechaInicioReFacturacion >= @FechaFacturacion
		and p.IndicadorEnviado = 0
		and p.Bloqueado = 0
		--and exists(select * from dbo.PedidoWebDetalle with(nolock) where CampaniaID = p.CampaniaID
		--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
		and c.zonaid not in (select Zonaid 
							 from cronograma with(nolock)
						     where CampaniaID = ca.CampaniaID)
		and (p.EstadoPedido = @Tipo OR @Tipo = 0);
end
else
	insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)
	select @NroLote, p.CampaniaID, p.PedidoID
	from dbo.PedidoWeb p with(nolock)
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Campania ca with(nolock) on p.CampaniaID = ca.Codigo
	join dbo.Cronograma cr with(nolock) on ca.CampaniaID = cr.CampaniaID
			and c.RegionID = cr.RegionID
			and c.ZonaID = cr.ZonaID
	join (
		select CampaniaID, PedidoID
		from dbo.PedidoWebDetalle with(nolock)
		WHERE isnull(EsKitNueva, '0') != 1
		group by CampaniaID, PedidoID
	) pd on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
	where cr.FechaInicioWeb <= @FechaFacturacion
		and cr.FechaInicioDD >= @FechaFacturacion
		and p.IndicadorEnviado = 0
		and p.Bloqueado = 0
		--and exists(select * from dbo.PedidoWebDetalle with(nolock) where CampaniaID = p.CampaniaID
		--and PedidoID = p.PedidoID and Cantidad > 0 and PedidoDetalleIDPadre is null)
		and (p.EstadoPedido = @Tipo OR @Tipo = 0);

-- Cabecera de pedidos para descarga
select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
	p.Clientes, r.Codigo as CodigoRegion,
	z.Codigo as CodigoZona,
	--(case p.EstadoPedido when 202 then (case when p.ModificaPedidoReservadoMovil = 0 then 1 else 0 end) else 0 end) as Validado
	case p.EstadoPedido when 202 then 1 else 0 end as Validado
from dbo.PedidoWeb p with(nolock)
	join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	join ods.Region r with(nolock) on c.RegionID = r.RegionID
	join ods.Zona z with(nolock) on c.RegionID = z.RegionID and c.ZonaID = z.ZonaID
where pk.NroLote = @NroLote
order by p.CampaniaID, p.PedidoID;

-- Detalle de pedidos para descarga
select p.PedidoID, p.CampaniaID, c.Codigo as CodigoConsultora,
	pd.CUV as CodigoVenta, pr.CodigoProducto,
	/*case when p.EstadoPedido = 202 and pr.IndicadorDigitable = 1
		then pr.FactorRepeticion * sum(pd.Cantidad)
		else sum(pd.Cantidad) end as Cantidad*/
		sum(pd.Cantidad) as Cantidad
from dbo.PedidoWeb p with(nolock)
	join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID
	join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID
	inner hash join dbo.PedidoWebDetalle pd with(nolock) on p.CampaniaID = pd.CampaniaID and p.PedidoID = pd.PedidoID
		and isnull(pd.EsKitNueva, '0') != 1
	join ods.Campania ca with(nolock) on pd.CampaniaID = ca.Codigo
	join ods.ProductoComercial pr with(nolock) on ca.CampaniaID = pr.CampaniaID and pd.CUV = pr.CUV
where pk.NroLote = @NroLote and pd.PedidoDetalleIDPadre is null
group by p.CampaniaID, p.PedidoID, p.EstadoPedido, c.Codigo,
	pd.CUV, pr.CodigoProducto, pr.IndicadorDigitable, pr.FactorRepeticion
having sum(pd.Cantidad) > 0
order by CampaniaID, PedidoID, CodigoVenta

END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebByCampaniaConsultora_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetPedidoWebByCampaniaConsultora_SB2
GO

CREATE PROCEDURE dbo.GetPedidoWebByCampaniaConsultora_SB2
(
	@CampaniaID int,
	@ConsultoraID int
)
AS
BEGIN

SET NOCOUNT ON;

SELECT 
	CampaniaID,
	PedidoID,
	ConsultoraID,
	FechaRegistro,
	FechaModificacion,
	FechaReserva,
	Clientes,
	ImporteTotal,
	ImporteCredito,
	EstadoPedido,
	ModificaPedidoReservado,
	ISNULL(MotivoCreditoID,0) AS MotivoCreditoID,
	PaisID,
	Bloqueado,
	DescripcionBloqueo,
	CAST(IndicadorEnviado AS INT) AS IndicadorEnviado,
	FechaProceso,
	IPUsuario,
	EstimadoGanancia,
	CodigoUsuarioCreacion,
	CodigoUsuarioModificacion,
	DescuentoProl,
	MontoEscala,
	MontoAhorroCatalogo,
	MontoAhorroRevista
FROM dbo.PedidoWeb
WHERE 
	CampaniaID = @CampaniaID 
	AND ConsultoraID = @ConsultoraID

END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetEscalaDescuento_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetEscalaDescuento_SB2
GO

CREATE PROCEDURE dbo.GetEscalaDescuento_SB2
AS
BEGIN
SELECT MontoHasta, 
	   PorDescuento
FROM ods.EscalaDescuento
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMontosPedidoWeb_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdateMontosPedidoWeb_SB2
GO

create procedure UpdateMontosPedidoWeb_SB2
@CampaniaID int,
@ConsultoraID int,
@MontoAhorroCatalogo money,
@MontoAhorroRevista money,
@MontoDescuento money,
@MontoEscala money
as
begin

update PedidoWeb 
set
	MontoAhorroCatalogo = @MontoAhorroCatalogo,
	MontoAhorroRevista = @MontoAhorroRevista,
	DescuentoProl = @MontoDescuento,
	MontoEscala = @MontoEscala
where CampaniaID = @CampaniaID and ConsultoraID = @ConsultoraID

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidosWebByConsultoraCampania_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetPedidosWebByConsultoraCampania_SB2
GO

create procedure dbo.GetPedidosWebByConsultoraCampania_SB2
@ConsultoraID int,
@CampaniaID int
as
/*
GetPedidosWebByConsultoraCampania 2,201611
*/
begin

SELECT PW.CampaniaID,  
    PW.ImporteTotal,  
    pw.ImporteCredito,  
    ISNULL(pw.MotivoCreditoID,0) MotivoCreditoID,  
    pw.PaisID,  
    PW.Clientes,  
    --est.Descripcion AS EstadoPedidoDesc,  
	'INGRESADO' AS EstadoPedidoDesc,
    PW.ConsultoraID,  
    PW.PedidoID,
	PW.FechaRegistro,
	'WEB' as CanalIngreso,
	SUM(PWD.Cantidad) as CantidadProductos
FROM PedidoWeb PW
INNER JOIN PedidoWebDetalle(NOLOCK) PWD ON 
	PW.PedidoID=PWD.PedidoID
	and PW.ConsultoraID = PWD.ConsultoraID
	and PW.CampaniaID = PWD.CampaniaID
--inner join TablaLogicaDatos est on 
--	est.TablaLogicaDatosID = pw.EstadoPedido
--	and est.TablaLogicaID = 2
WHERE 
	pw.ConsultoraID = @ConsultoraID 
	and	(select count(*) from PedidoWebDetalle where CampaniaID = PW.CampaniaID and ConsultoraID = PW.ConsultoraID) <> 0
	and pw.CampaniaID = @CampaniaID
group by PW.CampaniaID, PW.ImporteTotal, pw.ImporteCredito, ISNULL(pw.MotivoCreditoID,0),pw.PaisID,  
    PW.Clientes, PW.ConsultoraID, PW.PedidoID,	PW.FechaRegistro
end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidosFacturados_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetPedidosFacturados_SB2
GO

create procedure dbo.GetPedidosFacturados_SB2
	@CodigoConsultora VARCHAR(12)
AS
/*
GetPedidosFacturados_SB2 '000758833'
*/
BEGIN

SET NOCOUNT ON 

SELECT top 4
	CA.CODIGO AS CampaniaID,
	isnull(p.FechaFacturado,'1900-01-01') as FechaRegistro,
	P.MontoFacturado AS ImporteTotal,
	isnull(P.Origen,'') as CanalIngreso,
	SUM(PD.Cantidad) as CantidadProductos,
	'FACTURADO' AS EstadoPedidoDesc
FROM ods.Pedido(NOLOCK) P 
INNER JOIN ods.PedidoDetalle(NOLOCK) PD ON 
	P.PedidoID=PD.PedidoID
iNNER JOIN ods.ProductoComercial (nolock) PC ON 
	PD.CampaniaID = PC.CampaniaID 
	and PD.CUV = PC.CUV
INNER JOIN ods.Campania(NOLOCK) CA ON 
	P.CampaniaID=CA.CampaniaID
INNER JOIN ods.Consultora(NOLOCK) CO ON 
	P.ConsultoraID=CO.ConsultoraID
WHERE 
	co.Codigo=@CodigoConsultora
GROUP BY 
	P.PedidoID,CA.Codigo,P.MontoFacturado,P.Origen,P.Flete,p.FechaFacturado
ORDER BY 
	CA.Codigo desc   

SET NOCOUNT OFF

END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetFechaVencimiento_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetFechaVencimiento_SB2
GO

create procedure dbo.GetFechaVencimiento_SB2
@CodigoIso varchar(2),
@CampaniaID int,
@CodigoConsultora varchar(20)
as
/*
dbo.GetFechaVencimiento_SB2 'PE',201611,'000758833'
*/
begin

select top 1
	FEC_VENC
from ods.INT_SOA_COBRA_DEUDA_SECCI
where COD_PAIS = @CodigoIso and COD_PERI = @CampaniaID and COD_CLIE = @CodigoConsultora

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsPedidoWebDetalle_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].InsPedidoWebDetalle_SB2
GO

CREATE PROCEDURE [dbo].InsPedidoWebDetalle_SB2
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@ClienteID smallint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@PedidoID int,
	@OfertaWeb bit,
	@ConfiguracionOfertaID int,
	@TipoOfertaSisID int,
	@PedidoDetalleID smallint output,
	@CodigoUsuarioCreacion varchar(25) = null,
	@SubTipoOfertaSisID smallint = null,
	@EsSugerido bit,
	@EskitNueva bit = 0
AS	
BEGIN
	declare @orden int = 0

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		, @orden = max(ISNULL(OrdenPedidoWD,0))
	FROM dbo.PedidoWebDetalle 
	WHERE 
		CampaniaID = @CampaniaID
		AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @orden = ISNULL(@orden, 0) + 1

	INSERT INTO dbo.PedidoWebDetalle 
	(CampaniaID, PedidoID, PedidoDetalleID, MarcaID, ConsultoraID, ClienteID, Cantidad, PrecioUnidad, 
	ImporteTotal, CUV, OfertaWeb, ModificaPedidoReservado, ConfiguracionOfertaID, TipoOfertaSisID, 
	CodigoUsuarioCreacion, FechaCreacion, SubTipoOfertaSisID, EsSugerido, EskitNueva, OrdenPedidoWD)
	VALUES 
	(@CampaniaID, @PedidoID, @PedidoDetalleID, @MarcaID, @ConsultoraID, @ClienteID, @Cantidad, @PrecioUnidad, 
	@Cantidad*@PrecioUnidad, @CUV, @OfertaWeb, 0, @ConfiguracionOfertaID, @TipoOfertaSisID, 
	@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(),@SubTipoOfertaSisID, @EsSugerido, @EskitNueva, @orden)

END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdPedidoWebDetalle_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].UpdPedidoWebDetalle_SB2
GO

CREATE PROCEDURE dbo.UpdPedidoWebDetalle_SB2
	@CampaniaID INT,
	@PedidoID INT,
	@PedidoDetalleID SMALLINT,
	@Cantidad INT,
	@PrecioUnidad MONEY,
	@ClienteID SMALLINT,
	@CodigoUsuarioModificacion varchar(25) = null,
	@EsSugerido bit,
	@OrdenPedidoWD int = 0
AS
BEGIN
	
	if @OrdenPedidoWD = 1
	begin
		
		SELECT @OrdenPedidoWD = max(ISNULL(OrdenPedidoWD,0))
		FROM dbo.PedidoWebDetalle 
		WHERE 
			CampaniaID = @CampaniaID
			AND PedidoID = @PedidoID

		set @OrdenPedidoWD = ISNULL(@OrdenPedidoWD, 0) + 1
	end
	else 
		set @OrdenPedidoWD = 0

	UPDATE dbo.PedidoWebDetalle
	SET	ClienteID = @ClienteID,
		Cantidad = @Cantidad,
		ImporteTotal = @Cantidad*@PrecioUnidad,
		CodigoUsuarioModificacion = @CodigoUsuarioModificacion,
		FechaModificacion = dbo.fnObtenerFechaHoraPais(),
		TipoPedido = CASE WHEN TipoPedido = 'M' THEN 'X' ELSE TipoPedido END,
		EsSugerido = @EsSugerido,
		OrdenPedidoWD = case when @OrdenPedidoWD > 0 then @OrdenPedidoWD else OrdenPedidoWD end
	WHERE
		CampaniaID = @CampaniaID
		AND	PedidoID = @PedidoID
		AND	PedidoDetalleID = @PedidoDetalleID

END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetConsultorasProgramaNuevas_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetConsultorasProgramaNuevas_SB2
GO

CREATE PROCEDURE dbo.GetConsultorasProgramaNuevas_SB2
	@CodigoConsultora varchar(50),
	@Campania varchar(10),
	@CodigoPrograma varchar(5)
AS

BEGIN

SELECT 
	Campania
	,CodigoConsultora
	,CodigoPrograma
	,Participa
	,Motivo
	,MontoVentaExigido
FROM ods.ConsultorasProgramaNuevas
WHERE CodigoConsultora = @CodigoConsultora
	AND Campania = @Campania
	AND CodigoPrograma = @CodigoPrograma

END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMensajeMetaConsultoras_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetMensajeMetaConsultoras_SB2
GO

CREATE PROCEDURE dbo.GetMensajeMetaConsultoras_SB2
	@TipoMensaje varchar(50) = ''
AS

BEGIN
		set @TipoMensaje = isnull(@TipoMensaje, '')

		SELECT 
			TipoMensaje
			,Titulo
			,Mensaje
		FROM dbo.MensajeMetaConsultora
		WHERE TipoMensaje = @TipoMensaje or @TipoMensaje = ''

END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidosIngresadoFacturado_SB2]') AND type in (N'P', N'PC')) 
 DROP PROCEDURE [dbo].[GetPedidosIngresadoFacturado_SB2]
GO

-- GetPedidosIngresadoFacturado_SB2 2, 201612

/*
 unión de estas dos store
exec GetPedidosWebByConsultoraCampania 2, 201612
exec GetPedidosFacturados '000758833'
*/

create procedure dbo.GetPedidosIngresadoFacturado_SB2
	@ConsultoraID int,
	@CampaniaID int,
	@top int = 5
AS
begin

--declare @ConsultoraID int = 2,
--@CampaniaID int = 201612,

set @top = isnull(@top, 5)
if @top <= 0
	set @top = 5

DECLARE @T1 TABLE (
id int identity(1,1)
, EstadoPedido varchar(1)
, CampaniaID int 
, ImporteTotal money
, Flete money
, ImporteCredito money
, MotivoCreditoID int
, PaisID int
, Clientes smallint
, EstadoPedidoDesc varchar(12)
, ConsultoraID bigint
, PedidoID int
, FechaRegistro datetime
, CanalIngreso varchar(12)
, CantidadProductos int
)

-- agregar ingresados

INSERT INTO @T1
select top (@top) 
	'I' as EstadoPedido,
	PW.CampaniaID,  
    PW.ImporteTotal,  
	0 Flete,
    pw.ImporteCredito,  
    ISNULL(pw.MotivoCreditoID,0) MotivoCreditoID,  
    pw.PaisID,  
    PW.Clientes, 
	'INGRESADO' AS EstadoPedidoDesc,
    PW.ConsultoraID,  
    PW.PedidoID,
	PW.FechaRegistro,
	'WEB' as CanalIngreso,
	SUM(PWD.Cantidad) as CantidadProductos
FROM PedidoWeb PW
INNER JOIN PedidoWebDetalle(NOLOCK) PWD ON 
	PW.PedidoID=PWD.PedidoID
	and PW.ConsultoraID = PWD.ConsultoraID
	and PW.CampaniaID = PWD.CampaniaID
WHERE 
	pw.ConsultoraID = @ConsultoraID 
	and pw.CampaniaID <> @CampaniaID
	and	(select count(*) from PedidoWebDetalle(NOLOCK) where CampaniaID = PW.CampaniaID and ConsultoraID = PW.ConsultoraID) <> 0
group by PW.CampaniaID, PW.ImporteTotal, pw.ImporteCredito, ISNULL(pw.MotivoCreditoID,0),pw.PaisID,  
    PW.Clientes, PW.ConsultoraID, PW.PedidoID,	PW.FechaRegistro
ORDER BY 
	PW.CampaniaID desc 

-- agregar facturado

INSERT INTO @T1
SELECT top (@top) 
	'F',
	CA.CODIGO AS CampaniaID,
	P.MontoFacturado AS ImporteTotal,
	P.Flete,
	0 ImporteCredito,
	0 MotivoCreditoID,
	0 PaisID,
	'' Clientes,
	'FACTURADO' AS EstadoPedidoDesc,
	0 ConsultoraID,
	0 PedidoID,
	isnull(p.FechaFacturado,'1900-01-01') as FechaRegistro,
	isnull(P.Origen,'') as CanalIngreso,
	SUM(PD.Cantidad) as CantidadProductos
FROM ods.Pedido(NOLOCK) P 
INNER JOIN ods.PedidoDetalle(NOLOCK) PD ON 
	P.PedidoID=PD.PedidoID
iNNER JOIN ods.ProductoComercial (nolock) PC ON 
	PD.CampaniaID = PC.CampaniaID 
	and PD.CUV = PC.CUV
INNER JOIN ods.Campania(NOLOCK) CA ON 
	P.CampaniaID=CA.CampaniaID
INNER JOIN ods.Consultora(NOLOCK) CO ON 
	P.ConsultoraID=CO.ConsultoraID
WHERE 
	co.ConsultoraID=@ConsultoraID
	and	P.CampaniaID <> @CampaniaID
GROUP BY 
	P.PedidoID,CA.Codigo,P.MontoFacturado,P.Origen,P.Flete,p.FechaFacturado
ORDER BY 
	CA.Codigo desc 

-- eliminar repetido, <> @CampaniaID, prioridad F
delete @T1
FROM @T1 T
		INNER JOIN (
		select CampaniaID, count(EstadoPedido) AS CantEstado
		from @T1
		where CampaniaID <> @CampaniaID
		group by CampaniaID
		having count(EstadoPedido) > 1
) AS R
ON R.CampaniaID = T.CampaniaID AND T.EstadoPedido <> 'F'

SELECT top (@top)
 CampaniaID  
, ImporteTotal 
, Flete
, ImporteCredito 
, MotivoCreditoID 
, PaisID 
, Clientes 
, EstadoPedidoDesc 
, ConsultoraID 
, PedidoID
, FechaRegistro
, CanalIngreso 
, CantidadProductos 
FROM @T1 order by CampaniaID desc


end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoCUVmarquesina_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetPedidoCUVmarquesina_SB2]
GO

CREATE PROCEDURE [dbo].[GetPedidoCUVmarquesina_SB2]
	@CampaniaID int,
	@ConsultoraID bigint,
	@CUV varchar(10)
AS
BEGIN
	select 
		Isnull(CUV,'') as CUV,
		ISNULL(Cantidad, '0') as Cantidad,
		ISNULL(PedidoDetalleID, '') PedidoWebDetalleID,
		ISNULL(PedidoID, '') PedidoID
	from [dbo].[PedidoWebDetalle] WITH (NOLOCK)
	WHERE 
		CampaniaID = @CampaniaID 
		AND ConsultoraID = @ConsultoraID 
		and CUV = @CUV
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsPedidoWebDetalleOferta_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsPedidoWebDetalleOferta_SB2]
GO

CREATE PROCEDURE [dbo].[InsPedidoWebDetalleOferta_SB2]
	@CampaniaID int,
	@ConsultoraID int,
	@MarcaID tinyint,
	@Cantidad int,
	@PrecioUnidad money,
	@CUV varchar(20),
	@ConfiguracionOfertaID INT,
	@TipoOfertaSisID INT,
	@PaisID int,
	@IPUsuario varchar(25) = null,
	@CodigoUsuarioCreacion varchar(25) = null
AS
BEGIN
DECLARE @PedidoDetalleID INT;
DECLARE @PedidoID  INT = 0;
DECLARE @OfertaWeb INT  = 1;
DECLARE @ExisteDet INT = 0;
DECLARE @Orden INT=0;

	EXEC [dbo].[InsPedidoWebOferta] @CampaniaID, @ConsultoraID , @PaisID, @IPUsuario, @CodigoUsuarioCreacion;

	SELECT @PedidoID = PedidoID FROM dbo.PedidoWeb WHERE CampaniaID = @CampaniaID AND ConsultoraID = @ConsultoraID;

	SELECT @PedidoDetalleID = MAX(ISNULL(PedidoDetalleID,0))
		   , @Orden = max(ISNULL(OrdenPedidoWD,0))
		   FROM dbo.PedidoWebDetalle 
		   WHERE CampaniaID = @CampaniaID AND PedidoID = @PedidoID
	
	SET @PedidoDetalleID = ISNULL(@PedidoDetalleID, 0) + 1
	SET @Orden = ISNULL(@Orden, 0) + 1

	--SET @PedidoDetalleID =	(SELECT ISNULL(MAX(PedidoDetalleID),0) + 1 
	--							FROM	dbo.PedidoWebDetalle 
	--							WHERE	CampaniaID = @CampaniaID AND
	--									PedidoID = @PedidoID);

	/* Validar Al Agregar Nuevamente */
	set @ExisteDet = (select count(*) from PedidoWebDetalle 
						where CampaniaID = @CampaniaID 
							  AND PedidoID = @PedidoID
							  AND CUV = @CUV
							  AND ClienteID IS NULL);

	IF @ExisteDet = 0 
		BEGIN
			INSERT INTO dbo.PedidoWebDetalle 
			(
			 CampaniaID,
			 PedidoID,
			 PedidoDetalleID,
			 MarcaID,
			 ConsultoraID,
			 ClienteID,
			 Cantidad,
			 PrecioUnidad,
			 ImporteTotal,
			 CUV,
			 OfertaWeb, 
			 ModificaPedidoReservado,
			 ConfiguracionOfertaID,
			 TipoOfertaSisID,
			 CodigoUsuarioCreacion,
			 FechaCreacion,
			 OrdenPedidoWD
			)

		VALUES (@CampaniaID,@PedidoID,@PedidoDetalleID,
				@MarcaID,@ConsultoraID,NULL,
				@Cantidad,@PrecioUnidad,@Cantidad*@PrecioUnidad,@CUV,@OfertaWeb,0, @ConfiguracionOfertaID, @TipoOfertaSisID,
				@CodigoUsuarioCreacion, dbo.fnObtenerFechaHoraPais(), @Orden)
		END
	ELSE
		BEGIN
			UPDATE dbo.PedidoWebDetalle
				SET Cantidad += @Cantidad,
					ImporteTotal = ((Cantidad + @Cantidad) * @PrecioUnidad),
					CodigoUsuarioModificacion = @CodigoUsuarioCreacion,
					FechaModificacion = dbo.fnObtenerFechaHoraPais(),
					OrdenPedidoWD = @Orden
			WHERE CampaniaID = @CampaniaID 
				  AND PedidoID = @PedidoID
				  AND CUV = @CUV
				  AND ClienteID IS NULL		
		END
END

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertarEstrategia_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarEstrategia_SB2]
GO

CREATE PROCEDURE [dbo].[InsertarEstrategia_SB2]
	@EstrategiaID int,
	@TipoEstrategiaID int,
	@CampaniaID int,
	@CampaniaIDFin int,
	@NumeroPedido int,
	@Activo bit,
	@ImagenURL varchar(800),
	@LimiteVenta int,
	@DescripcionCUV2 varchar(800),
	@FlagDescripcion bit,
	@CUV varchar(20),
	@EtiquetaID int,
	@Precio numeric(12,2),
	@FlagCEP bit,
	@CUV2 varchar(20),
	@EtiquetaID2 int,
	@Precio2 numeric(12,2),
	@FlagCEP2 bit,
	@TextoLibre varchar(800),
	@FlagTextoLibre bit,
	@Cantidad int,
	@FlagCantidad bit,
	@Zona varchar(8000),
	@Orden int,
	@UsuarioCreacion varchar(100),
	@UsuarioModificacion varchar(100),
	@ColorFondo varchar(20),
	@FlagEstrella bit
AS
BEGIN
	SET NOCOUNT ON
		BEGIN TRY
			IF NOT EXISTS(SELECT 1 FROM Estrategia WHERE EstrategiaID = @EstrategiaID)
			BEGIN

				IF EXISTS(SELECT 1 FROM ESTRATEGIA WHERE CUV2 = @CUV2 AND CAMPANIAID = @CampaniaID AND TIPOESTRATEGIAID = @TipoEstrategiaID AND NUMEROPEDIDO = @NumeroPedido)
				BEGIN
					RAISERROR('El valor de cuv2 a registrar ya existe para el tipo de estrategia y campaña seleccionado.', 16, 1)
				END

				IF (@TipoEstrategiaID NOT IN (3009) AND ISNULL(@Orden,0) > 0)	-- SB20-312
				BEGIN
					IF EXISTS(SELECT 1 FROM ESTRATEGIA WHERE Orden = @Orden AND CAMPANIAID = @CampaniaID AND TIPOESTRATEGIAID = @TipoEstrategiaID AND NUMEROPEDIDO = @NumeroPedido)
					BEGIN
						RAISERROR('El orden ingresado para la estrategia ya está siendo utilizado.', 16, 1)
					END
				END

			    INSERT INTO dbo.Estrategia
			    (TipoEstrategiaID, CampaniaID, CampaniaIDFin, NumeroPedido, Activo, ImagenURL, LimiteVenta, DescripcionCUV2
				,FlagDescripcion, CUV, EtiquetaID, Precio, FlagCEP, CUV2, EtiquetaID2, Precio2
				,FlagCEP2, TextoLibre, FlagTextoLibre, Cantidad, FlagCantidad, Zona, Orden, UsuarioCreacion, FechaCreacion, ColorFondo, FlagEstrella )
				VALUES
			   (@TipoEstrategiaID,@CampaniaID,@CampaniaIDFin,@NumeroPedido,@Activo,@ImagenURL,@LimiteVenta,@DescripcionCUV2
				,@FlagDescripcion,@CUV,@EtiquetaID,@Precio,@FlagCEP,@CUV2,@EtiquetaID2,@Precio2
				,@FlagCEP2,@TextoLibre,@FlagTextoLibre,@Cantidad,@FlagCantidad,@Zona,@Orden,@UsuarioCreacion,GETDATE(), @ColorFondo, @FlagEstrella)
			END
			ELSE
			BEGIN

				IF EXISTS(SELECT 1 FROM ESTRATEGIA WHERE CUV2 = @CUV2 AND CAMPANIAID = @CampaniaID AND TIPOESTRATEGIAID = @TipoEstrategiaID AND ESTRATEGIAID <> @EstrategiaID  AND NUMEROPEDIDO = @NumeroPedido)
				BEGIN
					RAISERROR('El valor de cuv2 a registrar ya existe para el tipo de estrategia y campaña seleccionado.', 16, 1)
				END
				 
				IF (@TipoEstrategiaID NOT IN (3009) AND ISNULL(@Orden,0) > 0)		-- SB20-312
				BEGIN
					IF EXISTS(SELECT 1 FROM ESTRATEGIA WHERE Orden = @Orden AND CAMPANIAID = @CampaniaID AND TIPOESTRATEGIAID = @TipoEstrategiaID  AND ESTRATEGIAID <> @EstrategiaID AND NUMEROPEDIDO = @NumeroPedido)
					BEGIN
						RAISERROR('El orden ingresado para la estrategia ya está siendo utilizado.', 16, 1)
					END
				END
				
				DECLARE @CantidadYaSolicitada INT
				SELECT @CantidadYaSolicitada = Cantidad FROM PEDIDOWEBDETALLE WHERE CUV = @CUV AND CampaniaID = @CampaniaID
				IF @LimiteVenta < @CantidadYaSolicitada
				BEGIN
					DECLARE @mensaje VARCHAR(2000)
					SET @mensaje = 'No se puede reducir el limite de venta por que ya se hicieron ' + convert(varchar, @CantidadYaSolicitada) + ' pedido(s) de éste producto.'
					RAISERROR(@mensaje, 16, 1)
				END

				UPDATE Estrategia SET
					TipoEstrategiaID= @TipoEstrategiaID,
					CampaniaID= 	  @CampaniaID,
					CampaniaIDFin= 	  @CampaniaIDFin,
					NumeroPedido= 	  @NumeroPedido,
					Activo= 		  @Activo,
					ImagenURL= 		  @ImagenURL,
					LimiteVenta= 	  @LimiteVenta, 
					DescripcionCUV2=  @DescripcionCUV2,
					FlagDescripcion=  @FlagDescripcion ,
					CUV= 			  @CUV,
					EtiquetaID= 	  @EtiquetaID,
					Precio= 		  @Precio,
					FlagCEP= 		  @FlagCEP, 
					CUV2= 			  @CUV2,
					EtiquetaID2= 	  @EtiquetaID2,
					Precio2=		  @Precio2,
					FlagCEP2= 		  @FlagCEP2, 
					TextoLibre= 	  @TextoLibre, 
					FlagTextoLibre=   @FlagTextoLibre,
					Cantidad= 		  @Cantidad,
					FlagCantidad= 	  @FlagCantidad,
					Zona= 			  @Zona,
					Orden= 			  @Orden,
					UsuarioModificacion	=  @UsuarioModificacion,
					FechaModificacion	= GETDATE(),
					ColorFondo			= @ColorFondo, 
					FlagEstrella		= @FlagEstrella
				WHERE EstrategiaID = @EstrategiaID
			END
		END TRY
		BEGIN CATCH
			DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT
			SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()
			RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)
		END CATCH
	SET NOCOUNT OFF
END

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertarTipoEstrategia_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsertarTipoEstrategia_SB2]
GO

CREATE PROCEDURE [dbo].[InsertarTipoEstrategia_SB2]  
 @TipoEstrategiaID  INT,  
 @DescripcionEstrategia VARCHAR(200),  
 @ImagenEstrategia  VARCHAR(500),  
 @Orden     INT,  
 @FlagActivo    BIT,  
 @UsuarioRegistro  VARCHAR(100),  
 @UsuarioModificacion VARCHAR(100),  
 @OfertaID    VARCHAR(8000),  
 @FlagNueva    INT,  
 @FlagRecoPerfil   INT,  
 @FlagRecoProduc   INT,
 @CodigoPrograma VARCHAR(3),
 @FlagMostrarImg TINYINT	/* SB20-353 */
AS  
BEGIN  
 SET NOCOUNT ON  
  BEGIN TRY  
  DECLARE @TipoEstrategiaIdAux INT  
  IF EXISTS(SELECT 1 FROM TipoEstrategia WHERE TipoEstrategiaID = @TipoEstrategiaID)  
   BEGIN  
    IF EXISTS(SELECT 1 FROM TipoEstrategia WHERE REPLACE(DescripcionEstrategia, ' ', '') = REPLACE(@DescripcionEstrategia, ' ', '') AND TipoEstrategiaID <> @TipoEstrategiaID)  
    BEGIN  
     RAISERROR('El Nombre del tipo estrategia ya existe.', 16, 1)  
    END  
    IF EXISTS(SELECT 1 FROM TipoEstrategia WHERE orden = @Orden AND TipoEstrategiaID <> @TipoEstrategiaID AND @FlagNueva <> 1)  
    BEGIN  
     RAISERROR('El order indicado ya existe.', 16, 1)  
    END 
    IF EXISTS(SELECT 1 FROM TipoEstrategia WHERE orden = @Orden AND CodigoPrograma = @CodigoPrograma AND TipoEstrategiaID <> @TipoEstrategiaID AND FlagNueva = 1)  
    BEGIN  
     RAISERROR('El Código de programa ya existe.', 16, 1)  
    END   
    UPDATE TipoEstrategia SET  
     DescripcionEstrategia = @DescripcionEstrategia,  
     ImagenEstrategia	= @ImagenEstrategia,  
     Orden				= @Orden,  
     FlagActivo			= @FlagActivo,  
     UsuarioModificacion  = @UsuarioModificacion,  
     FechaModificacion  = GETDATE(),  
     flagNueva			= @FlagNueva,  
     flagRecoProduc		= @FlagRecoProduc,  
     flagRecoPerfil		= @FlagRecoPerfil ,
     CodigoPrograma		= @CodigoPrograma
	 , FlagMostrarImg	= @FlagMostrarImg	/* SB20-353 */
    WHERE  
     TipoEstrategiaID  = @TipoEstrategiaID  
    SET @TipoEstrategiaIdAux = @TipoEstrategiaID  
   
    /*R20160301*/
    --IF @CodigoPrograma IS NOT NULL OR @CodigoPrograma != '' 
    IF @CodigoPrograma != '' 
	BEGIN
				
		UPDATE Oferta 
		SET  CodigoPrograma = @CodigoPrograma
		FROM Oferta O
			INNER JOIN TipoEstrategiaOferta TEO ON O.OfertaID = TEO.OfertaID
			INNER JOIN TipoEstrategia TE ON TEO.TipoEstrategiaID = TE.TipoEstrategiaID
		WHERE TE.TipoEstrategiaID = @TipoEstrategiaIdAux 
		
		DELETE FROM TipoEstrategiaOferta WHERE TipoEstrategiaID = @TipoEstrategiaIdAux  
		
		INSERT INTO TipoEstrategiaOferta
		SELECT @TipoEstrategiaIdAux, OfertaID 
		FROM Oferta 
		WHERE CodigoOferta IN (SELECT * FROM dbo.fnSplit(@OfertaID,',')) AND CodigoPrograma =   @CodigoPrograma
		
	END								
	ELSE
	BEGIN  
	
		DELETE FROM TipoEstrategiaOferta WHERE TipoEstrategiaID = @TipoEstrategiaIdAux  
	    INSERT INTO TipoEstrategiaOferta  
		SELECT @TipoEstrategiaIdAux, OfertaID FROM Oferta WHERE CodigoOferta IN (SELECT * FROM dbo.fnSplit(@OfertaID,','))  
    END
    
   END  
   ELSE  
   BEGIN  
    IF EXISTS(SELECT 1 FROM TipoEstrategia WHERE REPLACE(DescripcionEstrategia, ' ', '') = REPLACE(@DescripcionEstrategia, ' ', ''))  
    BEGIN  
     RAISERROR('El Nombre de la estrategia ya existe.', 16, 1)  
    END  
    IF EXISTS(SELECT 1 FROM TipoEstrategia WHERE orden = @Orden AND @FlagNueva <> 1)  
    BEGIN  
     RAISERROR('El orden indicado ya existe.', 16, 1)  
    END  
    IF EXISTS(SELECT 1 FROM TipoEstrategia WHERE orden = @Orden AND TipoEstrategiaID <> @TipoEstrategiaID AND CodigoPrograma = @CodigoPrograma)  
    BEGIN  
     RAISERROR('El Código de programa ya existe.', 16, 1)  
    END  
    
    INSERT INTO TipoEstrategia VALUES (@DescripcionEstrategia, @ImagenEstrategia, @Orden, @FlagActivo, @UsuarioRegistro, GETDATE(), NULL, NULL, @FlagNueva, @FlagRecoProduc, @FlagRecoPerfil, @CodigoPrograma
	, @FlagMostrarImg)	/* SB20-353 */  
    SET @TipoEstrategiaIdAux = @@IDENTITY 
    /*R20160301*/
    --IF @CodigoPrograma IS NOT NULL OR @CodigoPrograma != '' 
    IF @CodigoPrograma != '' 
	BEGIN 
		INSERT INTO TipoEstrategiaOferta  
		SELECT @TipoEstrategiaIdAux, OfertaID FROM Oferta WHERE CodigoOferta IN (SELECT * FROM dbo.fnSplit(@OfertaID,',')) AND CodigoPrograma =   @CodigoPrograma		
	END
    ELSE
    BEGIN
    	INSERT INTO TipoEstrategiaOferta  
		SELECT @TipoEstrategiaIdAux, OfertaID FROM Oferta WHERE CodigoOferta IN (SELECT * FROM dbo.fnSplit(@OfertaID,','))  
    END
   END  
  END TRY  
  BEGIN CATCH  
   DECLARE @ErrorMessage NVARCHAR(4000), @ErrorSeverity INT, @ErrorState INT  
   SELECT @ErrorMessage = ERROR_MESSAGE(), @ErrorSeverity = ERROR_SEVERITY(), @ErrorState = ERROR_STATE()  
   RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)     
  END CATCH  
 SET NOCOUNT OFF  
END 

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ListarTipoEstrategia_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ListarTipoEstrategia_SB2]
GO

CREATE PROCEDURE [dbo].[ListarTipoEstrategia_SB2]  
 @TipoEstrategiaID INT  
AS  
BEGIN  
/*  
 EXEC ListarTipoEstrategia 0  
*/  
 SET NOCOUNT ON  
  SELECT   
   TipoEstrategiaID,   
   DescripcionEstrategia,   
   dbo.ObtenerDescripcionOferta(TipoEstrategiaID) DescripcionOferta,   
   Orden,   
   FlagActivo,   
   CodigoPrograma,
   dbo.ObtenerOfertaID(TipoEstrategiaID) OfertaID,  
   ImagenEstrategia,  
   FlagNueva,  
   FlagRecoPerfil,  
   FlagRecoProduc  
   , ISNULL(FlagMostrarImg,0) AS FlagMostrarImg 		/* SB20-353 */
  FROM   
   TipoEstrategia  
  WHERE  
   TipoEstrategiaID = @TipoEstrategiaID OR 0 = @TipoEstrategiaID  
  ORDER BY Orden, DescripcionEstrategia ASC  
 SET NOCOUNT OFF  
END 

GO

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPaginateProductoSugerido_SB2]') AND type in (N'P', N'PC')) 
 DROP PROCEDURE [dbo].[GetPaginateProductoSugerido_SB2]
GO

-- test GetPaginateProductoSugerido null, '02769', '00004'
CREATE PROCEDURE [dbo].[GetPaginateProductoSugerido_SB2]
	@CampaniaID	INT,
	@CuvAgotado		VARCHAR(20),
	@CuvSugerido	VARCHAR(20)
AS
BEGIN
SET NOCOUNT ON
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CuvAgotado = isnull(@CuvAgotado, '')
	set @CuvSugerido = isnull(@CuvSugerido, '')

	SELECT 
		 ps.ProductoSugeridoID
		,ps.CampaniaID
		,ps.CUV
		,ps.CUVSugerido
		,ps.Orden
		,ps.ImagenProducto
		,ps.Estado
		,ps.UsuarioRegistro
		,ps.FechaRegistro
		,ps.UsuarioModificacion
		,ps.FechaModificacion
		,pc.CodigoProducto
	FROM dbo.ProductoSugerido ps
		inner join ods.campania c on c.Codigo = ps.CampaniaID
		left join ods.productocomercial pc on pc.CUV = ps.CUVSugerido
			and pc.CampaniaID = c.CampaniaID
	WHERE
		( ps.CampaniaID = @CampaniaID or @CampaniaID = 0 ) 
		and ps.CUV like '%' + @CuvAgotado + '%'
		and ps.CuvSugerido like '%' + @CuvSugerido  + '%'
		and ps.Estado = 1
	order by ps.CampaniaID, ps.CUV, ps.Orden
	
SET NOCOUNT OFF
END

go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetImagenesByCUV_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[GetImagenesByCUV_SB2]
GO

CREATE PROCEDURE [dbo].[GetImagenesByCUV_SB2]
(
	@CampaniaID int,
	@CUV varchar(50)
)
AS
BEGIN
	
	set @CampaniaID = isnull(@CampaniaID, 0)
	set @CUV = isnull(@CUV, '')

	SELECT isnull(mc.IdMatrizComercial,0)IdMatrizComercial,
		   mc.CodigoSAP,
		   isnull(mc.FotoProducto01,'') FotoProducto01,
		   isnull(mc.FotoProducto02,'') FotoProducto02,
		   isnull(mc.FotoProducto03,'') FotoProducto03,
		   ISNULL(mc.Descripcion,'') Descripcion,
		   pc.CUV,
		   pc.IndicadorDigitable,
		   pc.EstadoActivo
	FROM MatrizComercial mc
		inner join ods.productocomercial pc on pc.CodigoProducto  = mc.CodigoSAP
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where pc.CUV = @CUV
		and c.Codigo = @CampaniaID 
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ValidProductoSugerido_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[ValidProductoSugerido_SB2]
GO


CREATE PROCEDURE [dbo].[ValidProductoSugerido_SB2]
(
	 @Return varchar(1000) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@Usuario varchar(50)
)
AS
BEGIN
	set @Return = ''
	
	set @ProductoSugeridoID = isnull(@ProductoSugeridoID, 0)
	set @CampaniaID = isnull(@CampaniaID, '')
	set @CUV = isnull(@CUV, '')
	set @CUVSugerido = isnull(@CUVSugerido, '')
	set @Orden = isnull(@Orden, '')
	set @ImagenProducto = isnull(@ImagenProducto, '')
	set @Estado = isnull(@Estado,-1)
	set @Usuario = isnull(@Usuario, '')

	if @ProductoSugeridoID <= 0 
		set @ProductoSugeridoID = 0
	if @Estado < 0 
		set @Estado = -1

	-- Que se hayan ingresado todos los datos
	if @CampaniaID = '' or @CUV = '' or @CUVSugerido = '' or @Orden = '' or @Estado = -1
	begin
		set @Return = '-1|La información ingresada se encuentra incompleta. Por favor, revisar.'	
		return 0
	end

	-- Que el CUV Agotado exista para la campaña y que sea digitable.
	declare @digita int = -1, @activo int = -1
	
	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUV

	set @digita = isnull(@digita, -1)
	if @digita = -1 or @digita = 0
	begin
		set @Return = '-2|El CUV Agotado no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido exista para la campaña, sea digitable y se encuentre activo.	
	set @digita = -1	
	set @activo = -1

	SELECT @digita = pc.IndicadorDigitable,
		   @activo = pc.EstadoActivo
	FROM ods.productocomercial pc
		inner join ods.campania c on c.CampaniaID = pc.CampaniaID
	where c.Codigo = @CampaniaID
	and  pc.CUV = @CUVSugerido
	
	set @digita = isnull(@digita, -1)
	set @activo = isnull(@activo, -1)
	if @digita = -1 or @digita = 0 or @activo = -1 or @activo = 0
	begin
		set @Return = '-3|El CUV Sugerido no existe para la campaña.'		
		return 0
	end

	-- Que el CUV Sugerido no esté como faltante anunciado ni como producto faltante.
	set @activo = 1

	select @activo= count(1)
	from dbo.productofaltante
	where  CampaniaID = @CampaniaID
		and cuv = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'
		return 0
	end

	set @activo = 1
	select @activo= count(1)
	from ods.faltanteanunciado fa
		inner join ods.campania c on c.CampaniaID = fa.CampaniaID
	where c.Codigo = @CampaniaID
		and  fa.codigoVenta = @CUVSugerido
	
	set @activo = isnull(@activo, 1)
	if @activo > 0
	begin
		set @Return = '-4|El CUV Sugerido está configurado como faltante anunciado o producto faltante.'		
		return 0
	end

	-- Que el CUV Sugerido sea diferente al CUV Agotado
	if @CUV = @CUVSugerido
	begin
		set @Return = '-5|El CUV Sugerido debe ser diferente al CUV Agotado.'
		return 0
	end

	-- Que no se haya cargado previamente el mismo CUV Sugerido para el mismo CUV Agotado
	set @activo = 0

	select @activo = ProductoSugeridoID
	-- select *
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		and ps.CUVSugerido = @CUVSugerido
		and ps.Estado = 1
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0 )
	begin
		set @Return = '-6|El CUV Sugerido ya fue cargado previamente al mismo CUV Agotado.'
		return 0
	end

	-- Que el orden ingresado para el CUV sugerido, no esté siendo utilizado para un mismo CUV agotado.
	set @activo = 0

	select @activo = ProductoSugeridoID
	from productoSugerido ps
	where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV
		--and ps.CUVSugerido = @CUVSugerido
		and ps.Orden = @Orden
		and ps.Estado = 1
		
	set @activo = isnull(@activo, 0)

	if (@activo > 0 and @ProductoSugeridoID > 0 and @activo != @ProductoSugeridoID) or (@activo > 0  and @ProductoSugeridoID = 0)
	begin
		set @Return = '-7|El orden ingresado ya existe para el CUV Agotado configurado.'
		return 0
	end

	-- Que se haya seleccionado una foto
	if @ImagenProducto = '' 
	begin
		set @Return = '-8|No se ha seleccionado ninguna foto.'
		return 0
	end

	-- Productos con reemplazos configurados por campaña
	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		declare @id int = 0
		select @id = min(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		declare @cant int = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantProd int = 0
		select @cantProd = count(1)
			from (
			select CampaniaID, CUV
			from productoSugerido ps
			where ps.CampaniaID = @CampaniaID
			and ps.Estado = 1
			group by CampaniaID, CUV
		) as t			
					
		if ( @cant <= @cantProd and @ProductoSugeridoID = 0 )
		begin
			set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
			return 0
		end

		if @ProductoSugeridoID > 0
		begin 
					
			
			declare @cantProdDif int = 0
			select @cantProdDif = count(1)
			from (
				select CampaniaID, CUV
				from productoSugerido ps
				where ps.CampaniaID = @CampaniaID
				and ps.Estado = 1
				and ps.CUV != @CUV
				and ps.ProductoSugeridoID != @ProductoSugeridoID
				group by CampaniaID, CUV
			) as t

					
			if ( @cant <= @cantProdDif and @ProductoSugeridoID > 0 )
			begin
				set @Return = '-9|Ya se registró la cantidad máxima de reemplazos configurados en la campaña.'
				return 0
			end

		end -- if @ProductoSugeridoID > 0

		
		
	end


	-- Reemplazos configurados por producto por campaña

	set @activo = 0
	select @activo = TablaLogicaID from dbo.tablalogica where Descripcion = 'Reemplazos Sugeridos'
	set @activo = isnull(@activo, 0)
	if @activo > 0
	begin
		set @id = 0
		select @id = max(TablaLogicaDatosID) from dbo.tablalogicadatos where TablaLogicaID = @activo
		set @id = isnull(@id, 0) 

		set @cant = 0
		select @cant = convert(int, Codigo) from dbo.tablalogicadatos where TablaLogicaDatosID = @id

		declare @cantSug int = 0
		declare @cantSugDif int = 0

		select @cantSug = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1	
		
		select @cantSugDif = count(1)
		from productoSugerido ps
		where ps.CampaniaID = @CampaniaID
		and ps.CUV = @CUV	
		and ps.Estado = 1
		and ProductoSugeridoID != @ProductoSugeridoID			
			
		if (@cant <= @cantSug and @ProductoSugeridoID = 0 ) or ( @cant <= @cantSugDif and @ProductoSugeridoID > 0 )
		begin
			set @Return = '-10|Ya se registró la cantidad máxima de sugerencias de reemplazo para este producto en la campaña.'
			return 0
		end
	end
END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsProductoSugerido_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[InsProductoSugerido_SB2]
GO

CREATE PROCEDURE [dbo].[InsProductoSugerido_SB2]
(
	 @Return varchar(max) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@UsuarioRegistro varchar(50)
)
AS
BEGIN
	set @Return = '0|No se pudo registrar el producto sugerido, vuelva a intentarlo luego.'
	
	DECLARE @return_status varchar(max);
	EXEC ValidProductoSugerido_SB2 @return_status OUTPUT, @ProductoSugeridoID, @CampaniaID, @CUV, @CUVSugerido, @Orden, @ImagenProducto, @Estado, @UsuarioRegistro;
	-- SELECT 'Return Status' = @return_status;
	set @Return = @return_status

	if	@return_status = ''
	begin

		INSERT INTO ProductoSugerido
		 (
			 --ProductoSugeridoID
			 CampaniaID
			,CUV
			,CUVSugerido
			,Orden
			,ImagenProducto
			,Estado
			,UsuarioRegistro
			,FechaRegistro
			,UsuarioModificacion
			,FechaModificacion
		 )
		 VALUES
		 (
			--@ProductoSugeridoID
			 @CampaniaID
			,@CUV
			,@CUVSugerido
			,@Orden
			,@ImagenProducto
			,@Estado
			,@UsuarioRegistro
			,getdate()
			,null
			,null
		 )

		 set @Return = convert(varchar, @@IDENTITY) + '|Se registró con éxito el producto sugerido.'
	end
		
END

go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdProductoSugerido_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[UpdProductoSugerido_SB2]
GO

CREATE PROCEDURE [dbo].[UpdProductoSugerido_SB2]
(
	 @Return varchar(max) output
	,@ProductoSugeridoID int
	,@CampaniaID varchar(6)
	,@CUV varchar(20)
	,@CUVSugerido varchar(20)
	,@Orden int
	,@ImagenProducto varchar(150)
	,@Estado int
	,@UsuarioModificacion varchar(50)
)
AS
BEGIN
	
	set @Return = '0|No se pudo actualizar el producto sugerido, vuelva a intentarlo luego.'
	
	DECLARE @Existe int = 0
	select @Existe = ProductoSugeridoID
	from ProductoSugerido
	where ProductoSugeridoID = @ProductoSugeridoID

	set @Existe = isnull(@Existe, 0)

	if	@Existe > 0
	begin
	
		DECLARE @return_status varchar(max);
		EXEC ValidProductoSugerido_SB2 @return_status OUTPUT, @ProductoSugeridoID, @CampaniaID, @CUV, @CUVSugerido, @Orden, @ImagenProducto, @Estado, @UsuarioModificacion;
		-- SELECT 'Return Status' = @return_status;
		set @Return = @return_status


		if	@return_status = ''
		begin

			UPDATE ProductoSugerido
			SET CampaniaID = @CampaniaID,
				CUV = @CUV,
				CUVSugerido = @CUVSugerido,
				Orden = @Orden,
				ImagenProducto = @ImagenProducto,
				Estado = @Estado,
				UsuarioModificacion = @UsuarioModificacion,
				FechaModificacion = GETDATE()
			WHERE ProductoSugeridoID = @ProductoSugeridoID

			set @Return = convert(varchar, @ProductoSugeridoID)  + '|Se actualizó con éxito el producto sugerido.'

		end
	end

END

go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DelProductoSugerido_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].[DelProductoSugerido_SB2]
GO

CREATE PROCEDURE [dbo].[DelProductoSugerido_SB2]
(
	 @Return varchar(max) output
	,@ProductoSugeridoID int
	,@UsuarioModificacion varchar(50)
)
AS
BEGIN
	
	set @Return = '0|No se pudo eliminar el registro, vuelva a intentarlo luego.'
	
	DECLARE @Existe int = 0
	select @Existe = ProductoSugeridoID
	from ProductoSugerido
	where ProductoSugeridoID = @ProductoSugeridoID

	set @Existe = isnull(@Existe, 0)

	if	@Existe > 0
	begin

		UPDATE ProductoSugerido
		SET Estado = 0,
			UsuarioModificacion = @UsuarioModificacion,
			FechaModificacion = GETDATE()
		WHERE ProductoSugeridoID = @ProductoSugeridoID

		set @Return = convert(varchar, @ProductoSugeridoID) + '|Se eliminó satisfactoriamente.'
	end

END

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetParametriaOfertaFinal_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetParametriaOfertaFinal_SB2
GO

CREATE PROCEDURE dbo.GetParametriaOfertaFinal_SB2 
as
/*
dbo.GetParametriaOfertaFinal_SB2
*/
begin

select
Tipo as TipoParametriaOfertaFinal,
GapMinimo as MontoDesde,
GapMaximo as MontoHasta
from OfertaFinalParametria

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductoOfertaFinalMostrar_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetProductoOfertaFinalMostrar_SB2
GO

create procedure dbo.GetProductoOfertaFinalMostrar_SB2
@CampaniaID int,
@CodigoConsultora varchar(20),
@ZonaID int,
@CodigoRegion varchar(10),
@CodigoZona varchar(10)
as
/*
GetProductoOfertaFinalMostrar_SB2 201612,'000758833',2161,'50','5052'
GetProductoOfertaFinalMostrar_SB2 201612,'000008788',5053,'01','1257'
GetProductoOfertaFinalMostrar_SB2 201612,'041052287',2014,'60','6072'
*/
begin

declare @ConsultoraID int = 0
select top 1 @ConsultoraID = ConsultoraID from ods.Consultora where Codigo = @CodigoConsultora

declare @tablaCuvFaltante table (CUV varchar(6))

INSERT INTO @tablaCuvFaltante
select 
	distinct ltrim(rtrim(CUV))
from dbo.ProductoFaltante nolock
where 
	CampaniaID = @CampaniaID and Zonaid = @ZonaID
UNION ALL
select 
	distinct ltrim(rtrim(fa.CodigoVenta)) AS CUV
from ods.FaltanteAnunciado fa (nolock)
inner join ods.Campania c (nolock) on 
	fa.CampaniaID = c.CampaniaID
where 
	c.Codigo = @CampaniaID 
	and (rtrim(fa.CodigoRegion) = @CodigoRegion or fa.CodigoRegion IS NULL) 
	and (rtrim(fa.CodigoZona) = @CodigoZona or fa.CodigoZona IS NULL)

declare @tablaCuvPedido table (CUV varchar(6))

insert into @tablaCuvPedido
SELECT CUV   
FROM PedidoWebDetalle with(nolock)
WHERE CampaniaID=@CampaniaID and ConsultoraID=@ConsultoraID	

select distinct pc.CUV, pc.CodigoProducto as CodigoSap, op.Orden 
from ods.ProductoComercial pc
inner join ods.ofertaspersonalizadas op on
	pc.CUV = op.CUV
	and pc.AnoCampania = op.AnioCampanaVenta
	and op.CodConsultora = @CodigoConsultora
where 
	pc.AnoCampania = @CampaniaID
	and op.TipoPersonalizacion = 'OF'
	AND op.CUV not in (	SELECT CUV FROM @tablaCuvPedido )
	AND op.CUV not in ( SELECT CUV FROM @tablaCuvFaltante )
order by op.Orden

end

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSesionUsuario_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE dbo.GetSesionUsuario_SB2
GO

CREATE PROCEDURE dbo.GetSesionUsuario_SB2
@CodigoConsultora varchar(25)    
AS  
/*
GetSesionUsuario_SB2
*/
BEGIN  
	DECLARE @PasePedidoWeb int  
	DECLARE @TipoOferta2 int  
	DECLARE @CompraOfertaEspecial int  
	DECLARE @IndicadorMeta int  
	declare @PaisID int  
	declare @UsuarioPrueba bit  
	declare @CodConsultora varchar(20)  
	declare @CampaniaID int  
	declare @ZonaID int  
	declare @RegionID int  
	declare @ConsultoraID bigint  
  
	select TOP 1 @UsuarioPrueba = ISNULL(UsuarioPrueba,0),  
		@PaisID = IsNull(PaisID,0),  
		@CodConsultora = CodigoConsultora  
	from usuario with(nolock)  
	where codigousuario = @CodigoConsultora  
	
	declare @indicadorContrato bigint    
	declare @CountCodigoNivel bigint  
	declare @valorInscrita int  
  
	/*Oferta Final*/	
	declare @EsOfertaFinalZonaValida bit = 0
	declare @CodigoZona varchar(4) = ''
	declare @CodigoRegion varchar(2) = ''

	select 
		@CodigoZona = IsNull(z.Codigo,''),    
		@CodigoRegion = IsNull(r.Codigo,'')   
	from ods.consultora c with(nolock)   
	inner join ods.Region r on
		c.RegionID = r.RegionID
	inner join ods.Zona z on
		c.ZonaID = z.ZonaID
	where c.codigo = @CodConsultora   
	
	if exists (select 1 from OfertaFinalRegionZona where CodigoRegion = @CodigoRegion and CodigoZona = @CodigoZona and Estado = 1)
		set @EsOfertaFinalZonaValida = 1
	/*Fin Oferta Final*/

	IF @UsuarioPrueba = 0  
	BEGIN  
		select @ZonaID = IsNull(ZonaID,0),  
			@RegionID = IsNull(RegionID,0),  
			@ConsultoraID = IsNull(ConsultoraID,0)  
		from ods.consultora with(nolock)  
		where codigo = @CodConsultora  
  
		select @CampaniaID = campaniaId from dbo.GetCampaniaPreLogin(@PaisID,@ZonaID,@RegionID,@ConsultoraID)  
		SET @PasePedidoWeb = (SELECT dbo.GetPasaPedidoWeb(@CampaniaID,@ConsultoraID))  
		SET @TipoOferta2 = (SELECT dbo.GetComproOfertaWeb(@CampaniaID,@ConsultoraID))  
		SET @CompraOfertaEspecial = (SELECT dbo.GetComproOfertaEspecial(@CampaniaID,@ConsultoraID))  
		SET @IndicadorMeta = (SELECT dbo.GetIndicadorMeta(@ConsultoraID))  
		select top 1 @indicadorContrato= count(*) from Contrato where ConsultoraID=@ConsultoraID and aceptocontrato=1  
		select @CountCodigoNivel =count(*) from ods.ConsultoraLider with(nolock) where consultoraid=@ConsultoraID        
		select top 1 @valorInscrita=isnull(IndicadorActiva,0)  
		from ods.ConsultoraFlexipago with(nolock)  
		where PeriodoFacturado= @CampaniaID and ConsultoraID=@ConsultoraID  
	
		if @valorInscrita=0  
			select top 1 @valorInscrita = isnull(Estado,0) from [dbo].[FlexipagoInsDes] with(nolock)  
			where CodigoConsultora = @CodConsultora  
			order by FlexipagoInsDesID desc    
			Set @valorInscrita = isnull(@valorInscrita,0)  
  
		SELECT   
			u.PaisID,  
			p.CodigoISO,  
			c.RegionID,  
			r.Codigo AS CodigorRegion,  
			ISNULL(c.ZonaID,0) AS ZonaID,  
			ISNULL(z.Codigo,'') AS CodigoZona,  
			c.ConsultoraID,  
			u.CodigoUsuario,  
			u.CodigoConsultora,  
			u.Nombre AS NombreCompleto,  
			ISNULL(ur.RolID,0) AS RolID,  
			u.EMail,  
			p.Simbolo,  
			c.TerritorioID,  
			t.Codigo AS CodigoTerritorio,  
			c.MontoMinimoPedido,  
			c.MontoMaximoPedido,  
			p.CodigoFuente,  
			p.BanderaImagen,  
			p.Nombre as NombrePais,  
			u.CambioClave,  
			u.Telefono,  
			u.Celular,  
			ISNULL(s.descripcion,'') as Segmento,  
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,  
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,  
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,  
			u.UsuarioPrueba,  
			ISNULL(u.Sobrenombre,'') as Sobrenombre,  
			ISNULL(c.PrimerNombre,'') as PrimerNombre,  
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,  
			ISNULL(@TipoOferta2,0) as TipoOferta2,  
			1 as CompraKitDupla,  
			1 as CompraOfertaDupla,  
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,  
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,  
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,  
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,  
			0 as ProgramaReconocimiento,  
			ISNULL(s.segmentoid, 0) as segmentoid,  
			isnull((select top 1 Invitado from ods.ConsultoraFlexipago with(nolock)  
				where PeriodoFacturado= @CampaniaID and ConsultoraID=@ConsultoraID),0) as IndicadorFlexiPago,--1969  
			'' as Nivel,  
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,  
			ISNULL(c.PrimerNombre,'') as PrimerNombre,  
			ISNULL(c.PrimerApellido,'') as PrimerApellido,  
			u.MostrarAyudaWebTraking,  
			ro.Descripcion as RolDescripcion,  
			@indicadorContrato IndicadorContrato,  
			isnull(c.EsJoven,0) EsJoven,  
			(case     
				when @CountCodigoNivel =0 then 0  --1589  
				when @CountCodigoNivel>0 then 1 End) Lider,--1589      
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589  
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589  
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589  
			isnull(p.PortalLideres,0) PortalLideres,--1589  
			isnull(p.LogoLideres,null) LogoLideres, --1589   
			null as ConsultoraAsociada, --1688   
			isnull(si.descripcion,null) SegmentoConstancia, --2469  
			isnull(se.Codigo,null) Seccion, --2469  
			isnull(nl.DescripcionNivel,null) DescripcionNivel,  --2469  
			case When cl.ConsultoraID is null then 0  
			else 1 end esConsultoraLider,  
			isnull(c.CampanaInvitada,0)  CampanaInvitada, --1796  
			@valorInscrita InscritaFlexipago,    --1796  
			isnull(u.InvitacionRechazada,0)  InvitacionRechazada, --1796  
			u.EMailActivo, --2532  
			si.SegmentoInternoId,
			isnull(p.OfertaFinal,0) as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida
		FROM dbo.Usuario u with(nolock)  
		LEFT JOIN (  
			select *  
			from ods.consultora with(nolock)  
			where ConsultoraId = @ConsultoraID  
		) c ON 
			u.CodigoConsultora = c.Codigo  
		--LEFT JOIN [ods].[Consultora] c with(nolock) ON u.CodigoConsultora = c.Codigo  
		LEFT JOIN [dbo].[UsuarioRol] ur with(nolock) ON u.CodigoUsuario = ur.CodigoUsuario  
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID  
		INNER JOIN [dbo].[Pais] p with(nolock) ON u.PaisID = p.PaisID  
		LEFT JOIN [ods].[SegmentoInterno] si with(nolock) on c.SegmentoInternoId = si.SegmentoInternoId --R2469  
		LEFT JOIN [ods].[Seccion] se with(nolock) on c.SeccionID=se.SeccionID  --R2469   
		LEFT JOIn [ods].[Region] r with(nolock) ON c.RegionID = r.RegionID  
		LEFT JOIN [ods].[Zona] z with(nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID  
		LEFT JOIN [ods].[Territorio] t with(nolock) ON c.TerritorioID = t.TerritorioID  
            AND c.SeccionID = t.SeccionID  
            AND c.ZonaID = t.ZonaID  
            AND c.RegionID = t.RegionID  
		left join ods.segmento  s with(nolock) ON c.segmentoid = s.segmentoid  
		left join ods.ConsultoraLider cl with(nolock) on c.ConsultoraID=cl.ConsultoraID  
		left join ods.NivelLider nl with(nolock) on cl.CodigoNivelLider = nl.CodigoNivel -- R2469  
		WHERE 
			ro.Sistema = 1 
			and u.CodigoUsuario = @CodigoConsultora  
	END  
	ELSE  
	BEGIN  
		select top 1 @indicadorContrato= count(*) from Contrato where ConsultoraID=@ConsultoraID and aceptocontrato=1  
  
		SELECT   
			u.PaisID,  
			p.CodigoISO,  
			c.RegionID,  
			r.Codigo AS CodigorRegion,  
			ISNULL(c.ZonaID,0) AS ZonaID,  
			ISNULL(z.Codigo,'') AS CodigoZona,  
			c.ConsultoraID,  
			u.CodigoUsuario,  
			u.CodigoConsultora,  
			u.Nombre AS NombreCompleto,  
			ISNULL(ur.RolID,0) AS RolID,  
			u.EMail,  
			p.Simbolo,  
			c.TerritorioID,  
			t.Codigo AS CodigoTerritorio,  
			c.MontoMinimoPedido,  
			c.MontoMaximoPedido,  
			p.CodigoFuente,  
			p.BanderaImagen,  
			p.Nombre as NombrePais,  
			u.CambioClave,  
			u.Telefono,  
			u.Celular,  
			ISNULL(s.descripcion,'') as Segmento,  
			ISNULL(c.FechaNacimiento, getdate()) FechaNacimiento,  
			ISNULL(c.IdEstadoActividad,0) as ConsultoraNueva,  
			isnull(c.IndicadorDupla, 0) as IndicadorDupla,  
			u.UsuarioPrueba,  
			ISNULL(u.Sobrenombre,'') as Sobrenombre,  
			ISNULL(c.PrimerNombre,'') as PrimerNombre,  
			ISNULL(@PasePedidoWeb,0) as PasePedidoWeb,  
			ISNULL(@TipoOferta2,0) as TipoOferta2,  
			1 as CompraKitDupla,  
			1 as CompraOfertaDupla,  
			--ISNULL(c.CompraKitDupla,1) as CompraKitDupla,  
			--ISNULL(c.CompraOfertaDupla,1) as CompraOfertaDupla,  
			ISNULL(@CompraOfertaEspecial,0) as CompraOfertaEspecial,  
			ISNULL(@IndicadorMeta,0) as IndicadorMeta,  
			0 as ProgramaReconocimiento,  
			ISNULL(s.segmentoid, 0) as segmentoid,  
			ISNULL(c.IndicadorFlexiPago, 0) as IndicadorFlexiPago,  
			'' as Nivel,  
			ISNULL(c.AnoCampanaIngreso,'') As AnoCampanaIngreso,  
			ISNULL(c.PrimerNombre,'') as PrimerNombre,  
			ISNULL(c.PrimerApellido,'') as PrimerApellido,  
			u.MostrarAyudaWebTraking,  
			ro.Descripcion as RolDescripcion,  
			@indicadorContrato IndicadorContrato,  
			(case     
				when ISNULL(cl.ConsultoraID,0) =0 then 0  --1589  
				when ISNULL(cl.ConsultoraID,0)>0 then 1 End) Lider,--1589    
			isnull(cl.CampaniaInicioLider,null) CampaniaInicioLider,--1589  
			isnull(cl.SeccionGestionLider,null) SeccionGestionLider,--1589  
			isnull(cl.CodigoNivelLider,0) NivelLider,--1589  
			isnull(p.PortalLideres,0) PortalLideres,--1589  
			isnull(p.LogoLideres,null) LogoLideres, --1589   
			isnull(up.CodigoConsultoraAsociada,null) ConsultoraAsociada, --1688  
			isnull(u.InvitacionRechazada,0)  InvitacionRechazada, --1796  
			u.EMailActivo, --2532  
			isnull(p.OfertaFinal,0) as OfertaFinal,
			isnull(@EsOfertaFinalZonaValida,0) as EsOfertaFinalZonaValida
		FROM dbo.Usuario u (nolock)  
		LEFT JOIN [ConsultoraFicticia] c (nolock) ON u.CodigoConsultora = c.Codigo  
		LEFT JOIN [dbo].[UsuarioRol] ur (nolock) ON u.CodigoUsuario = ur.CodigoUsuario  
		LEFT JOIN [dbo].[Rol] ro with(nolock) ON ur.RolID = ro.RolID  
		INNER JOIN [dbo].[Pais] p (nolock) ON u.PaisID = p.PaisID  
		LEFT JOIn [ods].[Region] r (nolock) ON c.RegionID = r.RegionID  
		LEFT JOIN [ods].[Zona] z (nolock) ON c.ZonaID = z.ZonaID AND c.RegionID = z.RegionID  
		LEFT JOIN [ods].[Territorio] t (nolock) ON c.TerritorioID = t.TerritorioID  
			AND c.SeccionID = t.SeccionID  
			AND c.ZonaID = t.ZonaID  
			AND c.RegionID = t.RegionID  
		left join ods.segmento  s (nolock) ON c.segmentoid = s.segmentoid  
		left join usuarioprueba up (nolock) on u.CodigoUsuario = up.CodigoUsuario  
		left join ods.ConsultoraLider cl with(nolock) on up.CodigoConsultoraAsociada = cl.CodigoConsultora  
		WHERE 
			ro.Sistema = 1 
			and u.CodigoUsuario = @CodigoConsultora
	END  
END

go


IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPermisosByRol_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetPermisosByRol_SB2
GO

CREATE PROCEDURE [dbo].GetPermisosByRol_SB2
(
	@RolID smallint
)
AS
/*
GetPermisosByRol_SB2 1
GetPermisosByRol_SB2 4
*/
BEGIN
	SELECT P.PermisoID,
			P.Descripcion,
			P.IdPadre,
			P.OrdenItem,
			P.UrlItem,
			P.PaginaNueva,
			P.UrlImagen,
			P.EsSoloImagen,
			P.EsMenuEspecial,
			P.EsServicios,
			RL.RolID,
			isnull(RL.Mostrar,1) As Mostrar,
			isnull(Posicion,'')[Posicion]
	FROM Permiso P
	INNER JOIN RolPermiso RL
	ON RL.PermisoID = P.PermisoID
	WHERE RL.Activo = 1
		AND RL.RolID = @RolID
		AND (@RolID != 1 or P.EsPrincipal = 1)	
END

GO

ALTER PROCEDURE [dbo].[GetPermisosByRol] 
(
	@RolID smallint
)
AS
/*
GetPermisosByRol 1
GetPermisosByRol 4
*/
BEGIN
	SELECT P.PermisoID,
			P.Descripcion,
			P.IdPadre,
			P.OrdenItem,
			P.UrlItem,
			P.PaginaNueva,
			P.UrlImagen,
			P.EsSoloImagen,
			P.EsMenuEspecial,
			P.EsServicios,
			RL.RolID,
			isnull(RL.Mostrar,1) As Mostrar,
			isnull(Posicion,'')[Posicion]
	FROM Permiso P
	INNER JOIN RolPermiso RL
	ON RL.PermisoID = P.PermisoID
	WHERE RL.Activo = 1
		AND RL.RolID = @RolID
		AND (@RolID != 1 or P.EsPrincipal = 0)
	ORDER BY P.OrdenItem
END

GO
/*FIN PROCEDIMIENTOS ALMACENADOS*/