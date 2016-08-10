USE BelcorpEcuador_SB2
go

/*INSERT*/

CREATE TABLE #tblTemporal (idPermisoTemp int)
INSERT INTO #tblTemporal(idPermisoTemp) 
SELECT PermisoID FROM RolPermiso WHERE RolID=1
DELETE FROM RolPermiso WHERE RolID=1
DELETE FROM Permiso WHERE PermisoID IN (SELECT idPermisoTemp FROM #tblTemporal) 
DROP TABLE #tblTemporal

INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (2, N'SOCIA EMPRESARIA', 0, 1, N'Lider/Index', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (3, N'MI NEGOCIO', 0, 2, N'', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (4, N'MI ACADEMIA', 0, 3, N'MiAcademia/Index', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (5, N'MI COMUNIDAD', 0, 4, N'Comunidad/Index', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (6, N'MI ASESOR DE BELLEZA', 0, 5, N'', 0, N'Header', NULL, 0, 0, 0)

INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (7, N'MIS PEDIDOS', 3, 1, N'', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (8, N'MIS PAGOS', 3, 2, N'', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (9, N'MIS CATÁLOGOS Y REVISTAS', 3, 3, N'', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (10, N'MIS CLIENTES', 3, 4, N'', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (11, N'PROGRAMAS BELCORP', 3, 5, N'', 0, N'Header', NULL, 0, 0, 1)

INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (12, N'Ingresa tu pedido', 7, 1, N'Pedido/Index', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (13, N'Información de campaña', 7, 2, N'Bienvenida/Index', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (14, N'Seguimiento de pedido', 7, 3, N'Tracking/Index', 0, N'Header', NULL, NULL, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (15, N'Paquete documentario', 7, 4, N'PaqueteDocumentario/Index', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (16, N'Mis Pedidos', 7, 5, N'MisPedidos/Index', 0, N'Header', NULL, NULL, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (17, N'Pedidos facturados', 7, 6, N'PedidoWebAnteriores/PedidoWebAnteriores', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (18, N'Zona de liquidación', 7, 7, N'OfertaLiquidacion/OfertasLiquidacion', 0, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (19, N'Ofertas flexiPago', 7, 8, N'OfertaFlexipago/OfertasFlexipago', 0, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (20, N'Incentivos', 7, 9, N'Incentivos/Index', 0, N'Header', NULL, 0, 0, 0)

INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (21, N'Mis Pagos', 8, 1, N'MisPagos/Index', 0, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (22, N'Lugares de pago', 8, 2, N'LugaresPago/Index', 0, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (23, N'Facturación electrónica', 8, 3, N'FacturaElectronica/Index', 0, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (24, N'Percepciones', 8, 4, N'Percepciones/Index', 0, N'Header', NULL, NULL, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (25, N'Escala de descuentos', 8, 5, N'EscalaDescuentos/Index', 0, N'Header', NULL, 0, 0, 0)

INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (26, N'Mis Catálogos y Revistas', 9, 1, N'MisCatalogosRevistas/Index', 0, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (27, N'Guía de Negocio Ésika', 9, 2, N'RevistaGana/Index', 0, N'Header', NULL, 0, 0, 0)

INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (28, N'Listado de clientes', 10, 1, N'Cliente/Index', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (29, N'Pedidos por cliente', 10, 2, N'PedidoWeb/PedidoWeb', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (30, N'Consultora Online', 10, 3, N'ConsultoraOnline/Index', 0, N'Header', NULL, 0, 0, 0)

--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (31, N'', 6, 1, N'', 0, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (32, N'Maquillador Virtual', 31, 1, N'http://www.esika.biz/coach-de-belleza/maquillador-virtual/', 1, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (33, N'Ésika Fashion Blog', 31, 2, N'http://fashionblog.esika.biz/', 1, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (34, N'Asesor de looks', 31, 3, N'http://www.esika.biz/coach-de-belleza/asesor-de-looks/', 1, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (35, N'Asesor de Fragancias', 31, 4, N'http://www.esika.biz/coach-de-belleza/asesor-de-fragancias-para-ti/', 1, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (36, N'Manicure Virtual', 31, 5, N'http://www.esika.biz/coach-de-belleza/manicure-virtual/', 1, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (37, N'Esika Fashion Blog ', 31, 5, N'http://www.fashionblog.esika.com/', 1, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (38, N'Tips de Belleza ', 31, 5, N'http://www.esika.com/clps-de-belleza/', 1, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (39, N'A la Moda', 31, 5, N'http://www.esika.com/a-la-moda/esika-fashion/', 1, N'Header', NULL, 0, 0, 0)

--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (31, N'Brillante 2016', 11, 1, N'https://s3.amazonaws.com/somosbelcorp/2016/Folleto+Brillante+2016/Folleto+Brillante+2016+EC.pdf', 1, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (32, N'Familia Primero', 11, 2, N'', 1, N'Header', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (34, N'Programa Nuevas', 11, 4, N'https://s3.amazonaws.com/somosbelcorp/2016/Minisite+Nuevas+Esikizado/EC/index.html', 1, N'Header', NULL, 0, 0, 0)



INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (40, N'AYUDA', 0, 2, N'', 0, N'Footer', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (41, N'LEGAL', 0, 3, N'', 0, N'Footer', NULL, 0, 0, 0)

INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (42, N'PREGUNTAS FRECUENTES', 40, 1, N'https://www.somosbelcorp.com/Content/FAQ/Preguntas frecuentes Portal Consultora EC.pdf', 1, N'Footer', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (43, N'CONTÁCTANOS', 40, 2, N'http://belcorpresponde.somosbelcorp.com/', 1, N'Footer', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (44, N'CONDICIONES DE USO WEB', 41, 1, N'https://www.somosbelcorp.com/Content/FAQ/CONDICIONES_DE_USO_WEB_EC.pdf', 1, N'Footer', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (45, N'POLÍTICAS DE PRIVACIDAD', 41, 2, N'https://www.somosbelcorp.com/Content/FAQ/POLITICA_DE_PRIVACIDAD_EC.pdf', 1, N'Footer', NULL, 0, 0, 0)
--INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
--VALUES (46, N'PROCEDIMIENTO Y FORMULARIO PARA EL EJERCICIO DE DERECHOS ARCO', 41, 3, N'https://www.somosbelcorp.com/Content/FAQ/PROCEDIMIENTO_Y_FORMULARIO_PARA_EL_EJERCICIO_DE_DERECHOS_ARCO_EC.pdf', 1, N'Footer', NULL, 0, 0, 0)
--GO

INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (50, N'', 6, 1, N'', 0, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (51, N'Maquillador Virtual', 50, 1, N'http://www.esika.biz/coach-de-belleza/maquillador-virtual/', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (52, N'Ésika Fashion Blog', 50, 2, N'http://fashionblog.esika.biz/', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (53, N'Asesor de looks', 50, 3, N'http://www.esika.biz/coach-de-belleza/asesor-de-looks/', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (54, N'Asesor de Fragancias', 50, 4, N'http://www.esika.biz/coach-de-belleza/asesor-de-fragancias-para-ti/', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (55, N'Manicure Virtual', 50, 5, N'http://www.esika.biz/coach-de-belleza/manicure-virtual/', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (56, N'Tips de Belleza ', 50, 6, N'http://www.esika.com/clps-de-belleza/', 1, N'Header', NULL, 0, 0, 0)
INSERT [dbo].[Permiso] ([PermisoID], [Descripcion], [IdPadre], [OrdenItem], [UrlItem], [PaginaNueva], [Posicion], [UrlImagen], [EsSoloImagen], [EsMenuEspecial], [EsServicios]) 
VALUES (57, N'A la Moda', 50, 7, N'http://www.esika.com/a-la-moda/esika-fashion/', 1, N'Header', NULL, 0, 0, 0)

INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 2, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 3, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 4, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 5, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 6, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 7, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 8, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 9, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 10, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 11, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 12, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 13, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 14, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 15, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 16, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 17, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 18, 1, 1)

--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 19, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 20, 0, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 21, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 22, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 23, 1, 1)

--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 24, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 25, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 26, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 27, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 28, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 29, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 30, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 31, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 32, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 33, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 34, 1, 1)

--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 35, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 36, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 37, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 38, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 39, 1, 1)

INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 40, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 41, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 42, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 43, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 44, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 45, 1, 1)
--INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 46, 1, 1)

INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 50, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 51, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 52, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 53, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 54, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 55, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 56, 1, 1)
INSERT [dbo].[RolPermiso] ([RolID], [PermisoID], [Activo], [Mostrar]) VALUES (1, 57, 1, 1)
GO

IF NOT EXISTS (SELECT TablaLogicaID FROM TablaLogica WHERE TablaLogicaID = 87)
BEGIN
	INSERT INTO TablaLogica (TablaLogicaID, Descripcion) VALUES (87, 'Carousel Liquidaciones Home')
END

IF NOT EXISTS (SELECT TablaLogicaDatosID FROM TablaLogicaDatos WHERE TablaLogicaDatosID = 8701)
BEGIN
	INSERT INTO TablaLogicaDatos (TablaLogicaDatosID, TablaLogicaID, Codigo, Descripcion) VALUES (8701, 87, 1, 'Cantidad de productos a cargar')
END

GO

/*FIN INSERTS*/

/*NUEVOS CAMPOS*/
IF  EXISTS ( SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ods].[OfertasPersonalizadas]') AND (type = N'SN') )
	DROP SYNONYM [ods].[OfertasPersonalizadas]
GO

CREATE SYNONYM [ods].[OfertasPersonalizadas] FOR [ODS_EC_SB2].[dbo].[OfertasPersonalizadas]
GO

IF  EXISTS ( SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ods].[ConfiguracionProgramaNuevas]') AND (type = N'SN') )
	DROP SYNONYM [ods].[ConfiguracionProgramaNuevas]
GO

CREATE SYNONYM [ods].[ConfiguracionProgramaNuevas] FOR [ODS_EC_SB2].[dbo].[ConfiguracionProgramaNuevas]
GO

IF  EXISTS ( SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ods].[EscalaDescuento]') AND (type = N'SN') )
	DROP SYNONYM [ods].[EscalaDescuento]
GO

CREATE SYNONYM [ods].[EscalaDescuento] FOR [ODS_EC_SB2].[dbo].[EscalaDescuento]
GO

IF  EXISTS ( SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[ods].[INT_SOA_COBRA_DEUDA_SECCI]') AND (type = N'SN') )
	DROP SYNONYM [ods].[INT_SOA_COBRA_DEUDA_SECCI]
GO

CREATE SYNONYM [ods].[INT_SOA_COBRA_DEUDA_SECCI] FOR [ODS_EC_SB2].[ffvv].[INT_SOA_COBRA_DEUDA_SECCI]

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
	where sysobjects.id = object_id('dbo.PedidoWeb') and SYSCOLUMNS.NAME = N'MontoDescuento') = 0
	ALTER TABLE dbo.PedidoWeb ADD MontoDescuento money
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

/*FIN NUEVOS CAMPOS*/

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

CREATE PROCEDURE dbo.ListarEstrategiasPedido_SB2  
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

go

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPedidoWebByFechaFacturacion_SB2]') AND type in (N'P', N'PC')) 
	DROP PROCEDURE [dbo].GetPedidoWebByFechaFacturacion_SB2
GO

CREATE PROCEDURE [dbo].GetPedidoWebByFechaFacturacion_SB2 --'2015-10-19',1,1  
 @FechaFacturacion date,  
 @TipoCronograma int,  
 @NroLote int  
 with recompile
as  
set nocount on;  
  
declare @Tipo smallint  
if @TipoCronograma = 1  
 set @Tipo = (select isnull(ProcesoRegular,0) from [dbo].[ConfiguracionValidacion])  
else if @TipoCronograma = 2  
 set @Tipo = (select isnull(ProcesoDA,0) from [dbo].[ConfiguracionValidacion])  
else  
 set @Tipo = (select isnull(ProcesoDAPRD,0) from [dbo].[ConfiguracionValidacion])  
  
declare @EsquemaDAConsultora bit  
declare @TipoProcesoCarga bit
select	@EsquemaDAConsultora = ISNULL(EsquemaDAConsultora,0),  
		@TipoProcesoCarga = ISNULL(TipoProcesoCarga,0)
from pais with(nolock)  
where EstadoActivo = 1  

declare @ConfValZonaTemp table  
(  
	Campaniaid int,  
	Regionid int,  
	Zonaid int,  
	FechaInicioFacturacion smalldatetime,  
	FechaFinFacturacion smalldatetime,
	FechaFinNuevoProceso smalldatetime, --R20151221  
	CodigoRegion varchar(8),  
	CodigoZona varchar(8),  
	CodigoCampania int,
	ZonaActivaTP bit,
	TipoProceso int
)  
  
declare @tabla_pedido_detalle table  
(  
	CampaniaId int null,  
	PedidoId int null,  
	Clientes int,  
	EstadoPedido smallint null,  
	Bloqueado bit null,  
	IndicadorEnviado bit null,  
	ModificaPedidoReservadoMovil bit null,  
	CodigoConsultora varchar(25) null,  
	CodigoRegion varchar(8) null,  
	CodigoZona varchar(8) null,  
	CampaniaIdSicc int null,  
	ZonaId int,  
	CUV varchar(20) null,  
	Cantidad int null,  
	PedidoDetalleIDPadre bit,
	TipoProceso int
)  
  
declare @tabla_pedido table  
(  
	CampaniaId int null,  
	PedidoId int null,  
	Clientes int,  
	EstadoPedido smallint null,  
	Bloqueado bit null,  
	IndicadorEnviado bit null,  
	ModificaPedidoReservadoMovil bit null,  
	CodigoConsultora varchar(25) null,  
	CodigoRegion varchar(8) null,  
	CodigoZona varchar(8) null,  
	CampaniaIdSicc int null,  
	ZonaId int,
	TipoProceso int
)  
  
IF @TipoCronograma = 1  
BEGIN  
	insert into @ConfValZonaTemp  
	select cr.campaniaid, cr.regionid, cr.zonaid, cr.FechaInicioFacturacion,   
		cr.FechaInicioFacturacion + isnull(cz.DiasDuracionCronograma,1) - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(cr.ZonaID, cz.DiasDuracionCronograma, cr.FechaInicioFacturacion),0),
		cr.FechaInicioFacturacion + isnull(tp.DiasParametroCarga,1) - 1 + ISNULL(dbo.GetHorasDuracionRestriccion(cr.ZonaID, tp.DiasParametroCarga, cr.FechaInicioFacturacion),0),  --R20151221
		r.Codigo, z.Codigo, cast(ca.Codigo as int), 
		IIF(@TipoProcesoCarga=1,IIF(isnull(tp.ZonaId,0)=0,0,1),0),0
	from ods.Cronograma cr with(nolock)  
	left join ConfiguracionValidacionZona cz with(nolock) on cr.zonaid = cz.zonaid  
	inner join ods.Region r with(nolock) on cr.RegionId = r.RegionId  
	inner join ods.Zona z with(nolock) on cr.ZonaId = z.ZonaId  
	inner join ods.Campania ca with(nolock) on cr.CampaniaId = ca.CampaniaId  
	left join cronograma co with(nolock) on cr.CampaniaId = co.CampaniaId and cr.ZonaId = co.ZonaId  
	left join ConfiguracionTipoProceso tp with(nolock) on cr.ZonaId = tp.ZonaId
	where	cr.FechaInicioFacturacion <= @FechaFacturacion and   
		cr.FechaInicioFacturacion + 10 >= @FechaFacturacion and   
		IIF(ISNULL(co.ZonaId,0) = 0,1,IIF(@EsquemaDAConsultora = 0,0,1)) = 1  
	
	update @ConfValZonaTemp
	--set TipoProceso = IIF(ZonaActivaTP = 1, IIF(FechaFinFacturacion = @FechaFacturacion,3,2),1)
	set TipoProceso = IIF(ZonaActivaTP = 1, IIF(FechaFinNuevoProceso <= @FechaFacturacion,3,2),1) --R20151221
  
	IF @EsquemaDAConsultora = 0  
	BEGIN  
		insert into @tabla_pedido_detalle  
		select p.CampaniaId,p.PedidoId,p.Clientes,p.EstadoPedido,p.Bloqueado,p.IndicadorEnviado,p.ModificaPedidoReservadoMovil,  
			c.Codigo,cr.CodigoRegion,cr.CodigoZona,cr.CampaniaID, cr.ZonaId, pd.CUV, pd.Cantidad,   
			IIF(pd.PedidoDetalleIDPadre IS NULL,0,1), cr.TipoProceso
		from dbo.PedidoWeb p with(nolock)  
		join dbo.PedidoWebDetalle pd with(nolock) on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID
			and isnull(pd.EsKitNueva, '0') != 1  
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID  
		join @ConfValZonaTemp cr on p.CampaniaId = cr.CodigoCampania  
		and c.RegionID = cr.RegionID  
		and c.ZonaID = cr.ZonaID  
		where cr.FechaInicioFacturacion <= @FechaFacturacion  
			and cr.FechaFinFacturacion >= @FechaFacturacion  
	END  
	ELSE  
	BEGIN  
		insert into @tabla_pedido_detalle  
		select p.CampaniaId,p.PedidoId,p.Clientes,p.EstadoPedido,p.Bloqueado,p.IndicadorEnviado,p.ModificaPedidoReservadoMovil,  
			c.Codigo,cr.CodigoRegion,cr.CodigoZona,cr.CampaniaID, cr.ZonaId, pd.CUV, pd.Cantidad,   
			IIF(pd.PedidoDetalleIDPadre IS NULL,0,1), cr.TipoProceso  
		from dbo.PedidoWeb p with(nolock)  
		join dbo.PedidoWebDetalle pd with(nolock) on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID 
			and isnull(pd.EsKitNueva, '0') != 1  
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID  
		join @ConfValZonaTemp cr on p.CampaniaId = cr.CodigoCampania  
		and c.RegionID = cr.RegionID  
		and c.ZonaID = cr.ZonaID  
                left join ConfiguracionConsultoraDA da with(nolock) on p.CampaniaId = da.CampaniaId and p.ConsultoraId = da.ConsultoraId
		where	cr.FechaInicioFacturacion <= @FechaFacturacion  
				and cr.FechaFinFacturacion >= @FechaFacturacion  
				and isnull(da.TipoConfiguracion,0) = 0 
END  
END  
ELSE  
BEGIN  
	insert into @ConfValZonaTemp  
	select cr.campaniaid, cr.regionid, cr.zonaid, cr.FechaInicioWeb,   
		cr.FechaFinWeb,cr.FechaFinWeb,r.Codigo, z.Codigo, cast(ca.Codigo as int),
		IIF(@TipoProcesoCarga=1,IIF(isnull(tp.ZonaId,0)=0,0,1),0),0
	from Cronograma cr with(nolock)  
	inner join ods.Region r with(nolock) on cr.RegionId = r.RegionId  
	inner join ods.Zona z with(nolock) on cr.ZonaId = z.ZonaId  
	inner join ods.Campania ca with(nolock) on cr.CampaniaId = ca.CampaniaId  
	left join ConfiguracionTipoProceso tp with(nolock) on cr.ZonaId = tp.ZonaId
	where cr.FechaInicioWeb = @FechaFacturacion  

	update @ConfValZonaTemp
	--set TipoProceso = IIF(ZonaActivaTP = 1, IIF(FechaFinFacturacion = @FechaFacturacion,3,2),1)
	set TipoProceso = IIF(ZonaActivaTP = 1, IIF(FechaFinNuevoProceso <= @FechaFacturacion,3,2),1) --R20151221
  
	IF @EsquemaDAConsultora = 0  
	BEGIN  
		insert into @tabla_pedido_detalle  
		select p.CampaniaId,p.PedidoId,p.Clientes,p.EstadoPedido,p.Bloqueado,p.IndicadorEnviado,p.ModificaPedidoReservadoMovil,  
			c.Codigo,cr.CodigoRegion,cr.CodigoZona,cr.CampaniaID, cr.ZonaId, pd.CUV, pd.Cantidad,   
			IIF(pd.PedidoDetalleIDPadre IS NULL,0,1), cr.TipoProceso  
		from dbo.PedidoWeb p with(nolock)  
		join dbo.PedidoWebDetalle pd with(nolock) on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID  
			and isnull(pd.EsKitNueva, '0') != 1  
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID  
		join @ConfValZonaTemp cr on p.CampaniaId = cr.CodigoCampania  
		and c.RegionID = cr.RegionID  
		and c.ZonaID = cr.ZonaID  
		where cr.FechaInicioFacturacion <= @FechaFacturacion  
			and cr.FechaFinFacturacion >= @FechaFacturacion  
	END  
	ELSE  
	BEGIN  
		insert into @tabla_pedido_detalle  
		select p.CampaniaId,p.PedidoId,p.Clientes,p.EstadoPedido,p.Bloqueado,p.IndicadorEnviado,p.ModificaPedidoReservadoMovil,  
			c.Codigo,cr.CodigoRegion,cr.CodigoZona,cr.CampaniaID, cr.ZonaId, pd.CUV, pd.Cantidad,   
			IIF(pd.PedidoDetalleIDPadre IS NULL,0,1), cr.TipoProceso  
		from dbo.PedidoWeb p with(nolock)  
		join dbo.PedidoWebDetalle pd with(nolock) on pd.CampaniaID = p.CampaniaID and pd.PedidoID = p.PedidoID  
			and isnull(pd.EsKitNueva, '0') != 1  
		join ods.Consultora c with(nolock) on p.ConsultoraID = c.ConsultoraID  
		join @ConfValZonaTemp cr on p.CampaniaId = cr.CodigoCampania  
		and c.RegionID = cr.RegionID  
		and c.ZonaID = cr.ZonaID  
		join ConfiguracionConsultoraDA da with(nolock) on p.CampaniaId = da.CampaniaId and p.ConsultoraId = da.ConsultoraId
		where	cr.FechaInicioFacturacion <= @FechaFacturacion  
				and cr.FechaFinFacturacion >= @FechaFacturacion  
				and da.TipoConfiguracion = 1
	END  
END  
  
insert into @tabla_pedido  
select CampaniaId,PedidoId,Clientes,EstadoPedido,Bloqueado,IndicadorEnviado,ModificaPedidoReservadoMovil,  
CodigoConsultora,CodigoRegion,CodigoZona,CampaniaIdSicc,ZonaId,TipoProceso
from @tabla_pedido_detalle  
group by CampaniaId,PedidoId,Clientes,EstadoPedido,Bloqueado,IndicadorEnviado,ModificaPedidoReservadoMovil,  
CodigoConsultora,CodigoRegion,CodigoZona,CampaniaIdSicc,ZonaId,TipoProceso 
  
insert into dbo.TempPedidoWebID (NroLote, CampaniaID, PedidoID)  
select @NroLote, p.CampaniaID, p.PedidoID  
from @tabla_pedido p  
where p.IndicadorEnviado = 0 and p.Bloqueado = 0  
  and IIF(p.TipoProceso = 1, IIF(p.EstadoPedido = @Tipo OR @Tipo = 0,1,0),
		IIF(p.TipoProceso = 2,IIF(p.EstadoPedido = 202,1,0),1)) = 1
  
select p.PedidoID, p.CampaniaID, p.CodigoConsultora,  
 p.Clientes, p.CodigoRegion,  
 p.CodigoZona,  
 --(case p.EstadoPedido when 202 then (case when p.ModificaPedidoReservadoMovil = 0 then 1 else 0 end) else 0 end) as Validado  
 case p.EstadoPedido when 202 then 1 else 0 end as Validado  
from @tabla_pedido p   
 inner join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID  
where pk.NroLote = @NroLote  
  
  
select p.PedidoID, p.CampaniaID, p.CodigoConsultora,  
 p.CUV as CodigoVenta, p.CUV as CodigoProducto, sum(p.Cantidad) as Cantidad  
from @tabla_pedido_detalle p   
 inner join dbo.TempPedidoWebID pk with(nolock) on p.CampaniaID = pk.CampaniaID and p.PedidoID = pk.PedidoID  
 inner join ods.ProductoComercial pr with(nolock) on p.CampaniaIdSicc = pr.CampaniaID and p.CUV = pr.CUV  
where pk.NroLote = @NroLote and p.PedidoDetalleIDPadre = 0  
group by p.CampaniaID, p.PedidoID, p.CodigoConsultora, p.CUV  
having sum(p.Cantidad) > 0  

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
	MontoDescuento,
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
	MontoDescuento = @MontoDescuento,
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

/*FIN PROCEDIMIENTOS ALMACENADOS*/